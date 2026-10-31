# Template — Review Record

**Content type:** Template

**Work item:** Milestone, change, artifact set, or release candidate

**Review date:** YYYY-MM-DD

**Reviewed baseline:** Source revision and artifact versions

**Scope:** Requirements, design, source, tests, documentation, or other inputs

**Reviewer:** Person or role

**Independence or exception:** Required independence, relationship to the work,
or approved single-reviewer exception

**Status:** In progress / Rework required / Accepted / Rejected

**Approval:** Controlled approval reference

## Review Inputs

- Exact controlled artifact, revision, configuration, and supporting evidence

Identify excluded artifacts so the review boundary cannot be mistaken for a
broader approval.

## Review Criteria and Results

| Area | Criterion | Result | Evidence or observation |
| --- | --- | --- | --- |
| Review area | Applicable checklist item | Pass / Finding / N/A | Reference or concise result |

Use `N/A` only with a rationale. Automated checks may support a review but do
not silently replace required engineering judgment or independence.

## Findings and Disposition

| ID and severity | Finding | Owner | Disposition | Evidence or condition |
| --- | --- | --- | --- | --- |
| `F-NNN`, project scale | Observable issue | Role | Open / Resolved / Deferred / Accepted risk | Fix, approval, or condition |

Every material finding shall remain open until it is resolved, deferred with
approval, or accepted as residual risk by the designated authority. A deferred
finding does not by itself block release when it is outside the current release
gates, but it shall not be represented as resolved or verified.

## Impact Review

Record effects on requirements, architecture, interfaces, implementation,
tests and evidence, compatibility, security or privacy, documentation,
dependencies, supported releases, and release criteria.

## Residual Boundaries

Identify limitations, unreviewed configurations, equivalence assumptions,
deferred objectives, and claims that this review does not support.

## Conclusion

- **Decision:** Accept / Rework / Reject / Accept with documented exceptions
- **Required gates affected:** None or references
- **Open unaccepted risk:** None or references
- **Follow-up:** Owner, action, and completion or review condition

A review may be accepted with approved deferrals or accepted residual risk.
It shall not pass a failed or unknown required gate or accept risk on behalf of
an authority that has not approved it.

## References

- Plan, design record, change, test report, issue, approval, or prior review
