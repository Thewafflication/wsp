# Requirements

**Content type:** Requirements, guidance, and templates

This directory is the authoritative index for common WSP requirements and the
method by which projects adopt, tailor, trace, and baseline them.

## Common Baseline

- [Requirements management](requirements-management.md) defines the lifecycle
  requirements that apply to every adopting project.
- [Requirement template](requirement-template.md) provides a standard structure
  for project and WSP requirement documents.
- [Adoption record template](adoption-record-template.md) records the WSP
  version, selected profiles, and tailoring decisions for a project.

Technology-specific requirements may live with the guidance they govern. The
following requirement sets are currently defined outside this directory:

| Requirement set | Location | Applicability |
| --- | --- | --- |
| `WSP-CSTYLE-####` | [C style](../style/c-style.md) | C projects |

This index shall be updated whenever a normative requirement set is added,
moved, renamed, or retired.

## Requirement Levels

WSP distinguishes these levels:

```text
WSP common requirement
        ↓ adopted or tailored by
Project requirement or project-wide obligation
        ↓ allocated to
Design, source, process, or other implementation
        ↓ verified by
Test, inspection, analysis, review, or demonstration
```

A project may satisfy a WSP requirement directly through a project-wide rule or
derive one or more detailed project requirements from it. In either case, the
adoption record and traceability data shall identify how the WSP obligation is
discharged.

## Normative Boundaries

Only statements explicitly identified by a WSP requirement ID are normative
WSP requirements. Guidance and templates help projects comply but do not create
additional obligations merely through example text.

Project requirements remain owned and controlled by their project. WSP does
not assign project `REQ-####` numbers or store project verification evidence.
