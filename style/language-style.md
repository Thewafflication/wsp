# Language Style Profiles

**Content type:** Selectable profile requirements and guidance

Every applicable language profile uses the
[common physical style baseline](source-style.md), including 80-character
lines and structured [source documentation](source-documentation.md).
The following rules apply to owned files; pin tool versions/settings and
record any justified tailoring. Examples of tool commands are recommendations,
not substitutes for the project's complete check inventory.

## C

### WSP-LANG-0001 — C Profile

Projects owning C shall apply [C style](c-style.md), declare their language
edition, require that edition in the build, and use reviewed compiler-warning
and static-analysis configurations for their owned translation units.

Use four-space indentation, explicit braces for control bodies, meaningful
project-prefixed public identifiers, self-contained headers, and explicit
ownership/error contracts. Doxygen and the full physical scan remain required;
clang-format is an optional check with project settings and `ColumnLimit: 80`.
Compiler warnings and clang-tidy follow the existing WSP profiles.

**Verification:** Build/analysis, source-quality validator, and interface review.

## C++

### WSP-LANG-0002 — C++ Profile

Projects owning C++ shall declare the supported C++ edition and use controlled
formatting, compiler warnings, clang-tidy analysis, and Doxygen documentation
for owned headers, translation units, types, templates, and public members.

Use four-space indentation, explicit control-body braces, self-contained
headers, namespaces, RAII for resource ownership, and explicit exception/error
contracts. Prefer standard-library value/ownership types; raw pointers shall
have a documented ownership role. Avoid undocumented implicit conversions,
global `using namespace` directives in headers, and unjustified macros.
Document template parameters with `@tparam` and special lifetime/thread rules.
Use clang-format check mode with `ColumnLimit: 80`, plus the strict physical
scan because formatting does not split every long literal or identifier.

**Verification:** Formatter/analysis/build, documentation, and ownership review.

## Python

### WSP-LANG-0003 — Python Profile

Projects owning Python shall use four-space indentation, a declared interpreter
baseline, controlled lint rules, and documented module/class/function contracts.

