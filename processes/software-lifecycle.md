# WSP Software Lifecycle

**Content type:** Process guidance and requirement mapping

## Purpose

The WSP lifecycle connects its requirements, practices, templates, and tools
into one repeatable flow. It does not require a waterfall development model.
Projects may perform the activities iteratively, incrementally, concurrently,
or at different levels of formality according to risk and scope.

```text
Adopt -> Plan -> Specify -> Design -> Implement -> Review -> Verify
  ^                                                        |
  |                                                        v
Improve <- Operate and Support <- Release and Baseline <----+
```

Every activity produces or updates controlled project artifacts. Tailoring may
change how an activity is performed, but shall not silently remove an adopted
WSP obligation.

## 1. Adopt and Baseline

The project selects an immutable WSP release or commit, records applicable
profiles, dispositions every adopted requirement, and commits the WSP
submodule gitlink and adoption record together.

**Principal WSP material:** Requirements management, adoption record, and
ADR-0001.

**Expected output:** Approved adoption record and pinned WSP baseline.

## 2. Plan

The project identifies scope, stakeholders, risks, milestones, responsibilities,
verification activities, release criteria, and required evidence. Projects
using the personal-process profile also estimate and plan individual work.

**Principal WSP material:** Requirements management, test strategy, Security/DFS
profile, and personal-process profile.

**Expected output:** Project, work, test, and quality plans proportional to the
work.

## 3. Specify

Stakeholder needs, product behavior, constraints, interfaces, quality
attributes, and applicable security obligations become uniquely identified,
verifiable project requirements.

**Principal WSP material:** Requirements management, requirements-writing
style, artifact identifiers, and Security/DFS requirements.

**Expected output:** Reviewed and baselined project requirements with planned
verification.

## 4. Design

The project develops a design that satisfies its requirements. Durable choices
and rejected alternatives are recorded as ADRs. Security-relevant projects
maintain a DFS containing their trust model, threats, controls, and residual
risk decisions.

**Principal WSP material:** ADR guidance and Security/DFS guidance.

**Expected output:** Reviewable design information, accepted ADRs, and an
updated DFS when applicable.

## 5. Implement

Source, automation, configuration, build definitions, and documentation are
created under the applicable style, security, and tool requirements. Generated
and third-party content remain distinguishable from project-owned work.

**Principal WSP material:** Style profiles, Security/DFS requirements, and
common tools.

**Expected output:** Traceable implementation and repeatable build inputs.

## 6. Review

Requirements, design, source, tests, documentation, dependencies, and release
changes receive review proportional to their risk. Findings become controlled
defects, requirement changes, ADR updates, or approved risk decisions.

**Principal WSP material:** Requirements management, ADR guidance, security
review requirements, style rules, and personal review practices.

**Expected output:** Review records and resolved or dispositioned findings.

## 7. Verify

The project performs its planned tests, analyses, inspections, reviews, and
demonstrations. Verification maintains bidirectional traceability and produces
objective evidence and a report suitable for release decisions.

**Principal WSP material:** ISO/IEC/IEEE 29119 alignment, test strategy,
test-case templates, report template, and evidence tools.

**Expected output:** Requirement coverage, execution evidence, defect records,
and an approved verification or test report.

## 8. Release and Baseline

The project confirms release criteria, known limitations, security findings,
artifact identity, version, source revision, dependency baseline, test status,
and required documentation. Released artifacts and evidence are retained under
project policy.

**Principal WSP material:** Test release gates, documentation requirements,
common tools, semantic versioning, and security update requirements.

**Expected output:** Identified release artifacts, release documentation,
approval, and reproducible source and dependency references.

## 9. Operate and Support

Supported products receive defect and vulnerability triage, maintenance,
updates, and recovery action. Material operational evidence feeds requirements,
threat analysis, tests, and process improvement.

**Principal WSP material:** Security vulnerability response, requirements
change control, testing, and project support policy.

**Expected output:** Controlled issues, maintenance changes, security updates,
and support decisions.

## 10. Improve

The project evaluates estimation results, escaped defects, review and test
findings, build warnings, incidents, and release outcomes. Improvements update
project checklists and practices or enter the WSP change process when they are
generally reusable.

**Principal WSP material:** Personal-process postmortems, requirement change
analysis, warning summaries, and retained verification evidence.

**Expected output:** Approved process changes and traceable improvement
proposals.

## Lifecycle Tailoring

An adopting project may combine, repeat, or rename lifecycle activities. Its
adoption record shall still make clear where each applicable WSP requirement is
satisfied and which evidence demonstrates completion.
