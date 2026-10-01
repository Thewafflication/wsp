# Project Commit Checks Template

**Content type:** Informative example and adoption template

## Ownership and Assumptions

Start with the concrete
[workflow-derived WPM, WFC, and WSH examples](workflow-derived-commit-checks.md)
when adapting this generic template to those projects.

This example is for a Windows C project with PowerShell automation, CMake
presets, Markdown documentation, and WSP at `wsp/`. It is a starting point for
WPM, WFC, WSH, or another consumer with those technologies, not a statement of
their current layouts or commands. Adapt paths and presets before use.

The project supplies `src/`, `include/`, `tools/`, `tests/`, and `docs/`, its
canonical scripts, and dependency lockfiles. The example traceability layout
has project `req-*.md` and `tc-*.tex` artifacts under `docs/` and PowerShell TC
runners under `tests/`. Other layouts need equivalent validation or tailoring.

Ignore generated `output/`; keep `wsp/` read-only. Initialize the pinned
submodule with `git submodule update --init wsp`. Pin tested versions of
pre-commit, PSScriptAnalyzer, LLVM, Doxygen, CMake, Ninja, the native compiler,
and selected documentation tools in project-owned dependency/version records.
Provision them during setup and CI, not during each commit.

## Hook Configuration and Setup

Copy [`pre-commit-config.yaml`](pre-commit-config.yaml) to the project root as
`.pre-commit-config.yaml`. Its three hooks call:

```powershell
pwsh -NoProfile -File tools/lint.ps1
pwsh -NoProfile -File tools/build.ps1
pwsh -NoProfile -File tests/run-tests.ps1
```

Keep existing canonical commands when available; adapt YAML entries instead
of duplicating scripts. All checks run once, including empty and
documentation-only commits, and stop at the first failure.

After provisioning the declared project dependencies:

```powershell
python -m pip install --requirement requirements-dev.txt
pre-commit validate-config
pre-commit install
pre-commit run --all-files
```

Activate the project's Python development environment before installation and
committing; repeat hook installation after cloning. If `core.hooksPath` is
configured, reconcile it with the project setup: pre-commit refuses installation
in that situation. Do not silently remove existing hooks.

## Example PowerShell Rules

Commit this as `PSScriptAnalyzerSettings.psd1`. It is a starting rule set, not
an exhaustive implementation of the PowerShell style profile.

```powershell
@{
    Severity = @('Error', 'Warning')
    IncludeRules = @(
        'PSAvoidAssignmentToAutomaticVariable'
        'PSAvoidUsingCmdletAliases'
        'PSAvoidUsingInvokeExpression'
        'PSUseDeclaredVarsMoreThanAssignments'
        'PSUseApprovedVerbs'
    )
}
```

Separately review script structure, exit-code propagation, explicit paths,
output isolation, and other WSP obligations that these rules do not prove.

## Example Canonical Lint Script

Adapt this as `tools/lint.ps1` for the C, PowerShell, static-analysis, and
traceability profiles. Complete owned directories are checked; keep generated
and third-party code outside them or add reviewed explicit exclusions.

