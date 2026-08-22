# Template — Milestone Work Plan

**Content type:** Template

**Milestone or work package:** Identifier and title

**Status:** Proposed / Accepted / Superseded

**Planned period:** Start and target completion

**Inherited baseline:** Source revision, release, or predecessor milestone

**Owner:** Responsible person or role

**Approval:** Controlled approval reference

Use this template for an independently reviewable work package. Scale the
detail to the work's novelty, risk, and release effect.

## Objective and Scope

State the observable outcome and why it is needed. Identify the product,
process, configurations, and lifecycle stages in scope.

### Included Work

- Required behavior, artifact, or decision

### Excluded or Deferred Work

- Work intentionally assigned to another milestone or release

Deferred objectives do not by themselves block this work package or a product
release. Record each deferral below; do not designate the same objective as a
required exit or release gate.

## Baseline and Assumptions

- Applicable requirement, specification, architecture, and security baselines
- Dependencies and predecessor outputs
- Supported platforms and configurations
- Inherited defects, limitations, and accepted risks
- Assumptions that require confirmation

## Deliverables

| Deliverable | Owner | Completion evidence |
| --- | --- | --- |
| Artifact or outcome | Role | Review, test, or retained record |

## Requirement and Verification Allocation

| Requirement or objective | Design or implementation allocation | Verification | Required gate |
| --- | --- | --- | --- |
| `REQ-NNNN` | Component or document | `TC-NNNN` or other method | Yes / No |

## Roles and Review

| Role | Assignment | Responsibility or independence condition |
| --- | --- | --- |
| Owner | Person or role | Scope and completion |
| Reviewer | Person or role | Review boundary or approved exception |
| Verifier | Person or role | Evidence and verdict |

## Risks and Controls

| Risk | Impact | Planned control | Owner or trigger |
| --- | --- | --- | --- |
| Credible uncertainty or failure | Consequence | Prevention or response | Role or condition |

## Estimate and Forecast

This section is optional unless selected WSP or project requirements make
estimation mandatory. Use measures the project can obtain reliably. Do not
invent unavailable effort, elapsed-time, size, or token data.

| Phase or activity | Planned size or effort | Current forecast | Basis |
| --- | ---: | ---: | --- |
| Plan, design, implement, review, verify, or close | Estimate | Forecast | Historical data or assumption |

State the replanning threshold and the action required when the forecast
crosses it. A budget limit does not waive an exit criterion.

## Execution and Evidence

Identify the build and test configurations, top-level dispatchers, inspections,
analyses, evidence formats, retention locations, and failure-preservation
rules needed to verify this work.

## Rollback and Recovery

Describe how incomplete or defective changes can be isolated, disabled,
reverted, repaired, or recovered without damaging unrelated work or evidence.

## Exit Criteria

| Criterion | Required evidence | Gate | Status |
| --- | --- | --- | --- |
| Measurable completion condition | Test, review, analysis, or artifact | Required / Informative | Planned |

Every required gate shall pass before the work package closes. Informative
objectives may be carried into later work through an approved deferral.

## Deferred Objectives

| Objective | Impact | Owner | Target milestone or release | Compensating control | Approval |
| --- | --- | --- | --- | --- | --- |
| Reference | Consequence | Role | Identifier or completion condition | Control or `None` | Reference |

## Change Control

Identify changes that require replanning, requirements impact analysis, an ADR,
DFS review, stakeholder approval, or a revised release decision.

## References

- Requirement, specification, ADR, DFS, test strategy, issue, or predecessor
  record
