# Common Tools

**Content type:** Requirements, tools, and guidance

This directory contains reusable PowerShell tools that enforce WSP practices in
adopting projects. The first tools generalize behavior duplicated in WPM and
WCRT while removing repository-specific paths and assumptions.

## Tools

| Tool | Purpose |
| --- | --- |
| `Build-Documentation.ps1` | Build a linked release documentation PDF |
| `Test-CSourceQuality.ps1` | Enforce Doxygen and 80-column C rules |
| `Test-Traceability.ps1` | Validate requirement, test, and runner links |
| `Test-TestEvidence.ps1` | Validate complete passing LaTeX evidence |
| `New-TestReport.ps1` | Combine a test case and evidence into a report |
| `Write-BuildWarningSummary.ps1` | Add build warnings to a CI summary |

The [tool requirements](requirements.md) define behavior common to every WSP
tool.

Run the common-tool self-tests with:

```powershell
pwsh -File wsp/tools/tests/run-tests.ps1
```

## Invocation from an Adopting Project

Invoke tools through the pinned `wsp/` submodule. Do not copy or modify them in
the adopting repository.

```powershell
pwsh -File wsp/tools/Test-Traceability.ps1 `
  -RepositoryRoot . `
  -RequirementsPath docs `
  -TestSpecificationsPath docs `
  -TestImplementationsPath tests
```

Projects that maintain forward links in a central matrix may pass one or more
files through `-TraceabilityPath`, for example
`-TraceabilityPath tests/c89/manifest.md`.

Paths supplied by a project are resolved relative to `RepositoryRoot` unless
they are absolute. Generated outputs are always written to project-owned paths,
never beneath the WSP submodule.

## Compatibility

Tools target PowerShell 7 and Windows CI. Scripts should remain portable to
other PowerShell 7 platforms unless their purpose is explicitly Windows-only.
External programs such as Git, Doxygen, and PDFLaTeX are dependencies only of
the tools that invoke them.

## Candidate Future Tools

The WPM and WCRT copies of dependency-release checks, dependency metadata
export, and test-runner helpers still contain WPM-specific assumptions. They
should move here only after their input and output contracts are generalized
and tested independently.