Follow [PEP 8](https://peps.python.org/pep-0008/) naming and import organization;
WSP chooses an 80-character ceiling rather than PEP 8's normal 79-character
code recommendation. Use `snake_case` functions/variables, `CapWords` classes,
specific exceptions, context managers, and type annotations on public APIs
where feasible. Pin Ruff and select error/import, unused-code, and deliberate
documentation rules. Use `ruff check` and `ruff format --check` separately.
Ruff E501 has exemptions, so retain the shared strict physical scan.

**Verification:** Ruff, syntax/tests, physical scan, and contract review.

## YAML

### WSP-LANG-0004 — YAML Profile

Owned YAML shall use two-space indentation, prohibit indentation tabs and
duplicate keys, declare intended scalar types, and pass the consumer's schema
or configuration validation where one is available.

Use explicit quotes when a value could be interpreted as a number, date,
boolean, or expression differently by supported consumers. Keep controlled
key ordering consistent, and document anchors or non-obvious merge behavior.
Use yamllint with explicit indentation/key-duplicate/line-length rules; disable
unbreakable-word exemptions to match WSP's strict ceiling. Review YAML block
scalar wrapping because folded/literal styles have different value semantics.

**Verification:** yamllint, consumer/schema validation, and scalar review.

## JSON

### WSP-LANG-0005 — JSON Profile

Owned JSON shall use strict JSON syntax, two-space indentation, unique object
keys, and the applicable schema where one is controlled.

Do not add comments, trailing commas, NaN, or Infinity to strict JSON.
Detect duplicate keys during validation; parsers that keep only the last value
do not prove uniqueness. Use a pinned formatter's check mode, a strict parser,
schema validation, and the shared physical scan. Do not split a JSON string
across lines illegally or change its value solely to satisfy formatting;
use a data-model change or controlled tailoring. Document the configuration
contract in an adjacent reference/schema rather than illegal inline comments.

**Verification:** Strict parsing, duplicate-key/schema checks, and physical scan.

## Makefiles

### WSP-LANG-0006 — Make Profile

Projects owning Makefiles shall declare their Make dialect and preserve its
recipe-prefix, continuation, quoting, and shell semantics in formatted source.

GNU Make normally requires recipe-prefix tabs; preserve them or explicitly
declare the supported `.RECIPEPREFIX` alternative. Use spaces for surrounding
prose/layout, document public variables and targets, distinguish recursive
versus immediate assignments intentionally, and mark non-file targets phony
where appropriate. Never blanket-replace tabs or silently ignore command
errors. Validate actual targets in a disposable project-owned build directory;
do not assume a dry run proves syntax or has no side effects.

**Verification:** Dialect build checks, shell analysis, and physical scan.

## PowerShell

### WSP-LANG-0007 — PowerShell Profile

Owned PowerShell shall follow [PowerShell style](powershell-style.md), use
four-space indentation, approved Verb-Noun function names, and structured
comment-based help for reusable scripts and exported functions.

Pin PSScriptAnalyzer, reject selected diagnostics explicitly, avoid aliases in
controlled scripts, preserve native exit status, and avoid assignments to
automatic variables. Use the shared scan for the strict line ceiling, including
help/comments. Prefer natural expression/argument wrapping over fragile
backtick continuations. The example documentation bridge preserves `Get-Help`.

**Verification:** Parsing, PSScriptAnalyzer, help review, and failure tests.

## C#

### WSP-LANG-0008 — C# Profile

Owned C# shall declare its language/.NET SDK baseline, use controlled
EditorConfig/Roslyn rules, and provide structured public API documentation.

Use four-space indentation, explicit control-body braces, `PascalCase` types
and public members, `camelCase` locals/parameters, and a consistent private-field
convention. Use `using`/`IDisposable` ownership, explicit nullability policy,
and cancellation/error contracts for asynchronous APIs. Use `///` XML comments
with summary, parameter, return, and exception information; include them in
the documentation pipeline. Set SDK/analyzer versions and diagnostic severity
in controlled project files. Use `dotnet format --verify-no-changes` plus build
analysis and the shared physical scan; formatter settings alone do not force
all lines below 80 characters.

**Verification:** Format/analyzer/build checks, XML docs, and contract review.

## Visual Basic

### WSP-LANG-0009 — Visual Basic Profile

Owned Visual Basic shall declare its dialect/runtime and use controlled
formatting, type-safety checks, and public API documentation appropriate to
that dialect.

For VB.NET, use four-space indentation, `Option Explicit On`,
`Option Strict On`, and `Option Infer On` unless specifically tailored. Use
`PascalCase` types/public members, `camelCase` locals/parameters, explicit
`If`/loop blocks, `Using` resource management, and structured `'''` XML comments.
Use applicable Roslyn rules, .NET formatting/build checks, and the physical
scan. Doxygen does not natively parse VB.NET; use a validated adapter or native
XML documentation generator with an explicit coverage inventory.

VB6/VBA projects use the supported native equivalent, including
`Option Explicit`, documented COM/resource lifetimes and error behavior, and
a reviewed compatible analyzer. Do not apply VB.NET compiler switches to them.

**Verification:** Dialect compiler/analysis, documentation, and physical scan.

## CMake

### WSP-LANG-0010 — CMake Profile

Owned CMake shall follow [CMake style](cmake-style.md), use two-space
indentation, and document public functions, arguments, targets, and cache
variables with structured comments or generated reference documentation.

Keep configuration target-scoped and validate unsupported combinations.
Use gersemi in check mode with controlled two-space settings where selected;
use actual configure/build checks and the physical scan independently.

**Verification:** Formatting, configure/build failures, and documentation.

## Other Applicable Languages

### WSP-LANG-0011 — Additional Language Profiles

Projects owning another implementation/configuration language shall control
its edition/dialect, naming/indentation conventions, analyzer/formatter checks,
documentation format, and allocation to the common style baseline.

Recommended starting points include:

- JavaScript/TypeScript: ESLint and Prettier check mode, two spaces, JSDoc/TSDoc
  contracts, and strict TypeScript settings where applicable.
- Shell: ShellCheck and shfmt check mode; two spaces, a declared shell dialect,
  quoted expansions, and documented CLI/exit-status contracts.
- Rust: rustfmt check mode and Clippy; four spaces, rustdoc contracts, explicit
  unsafe-block safety rationale, and reviewed lint severities.
- Go: gofmt verification and go vet; preserve formatter tabs and Go doc
  comments. Wrap safely or tailor unbreakable lines explicitly.
- Java: a pinned Checkstyle/formatter configuration; four spaces and Javadoc.
- HTML/CSS/XML: selected syntax/schema/accessibility checks, two-space default
  layout, and comments or adjacent interface documentation.
- SQL: a declared database dialect, controlled SQLFluff rules, and documented
  schema/query contracts; do not assume one dialect accepts another's syntax.

Select only applicable tools and verify their support against the project's
declared versions. Native documentation styles map to the same contract fields
and feed an appropriate generator/adapter. Language-default formatting is not
an automatic exemption from WSP-STYLE-0001.

**Verification:** Adoption record, check inventory, and positive/negative checks.

## Tool References

- [Doxygen documentation](https://www.doxygen.nl/manual/docblocks.html)
- [Ruff rules](https://docs.astral.sh/ruff/rules/)
- [yamllint rules](https://yamllint.readthedocs.io/en/stable/rules.html)
- [.NET format](https://learn.microsoft.com/en-us/dotnet/core/tools/dotnet-format)
- [GNU Make recipes](https://www.gnu.org/software/make/manual/html_node/Recipe-Syntax.html)
- [Visual Basic XML docs](https://learn.microsoft.com/en-us/dotnet/visual-basic/language-reference/xmldoc/)
