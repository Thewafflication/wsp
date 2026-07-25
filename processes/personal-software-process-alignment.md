# Personal Software Process Alignment

**Content type:** Framework guidance and mapping

## Purpose

The Personal Software Process (PSP), developed by Watts S. Humphrey at the
Carnegie Mellon Software Engineering Institute (SEI), provides a disciplined
personal framework for planning, measuring, managing, and improving software
work.

WSP uses PSP concepts where they add individual engineering discipline without
requiring every project to reproduce the complete PSP training framework,
forms, or progression model.

## Core Relationship

| PSP concept | WSP application |
| --- | --- |
| Defined personal process | Planned phases and completion criteria |
| Size and effort estimation | Estimates based on relevant historical data |
| Time recording | Actual effort recorded by work phase |
| Defect recording | Injection, removal, type, and fix effort captured |
| Design and code reviews | Personal checklists used before test |
| Quality planning | Expected review and test activities planned early |
| Postmortem analysis | Estimate and quality results compared with actuals |
| Process improvement | Checklists and practices updated from observed data |

## WSP Boundaries

WSP makes these distinctions:

- PSP informs individual planning and quality discipline.
- WSP requirements management controls project requirements and baselines.
- WSP ADRs control durable project architecture decisions.
- ISO/IEC/IEEE 29119 controls the WSP testing model.
- Project governance controls releases, approvals, and shared process changes.

An engineer's personal process may be more detailed than the project process,
but it shall not silently alter a controlled project obligation.

## Measurement Ethics

Personal process data is contextual. Time, size, and defect measures vary with
task novelty, language, environment, experience, and classification practice.

Projects using this profile shall protect individual data and define who may
access it. Aggregated data may support estimation and process improvement when
its limitations are documented. WSP does not permit personal defect or time
data to be treated as a standalone measure of engineer performance.

## WSP Mapping

The `WSP-PSP-####` requirements implement the personal-process profile.
Additional relationships include:

- requirements planning and change impact in `WSP-REQM-0004` and
  `WSP-REQM-0008`;
- early verification planning in `WSP-TEST-0001` through `WSP-TEST-0004`;
- failure preservation and analysis in `WSP-TEST-0009`;
- automated quality checks in `WSP-CSTYLE-0005`; and
- repeatable common tools in `WSP-TOOL-0003` and `WSP-TOOL-0008`.

## Conformity Position

WSP references and adapts PSP concepts. Adoption of WSP or its personal-process
profile is not a claim of SEI PSP certification, completion of PSP training, or
conformity to the complete PSP Body of Knowledge.

## References

- [The Personal Software Process (PSP), CMU/SEI-2000-TR-022][psp-report]
- [The Software Quality Profile][quality-profile]

[psp-report]: https://doi.org/10.1184/R1/6585197.v1
[quality-profile]: https://www.sei.cmu.edu/library/the-software-quality-profile/
