# Security and DFS Requirements

**Content type:** Selectable profile requirements and guidance

## Applicability

These requirements apply when a project selects the WSP Security/DFS profile.
The project shall define the systems, components, data, environments, and
release activities within the profile's scope.

The profile is informed by IEC 62443-4-1:2018, ISO/IEC 27034-1:2011,
ISO/IEC/IEEE 12207:2026, and the ISO/IEC/IEEE 29119 series. See the
[standards alignment](standards-alignment.md). These requirements do not by
themselves establish conformity to any referenced standard.

## Standards Relationships

| WSP requirements | Principal relationship |
| --- | --- |
| `WSP-SEC-0001`--`0005` | IEC 62443-4-1 requirements and design |
| `WSP-SEC-0001` and `0002` | ISO/IEC 27034 application-security context |
| `WSP-SEC-0002/0009/0011/0014` | ISO/IEC/IEEE 12207 lifecycle |
| `WSP-SEC-0006`--`0008` | IEC 62443-4-1 design and implementation |
| `WSP-SEC-0009`--`0011` | IEC 62443-4-1 implementation and updates |
| `WSP-SEC-0012` | IEC 62443-4-1; ISO/IEC/IEEE 29119-2 and 29119-4 |
| `WSP-SEC-0013/0014` | IEC 62443-4-1 issues, updates, and end of life |

## Requirements

### WSP-SEC-0001 — Security Scope

The project shall identify its security-relevant scope, intended environment,
protected assets, adverse consequences, assumptions, and explicit non-goals.

**Verification:** DFS inspection and stakeholder review.

### WSP-SEC-0002 — Controlled DFS

The project shall maintain a version-controlled Design for Security that traces
security goals, threats, requirements, controls, verification, and residual
risk decisions.

The DFS shall be reviewed when a security-relevant interface, trust boundary,
privilege, dependency, asset, threat, or control materially changes.

**Verification:** DFS history, review, and traceability inspection.

### WSP-SEC-0003 — Trust Model

The DFS shall identify trusted, untrusted, and partially trusted actors,
components, services, data, trust anchors, entry points, privileged operations,
and trust boundaries.

Trust shall not be inferred solely from network location, repository location,
transport encryption, file ownership, or successful parsing.

**Verification:** Trust-model review and architecture inspection.

### WSP-SEC-0004 — Threat Analysis

The project shall analyze credible threats and abuse cases for in-scope assets,
interfaces, trust boundaries, privileged operations, and update paths.

Each accepted threat shall trace to one or more preventive, detective,
corrective, or recovery controls, or to an approved residual-risk decision.

**Verification:** Threat-to-control traceability inspection.

### WSP-SEC-0005 — Derived Security Requirements

Security goals, threats, legal or contractual obligations, and architecture
constraints shall be converted into uniquely identified, verifiable project
requirements.

Derived security requirements shall follow WSP requirements management and
shall trace through implementation and verification evidence.

**Verification:** Requirements and bidirectional-traceability inspection.

### WSP-SEC-0006 — Untrusted Input and Resource Control

Software shall validate untrusted input before it affects security-relevant
behavior. Validation shall address structure, range, length, encoding,
canonical form, path handling, resource consumption, and unexpected data as
applicable.

Malformed or excessive input shall not cause unauthorized access, execution,
data modification, uncontrolled resource exhaustion, or escape from an
intended storage boundary.

**Verification:** Code review, static analysis, and negative testing.

### WSP-SEC-0007 — Least Privilege and Authorization

Components shall operate with the least privilege practical for their assigned
functions. Every security-relevant operation shall enforce authorization at a
trusted decision point before the operation occurs.

Privilege changes, administrative overrides, and bypasses shall be explicit,
limited, auditable, and covered by project requirements.

**Verification:** Architecture and code review; authorization testing.

### WSP-SEC-0008 — Cryptography and Secrets

The project shall identify cryptographic purposes, algorithms, protocols, key
and credential lifecycles, trust anchors, randomness needs, and failure
behavior in its DFS.

Secrets and private keys shall not be committed to source control, written to
ordinary logs, or exposed through avoidable process arguments or diagnostics.
The project shall use reviewed cryptographic implementations rather than
project-designed cryptographic algorithms.

**Verification:** DFS, configuration, source, and secret-scan inspection.

### WSP-SEC-0009 — Dependency and Build Integrity

Security-relevant dependencies and build inputs shall have identified sources,
versions, licenses, and integrity or authenticity evidence appropriate to
their risk.

Release production shall preserve traceability from source revision and
dependency baseline to the generated artifacts. Known vulnerabilities shall be
assessed before release and when material new information becomes available.

**Verification:** Dependency record, build evidence, and assessment inspection.

### WSP-SEC-0010 — Security Logging and Data Protection

The project shall define security-relevant events, audit-record content,
access, integrity protection, retention, and review responsibilities.

Logs shall contain enough context to investigate relevant events without
unnecessarily disclosing credentials, secrets, or protected personal data.

**Verification:** Logging design review and generated-record inspection.

### WSP-SEC-0011 — Secure Failure and Recovery

Security-control failure shall produce a defined, observable state that does
not silently grant access, establish trust, execute unverified content, or
discard evidence required for diagnosis.

Recovery, rollback, downgrade, and emergency-bypass behavior shall be defined
and verified where those operations can affect security.

**Verification:** Failure-injection, recovery testing, and DFS inspection.

### WSP-SEC-0012 — Security Verification

Each applicable security requirement and accepted threat shall have planned
verification by test, analysis, inspection, review, or demonstration.

Testing shall include misuse, malformed input, boundary conditions, denied
operations, control failure, and recovery scenarios as applicable. Results and
evidence shall follow the WSP test strategy and ISO/IEC/IEEE 29119 alignment.

**Verification:** Security traceability and test-report inspection.

### WSP-SEC-0013 — Security Review and Defect Handling

Security-relevant requirements, architecture, source, dependencies, and release
changes shall receive review proportional to their risk.

Security findings shall be recorded, classified, traced, and resolved or
accepted through controlled risk approval. Projects using the personal-process
profile should feed recurring security defects into personal review checklists.

**Verification:** Review, defect, and risk-decision inspection.

### WSP-SEC-0014 — Vulnerability Response

The project shall define how vulnerabilities are privately reported, triaged,
remediated, verified, disclosed, and released for supported versions.

The process shall identify responsible roles, severity and urgency criteria,
affected-version analysis, and conditions for coordinated response, rollback,
or security release.

**Verification:** Response-process and completed-response inspection.
