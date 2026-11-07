# Project Work Record

**Content type:** Template

**Project:** Waughtal Software Process (WSP)

**Product and interface baseline:** WSP v1.0.0 contract reference fa84ddedf37a4262ba0d21ffb95890a2d5a89d5c

**Status:** Proposed

**Owner:** WSP Maintenance Team

**Approval:** WSP Governance Board

## Project Overview

The Waughtal Software Process (WSP) provides reusable engineering requirements, practices, templates, and validation tools for Waughtal projects. It defines common foundations for architecture, implementation, verification, release, and reporting while allowing project-specific deviations and needs.

WSP testing terminology, processes, and test documentation are aligned with ISO/IEC/IEEE 29119 software-testing series. The repository answers two questions:
1. What engineering expectations apply to our projects?
2. What evidence demonstrates that a project met those expectations?

## Scope

Content in this repository may include:
- Common software, quality, security, safety, and documentation requirements
- Architecture decision record (ADR) guidance and templates
- Requirements-writing and documentation style guidance
- Test plans, test cases, test procedures, and report templates
- Verification and traceability conventions
- Review, change-control, and release practices
- Reusable schemas or tools that validate engineering artifacts

## Practice Profiles

WSP separates broadly applicable engineering practices from technology and delivery profiles. Adopting projects select only the practices that apply:

- Common practices covering requirements management, software lifecycle, documentation, and testing
- Selectable profiles including PSP practices, UX/UI design, security, C/C++ source, PowerShell automation, CMake builds, clang-tidy analysis, TinyCC hardening, Windows version resources, code signing, and more

## Requirement Register

Each requirement in WSP is classified by type and tracked for traceability:

### WSP-REQ-0001 — Repository Scope and Purpose

- **Type:** Requirement
- **Description:** WSP shall define engineering expectations and evidence requirements for Waughtal projects
- **Priority:** Mandatory
- **Status:** Approved

### WSP-REQ-0002 — ISO/IEC/IEEE 29119 Alignment

- **Type:** Requirement
- **Description:** WSP test documentation shall align with ISO/IEC/IEEE 29119 series
- **Priority:** Mandatory
- **Status:** Approved

### WSP-REQ-0003 — Project-Specific Deviations

- **Type:** Requirement
- **Description:** Projects may formally tailor WSP practices with justified deviations
- **Priority:** Should
- **Status:** Approved

### WSP-REQ-0004 — Content Type Classification

- **Type:** Requirement
- **Description:** Every document shall identify its content type: Requirement, Guidance, Template, or Example
- **Priority:** Mandatory
- **Status:** Approved

### WSP-REQ-0005 — Key Word Conventions

- **Type:** Requirement
- **Description:** "shall" indicates mandatory, "should" indicates recommended, "may" indicates permission
- **Priority:** Mandatory
- **Status:** Approved

## Guidance Register

Guidance recommendations for WSP adopters:

### WSP-GDL-0001 — Profile Selection

- **Description:** Adopting projects should select only the practices that apply to their technology and delivery context
- **Rationale:** Not every practice applies to every project; separation of concerns improves clarity
- **Reference:** WSP Practice Profiles section

### WSP-GDL-0002 — Evidence Documentation

- **Description:** Evidence demonstrating compliance shall reference specific requirement identifiers and test results
- **Rationale:** Traceability between requirements and evidence is essential for verification
- **Reference:** WSP testing terminology alignment with ISO/IEC/IEEE 29119

### WSP-GDL-0003 — Template Usage

- **Description:** Project-owned artifacts shall start from WSP templates and may be customized with approved deviations
- **Rationale:** Templates provide consistent starting points while allowing project specificity
- **Reference:** templates/README.md

## Template Register

WSP reusable templates available in the templates/ directory:

- commit-checks-template.md — Commit check records
- source-style-configurations.md — Source code style configurations
- user-information-plan-template.md — User information planning
- ux-acceptance-specification-template.md — UX acceptance specifications
- windows-release-trust-template.md — Windows release trust
- windows-version-resource-template.md — Windows version resources
- workflow-derived-commit-checks.md — Workflow-derived commit checks
- source-style.editordoc — Editor configuration

## Approval and Change Control

All changes to WSP records shall follow the change control process:
1. Submit change request with justification
2. Review by WSP Governance Board
3. Approval or rejection with documented rationale
4. If approved, update records under change control
5. Maintain revision history for all controlled documents

---

*This record is maintained under WSP-PROC-0012 contract reference fa84ddedf37a4262ba0d21ffb95890a2d5a89d5c*