```powershell
[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$powerShell = (Get-Process -Id $PID).Path

function Invoke-CheckedCommand {
    param([string]$Command, [string[]]$Arguments)

    & $Command @Arguments
    if ($LASTEXITCODE -ne 0) {
        throw "$Command $($Arguments -join ' ') failed ($LASTEXITCODE)."
    }
}

Push-Location $root
try {
    & ./wsp/tools/Test-SourceStyle.ps1 -RepositoryRoot $root `
        -SourcePath @('src', 'include', 'tools', 'tests', '.github')
    if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

    Import-Module PSScriptAnalyzer -ErrorAction Stop
    $findings = @(
        foreach ($path in @('tools', 'tests')) {
            Invoke-ScriptAnalyzer -Path $path -Recurse `
                -Settings PSScriptAnalyzerSettings.psd1
        }
    )
    if ($findings.Count -gt 0) {
        $findings | Format-Table ScriptName, Line, RuleName, Message -Wrap
        throw 'PowerShell analysis failed; see diagnostics above.'
    }

    # A direct script call supports arrays and covers owned test/helper C too.
    & ./wsp/tools/Test-CSourceQuality.ps1 -RepositoryRoot $root `
        -SourcePath @('src', 'include', 'tests', 'tools') `
        -Doxyfile 'Doxyfile'
    if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
    Invoke-CheckedCommand $powerShell @(
        '-NoProfile', '-File', 'wsp/tools/Test-Traceability.ps1',
        '-RepositoryRoot', $root, '-RequirementsPath', 'docs',
        '-TestSpecificationsPath', 'docs',
        '-TestImplementationsPath', 'tests')

    # Ninja/Makefiles analysis preset, WSP baseline on owned targets,
    # WSP_ENABLE_STATIC_ANALYSIS=ON, controlled clang-tidy configuration.
    Invoke-CheckedCommand cmake @('--preset', 'x64-analysis')
    Invoke-CheckedCommand cmake @(
        '--build', '--preset', 'x64-analysis', '--clean-first')
}
finally {
    Pop-Location
}
```

The source-quality invocation scans all selected owned directories, including
C tests/helpers; the Doxyfile covers the same inventory. Direct PowerShell
invocation preserves array parameters. The clean analysis build ensures
unchanged translation units are
analyzed as well. The normal product build still uses the declared native
compiler. Commit the analysis preset and apply `wsp_apply_build_baseline` to
every owned compiled target before using the example.

Add these commands when the corresponding checks are selected:

```powershell
Invoke-CheckedCommand markdownlint-cli2 @(
    'README.md', 'CHANGELOG.md', 'docs/**/*.md')
Invoke-CheckedCommand gersemi @('--check', 'CMakeLists.txt', 'cmake')
Invoke-CheckedCommand ruff @('check', 'tools/python', 'tests/python')
```

markdownlint-cli2 interprets its literal glob. Include every owned directory
in the inventory; exclude `wsp/` and output. Optional tools need pinned setup
and committed settings. Missing selected tools fail instead of being skipped.
Use check modes; run fixes separately, review the diff, and stage changes.

## Example C Documentation Configuration

Adapt this project-root `Doxyfile`, including project-specific include paths
and predefined macros as needed:

```text
PROJECT_NAME           = Example
OUTPUT_DIRECTORY       = output/doxygen
INPUT                  = src include tests tools
FILE_PATTERNS          = *.c *.h
RECURSIVE              = YES
EXTRACT_ALL            = NO
EXTRACT_STATIC         = YES
EXTRACT_PRIVATE        = YES
WARNINGS               = YES
WARN_IF_UNDOCUMENTED   = YES
WARN_IF_DOC_ERROR      = YES
WARN_NO_PARAMDOC       = YES
WARN_AS_ERROR          = YES
GENERATE_HTML          = NO
GENERATE_LATEX         = NO
```

The shared validator checks `@file` comments and every physical C line's
80-character limit. Doxygen checks configured documentation scope. Review
contract meaning and side effects under WSP-CSTYLE-0002 and WSP-CSTYLE-0003.

## Build and Full-Test Commands

`tools/build.ps1` invokes the normal compiler preset, for example
`cmake --preset x64-development` followed by
`cmake --build --preset x64-development`. Use the checked-command failure
contract above for every native command. Define and commit the configure,
build, and test presets before adopting these commands.

The existing `tests/run-tests.ps1` runs every applicable PowerShell, native,
and other test in the declared local inventory. For native tests, use
`ctest --preset x64-development --output-on-failure --no-tests=error`, without
filters that silently narrow the inventory. Projects without CTest retain
their actual full-suite command. Release CI covers the wider supported matrix.

Clear previous execution evidence before producing current evidence beneath
project-owned output. Use `wsp/tools/Test-TestEvidence.ps1` to check the expected
count and Pass statuses when claiming release verification. Do not relax that
validator so a known defect counts as verified.

An example PowerShell negative test is:

```powershell
$output = & $program '--deliberately-invalid-option' 2>&1
$testExitCode = $LASTEXITCODE
if ($testExitCode -ne 2 -or
    ($output -join "`n") -notmatch 'Unknown option') {
    throw 'TC-0042: expected invalid-option rejection was not observed.'
}
Write-Output '[PASS] TC-0042 rejects an invalid option'
```

Exit code 2 is this example program's specified behavior. A different error
fails the test. Framework expected-failure annotations need test-specific
defect references and remain outside required passing release evidence.

## Check Inventory and CI

Copy this starting inventory into the adoption record, fill the project
configuration and evidence, and add every other applicable WSP requirement.

**PowerShell analysis.** PowerShell style profile. Settings, module version,
owned script paths, reviewed exclusions.

**C source quality.** WSP-CSTYLE-0001 through 0005. Source roots, strict
Doxyfile, diagnostics, contract review.

**Static analysis.** WSP-SAST-0001 through 0006. Presets, WSP configuration,
suppressions and matrix.

**Traceability.** WSP-REQM-0001, 0004, 0005; WSP-TEST-0011. REQ/TC inventory,
non-test verification and adoption review.

**Complete tests.** WSP-TEST-0005 through 0009; WSP-CHECK-0003 through 0005.
Full inventory, expected failures and diagnostics.

**CI and release.** WSP-TEST-0012 through 0014. Required checks, matrix,
retained results and approval.

After dependency provisioning, CI runs the same three commands in separate
steps and retains required diagnostics and evidence. Configure required CI
checks in the hosting service; hook installation is not a merge control.

In an isolated test repository, verify successful commits, a PowerShell lint
finding, an over-80-column C line, missing Doxygen documentation, build failure,
unexpected test failure, a specifically expected negative result, and missing
infrastructure. Confirm empty and documentation-only commits run all hooks.
Confirm outputs stay outside `wsp/` and release evidence does not count known
defects as Pass.
