# Commit Checks from Existing GitHub Workflows

**Content type:** Informative worked examples

## Workflow-First Adoption

Start with the project's existing GitHub scripts and CMake presets. Inventory
lint, configure, build, and test commands, dependency setup, environment,
architecture, and failure handling. Reuse scripts and presets; extract useful
inline `run` blocks into project-owned scripts invoked by both hooks and CI.
Keep runner provisioning, artifact uploads, signing, and publishing in CI.
Do not execute or translate arbitrary workflow YAML at commit time.

Select the supported local architecture, normally x64 on x64 Windows, and
retain the broader x86/native ARM64 matrix in CI. Check missing dependencies,
test filters, empty inventories, and cached evidence before treating an
existing workflow command as a full per-commit gate.

These examples were inspected on 2026-09-30 at the linked revisions. They are
proposed local adaptations of actual commands, not installed or executed gates
in those repositories. Recheck them when updating an adopting project's WSP
pin. Snippets use `Invoke-CheckedCommand` from the
[generic example](commit-checks-template.md) and execute from the project root.

## WPM

Sources: [Test Reports workflow](https://github.com/Thewafflication/wpm/blob/f608cf2a3a053e0fb0dcfd71b4d3727ca234141a/.github/workflows/test-reports.yml),
[Release workflow](https://github.com/Thewafflication/wpm/blob/f608cf2a3a053e0fb0dcfd71b4d3727ca234141a/.github/workflows/release.yml),
[presets](https://github.com/Thewafflication/wpm/blob/f608cf2a3a053e0fb0dcfd71b4d3727ca234141a/CMakePresets.json),
and [verification targets](https://github.com/Thewafflication/wpm/blob/f608cf2a3a053e0fb0dcfd71b4d3727ca234141a/wpm/CMakeLists.txt).

Reuse these existing project checks:

- `tests/lint-c99.ps1`;
- `tests/verify-traceability.ps1`;
- `tests/verify-traceability-validator.ps1`; and
- `tests/verify-wsp-adoption.ps1`.

The C99 linter checks language edition and forbidden C11 tokens, not every
C-style or static-analysis rule.

The added scans below enforce physical lines across owned languages and run
the C Doxygen gate. Add a strict project-owned `Doxyfile`, based on the
generic example with `INPUT = wpm tests cmake`. These are new adoption steps;
the inspected workflows did not already contain them. Record vendored-header
exclusions explicitly and keep the Doxygen and scan inventories consistent.
Correct existing violations or record approved tailoring before enabling gates.

CI configures `x64-debug-reports` and builds `verify-x64-debug`. The latter
targets `verify`; it is not a CTest preset. The existing CTest presets are
for x86, so an x64 hook must not invent `ctest --preset x64-debug`.

```powershell
# Lint/allocation stage
# Adopt a WSP pin containing the new physical source-style validator.
& ./wsp/tools/Test-SourceStyle.ps1 -RepositoryRoot . `
    -SourcePath @('wpm', 'tests', 'cmake', '.github',
        'CMakeLists.txt', 'CMakePresets.json', 'Doxyfile')
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

# The project-owned Doxyfile covers owned C in all these roots.
foreach ($source in @('wpm', 'tests', 'cmake')) {
    Invoke-CheckedCommand pwsh @(
        '-NoProfile', '-File', 'wsp/tools/Test-CSourceQuality.ps1',
        '-RepositoryRoot', '.', '-SourcePath', $source,
        '-Doxyfile', 'Doxyfile')
}

foreach ($script in @(
    'tests/lint-c99.ps1',
    'tests/verify-traceability.ps1',
    'tests/verify-traceability-validator.ps1',
    'tests/verify-wsp-adoption.ps1')) {
    Invoke-CheckedCommand pwsh @('-NoProfile', '-File', $script)
}

# Build stage; dependency paths/metadata are established during setup.
Invoke-CheckedCommand cmake @('--preset', 'x64-debug-reports')
Invoke-CheckedCommand cmake @(
    '--build', 'out/build/x64-debug-reports', '--parallel')

# Full test stage: fresh, unfiltered registered test execution.
Invoke-CheckedCommand ctest @(
    '--test-dir', 'out/build/x64-debug-reports', '-C', 'Debug',
    '--output-on-failure', '--no-tests=error')
```

**Caching gap:** with reports enabled, `verify` checks generated evidence and
runs component tests. Its report dependencies can already be up to date on a
documentation-only commit. Calling that preset alone does not guarantee fresh
execution of every registered test. The unfiltered CTest command above also
executes the separately registered traceability-validator test. Preserve CI
report generation; if local fresh reports are required, explicitly expire old
report/evidence outputs or use a clean verification build and check the fresh
inventory. Cached passing evidence is not new full-suite execution.

**Setup:** initialize recursive submodules and provision TinyCC, WCRT, Ninja,
PowerShell, and Doxygen for the added gate. The setup action exports
`WPM_TCC_ROOT`, `WPM_WCRT_ROOT`, and
`WPM_NINJA`; pass `-DCMAKE_MAKE_PROGRAM` when Ninja is outside `PATH`. CI also
derives dependency metadata from pinned submodules and supplies
`WPM_*_VERSION_OVERRIDE` and `WPM_*_COMMIT_OVERRIDE` cache values. Preserve
these in a shared configure wrapper or derive them from those same submodules;
do not use guessed versions or literal GitHub expressions locally.

The current setup action installs latest WPM/TinyCC/WCRT, a reproducibility
gap against WSP-CHECK-0007. Pin tested versions during adopting setup rather
than installing latest releases on every commit. Dependency freshness,
release package signing, and publishing remain separate controls.

## WFC

Sources: [Build and test workflow](https://github.com/Thewafflication/wfc/blob/a4de6445fe3354cf4db10e7eaf1eefe31201704b/.github/workflows/build.yml),
[presets](https://github.com/Thewafflication/wfc/blob/a4de6445fe3354cf4db10e7eaf1eefe31201704b/CMakePresets.json),
and [warnings](https://github.com/Thewafflication/wfc/blob/a4de6445fe3354cf4db10e7eaf1eefe31201704b/cmake/WfcWarnings.cmake).

The actual configure, build, and test preset is `windows-x64-debug`. It uses
Visual Studio 17 2022, enables tests, and requires CMake 3.28 or newer. Provision
Visual Studio 2022 C++ build tools and the Windows SDK matching this preset;
another installed Visual Studio major version is not automatically equivalent.

```powershell
# Preceding lint stage: strict source/configuration text, including C++.
& ./wsp/tools/Test-SourceStyle.ps1 -RepositoryRoot . `
    -SourcePath @('src', 'include', 'tests', 'cmake', '.github',
        'CMakeLists.txt', 'CMakePresets.json', 'Doxyfile')
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
Invoke-CheckedCommand doxygen @('Doxyfile')

# Build stage
Invoke-CheckedCommand cmake @('--preset', 'windows-x64-debug')
Invoke-CheckedCommand cmake @('--build', '--preset', 'windows-x64-debug')

# Full test stage
Invoke-CheckedCommand ctest @(
    '--preset', 'windows-x64-debug',
    '--output-on-failure', '--no-tests=error')
```

**Lint gap:** the workflow has no separate lint step. Compiler warnings are
errors (`/W4 /WX` for MSVC), but they occur during the build. Add selected
PowerShell/Markdown checks and a clang-tidy analysis configuration according
to the adoption record. WSP's clang-tidy integration needs a supported Ninja
or Makefile analysis generator; enabling it in this Visual Studio product
preset is not sufficient.

WFC owns C++ sources. The common style profile now applies the 80-character
rule to those files too. Add strict owned C++ Doxygen inputs/extraction checks.
Create the project-owned `Doxyfile` before enabling this example, using
`INPUT = src include tests` and file patterns for all owned C++ extensions.
Provision Doxygen and apply the strict warning settings from the generic
template; its C-only `FILE_PATTERNS` must be expanded for C++.
The legacy C-only source-quality tool does not scan `.cpp` or `.hpp`; use the
new physical validator plus a separate C++ documentation build. Retain
x86/native ARM64 CI and Debug artifact/context collection.

## WSH

Sources: [Windows CI workflow](https://github.com/Thewafflication/wsh/blob/9b89404bf99212062050fb694b412f67f463405c/.github/workflows/m2.yml),
[presets](https://github.com/Thewafflication/wsh/blob/9b89404bf99212062050fb694b412f67f463405c/CMakePresets.json),
[registered tests](https://github.com/Thewafflication/wsh/blob/9b89404bf99212062050fb694b412f67f463405c/tests/CMakeLists.txt),
and [dependency setup](https://github.com/Thewafflication/wsh/blob/9b89404bf99212062050fb694b412f67f463405c/tools/Install-BuildDependencies.ps1).

CI configures `x64-debug` into `out/build/source-quality` with quality tests
enabled, builds `wsh` and `wsh_shared`, and runs project/WSP traceability and
source checks before the separate product Debug job.

**Filter gap:** the workflow regex includes m2 through m9 traceability tests
but only m2 through m5 source-quality tests. The inspected registration also
has m6 and m7 source-quality tests. The proposed lint command includes m2
through m9 source-quality names as well. The broad `quality` label also
includes evidence validators requiring product test results, so it is not a
standalone lint inventory. CTest's
[`DEPENDS`](https://cmake.org/cmake/help/latest/prop_test/DEPENDS.html)
controls ordering but does not
select filtered-out prerequisite tests. Verify the selected inventory as tests
are added; the full product stage remains unfiltered.

```powershell
# Lint stage: reuse CI configuration and include later source-quality checks.
& ./wsp/tools/Test-SourceStyle.ps1 -RepositoryRoot . `
    -SourcePath @('src', 'include', 'tests', 'tools', 'cmake', '.github',
        'CMakeLists.txt', 'CMakePresets.json', 'Doxyfile')
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
& ./wsp/tools/Test-CSourceQuality.ps1 -RepositoryRoot . `
    -SourcePath @('src', 'include', 'tests', 'tools', 'cmake') `
    -Doxyfile 'Doxyfile'
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

Invoke-CheckedCommand cmake @(
    '--preset', 'x64-debug', '-B', 'out/build/source-quality',
    '-DWSH_ENABLE_SOURCE_QUALITY_TESTS=ON')
Invoke-CheckedCommand cmake @(
    '--build', 'out/build/source-quality', '--target', 'wsh', 'wsh_shared')
Invoke-CheckedCommand ctest @(
    '--test-dir', 'out/build/source-quality',
    '-R', '^m[2-9]-(traceability|source-quality)$',
    '--output-on-failure', '--no-tests=error')

# Build stage: separate product configuration, matching CI's Debug job.
Invoke-CheckedCommand cmake @(
    '--preset', 'x64-debug', '-DWSH_ENABLE_SOURCE_QUALITY_TESTS=OFF')
Invoke-CheckedCommand cmake @('--build', '--preset', 'x64-debug')

# Full product suite; required quality checks already ran in the lint stage.
Invoke-CheckedCommand ctest @(
    '--preset', 'x64-debug', '--output-on-failure',
    '--timeout', '120', '--no-tests=error')
```

If combining the configurations, enable quality tests and execute the complete
unfiltered inventory rather than dropping quality checks.

The added top-level C documentation gate covers owned source and test/helper
C beyond any milestone filter. Create a strict project-owned `Doxyfile` with
matching inputs (`src include tests tools cmake`) before enabling this example;
existing milestone Doxyfiles remain useful but do not by themselves prove
complete owned-source coverage. Record the same ownership exclusions in both
validators and Doxygen.

**Setup:** initialize recursive submodules and provision WPM, Ninja, PowerShell,
Doxygen, and pinned TinyCC/WCRT. The dependency script defaults inspected here
are TinyCC `0.9.28-rc.1444+9a4be30f` and WCRT `1.0.0`; it validates installation
and uses `TCC_HOME` and `WCRT_HOME`. Run
`tools/Install-BuildDependencies.ps1 -Architecture x64` during explicit setup,
not commits: it installs packages and changes WPM configuration. CI's
latest-WPM bootstrap and unversioned Doxygen installation need controlled
versions for reproducible setup.

CI uses `continue-on-error` while collecting evidence, then explicitly fails
the gate on a failed build or test. A local wrapper must preserve the original
failure. Copying only the permissive intermediate step would hide it. Retain
evidence collection, package creation, and architecture validation in CI.

## Adoption Validation

Point the [YAML template](pre-commit-config.yaml) at project-owned wrappers
using these commands and the checked-command failure contract. Add any missing
applicable profile checks; existing workflow omissions do not waive WSP rules.
Test successful and deliberate failing commits in isolation, inspect complete
inventories/fresh evidence, then run the adapted x64 commands in the actual
project environment before enabling its hook. These are inspected examples,
not consumer build or test results.
