# Requirements Management

**Content type:** Requirements and guidance

## Purpose and Applicability

These requirements establish a minimum requirements-management baseline for
every project adopting WSP. They apply to project requirements and adopted WSP
requirements throughout development, maintenance, and release.

## Requirements

### WSP-REQM-0001 — Identified Requirements

Each controlled requirement shall have a unique, stable identifier and a
descriptive title.

**Rationale:** Stable identifiers support review, change history, traceability,
and durable references from tests and reports.

**Verification:** Inspection of the requirement set and duplicate-identifier
check.

### WSP-REQM-0002 — Requirement Quality

Each controlled requirement shall identify an obligated subject and state
behavior or a constraint that is necessary, unambiguous, feasible, and
objectively verifiable.

A compound statement shall be used only when its obligations form one
inseparable behavior with one verification outcome.

**Rationale:** A requirement cannot be implemented or verified consistently if
different readers can reasonably infer different obligations.

**Verification:** Requirements review using the criteria in
[Requirements-writing style](../style/requirements-writing.md).

### WSP-REQM-0003 — Requirement Context

Each controlled requirement shall record or reference its rationale,
applicability, source, and relevant dependencies when those attributes are not
self-evident.

**Rationale:** Context prevents future changes from removing a necessary
constraint or extending it beyond its intended scope.

**Verification:** Requirements-document inspection.

### WSP-REQM-0004 — Planned Verification

Each controlled requirement shall identify at least one planned verification
method before the requirement is accepted into a release baseline.

Permitted methods are test, inspection, analysis, review, and demonstration.
The method shall be capable of producing objective pass or fail evidence for
the stated obligation.

**Rationale:** Early verification planning exposes requirements that are vague,
infeasible, or impractical to verify.

**Verification:** Traceability inspection and requirements review.

### WSP-REQM-0005 — Bidirectional Traceability

Each applicable requirement shall be traceable forward to its verification
specification and evidence. Each verification specification and result shall
trace backward to every requirement it claims to verify.

Where implementation allocation is controlled, requirements shall also trace
to the applicable design or implementation units.

**Rationale:** Bidirectional traceability identifies unverified requirements,
unjustified tests, and changes whose effects have not been evaluated.

**Verification:** Automated traceability validation where practical, followed
by inspection of relationships that cannot be checked automatically.

### WSP-REQM-0006 — WSP Adoption Record

An adopting project shall maintain a controlled adoption record that identifies:

- the adopted WSP release or immutable commit;
- applicable technology and delivery profiles;
- the disposition of every applicable WSP requirement;
- every tailoring decision and its rationale; and
- the project artifacts that satisfy or derive from each applicable
  requirement.

**Rationale:** Adoption must refer to a reproducible baseline and make omissions
or modifications visible.

**Verification:** Inspection of the project's adoption record against the WSP
requirement index.

### WSP-REQM-0007 — Tailoring Control

A project shall not silently omit or weaken an applicable WSP requirement.

Every tailored, deferred, or not-applicable disposition shall record the
rationale, approving authority, impact, and any compensating control. A
deferred disposition shall additionally identify an owner and completion
condition.

**Rationale:** Explicit tailoring permits proportional application without
making the actual project baseline ambiguous.

**Verification:** Adoption-record and approval-history inspection.

### WSP-REQM-0008 — Change Impact Analysis

A change to an accepted requirement shall include an impact analysis covering,
as applicable:

- dependent and conflicting requirements;
- architecture and implementation;
- verification specifications and existing evidence;
- supported platforms and compatibility;
- security, safety, and operational risk; and
- released or maintained product versions.

**Rationale:** A locally reasonable requirement change can invalidate design,
tests, evidence, or compatibility elsewhere.

**Verification:** Change-review inspection.

### WSP-REQM-0009 — Requirement History

Requirement changes shall be reviewable through version control or another
controlled history that identifies the changed content, author, date, and
approval record.

Removed requirements shall remain discoverable in history, and their
identifiers shall not be reused.

**Rationale:** Historical decisions and identifiers must remain explainable
after the current requirement set changes.

**Verification:** Configuration-management and version-history inspection.

### WSP-REQM-0010 — Release Baseline

Each release shall identify the exact baseline of requirements it claims to
satisfy and the disposition of every requirement in that baseline.

No requirement shall be reported as verified unless its required verification
completed successfully against the released or configuration-equivalent
software and its evidence is retained or referenced.

**Rationale:** A release claim is meaningful only when its obligations and
supporting evidence are reproducible.

**Verification:** Release-record, traceability, and evidence inspection.

## Recommended Automation

Projects should automate checks for:

- duplicate or malformed identifiers;
- requirement files absent from the controlled index;
- missing verification references;
- test cases without requirement back-references;
- missing result evidence; and
- adoption records that do not cover the selected WSP baseline.

WPM and WCRT already automate several of these checks through their shared
traceability and evidence-validation scripts.
