# WSP Adoption Record

**Project:** Project name

**WSP baseline:** Release tag or immutable commit

**Status:** Proposed

**Approval:** Change, review, or other controlled approval reference

## Selected Profiles

| Profile | Applicable | Project scope or rationale |
| --- | --- | --- |
| Common requirements management | Yes | All controlled project requirements |
| C source style | Yes / No | Owned C files, or N/A rationale |
| PowerShell style | Yes / No | In-scope automation, or reason not applicable |
| CMake style | Yes / No | In-scope build files, or reason not applicable |

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
