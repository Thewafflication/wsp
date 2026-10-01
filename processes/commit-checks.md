# Commit Checks

**Content type:** Requirements and adoption guidance

## Purpose and Applicability

This baseline applies to repositories adopting WSP. Each project owns its
commit configuration and canonical commands; WSP supplies the rules,
[example](../templates/commit-checks-template.md), and pinned shared validators.
WPM, WFC, WSH, and other consumers select checks from their actual languages
and adopted profiles. Their build commands and test inventories are not
assumed to be identical.

## Requirements

### WSP-CHECK-0001 — Controlled Commit Configuration

Each project shall control a `.pre-commit-config.yaml` using the YAML-configured
pre-commit framework with lint, build, and full-test hooks at the `pre-commit`
stage, in that order, and `fail_fast: true`.

**Verification:** Configuration inspection and successful commit execution.

### WSP-CHECK-0002 — Canonical Commands

Commit hooks shall invoke the project's documented canonical lint, build, and
test commands, which shall also be invocable independently of Git hooks.

**Verification:** Comparison of hooks, developer commands, and CI commands.

### WSP-CHECK-0003 — Complete Local Scope

Each commit check shall execute once per commit using `always_run: true`,
`pass_filenames: false`, and `require_serial: true`, without changed-file
filters that reduce its project-defined scope.

The project shall declare the local build configuration and full automated
test inventory for that environment. Full means all applicable tests in that
inventory, including negative tests; unavailable required infrastructure shall
fail rather than silently reduce the inventory. CI and release verification
remain responsible for the wider supported matrix in WSP-TEST-0013.

**Verification:** Documentation-only and empty commits, inventory inspection,
and a controlled missing-infrastructure check.

### WSP-CHECK-0004 — Failure Propagation

A commit check shall prevent the commit when its required command reports a
finding or failure, cannot execute, has invalid configuration, or cannot
complete its declared scope.

PowerShell wrappers shall check native-command exit codes and terminate with
actionable diagnostics. Logging, cleanup, or a later successful command shall
not replace an earlier failure status.

**Verification:** Lint, build, unexpected-test, and infrastructure failures.

### WSP-CHECK-0005 — Expected Failure Control

A test counted as an acceptable expected failure by the commit gate shall have
an explicit, controlled expectation identifying the test and intended failure.

Negative tests should assert the expected error and report Pass when that
assertion succeeds. A framework's expected-failure annotation may also be used
for a known defect with a linked defect record and review condition. Blanket
exit-code suppression, allowing every failed test, and reclassifying an
ordinary failure after execution are prohibited.

An accepted expected failure does not establish requirement verification or
satisfy a required release gate under WSP-TEST-0008. Projects shall define
unexpected-success handling and review obsolete expectations.

**Verification:** An explicit expected failure is accepted and an ordinary
failure remains blocking; release evidence preserves the actual result.

### WSP-CHECK-0006 — Profile Rule Coverage

Each project shall control a check inventory mapping its applicable WSP
requirements to automated commands or identified review and evidence steps,
including scope, tool configuration, exclusions, and approved tailoring.

Selecting a linter does not establish coverage of every WSP obligation. Missing
coverage shall be recorded in the adoption record under WSP-REQM-0006 and
WSP-REQM-0007, rather than hidden by a passing generic lint command.

**Verification:** Adoption record, check inventory, and configuration review.

### WSP-CHECK-0007 — Reproducible Setup

Each project shall document hook installation, canonical manual commands,
required tool versions, source scope, and project-owned output paths.

Tool versions and configurations shall be controlled in dependency manifests,
lockfiles, versioned settings, or an equivalent reproducible setup. Hooks shall
not install unpinned tools or modify source automatically during a commit.

**Verification:** Setup in a clean checkout and tool/configuration inspection.

### WSP-CHECK-0008 — Independent CI Backstop

CI shall independently execute the canonical lint, build, and full-test checks,
and projects shall require successful CI verification before accepting changes
as specified by WSP-TEST-0012.

Git hooks can be bypassed and are not the sole acceptance control. A documented
emergency exception follows the existing project process.

**Verification:** CI inspection, required-check settings, and controlled
failure.

## Adoption

Start with the existing GitHub workflow commands and project presets, using
the [workflow-derived examples](../templates/workflow-derived-commit-checks.md).
Extract useful inline checks into project-owned scripts shared by CI and
hooks, preserving scope and failure handling. Review existing filters, cached
results, and gaps before declaring those commands a complete commit gate.

Copy and adapt the example into the owning project. Keep the pinned `wsp/`
submodule read-only. Include only applicable language profiles, but do not
silently drop an applicable WSP rule. Reuse existing project scripts instead
of introducing a second implementation solely for hooks.

