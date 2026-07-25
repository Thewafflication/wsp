# Design for Security Guidance

**Content type:** Security design guidance

## Purpose

A Design for Security (DFS) describes how a project protects its assets in its
intended environment. It connects security goals and threats to controlled
requirements, architecture decisions, implementation controls, and
verification evidence.

The DFS is owned by the adopting project. WSP supplies its structure and common
requirements but cannot prescribe a product's assets, attackers, trust
boundaries, or acceptable residual risk.

For industrial automation and control system products, the DFS and supporting
process should be assessed against IEC 62443-4-1:2018. ISO/IEC 27034-1:2011
provides broader application-security context, while ISO/IEC/IEEE 12207:2026
places these activities in the full software lifecycle. See the
[standards alignment](standards-alignment.md).

## Expected Content

A DFS should identify:

- product purpose, deployment environment, and security scope;
- protected assets and adverse consequences;
- trusted, untrusted, and partially trusted actors and components;
- entry points, privileged operations, and trust boundaries;
- credible threats, abuse cases, assumptions, and dependencies;
- security goals, non-goals, and derived project requirements;
- preventive, detective, corrective, and recovery controls;
- cryptographic operations, keys, credentials, and trust anchors;
- audit events, protected records, retention, and access;
- security verification and residual-risk acceptance; and
- vulnerability reporting, remediation, and release-response arrangements.

Diagrams are recommended when they clarify data flow, privilege changes, or
trust boundaries. Every security-critical claim should trace to a requirement,
ADR, test, analysis, review, or approved risk decision.

## Lifecycle

The project shall create or review its DFS before approving security-relevant
architecture. It should update the DFS when an interface, trust boundary,
privilege, dependency, data classification, threat, or security control
materially changes.

DFS review should occur with requirements and architecture review. Verification
should include positive, negative, boundary, malformed-input, abuse-case, and
recovery scenarios as applicable. These tests remain subject to the WSP test
strategy and its ISO/IEC/IEEE 29119 alignment.

## Relationship to WPM

The WPM DFS established the reusable pattern behind this profile: explicit
security goals and non-goals, a trust model, untrusted package inputs, archive
extraction constraints, integrity and authenticity checks, privileged script
execution, downgrade protection, and audit records.

An adopting WPM baseline should preserve those product-specific decisions in
its own DFS and map them to `WSP-SEC-####` requirements. WSP does not replace
the detailed WPM trust, signature, package, or repository requirements.
