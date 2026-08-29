# Changelog

**Content type:** Controlled release history

This file records material changes to WSP releases. Requirement identifiers are
not reused when requirements are removed or superseded.

## 1.2.0 — 2026-08-27

### Added

- a selectable information-for-users profile linked to ISO/IEC/IEEE
  26514:2022, with atomic requirements for planning, audience and task
  analysis, manuals and help content, command and API reference, information
  quality, accessibility, validation, synchronized release, maintenance, and a
  project-owned information plan and acceptance record;
- a selectable UX/UI profile covering human-centred development, interaction
  and interface design, accessible information presentation, EN 301 549
  applicability, assistive-technology interoperability, evaluation, and
  release evidence, with atomic behavioral controls and a project-owned
  acceptance-specification template for exact thresholds and coverage;
- a standardized clang-tidy profile for project-owned C and C++ source, with
  controlled configuration, fail-closed CI, finding disposition, and retained
  release evidence requirements;
- target-scoped CMake helpers that apply the common warning baseline, run
  clang-tidy during compilation, and enable compiler and linker hardening;
- a PE image verifier for ASLR, NX, 64-bit high-entropy address space, and
  optional Control Flow Guard characteristics;
- TinyCC-first hardening that rejects silently ignored compatibility options,
  enables supported Windows PE protections, documents its built-in ELF
  protections, and preserves TinyCC as the default compiler; and
- native build-hardening and final-binary verification requirements covering
  stack protection, ASLR/PIE, non-executable memory, fortified library calls,
  ELF RELRO/immediate binding, and available control-flow protection; and
- an upstream-issue requirement for changes or workarounds affecting
  Thewafflication-owned dependencies or dependencies distributed as WPM
  packages, including attachment or linkage of the workaround.

### Fixed

- release-document tables that could extend beyond the printable page area;
- documentation CI now verifies manifest and bookmark order, metadata,
  extractable text, table-of-contents placement, internal and external links,
  and page boundaries, with positive and controlled negative tests; and
- the release-readiness record now captures every-page visual review evidence
  and an explicit PAdES applicability decision and rationale.

### Changed

- integrated former Annex A into the common GitHub Action requirements and
  migration guidance, former Annex B into three native standard-input testing
  requirements and its test-design guidance, and former Annex C into the main
  logging and visual-style chapters;
- added the logging and visual-style chapters to the controlled documentation
  manifest and retired the three superseded interim annex chapters;
- the TinyCC warning baseline now includes `-Wunsupported`, ensuring options
  accepted only for GCC compatibility cannot be mistaken for implemented
  security controls.

## 1.1.0 — 2026-08-22

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
  interim additions planned for incorporation into the main chapters in a
  later release; and
- a reusable milestone-document pack, generalized from WSH practice, covering
  work planning, design, review, closeout, and optional chronological work
  logging.

### Changed

- updated the WSP documentation workflow to Node.js 24-based releases of the
  checkout and artifact actions; and
- linked the common test strategy to Annex B for interactive native-input
  verification; and
- clarified that approved deferred objectives do not by themselves block a
  release, remain outside completion and verification claims, and must be
  closed, revised, or explicitly carried forward during release approval.

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
