"""Positive and negative checks for the shared physical-source validator."""

from pathlib import Path
import subprocess
import tempfile
import unittest


ROOT = Path(__file__).resolve().parents[2]
SCRIPT = ROOT / "tools" / "Test-SourceStyle.ps1"


class SourceStyleTests(unittest.TestCase):
    def setUp(self):
        output = ROOT / "output" / "tests"
        output.mkdir(parents=True, exist_ok=True)
        self.directory = tempfile.TemporaryDirectory(dir=output)
        self.addCleanup(self.directory.cleanup)
        self.repo = Path(self.directory.name)

    def write(self, name, content):
        path = self.repo / name
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_bytes(content.encode("utf-8"))

    def check(self, accepted, *arguments, source="."):
        result = subprocess.run(
            ["pwsh", "-NoProfile", "-File", str(SCRIPT),
             "-RepositoryRoot", str(self.repo), "-SourcePath", source,
             *arguments],
            cwd=ROOT, text=True, capture_output=True, timeout=30,
        )
        diagnostics = result.stdout + result.stderr
        self.assertEqual(result.returncode == 0, accepted, diagnostics)
        return diagnostics

    def test_requested_languages_accept_80_reject_81(self):
        names = ["file.c", "file.cpp", "file.py", "file.yaml", "file.json",
                 "Makefile", "file.ps1", "file.cs", "file.vb", "file.cmake"]
        for name in names:
            self.write(name, "x" * 80 + "\n")
        self.check(True)
        for name in names:
            with self.subTest(name=name):
                self.write(name, "x" * 81 + "\n")
                diagnostics = self.check(False)
                self.assertIn(f"{name}:1: WSP-STYLE-0001", diagnostics)
                self.write(name, "x" * 80 + "\n")

    def test_comments_and_literals_have_no_exemption(self):
        self.write("file.cpp", "// " + "x" * 78 + "\n")
        self.assertIn("WSP-STYLE-0001", self.check(False))
        self.write("file.cpp", 'const char *url = "' + "x" * 80 + '";\n')
        self.check(False)

    def test_make_recipe_tabs_are_preserved(self):
        self.write("Makefile", "all:\n\t@echo success\n")
        self.check(True)

    def test_trailing_whitespace_and_final_newline(self):
        self.write("file.yaml", "value: 3 \n")
        self.assertIn("trailing whitespace", self.check(False))
        self.write("file.yaml", "value: 3")
        self.assertIn("missing final newline", self.check(False))

    def test_invalid_utf8_fails_with_filename(self):
        (self.repo / "file.json").write_bytes(b"\xff\n")
        self.assertIn("file.json: WSP-STYLE-0002", self.check(False))

    def test_utf8_bom_and_crlf(self):
        self.write("file.ps1", "\ufeff" + "x" * 80 + "\r\n")
        self.check(True)

    def test_supplementary_characters_follow_utf16_metric(self):
        self.write("file.py", "\U0001f600" * 40 + "\n")
        self.check(True)
        self.write("file.py", "\U0001f600" * 41 + "\n")
        self.assertIn("82 characters", self.check(False))

    def test_empty_selected_file_is_valid(self):
        self.write("file.json", "")
        self.check(True)

    def test_exclusions_apply_to_descendants_not_similar_names(self):
        self.write("src/good.c", "int value;\n")
        self.write("vendor/bad.c", "x" * 81 + "\n")
        self.check(True, "-ExcludePath", "vendor")
        self.write("vendor-owned/bad.c", "x" * 81 + "\n")
        self.assertIn(
            "vendor-owned", self.check(False, "-ExcludePath", "vendor"))

    def test_missing_scope_and_empty_inventory_are_errors(self):
        self.assertIn("input is missing", self.check(False, source="missing"))
        self.write("notes.txt", "Non-source data\n")
        self.assertIn("No in-scope", self.check(False))
        self.check(True, "-IncludeExtension", ".txt")

    def test_sources_outside_root_are_rejected(self):
        self.assertIn("outside RepositoryRoot", self.check(False, source=".."))

    def test_invocation_does_not_require_project_working_directory(self):
        self.write("src/file.cs", "class Example {}\n")
        self.check(True, source="src")


if __name__ == "__main__":
    unittest.main(verbosity=2)
