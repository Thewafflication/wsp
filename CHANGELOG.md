# Changelog

**Content type:** Controlled release history

This file records material changes to WSP releases. Requirement identifiers are
not reused when requirements are removed or superseded.

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
