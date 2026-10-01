# Common Source and Configuration Style

**Content type:** Requirements and guidance

## Applicability

This baseline applies to project-owned source and build/configuration text in
C, C++, Python, YAML, JSON, Makefiles, PowerShell, C#, Visual Basic, CMake, and
other adopted language profiles. Generated files, vendored code, package
lockfiles produced by tools, and external protocol/test fixtures may be outside
the owned scope only when the check inventory identifies them explicitly.
Manual edits to an excluded generated file do not make it maintained source.

Previously adopted WSP pins retain their original obligations. Projects adopting
this baseline record migration, exclusions, or approved tailoring in their
adoption record; they do not silently declare existing violations compliant.

## Requirements

### WSP-STYLE-0001 — Physical Line Length

Each physical line in an in-scope source or configuration file shall contain
no more than 80 characters, including indentation, comments, and literals.

The shared validators measure decoded UTF-16 code units, excluding a UTF-8
BOM and the line terminator. A tab counts as one physical character, not its
rendered column width. ASCII/BMP characters count once; supplementary Unicode
characters count twice. Projects should also keep rendered lines readable.

URLs, imports, string literals, preprocessor directives, JSON values, and
formatter output are not automatic exceptions. Split or restructure content
without changing meaning; if the language or external contract prevents that,
record a narrow, justified tailoring or explicitly owned fixture exclusion.

**Verification:** Full-scope `Test-SourceStyle.ps1` scan and exclusion review.

### WSP-STYLE-0002 — Text Encoding

Owned source/configuration files shall use valid UTF-8 unless a required
consumer format has a documented encoding exception.

Projects should use UTF-8 without a BOM unless their consumer requires one,
and control compatible line endings through `.gitattributes` or equivalent.

**Verification:** Strict decoding and consumer/toolchain checks.

### WSP-STYLE-0003 — Whitespace

In-scope source/configuration text shall have no trailing spaces or tabs and
shall end with a newline when nonempty.

Whitespace that is required data needs a controlled fixture boundary or
tailoring; a formatter shall not silently alter such data.

**Verification:** Shared validator and semantic fixture inspection.

### WSP-STYLE-0004 — Language-Safe Formatting

Projects shall control indentation and formatting settings that preserve
language syntax and behavior, including Make recipe prefixes and significant
Python/YAML whitespace.

Use four spaces for C, C++, Python, PowerShell, C#, Visual Basic, Rust, and
Java; use two for YAML, JSON, JavaScript/TypeScript, shell, HTML/CSS, and CMake
unless a selected language/tool convention or approved existing project style
requires otherwise. Preserve Make recipe tabs and Go's standard formatter.
Do not perform mechanical wrapping that changes strings, YAML folding, shell
commands, macros, or Make recipes.

**Verification:** Language formatter check, configuration review, and tests.

### WSP-STYLE-0005 — Controlled Language Checks

Each project shall select reproducible language-specific syntax, style, and
analysis checks for its owned languages and treat selected findings and tool
execution errors as failures.

See [language profiles](language-style.md). Formatters complement syntax,
analysis, documentation, and physical-line checks; a successful formatter does
not prove an 80-character limit or semantic correctness.

**Verification:** Check inventory, pinned configuration, and negative tests.

### WSP-STYLE-0006 — Documentation Contracts

Owned modules/files, public types and members, functions, and non-obvious
internal behavior shall have structured documentation describing purpose,
inputs, outputs, ownership/lifetime, errors, and side effects where applicable.

Use Doxygen-style documentation where the language is supported, or the native
structured equivalent with a controlled documentation adapter or adjacent
reference when direct Doxygen extraction is unavailable. See
[source documentation](source-documentation.md). Do not insert illegal comment
syntax into strict data formats.

**Verification:** Documentation build/diagnostics and contract review.

### WSP-STYLE-0007 — Complete Enforcement Scope

Lint and CI shall scan the complete declared owned source/configuration scope
for the physical style baseline and selected language/documentation rules.

Exclusions and suppressions shall identify their ownership boundary or approved
tailoring. Failures shall identify the rule, file, and line when available.
Missing inputs and zero selected files are errors rather than a successful
empty scan.

**Verification:** Deliberate overlength, whitespace, documentation, and missing
input checks; source inventory comparison.

## Shared Validator

Invoke `wsp/tools/Test-SourceStyle.ps1` with an explicit project root and source
roots. The default selection includes the listed language extensions,
`Makefile`, `GNUmakefile`, `CMakeLists.txt`, and common style configuration names.
Use `IncludeExtension`/`IncludeName` to cover additional dialects. Markdown
prose and binaries are not selected by default.

```powershell
& ./wsp/tools/Test-SourceStyle.ps1 `
    -RepositoryRoot . `
    -SourcePath @('src', 'include', 'tests', 'tools', '.github') `
    -ExcludePath @('tests/fixtures/external-format')
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
```

This is a direct PowerShell invocation; native `pwsh -File` wrappers should
use a project script to pass arrays reliably. Select actual existing paths.
Keep outputs, submodules, vendored libraries, and tool caches outside scanned
roots or exclude them explicitly. The validator checks physical text, not
indentation, language syntax, or documentation meaning.

For C, also run `Test-CSourceQuality.ps1` with a strict project Doxyfile as
required by WSP-CSTYLE-0001 through WSP-CSTYLE-0005. Those stable requirements
remain intact. The new common rule extends the physical baseline to the other
owned languages; it does not remove C's documentation gate.
