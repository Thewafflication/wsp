# Template — WSP Adoption Record

**Content type:** Template

**Project:** Project name

**WSP baseline:** Release tag or immutable commit

**Submodule path:** `wsp/`

**Pinned commit:** Full WSP commit identifier

**Status:** Proposed

**Approval:** Change, review, or other controlled approval reference

## Common Baseline

| Requirement set or practice | Applicability | Project artifact or scope |
| --- | --- | --- |
| Common requirements management | Yes | All controlled project requirements |
| WSP software lifecycle | Yes | Project lifecycle or mapped process |
| Project process | Yes | Planning through support and improvement |
| Documentation requirements | Yes | Controlled project documentation |
| Documentation style and identifiers | Yes | Project-authored artifacts |
| Testing requirements | Yes | Project verification and evidence |

Common requirements may be tailored only through an approved requirement
disposition. They are not removed by omitting a selectable profile.

## Selected Profiles

| Profile | Selected | Project scope or rationale |
| --- | --- | --- |
| Personal process | Yes / No | Individual planning and improvement |
| Security/DFS | Yes / No | Security scope, design, and verification |
| C source style | Yes / No | Owned C files, or N/A rationale |
| PowerShell style | Yes / No | In-scope automation, or reason not applicable |
| CMake style | Yes / No | In-scope build files, or reason not applicable |
| Windows version resources | Yes / No | Shipped project-owned EXEs and DLLs |
| Windows code signing and Defender | Yes / No | Shipped Windows artifacts |
| Common tools | Yes / No | Reusable validation and reporting tools |

Add every profile present in the adopted WSP baseline.

## Requirement Dispositions

Use one row for every requirement applicable to the selected profiles.

| WSP requirement | Disposition | Project artifact | Rationale or notes |
| --- | --- | --- | --- |
| `WSP-REQM-0001` | Applicable | Project requirements index | |
| `WSP-CSTYLE-0001` | Applicable | Source requirement and test | |

Permitted dispositions are:

- **Applicable** — satisfied without changing the WSP obligation;
- **Tailored** — changed for project context with approved rationale;
- **Not applicable** — excluded with approved rationale; and
- **Deferred** — not yet satisfied, with an owner and completion condition.

## Tailoring Decisions

For every non-applicable disposition, record:

### WSP-AREA-NNNN — Requirement title

- **Disposition:** Tailored, Not applicable, or Deferred
- **Rationale:** Why the original obligation is unsuitable now
- **Impact:** Consequences and risks introduced by the disposition
- **Compensating control:** Alternative protection, or `None`
- **Owner:** Responsible person or role
- **Completion condition:** Required for deferred items; otherwise `N/A`
- **Approval:** Controlled approval reference

## Baseline History

| Date | WSP baseline | Project change | Summary |
| --- | --- | --- | --- |
| YYYY-MM-DD | `vX.Y.Z` | Review or commit | Initial adoption |

The current baseline, pinned commit, and `wsp` gitlink shall agree. An upgrade
entry should reference the adopting-project change that reviewed the new WSP
requirements and tailoring impact.
