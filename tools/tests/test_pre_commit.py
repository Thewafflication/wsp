"""Exercise the checked-in hooks through real commits in isolated repositories."""

import os
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile
import unittest


ROOT = Path(__file__).resolve().parents[2]


class CommitGateTests(unittest.TestCase):
    configuration = '.pre-commit-config.yaml'
    lint_path = 'tools/Test-RepositorySyntax.ps1'
    build_path = 'tools/Build-Documentation.ps1'
    test_path = 'tools/tests/run-all-tests.ps1'

    def setUp(self):
        output = ROOT / 'output' / 'tests'
        output.mkdir(parents=True, exist_ok=True)
        self.directory = tempfile.TemporaryDirectory(dir=output)
        self.addCleanup(self.directory.cleanup)
        self.repo = Path(self.directory.name)
        self.env = os.environ.copy()
        # Never inherit bypass flags or the parent repository's Git index.
        for key in list(self.env):
            if key.startswith('GIT_') or key in ('SKIP', 'PRE_COMMIT_ALLOW_NO_CONFIG'):
                del self.env[key]
        self.env['PRE_COMMIT_HOME'] = str(output / 'pre-commit-cache')
        self.env['GIT_CONFIG_GLOBAL'] = os.devnull
        self.env['GIT_CONFIG_NOSYSTEM'] = '1'
        self.run_command('git', 'init')
        self.run_command('git', 'config', 'user.name', 'Hook test')
        self.run_command('git', 'config', 'user.email', 'hook-test@example.invalid')
        self.run_command('git', 'config', 'commit.gpgsign', 'false')
        shutil.copy(ROOT / self.configuration,
                    self.repo / '.pre-commit-config.yaml')
        (self.repo / 'tools' / 'tests').mkdir(parents=True)
        (self.repo / 'tests').mkdir()
        shutil.copy(ROOT / 'tools' / 'Test-RepositorySyntax.ps1',
                    self.repo / self.lint_path)
        self.write(self.build_path,
                   "Add-Content order.txt build\nexit 0\n")
        self.write(self.test_path,
                   "Add-Content order.txt tests\npython tests.py\nexit $LASTEXITCODE\n")
        self.write('tests.py',
                   'import unittest\n'
                   'class Example(unittest.TestCase):\n'
                   '    def test_example(self):\n'
                   '        self.assertTrue(True)\n'
                   'unittest.main()\n')
        self.write('.gitignore', 'order.txt\n')
        self.run_command('git', 'add', '.')
        self.run_command('git', 'commit', '-m', 'Fixture before hook installation')
        self.head = self.run_command('git', 'rev-parse', 'HEAD').stdout.strip()
        self.run_command(sys.executable, '-m', 'pre_commit', 'install')

    def write(self, name, value):
        (self.repo / name).write_text(value, encoding='utf-8')

    def run_command(self, *args, check=True):
        result = subprocess.run(args, cwd=self.repo, env=self.env,
                                text=True, capture_output=True, timeout=120)
        if check and result.returncode:
            self.fail(f'{args}:\n{result.stdout}\n{result.stderr}')
        return result

    def commit(self, accepted, order):
        self.run_command('git', 'add', '.')
        result = self.run_command('git', 'commit', '--allow-empty', '-m',
                                  'Exercise hook', check=False)
        self.assertEqual(result.returncode == 0, accepted,
                         result.stdout + result.stderr)
        head = self.run_command('git', 'rev-parse', 'HEAD').stdout.strip()
        self.assertEqual(head != self.head, accepted)
        trace = self.repo / 'order.txt'
        self.assertEqual(trace.read_text().splitlines() if trace.exists() else [],
                         order)
        return result.stdout + result.stderr

    def test_success_on_document_only_commit(self):
        self.write('example.md', '# Documentation only\n')
        self.commit(True, ['build', 'tests'])

    def test_success_on_empty_commit(self):
        self.commit(True, ['build', 'tests'])

    def test_lint_failure_stops_before_build(self):
        self.write('broken.ps1', 'function Broken {\n')
        self.assertIn('broken.ps1', self.commit(False, []))

    def test_build_failure_stops_before_tests(self):
        self.write(self.build_path,
                   "Add-Content order.txt build\nWrite-Error 'Build failed'\nexit 7\n")
        self.assertIn('Build failed', self.commit(False, ['build']))

    def test_unexpected_test_failure(self):
        self.write('tests.py',
                   'import unittest\n'
                   'class Example(unittest.TestCase):\n'
                   '    def test_example(self):\n'
                   '        self.fail("Unexpected failure")\n'
                   'unittest.main()\n')
        self.assertIn('Unexpected failure', self.commit(False, ['build', 'tests']))

    def test_explicit_expected_failure(self):
        self.write('tests.py',
                   'import unittest\n'
                   'class Example(unittest.TestCase):\n'
                   '    @unittest.expectedFailure\n'
                   '    def test_example(self):\n'
                   '        self.fail("Known failure")\n'
                   'unittest.main()\n')
        self.commit(True, ['build', 'tests'])

    def test_test_infrastructure_error(self):
        self.write('tests.py', 'raise RuntimeError("Runner infrastructure error")\n')
        self.assertIn('Runner infrastructure error',
                      self.commit(False, ['build', 'tests']))


class AdoptionCommitGateTests(CommitGateTests):
    """The adoption YAML uses the same failure contract with project commands.

    Build/test commands are controlled fixtures, not actual consumer builds.
    """

    configuration = 'templates/pre-commit-config.yaml'
    lint_path = 'tools/lint.ps1'
    build_path = 'tools/build.ps1'
    test_path = 'tests/run-tests.ps1'


if __name__ == '__main__':
    unittest.main(verbosity=2)
