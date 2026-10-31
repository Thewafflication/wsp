# Template — Work Log

**Content type:** Optional template

**Milestone or work package:** Identifier and title

**Period:** Start and end date or active period

**Starting baseline:** Source revision or controlled input set

**Author:** Person or role

**Status:** Active / Closed

Use this lightweight record when a chronological execution history improves
reproducibility, handoff, or process measurement. It does not replace the
accepted plan, controlled change history, defect records, verification
evidence, review record, or closeout decision.

## Work Performed

| Date or order | Phase | Activity | Output |
| --- | --- | --- | --- |
| YYYY-MM-DD or sequence | Lifecycle phase | Concise action | Reference |

## Verification Log

| Date | Configuration or method | Result | Evidence or failure reference |
| --- | --- | --- | --- |
| YYYY-MM-DD | Configuration or method | Pass / Fail / Other | Retained record |

Preserve failed results and their relationship to fixes and reruns. Do not copy
large logs into this record when a retained artifact can be referenced.

## Decisions and Scope Changes

| Decision or change | Authority | Impact | Reference |
| --- | --- | --- | --- |
| Summary | Approver or ADR | Scope, requirement, risk, or release effect | Record |

## Problems, Defects, and Recovery

| Item | Effect | Response | Status or owner |
| --- | --- | --- | --- |
| Failure, interruption, or defect | Consequence | Recovery or escalation | Open / Closed and role |

## Measurements

This section is optional. Use project-defined measures and their established
units. Record unavailable values as unavailable rather than estimating them
after the fact without a documented method.

| Measure | Value | Source or interpretation |
| --- | ---: | --- |
| Effort, elapsed time, size, tests, defects, or findings | Value | Measurement source |

## Preservation and Handoff

Identify retained artifacts and evidence, user-owned or unrelated changes that
were preserved, incomplete work, approved deferrals, and the next responsible
person or work package.

Do not record secrets, credentials, complete environment dumps, or sensitive
arguments in a work log.
