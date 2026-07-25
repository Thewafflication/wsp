# Test Strategy

**Content type:** Requirements and guidance

## Purpose and Applicability

These requirements define the minimum test process for every project adopting
WSP. They apply to tests used to claim requirement verification, release
readiness, compatibility, or conformance.

The strategy uses the concepts of ISO/IEC/IEEE 29119-1:2022, applies the generic
test-process model of ISO/IEC/IEEE 29119-2:2021, structures documentation using
ISO/IEC/IEEE 29119-3:2021, and expects intentional selection of techniques from
ISO/IEC/IEEE 29119-4:2021 where applicable. See the
[WSP alignment](iso-iec-ieee-29119-alignment.md).

Exploratory and developer-only checks may use a lighter process, but they shall
not be cited as release evidence unless they satisfy this baseline.

## Requirements

### WSP-TEST-0001 — Verification Coverage

Every applicable project requirement shall be verified by one or more tests,
inspections, analyses, reviews, or demonstrations.

Requirements verified by test shall trace to at least one controlled test-case
specification. A requirement shall not be considered verified merely because
an implementation exists.

**Verification:** Traceability inspection.

**Standards reference:** ISO/IEC/IEEE 29119-1 general testing concepts and
ISO/IEC/IEEE 29119-2 test processes.

### WSP-TEST-0002 — Controlled Test Specification

Every test cited as verification evidence shall have a version-controlled test-
case specification identified by a stable `TC-NNNN` identifier.

The specification shall be reviewed with the requirement or before its result
is accepted as release evidence.

**Verification:** Test inventory and change-history inspection.

**Standards reference:** ISO/IEC/IEEE 29119-3 test-case documentation.

### WSP-TEST-0003 — Test-Case Content

Each test-case specification shall define:

- identifier and title;
- purpose and priority;
- requirement references;
- relevant design, feature, or implementation references;
- preconditions, environment, and assumptions;
- input data and initial state;
- procedure;
- expected results and objective pass criteria; and
- postconditions or cleanup expectations.

Fields that do not apply shall state `Not applicable` with enough explanation
to distinguish an intentional omission from missing content.

**Verification:** Test-specification inspection or schema validation.

**Standards reference:** ISO/IEC/IEEE 29119-3 test-case specification content.

### WSP-TEST-0004 — Specification as Source of Truth

The controlled test-case specification shall be the authoritative description
of the test objective, procedure, and expected result.

Test reports shall incorporate or reference the controlled specification and
shall not maintain a manually duplicated procedure that can drift from it.

**Verification:** Test-report generation and document inspection.

**Standards reference:** ISO/IEC/IEEE 29119-3 test documentation produced by
the ISO/IEC/IEEE 29119-2 processes.

### WSP-TEST-0005 — Repeatable Execution

An automated test shall produce the same verdict when repeated against the
same software baseline, inputs, configuration, and declared environment,
except where controlled variability is the subject of the test.

A test runner shall establish or validate its preconditions, isolate outputs
from earlier executions, and leave the environment in its documented
postcondition.

**Verification:** Runner inspection and repeated execution where appropriate.

**Standards reference:** ISO/IEC/IEEE 29119-2 dynamic test implementation and
execution processes.

### WSP-TEST-0006 — Automated Execution

Tests shall be automated when automation is technically feasible and provides
reliable objective evidence.

A manual step shall state why automation is unsuitable, identify the operator
action and observation, and retain the operator and approval information needed
to reproduce and review the result.

**Verification:** Test-plan and test-specification inspection.

**Standards reference:** ISO/IEC/IEEE 29119-2 test processes and
ISO/IEC/IEEE 29119-3 test documentation.

### WSP-TEST-0007 — Execution Metadata

Each test execution record shall identify:

- test-case identifier and revision;
- verified requirement identifiers;
- software version and source revision;
- target architecture and build configuration;
- relevant operating system, toolchain, and dependency versions;
- start and finish timestamps;
- executed command or controlled manual procedure;
- process exit status where applicable;
- final test status; and
- location or inclusion of diagnostic output and other evidence.

Metadata not relevant to a test may be omitted only when the test specification
defines the controlled environment sufficiently to reproduce the result.

**Verification:** Evidence-record inspection.

**Standards reference:** ISO/IEC/IEEE 29119-3 test execution and incident
documentation concepts.

### WSP-TEST-0008 — Test Status

Each execution shall report exactly one controlled status:

