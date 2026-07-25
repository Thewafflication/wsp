# Security and DFS

**Content type:** Requirements, guidance, and templates

This directory defines the WSP security profile and the Design for Security
(DFS) artifact used by adopting projects.

**Design for Security (DFS)** is the canonical WSP term. Existing project
artifacts may retain a legacy title when their adoption record maps it to the
WSP DFS.

The profile separates two concerns:

- [Security requirements](security-requirements.md) define common, tailorable
  obligations identified as `WSP-SEC-####`.
- [DFS guidance](dfs-guidance.md) defines the project-owned security design
  that applies those obligations to a product and its threat environment.
- [DFS template](dfs-template.md) provides a starting structure for that
  project-owned design.
- [Standards alignment](standards-alignment.md) maps the profile to IEC 62443,
  ISO/IEC 27034, ISO/IEC/IEEE 12207, and ISO/IEC/IEEE 29119.

The security profile is selectable. A project that does not select it shall
record that decision and its rationale in the WSP adoption record. Selection
does not make WSP a product security certification or replace a project risk
assessment.

IEC 62443-4-1 is the primary secure-development reference for products in an
industrial automation and control system environment. ISO/IEC 27034 provides
broader application-security context. Security verification is part of the
project's ISO/IEC/IEEE 29119-aligned test process. Security findings may also
feed PSP defect records and review checklists without weakening the controls on
personal measurement data.
