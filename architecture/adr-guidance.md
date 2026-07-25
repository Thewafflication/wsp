# Architecture Decision Record Guidance

**Content type:** Guidance

## When to Write an ADR

Create an ADR when a decision has meaningful, lasting consequences or would be
difficult for a future contributor to infer from the implementation alone.
Typical subjects include:

- system or repository structure;
- trust boundaries and security models;
- data, package, or metadata formats;
- dependency and toolchain selection;
- compatibility and platform support;
- build, test, verification, and release strategy; and
- an intentional departure from an established practice.

An ADR is usually unnecessary for a readily reversible implementation detail,
a restatement of a requirement, or a temporary task with no architectural
effect.

## Lifecycle

Use one of these status values:

| Status | Meaning |
| --- | --- |
| **Proposed** | The decision is under review and is not yet authoritative. |
| **Accepted** | The decision is approved and governs the project. |
| **Deprecated** | The decision remains part of the history but should no longer guide new work. |
| **Superseded by ADR-NNNN** | A later ADR replaces the decision. |
| **Rejected** | The proposal was considered but not adopted. |

Do not rewrite the substance of an accepted ADR when the decision changes.
Create a new ADR, mark the previous record as superseded, and link the two.
Minor corrections that do not alter the decision or rationale may be made in
place through normal review.

## Writing Principles

An ADR should:

- describe the forces and constraints that made a decision necessary;
- state the decision directly and in the present tense;
- identify serious alternatives and why they were not selected;
- record both beneficial and adverse consequences;
- link related requirements, ADRs, standards, and implementation work; and
- contain enough information to remain useful without relying on a review
  discussion or issue that may later be unavailable.

Prefer a concise record over a comprehensive design specification. Supporting
detail may be linked when it belongs in another controlled artifact.

## Review

Reviewers should determine whether:

1. the context and decision boundary are clear;
2. the selected option satisfies applicable requirements and constraints;
3. credible alternatives received fair consideration;
4. security, compatibility, verification, deployment, and maintenance effects
   have been considered where applicable;
5. consequences and follow-up work are explicit; and
6. the record contains no unstated project requirement that should instead be
   traceable and verified independently.

Acceptance should occur through the project's normal change-review process.
The accepting commit or pull request provides the approval history; the ADR
does not need to duplicate reviewer names unless the project requires it.

## Relationship to Requirements and Tests

An ADR may cite requirements that constrain the decision, but it is not a
substitute for them. Normative behavior introduced by a decision should be
captured as a requirement and verified through the project's normal evidence
chain.

Tests normally trace to requirements rather than directly to ADRs. Direct ADR
verification is appropriate only when the architectural property itself is the
subject of an inspection, analysis, or automated structural check.
