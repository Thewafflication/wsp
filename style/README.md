# Style

**Content type:** Requirements, guidance, and technology profiles

This directory defines conventions that make engineering artifacts consistent,
reviewable, and suitable for automated validation. It consolidates practices
already visible in WPM, WCRT, and the TinyCC package project without assuming
that every project uses the same language or toolchain.

## Contents

- [Common source/configuration style](source-style.md) extends the strict
  80-character physical-line and whitespace baseline to owned languages.
- [Language profiles](language-style.md) cover C, C++, Python, YAML, JSON,
  Makefiles, PowerShell, C#, Visual Basic, CMake, and other applicable languages.
- [Structured source documentation](source-documentation.md) supplies Doxygen
  contracts, native documentation equivalents, and extraction requirements.

- [Documentation style](documentation-style.md) applies to project-authored
  Markdown documentation.
- [Visual style](visual-style.md) defines the preferred color palette and
  typography for project-owned web pages and rendered documentation; normative
  interaction, presentation, and accessibility behavior is defined by the
  [UX/UI profile](../ux/README.md).
- [Artifact identifiers](artifact-identifiers.md) defines stable names for
  requirements, test cases, and ADRs.
- [Requirements writing](requirements-writing.md) defines how to write
  verifiable normative statements.
- [C source style](c-style.md) defines mandatory source-documentation and line-
  length requirements for project-owned C sources and headers.
- [PowerShell style](powershell-style.md) is a profile for automation and test
  scripts.
- [CMake style](cmake-style.md) is a profile for CMake projects and presets.
- [Static analysis](static-analysis.md) defines the clang-tidy baseline,
  required CI gate, finding control, and evidence.
- [Commit checks and recommended linters](../processes/commit-checks.md)
  map language checks and shared validators to applicable WSP rules.
- [Windows version resources](windows-version-resources.md) defines executable
  and DLL `VERSIONINFO` requirements.

## Adoption

Documentation style and artifact identifiers are intended for all adopting
projects. Language and tool profiles apply when a project uses the named
technology. Once applicable, normative statements within a profile are
mandatory unless the project records an approved tailoring decision.

The C profile adopts WCRT's source-quality baseline: Doxygen documentation and
an 80-character physical-line limit for every project-owned C source and header
file.

The common source/configuration profile extends that ceiling to every owned
language selected above. Native help/XML/schema documentation remains valid
through the controlled Doxygen-equivalent contract and extraction rules.

Generated and third-party content is excluded unless a project explicitly
states otherwise. Existing projects may retain established conventions when a
mechanical conversion would add risk without improving clarity.

Published project-owned Windows executables and DLLs should select the Windows
version-resource profile even when their implementation language is not C.