Configure linters to check project-owned sources, excluding `wsp/`, dependencies,
generated files, and build output by explicit ownership boundaries. Shared WSP
validators are invoked through the pinned submodule with project paths.

The local gate intentionally performs complete checks, so large projects may
take minutes per commit. Improve incremental build caching and test setup
without narrowing the required inventory. A lighter gate requires documented
tailoring; it shall not be described as the full gate.

## Recommended Linters

The [common style baseline](../style/source-style.md) requires a strict physical
scan for every owned source/configuration language. The
[language profiles](../style/language-style.md) and
[documentation guide](../style/source-documentation.md) extend the choices below
to YAML, JSON, Make, C#, Visual Basic, and additional languages. Formatter
line-length preferences do not replace this scan.

These are recommendations except where an adopted profile already requires
a particular tool. Pin a tested version in each consumer, rather than treating
the current upstream release as a permanent WSP dependency.

**PowerShell.**
[PSScriptAnalyzer](https://learn.microsoft.com/en-us/powershell/module/psscriptanalyzer/invoke-scriptanalyzer?view=ps-modules).
Commit settings; reject selected Error and Warning diagnostics, including
assignment to automatic variables, unsafe expressions, aliases, and unused
assignments. Syntax parsing alone is a limited check.

**C and C++.** [clang-tidy](https://clang.llvm.org/extra/clang-tidy/). Use the
WSP configuration and target-scoped CMake integration required by
WSP-SAST-0001 through WSP-SAST-0006. Analyze every owned translation unit in
the declared configuration.

**C documentation.** [Doxygen](https://www.doxygen.nl/manual/config.html) plus
`Test-CSourceQuality.ps1`. Check required documentation and the physical
80-character limit under WSP-CSTYLE-0001 through WSP-CSTYLE-0005. Formatting
alone cannot prove this coverage.

**Markdown.**
[markdownlint-cli2](https://github.com/DavidAnson/markdownlint-cli2). Commit
heading, fence, list, whitespace, and table rules; explicitly scope owned
documents. Requirement meaning and traceability need additional validation and
review.

**CMake.** [gersemi](https://github.com/BlankSpruce/gersemi) in `--check`
mode. Optional formatting check; configure/build with compiler warnings as
errors remains the semantic validation. Use the WSP CMake profile.

**Python.** [Ruff](https://docs.astral.sh/ruff/linter/). Use `ruff check` with
committed settings; its default error and unused-import checks are a useful
starting point. Add rules deliberately.

PSScriptAnalyzer emits diagnostic objects; a wrapper must explicitly fail on
the selected findings. Merely printing them can leave PowerShell successful.
Use check modes during commits. Run automatic fixes separately, review the
diff, and stage the resulting changes.

## WSP-Specific Check Inventory

The following is a starting mapping, not a claim that one lint command verifies
all WSP requirements. Add entries for every applicable adopted profile.

**WSP-CSTYLE-0001 through 0005.** `Test-CSourceQuality.ps1` and a strict
project Doxyfile. Review documentation contracts and intent; ensure Doxygen
inputs match the owned C scope.

**WSP-SAST-0001 through 0006.** WSP clang-tidy configuration and analysis
build. Reviewed suppressions, version record, and complete release analysis
matrix.

**WSP-REQM-0001, 0004, 0005; WSP-TEST-0011.** `Test-Traceability.ps1` for its
documented REQ/TC conventions. Review non-test verification, adoption
dispositions, and WSP-to-project allocation. The tool is not an
adoption-record validator.

**WSP-TEST-0007, 0008, 0010, 0014.** Test runners, `Test-TestEvidence.ps1`,
and report generation. Exact result inventory, baseline metadata, retained
evidence, and release approval. The evidence validator accepts Pass only.

**WSP-REQM-0002 and 0003.** Identifier/structure checks where available.
Review obligated subjects, atomicity, rationale, and measurable pass criteria;
generic Markdown lint does not judge these.

**WSP-TOOL-0001, 0002, 0006.** Invoke tools from pinned `wsp/` with explicit
project paths. Gitlink inspection and confirmation that generated output stays
outside the submodule.

**WSP-TEST-0012 and 0013.** CI runs canonical checks and declared matrix jobs.
Required CI checks, supported configurations, and release acceptance.

For example, formatting a C line to 80 columns does not prove all physical
lines meet WSP-CSTYLE-0004: use the shared validator as the authoritative scan.
Likewise, a link checker cannot decide whether a requirement is objectively
verifiable. Retain human review for obligations that need judgment.