| Status | Meaning |
| --- | --- |
| **Pass** | All required steps completed and every pass criterion was met. |
| **Fail** | A pass criterion was not met or a required step failed. |
| **Blocked** | Execution could not proceed because a precondition was unmet. |
| **Inconclusive** | Evidence is insufficient to determine a verdict. |
| **Not run** | No execution was attempted for the identified baseline. |
| **Not applicable** | The test does not apply to this configuration. |

A blocked, inconclusive, not-run, or not-applicable result shall include a
rationale. No status other than Pass shall satisfy a required release gate.

**Verification:** Evidence validation.

**Standards reference:** ISO/IEC/IEEE 29119-3 test status and result reporting.

### WSP-TEST-0009 — Failure Preservation

Failure diagnostics and the original failing result shall be retained when a
test is rerun. A later passing execution shall not overwrite or reclassify the
earlier result.

The resolution shall link the failure, corrective change, and successful rerun
when those relationships are needed to support a release decision.

**Verification:** Evidence-history inspection.

**Standards reference:** ISO/IEC/IEEE 29119-2 test monitoring and control and
ISO/IEC/IEEE 29119-3 test incident and completion documentation.

### WSP-TEST-0010 — Generated Test Reports

Test reports shall be generated from controlled test specifications, execution
records, and baseline metadata. Generation shall fail when required inputs are
missing, malformed, duplicated, or inconsistent.

Each report shall summarize coverage and status, identify the tested baseline
and environment, include or link the evidence for every reported result, and
identify unresolved deviations.

**Verification:** Report-generation execution and report inspection.

**Standards reference:** ISO/IEC/IEEE 29119-3 test status and completion
reporting.

### WSP-TEST-0011 — Automated Traceability Validation

CI shall reject missing or duplicate requirement and test-case identifiers,
requirements without planned verification, test cases without requirement
back-references, and required tests without results.

Projects shall validate the actual relationships rather than infer one-to-one
traceability solely from matching requirement and test-case numbers.

**Verification:** Negative and positive tests of the traceability validator.

**Standards reference:** ISO/IEC/IEEE 29119-2 test processes and
ISO/IEC/IEEE 29119-3 documentation relationships.

### WSP-TEST-0012 — Continuous Integration

CI shall build the tested configuration, execute all tests required for the
change or baseline, retain their evidence, and return a failing conclusion when
any required test does not pass.

Pull requests shall not be accepted when a required CI verification gate is
failing or has not completed, except through a documented emergency process.

**Verification:** CI configuration inspection and controlled failure test.

**Standards reference:** ISO/IEC/IEEE 29119-2 test implementation, execution,
monitoring, control, and completion processes.

### WSP-TEST-0013 — Release Verification Matrix

Each project shall define its supported release matrix, including applicable
architectures, operating systems, configurations, toolchains, and other
compatibility dimensions.

A release shall pass every required test for every applicable matrix entry. A
project may use justified equivalence classes when testing every combination is
impractical, but shall document the selection and residual risk.

**Verification:** Release matrix, evidence, and approval inspection.

**Standards reference:** ISO/IEC/IEEE 29119-2 test planning, monitoring, and
completion processes.

### WSP-TEST-0014 — Evidence Retention

Test evidence used for a release claim shall be retained with or referenced by
the release record for the project's defined retention period.

Stored evidence shall be protected against silent modification and shall remain
associated with the exact tested software and test-specification revisions.

**Verification:** Evidence-store and release-record inspection.

**Standards reference:** ISO/IEC/IEEE 29119-3 test documentation and reporting.

### WSP-TEST-0015 — Test-Technique Selection

Each test-case specification shall identify the test-design technique used or
state why a named technique is not applicable.

Projects shall select techniques appropriate to the requirement, risk,
interface, and failure modes being tested. When applicable, projects should use
the techniques defined by ISO/IEC/IEEE 29119-4:2021 and record the achieved
coverage.

**Verification:** Test-specification and coverage inspection.

**Standards reference:** ISO/IEC/IEEE 29119-4 test techniques and the
ISO/IEC/IEEE 29119-2 test design and implementation process.

## Project Test Strategy

Each project should maintain a short test-strategy document that identifies:

- test levels and verification methods;
- supported release matrix;
- test environments and provisioning;
- naming and directory conventions;
- CI and release gates;
- evidence and report locations;
- retention period;
- known exclusions; and
- responsible roles.

Project strategy may reference this document instead of restating the common
requirements.
