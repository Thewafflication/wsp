# Source Style Configuration Examples

**Content type:** Informative templates

Copy the [EditorConfig template](source-style.editorconfig) into the owning
project as `.editorconfig`. Review overrides against declared language
profiles, existing conventions, and required consumer formats. Its
`max_line_length` is an editor hint, not a portable enforcement guarantee.
Use `Test-SourceStyle.ps1` for the strict physical line rule.

## C and C++ Formatter

An example project-owned `.clang-format` is:

```yaml
BasedOnStyle: LLVM
IndentWidth: 4
ColumnLimit: 80
BreakBeforeBraces: Allman
UseTab: Never
```

Use a pinned clang-format in check mode. Include all owned headers/source,
and run Doxygen and clang-tidy independently. Formatting does not establish
contract completeness or force every unbreakable line below the ceiling.

## Python

An example project-owned `ruff.toml` is:

```toml
line-length = 80

[lint]
select = ["E", "F", "I", "B"]
```

Declare the project's supported Python version separately. Run `ruff check`
and `ruff format --check` on the complete owned Python inventory. The selected
E501 rule has exemptions, including some long words/URLs; the shared strict
scan rejects those unless explicitly tailored. Choose a controlled docstring
rule set appropriate to the native/Doxygen documentation convention.

## YAML

An example project-owned `.yamllint.yaml` is:

```yaml
extends: default
rules:
  indentation:
    spaces: 2
  key-duplicates: enable
  line-length:
    max: 80
    allow-non-breakable-words: false
    allow-non-breakable-inline-mappings: false
  document-start: disable
```

Keep duplicate-key checks enabled. Add consumer-specific validation, such as
`pre-commit validate-config` for hooks. Review YAML dialect/scalar semantics
and GitHub workflow expression quoting when applying other rules.

## JSON

Use strict parsing with duplicate-key rejection, schema validation where
available, and a controlled two-space formatter in check mode. JSON formatter
line-width settings are not a proof of an 80-character ceiling. Do not insert
comments or split a string across physical lines illegally; record narrow
tailoring when an external value cannot be represented within the rule.

## PowerShell, C#, and Visual Basic

Use the PSScriptAnalyzer settings and failure wrapper in the
[commit example](commit-checks-template.md), with full owned scope, strict
physical scan, and structured help validation. Commit native .NET EditorConfig
and analyzer severities separately from the general editor template. Pin the
SDK with `global.json` and control analyzer packages/versions in project files.

For C#/VB.NET, use `dotnet format --verify-no-changes` with the canonical
solution/project and declared SDK, compiler/analyzer checks, and the strict
physical scan. Enable compiler XML documentation output and review missing
public contract diagnostics; do not imply that one C# analyzer supports VB.
Use a validated documentation adapter or native generator for VB XML comments.

## Make and Other Languages

Preserve Make recipe tabs; neither EditorConfig nor a generic whitespace fixer
may replace them with spaces. Choose the project dialect, validate real build
targets in disposable output, and use a shell analyzer for applicable recipes.
Preserve Go's gofmt output and native documentation styles as described in the
[language profiles](../style/language-style.md). No formatter's normal defaults
silently waive WSP's physical limit.
