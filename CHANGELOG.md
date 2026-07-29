# Changelog

**Content type:** Controlled release history

This file records material changes to WSP releases. Requirement identifiers are
not reused when requirements are removed or superseded.

## Unreleased

### Added

- toolchain-specific TinyCC and GCC/Clang C flags for WSP Debug and Release
  profiles, with GDB and DWARF as the default Debug path;
- Debug CI evidence requirements covering test results, tested binaries,
  symbols, and applicable packages;
- native ARM64 execution requirements for normal ARM64 GitHub CI; and
- automatic GDB all-thread backtraces for failing Debug tests;
- GitHub Action runtime-currency requirements that default new and updated
  workflows to maintained action majors on supported runtimes and require
  compatibility checks for self-hosted runners; and
- Annex A documenting the GitHub Node.js 20 deprecation, current WSP action
  defaults, migration review, and compatibility exceptions; and
- Annex B recording WPM's native standard-input testing lesson, false-positive
  mechanism, review questions, and a regression matrix for WCRT and other
  native runtimes; and
- Annex C documenting the shared logging tools and visual-style guidance as
  interim additions planned for incorporation into the main chapters in WSP
  1.1.

### Changed

- updated the WSP documentation workflow to Node.js 24-based releases of the
  checkout and artifact actions; and
- linked the common test strategy to Annex B for interactive native-input
  verification.

## 1.0.0 — 2026-07-26

### Added

- common requirements management and adoption by pinned Git submodule;
- architecture decision record guidance and templates;
- an iterative WSP software lifecycle and common project-process requirements;
- Personal Software Process alignment and a selectable personal-process
  profile;
- a selectable Security/DFS profile aligned with IEC 62443-4-1 and related
  ISO/IEC and ISO/IEC/IEEE standards;
- ISO/IEC/IEEE 29119-aligned testing requirements, templates, and evidence
  conventions;
- documentation, identifier, C, PowerShell, and CMake style rules;
- Windows executable and DLL version-resource requirements and template;
- Windows Authenticode signing, Defender scanning, and false-positive response
  requirements and release-evidence template;
- reusable validation and report-generation tools;
- a Pandoc and MiKTeX pipeline for one linked release PDF;
- a GitHub Actions workflow that builds the PDF and publishes it with GitHub
  releases; and
- repository ignore rules for generated documentation, tool caches, editor
  state, operating-system metadata, and LaTeX intermediates;
- embedded PDF identity metadata and SHA-256 release checksums;
- GitHub build-provenance attestations for trusted PDF builds; and
- a selectable ETSI PAdES document-signing profile.

### Changed

- standardized the project name as Waughtal Software Process;
- established Design for Security as the canonical DFS term while preserving
  a mapping for WPM's legacy Security Design title; and
- grouped reusable templates at the end of the release document.
