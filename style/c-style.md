# C Source Style

**Content type:** Requirements and guidance

This profile applies to project-owned C sources and headers. Generated and
third-party sources are excluded unless explicitly brought into scope.

The requirements in this profile apply to every WSP-adopting project that owns
C source or header files. A project may deviate only through the WSP tailoring
process with a documented rationale.

## Source Documentation Requirements

### WSP-CSTYLE-0001 — File Documentation

Every project-owned `.c` and `.h` file shall contain a Doxygen-style file
comment using `/** ... */` or `/*! ... */` syntax and an `@file` command.

### WSP-CSTYLE-0002 — Function Documentation

Every project-owned function declaration and definition shall have a
Doxygen-style comment that describes its purpose, parameters, return value,
and observable errors or side effects where applicable.

When a declaration and definition are both visible to Doxygen, a project may
place the complete contract on the declaration and use `@copydoc` or an
equivalent reference on the definition rather than duplicate the contract.

### WSP-CSTYLE-0003 — Entity Documentation

Public macros, constants, types, structures, unions, enumerations, objects, and
structure or union members shall have Doxygen-style documentation.

Internal functions, types, objects, and non-obvious implementation decisions
shall have Doxygen-style documentation sufficient to maintain the code without
relying on undocumented behavior.

Documentation shall describe contracts and intent rather than merely repeat an
identifier or restate the implementation.

### WSP-CSTYLE-0004 — Physical Line Length

Every physical line in a project-owned `.c` or `.h` file shall contain no more
than 80 characters, including indentation and comments.

URLs, string literals, preprocessor directives, generated-looking tables, and
other inconvenient constructs are not automatic exceptions. They shall be
structured, split, shortened, or locally tailored with a documented rationale.

### WSP-CSTYLE-0005 — Automated Enforcement

Each project shall automatically scan every in-scope `.c` and `.h` file, reject
physical lines longer than 80 characters, and run Doxygen with warnings treated
as errors.

The validation shall detect missing or incomplete required documentation,
report the file and line number for each violation, and return a nonzero exit
status when any violation exists.

## Language Edition and Portability

- A project shall declare its supported C language edition or editions.
- Build configuration should require the selected edition and disable
  compiler-specific language extensions unless an extension is intentional and
  documented.
- Code should compile with every toolchain identified as a project release
  gate.
- Platform-specific behavior should be isolated and guarded by explicit target
  detection.
- Compiler and platform assumptions should be documented and verified where
  practical.

WPM currently selects C99 and checks for unsupported C11 tokens. WCRT selects
language behavior by conformance milestone. WSP therefore does not prescribe a
single C edition for every project.

## Formatting

- Use spaces for indentation and do not mix tabs and spaces within source.
- Use braces and indentation consistently within the repository.
- Keep declarations close to the scope in which they are used, subject to the
  selected language edition.
- Prefer one statement per line.
- Avoid trailing whitespace.
- Obey the 80-character physical-line limit in WSP-CSTYLE-0004.

Formatting tools may enforce a project-owned configuration. The configuration
should be committed and CI should use the same version or compatible behavior.

## Interfaces and Names

- Public identifiers should use a documented project prefix when collision is
  possible.
- Internal linkage should be used for file-local functions and objects.
- Header files should be self-contained and safe to include in their supported
  contexts.
- Names should describe purpose rather than type alone.
- Ownership, lifetime, units, buffer sizes, error signaling, and valid ranges
  should be clear from the interface or its documentation.

## Documentation

Document contracts and intent rather than translating the implementation into
prose. Public interfaces should describe parameters, return values, ownership,
side effects, failure behavior, and relevant portability constraints.

The documentation requirements above adopt the source baseline already
enforced by WCRT.

## Validation

These source-quality requirements shall be release gates. A validator shall
enumerate only in-scope files and exclude generated and third-party sources by
explicit path rules rather than by silently ignoring validation failures.
