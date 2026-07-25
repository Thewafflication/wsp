# Project Process Requirements

**Content type:** Common requirements and guidance

## Purpose and Applicability

These requirements apply to every adopting project. They integrate the WSP
software lifecycle without prescribing a particular lifecycle model, issue
tracker, review system, or release platform.

## Requirements

### WSP-PROC-0001 — Defined Project Process

The project shall document how it plans, specifies, designs, implements,
reviews, verifies, releases, supports, and improves its software.

The process shall identify applicable WSP requirement sets, project-specific
procedures, required records, and approved tailoring.

**Verification:** Project-process and WSP adoption-record inspection.

### WSP-PROC-0002 — Roles and Responsibilities

The project shall assign responsibility for requirements, architecture,
implementation, verification, release approval, configuration control,
security response when applicable, and process improvement.

One person may hold multiple roles. Required independence or additional review
shall be identified where risk, contract, or an applicable standard demands it.

**Verification:** Responsibility and approval-record inspection.

### WSP-PROC-0003 — Proportional Planning

Work shall be planned at a level proportional to its scope, novelty, risk, and
impact. The plan shall identify completion criteria, dependencies, required
reviews, verification, evidence, and release effect.

Material uncertainty and assumptions shall be recorded and revisited as work
progresses.

**Verification:** Work-plan and completed-work inspection.

### WSP-PROC-0004 — Controlled Change

A change to a baselined requirement, architecture decision, interface, security
control, test obligation, supported platform, or release artifact shall receive
impact analysis before approval.

The analysis shall address affected requirements, design, implementation,
tests, documentation, compatibility, security, schedule, and retained evidence
as applicable.

**Verification:** Change, impact-analysis, and approval inspection.

### WSP-PROC-0005 — Review

Project artifacts and changes shall receive review proportional to their risk.
The project shall define review inputs, reviewers, completion criteria,
findings, required approvals, and the method used to retain the review record.

Authors shall not close a material review finding without a recorded
resolution, approved deferral, or accepted risk.

**Verification:** Review procedure and sampled review-record inspection.

### WSP-PROC-0006 — Issue and Defect Control

The project shall record issues and defects with enough information to
understand the observed behavior, affected baseline, severity or priority,
status, owner, resolution, and verification.

Security findings and protected personal-process measures shall use access and
disclosure controls appropriate to their sensitivity.

**Verification:** Issue-system definition and sampled record inspection.

### WSP-PROC-0007 — Release Readiness

Before release approval, the project shall evaluate:

- release scope and artifact identity;
- applicable requirements and planned verification status;
- unresolved defects, vulnerabilities, risks, and limitations;
- supported platforms and compatibility commitments;
- required documentation, notices, and installation or recovery information;
- source revision, dependency baseline, and build provenance;
- applicable signing, timestamp, malware-scan, and artifact-trust evidence;
- package integrity and exact published-artifact digests; and
- rollback, support, and communication needs.

Exceptions shall identify an owner, rationale, impact, approval, and completion
or review condition.

**Verification:** Completed release-readiness record inspection.

### WSP-PROC-0008 — Release Approval and Baseline

Each release shall have an identified version, source revision, artifact set,
approval, release date, and retained verification summary.

Published artifacts shall be traceable to the approved release baseline. A
release shall not be represented as verified when a required release gate
failed or its result is unknown.

**Verification:** Release record, artifacts, and baseline inspection.

### WSP-PROC-0009 — Support and Response

The project shall define supported versions, defect and vulnerability reporting
channels, triage responsibility, maintenance expectations, and end-of-support
communication appropriate to its users and risks.

Material field failures shall feed applicable requirements, threat analysis,
verification, release, and process changes.

**Verification:** Support policy and completed-response inspection.

### WSP-PROC-0010 — Retrospective and Improvement

At defined intervals or after a material release, incident, or process failure,
the project shall evaluate evidence relevant to planning accuracy, escaped
defects, reviews, verification, build quality, security, and release outcomes.

Selected improvements shall identify an owner, intended result, approval, and
method for determining whether the change was beneficial. Generally reusable
improvements should be proposed to WSP.

**Verification:** Retrospective and improvement-record inspection.

## Relationship to Other WSP Requirements

Project-process requirements coordinate rather than replace detailed
obligations:

- `WSP-REQM-####` controls requirements and change impact;
- `WSP-TEST-####` controls verification and release-test evidence;
- `WSP-DOC-####` controls release documentation;
- `WSP-SEC-####` controls security design and vulnerability response;
- `WSP-PSP-####` controls selected personal-process practices; and
- technology profiles control applicable implementation conventions.
