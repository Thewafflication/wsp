# Template — Release Readiness Record

**Content type:** Template

**Project:** Project name

**Release:** Version or candidate identifier

**Source revision:** Full commit identifier

**Status:** Proposed

**Approval:** Controlled approval reference

## Release Scope

Describe the intended release, included changes, supported platforms, artifact
set, and excluded or deferred work. Deferred objectives do not by themselves
block release, but they remain outside this release's completion and
verification claims.

## Gate Summary

| Gate | Evidence | Status | Exception or notes |
| --- | --- | --- | --- |
| Requirements baseline | Reference | Pass / Fail / N/A | |
| Architecture and DFS review | Reference | Pass / Fail / N/A | |
| Build and package | Reference | Pass / Fail / N/A | |
| Static analysis | Reference | Pass / Fail / N/A | |
| Native binary hardening | Reference | Pass / Fail / N/A | |
| Verification and test report | Reference | Pass / Fail / N/A | |
| Defect and vulnerability review | Reference | Pass / Fail / N/A | |
| Documentation | Reference | Pass / Fail / N/A | |
| Provenance and dependency record | Reference | Pass / Fail / N/A | |
| Windows signing and Defender scan | Reference | Pass / Fail / N/A | |
| PDF metadata, digest, and provenance | Reference | Pass / Fail / N/A | |
| PAdES signature, when selected | Reference | Pass / Fail / N/A | |
| Installation, rollback, and recovery | Reference | Pass / Fail / N/A | |

List only gates required for this release. A deferred objective shall not be
recorded as a failed gate; it is outside the current release scope. Every
required gate shall pass before approval. Use `N/A` only with a recorded
applicability rationale.

## Documentation Verification

- **Final PDF:** Exact file and version
- **Automated verification record:** Metadata, page count, text, table of
  contents, bookmarks, links, manifest order, and page-boundary result
- **Rendered-page review record:** Reviewer, date, rendering method, page
  coverage, defects found, and disposition
- **Final PDF SHA-256:** Digest of the reviewed bytes
- **Provenance verification:** Attestation result and repository identity

The automated and rendered-page reviews shall apply to the same final PDF bytes
identified by the recorded digest. A sampled rendered-page review does not
satisfy a requirement for review of every page.

## PAdES Applicability and Evidence

- **Selected:** Yes / No
- **Requirement or trigger:** Contractual, regulatory, customer, policy, or
  project source, or `None`
- **Applicability rationale:** Why PAdES is required or why it is not selected
  for this release
- **Profile:** PAdES-B-T / PAdES-B-LT / `N/A`
- **Certificate authorization and protected-key evidence:** Reference or `N/A`
- **RFC 3161 timestamp evidence:** Reference or `N/A`
- **Independent validation result:** Reference or `N/A`
- **Approval:** Role, record, and date

When PAdES is selected, the signature and timestamp shall cover the final PDF
before its digest and provenance are generated. When it is not selected, the
recorded rationale makes the gate explicitly not applicable rather than
silently omitting it.

## Deferred Objectives

| Objective | Impact | Owner | Target release or completion condition | Compensating control | Approval |
| --- | --- | --- | --- | --- | --- |
| Reference | Consequence | Role | Release or condition | Control or `None` | Reference |

For each prior deferral, record whether this release closes it, revises it, or
explicitly carries it forward. Do not report a deferred objective as complete
or verified.

## Artifacts

| Artifact | Platform or purpose | Integrity value | Publication location |
| --- | --- | --- | --- |
| Filename | Target | Approved digest | Location |

## Open Items and Accepted Risk

| Item | Impact | Owner | Approval | Completion or review condition |
| --- | --- | --- | --- | --- |
| Reference | Consequence | Role | Reference | Condition |

## Approval Decision

- **Decision:** Approve / Reject / Approve with exceptions
- **Approver:** Person or role
- **Date:** YYYY-MM-DD
- **Rationale:** Decision basis
- **Support or communication actions:** Required follow-up

`Approve with exceptions` may be selected for documented deferrals or accepted
residual risk only when every required release gate passes and the designated
approving authority accepts the remaining risk.

## Baseline Record

Record the release tag, full source revision, dependency baseline, build record,
test report, published artifact set, and release-document PDF.
