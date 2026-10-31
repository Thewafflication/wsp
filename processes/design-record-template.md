# Template — Milestone Design Record

**Content type:** Template

**Milestone or work package:** Identifier and title

**Status:** Proposed / Reviewed / Accepted / Superseded

**Design baseline:** Source revision or controlled document set

**Owner:** Responsible person or role

**Approval:** Controlled approval reference

This record describes how one work package will satisfy its allocated
requirements. Use ADRs for durable choices whose authority extends beyond the
work package.

## Context and Boundary

Describe the design problem, inputs, outputs, actors, trust boundaries, and
components in scope. State behavior and effects that remain outside the design.

## Design Drivers and Constraints

- Allocated requirement or quality attribute
- Compatibility, security, safety, resource, or operational constraint
- Toolchain, dependency, interface, or deployment constraint

## Components and Responsibilities

| Component | Responsibility | Dependencies | Requirement allocation |
| --- | --- | --- | --- |
| Unit or service | Owned behavior | Required interface or component | `REQ-NNNN` |

Include the smallest diagram that makes component boundaries or dependency
direction materially easier to understand.

## Interfaces and Contracts

| Interface | Inputs and outputs | Ownership | Failure and versioning |
| --- | --- | --- | --- |
| API, file, message, or command | Types and constraints | Owner and lifetime | Error, cleanup, compatibility |

Document observable preconditions, postconditions, side effects, ordering,
threading, encoding, and versioning rules as applicable.

## Data, State, and Ownership

Describe controlled data formats, mutable state, invariants, allocation and
resource ownership, persistence, concurrency, and cleanup responsibilities.

## Failure, Recovery, and Limits

Identify validation, bounded-resource behavior, partial-failure handling,
rollback, retry, cancellation, diagnostics, and recovery. State numerical or
environmental limits and the behavior at each limit.

## Security and Privacy

Describe untrusted inputs, privileged operations, protected or secret data,
authorization, redaction, dependency trust, and applicable DFS controls. Link
to the project DFS instead of duplicating its authoritative threat record.

## Compatibility and Portability

Record supported configurations, oldest or constrained environments, fallback
behavior, data or ABI compatibility, migration needs, and claims intentionally
left outside this work package.

## Verification Allocation

| Requirement or risk | Design element | Verification method | Evidence or test |
| --- | --- | --- | --- |
| `REQ-NNNN` or risk | Component or contract | Test, inspection, analysis, review, or demonstration | `TC-NNNN` or reference |

## Durable Decisions

| Decision | ADR | Status or follow-up |
| --- | --- | --- |
| Choice whose consequences outlive this work package | `ADR-NNNN` | Proposed, accepted, or required |

## Open Issues and Assumptions

| Item | Impact | Owner | Resolution or review condition |
| --- | --- | --- | --- |
| Unknown, assumption, or deferred design question | Consequence | Role | Condition |

An unresolved required design decision prevents design acceptance. An approved
deferred objective remains outside the work package's completion claim and
shall identify later ownership and a completion condition.

## References

- Work plan, requirement, specification, architecture description, ADR, DFS,
  test, or issue
