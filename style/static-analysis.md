# Static Analysis Profile

**Content type:** Selectable profile requirements and guidance

## Purpose and Applicability

This profile standardizes source static analysis without changing the project's
default compiler. It applies to project-owned C and C++ sources. Projects using
other implementation languages shall select an analyzer and equivalent rules
appropriate to those languages or record why this profile does not apply.

TinyCC remains the default WSP C compiler. Clang-tidy is a separate verification
tool: using it neither changes the compiler that produces normal binaries nor
permits a project to report a Clang build as a TinyCC build.

## Requirements

### WSP-SAST-0001 — Standard Analyzer

A project with project-owned C or C++ source shall use clang-tidy as its default
source static analyzer. An alternative analyzer shall be an approved tailoring
decision that identifies equivalent or stronger checks and any coverage gap.

**Verification:** Analyzer configuration and adoption-record inspection.

### WSP-SAST-0002 — Controlled Analysis Configuration

The analyzer executable version and configuration shall be declared and
reproducible in CI. The project shall use the WSP clang-tidy configuration, a
documented superset, or an approved tailoring that identifies every removed or
changed check and its rationale.

Analyzer findings shall be treated as errors in the required analysis gate.
Changing the analyzer version or controlled configuration shall receive review
and a recorded assessment of new, removed, or materially changed diagnostics.

**Verification:** CI, version record, configuration, and change-review
inspection.

### WSP-SAST-0003 — Analysis Scope

Static analysis shall cover every project-owned translation unit and
project-owned header used to produce a supported release. Generated,
third-party, and platform SDK sources may be excluded when their ownership and
exclusion boundaries are explicit.

Pull-request CI shall analyze every affected translation unit. Release
verification shall analyze the complete applicable source set for every
materially distinct language, platform, or preprocessor configuration that can
change analyzer results.

**Verification:** Analysis invocation, source inventory, and release-matrix
inspection.

### WSP-SAST-0004 — Fail-Closed Execution

The required analysis gate shall fail when the analyzer reports a finding,
cannot execute, cannot parse an applicable translation unit, cannot load its
controlled configuration, or does not complete its required scope.

An ordinary TinyCC build shall not silently stand in for the analysis gate, and
a passing analysis shall not stand in for compiling and testing with TinyCC.

**Verification:** Controlled finding, missing-tool, invalid-configuration, and
unparseable-source checks.

### WSP-SAST-0005 — Finding and Suppression Control

Each static-analysis finding shall be corrected or resolved through the
project's defect or approved risk process. A suppression shall be as narrow as
practical and shall record the diagnostic identifier, affected code, rationale,
and review authority in source or a controlled suppression record.

Global wildcard suppressions and unexplained inline suppressions shall not be
used to make a required gate pass.

**Verification:** Finding history, source, suppression record, and review
inspection.

### WSP-SAST-0006 — Analysis Evidence

Required static-analysis evidence shall identify the source revision, analyzer
name and version, controlled configuration revision or digest, applicable
target configuration, executed command or build preset, result status, and
complete diagnostic output.

Release evidence shall retain or reference the successful complete-source
analysis and every approved unresolved finding or suppression applicable to
the release.

**Verification:** CI artifact and release-readiness inspection.

## WSP clang-tidy Baseline

The reusable configuration enables the Clang static analyzer, bug-prone, CERT,
selected miscellaneous, and performance checks. It treats all enabled findings
as errors and analyzes project headers while excluding system headers.

Projects should mark third-party include directories as `SYSTEM` and allocate
third-party sources to separate targets. This makes the analysis boundary
visible in the build instead of relying on broad diagnostic suppressions.

Use the target-scoped CMake integration documented in
[`tools/cmake`](../tools/cmake/README.md). A dedicated analysis preset shall set
`WSP_ENABLE_STATIC_ANALYSIS=ON` and identify the clang-tidy executable. The
integration tolerates only compiler warning-option spelling that Clang does not
recognize, which is needed when clang-tidy consumes TinyCC compile arguments;
it does not suppress analyzer findings or source parse failures.
