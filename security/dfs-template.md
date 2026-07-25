# Project Design for Security (DFS)

**Project:** Project name

**Version:** Document version

**Status:** Proposed

**Approval:** Controlled approval reference

## Scope and Environment

Describe the product, deployment environment, security-relevant use, and what
is outside the DFS scope.

## Security Goals and Non-Goals

| ID | Goal or non-goal | Rationale | Related requirement |
| --- | --- | --- | --- |
| `SG-001` | Security goal | Why it matters | `REQ-####` |

## Assets and Consequences

| Asset | Required property | Consequence of compromise |
| --- | --- | --- |
| Asset | Confidentiality, integrity, or availability | Impact |

## Trust Model and Boundaries

Identify trusted, untrusted, and partially trusted actors, components, data,
services, trust anchors, entry points, and privileged operations. Include a
data-flow or trust-boundary diagram when useful.

## Threats and Abuse Cases

| ID | Threat or abuse case | Affected asset | Control | Residual risk |
| --- | --- | --- | --- | --- |
| `THR-001` | Credible adverse action | Asset | `REQ-####` | Accepted risk |

## Security Controls

Describe validation, authorization, privilege, cryptography, secrets,
dependencies, logging, failure handling, recovery, and release-integrity
controls. Reference ADRs instead of duplicating durable design decisions.

## Security Verification

| Requirement or threat | Verification | Evidence | Status |
| --- | --- | --- | --- |
| `REQ-####` / `THR-###` | Test or analysis | Evidence | Status |

## Vulnerability and Incident Response

Record the reporting channel, triage owner, remediation expectations, supported
versions, disclosure approach, and release or rollback process.

## Residual Risk and Approval

| Risk | Rationale | Owner | Approval | Review condition |
| --- | --- | --- | --- | --- |
| Residual risk | Why accepted | Role | Reference | Trigger or date |

## Change History

| Date | Version | Change | Approval |
| --- | --- | --- | --- |
| YYYY-MM-DD | `vX.Y` | Initial DFS | Reference |
