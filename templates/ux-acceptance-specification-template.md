# Template — UX Acceptance Specification

**Content type:** Template

**Project:** Project name

**Product and interface baseline:** Version, revision, or controlled reference

**Status:** Proposed

**Owner:** Responsible role

**Approval:** Review or change reference and date

This template creates the project-owned definitions and exact pass criteria
required by the WSP UX/UI profile. Replace every placeholder, delete
inapplicable examples, and keep the approved specification under change
control. Do not complete this template in the pinned WSP submodule.

## Scope and Sources

**In-scope interfaces:** Controlled interface identifiers

**User-needs baseline:** Research or stakeholder reference

**Product requirements:** Requirement-set reference

**Use-error and risk analysis:** Controlled reference

**EN 301 549 applicability matrix:** Controlled reference

**Support baseline:** Supported product, platform, host, and compatibility
reference

## User-Group Register

Assign one stable identifier to each materially different user group. Inclusion
criteria describe observable characteristics used for participant recruitment
or proxy-method selection. Record relevant permanent, temporary, and
situational limitations without collecting unnecessary personal information.

| User group | Goals and tasks | Inclusion criteria | Relevant capabilities and limitations | Research evidence |
| --- | --- | --- | --- | --- |
| `UG-NNNN` | Controlled task references | Exact participant or proxy criteria | Physical, sensory, cognitive, domain, and technical factors | Study, field, support, or stakeholder record |

## Principal-Task Register

Completion conditions identify the observable product and user state that ends
the task successfully. Record every applicable principal-task qualification
from the WSP definition.

| Task | User group | Entry state | Intended outcome and completion condition | Principal-task qualification | Critical use errors |
| --- | --- | --- | --- | --- | --- |
| `TASK-NNNN` | `UG-NNNN` | Exact initial state and data | Observable final state | Product commitment, primary outcome, critical consequence, or lifecycle/accessibility task | Use-error identifiers |

## Supported-Configuration Register

A bounded version range needs an objective inclusion rule and a method for
selecting exact verification versions.

| Configuration | Product build | Platform and host | Input and output | Locale and presentation | Assistive technology and settings | Support source |
| --- | --- | --- | --- | --- | --- | --- |
| `CFG-NNNN` | Exact revision or bounded release | OS, terminal, browser, runtime, or device versions | Keyboard, pointer, touch, speech, visual, audio, or haptic modes | Locale, scale, contrast, font, motion, and focus settings | Product, version, accessibility mode, and relevant preferences | Support-policy reference |

## Evaluation-Context Register

Use a separate context when a difference can change an acceptance result or
applicable risk.

| Context | User group | Task | Environment and data | Configuration | Prior knowledge, training, and assistance |
| --- | --- | --- | --- | --- | --- |
| `CTX-NNNN` | `UG-NNNN` | `TASK-NNNN` | Location, noise, lighting, workload, connectivity, and controlled data | `CFG-NNNN` or a stated configuration rule | Exact permitted conditions |

## Glossary and Convention Register

| Term, symbol, unit, or pattern | Approved meaning or behavior | User groups and contexts | Source | Approved exception |
| --- | --- | --- | --- | --- |
| Interface term or pattern | Exact wording, semantics, sequence, or presentation | `UG-NNNN`, `CTX-NNNN` | Domain, platform, research, or product source | Exception reference or `None` |

## Use-Error Register

| Use error | Trigger or sequence | Consequence | Foreseeability source | Critical | Preventable | Control and verification |
| --- | --- | --- | --- | --- | --- | --- |
| `UE-NNNN` | Invalid, missing, boundary, repeated, out-of-sequence, or observed action | Observable result | Research, field report, analysis, standard, or convention | Yes / No with rationale | Yes / No with feasibility reference | Requirement and test reference |

## Acceptance-Criterion Index

Each applicable user group and principal-task context, WSP-UX-0011 through
WSP-UX-0027 requirement, and critical use error needs criterion coverage. One
criterion can cover several sources only when one result passes or fails them
together.

| Criterion | Source requirements, tasks, or risks | Contexts | Measure or classification | Pass threshold | Detailed record |
| --- | --- | --- | --- | --- | --- |
| `UX-AC-NNNN` | WSP, project requirement, `TASK-NNNN`, or `UE-NNNN` | `CTX-NNNN` | One observable outcome | Exact numeric or enumerated condition | Heading or controlled protocol reference |

## UX-AC-NNNN — Criterion Title

Copy this section for every acceptance criterion.

- **Status:** Proposed / Approved / Retired
- **Sources:** WSP and project requirements, user need, task, use error, risk,
  or standard clause
- **Evaluation contexts:** `CTX-NNNN`
- **Measure or classification:** One observable value or enumerated result
- **Unit:** Time, count, percentage, rating scale, state, or `N/A`
- **Observation start:** Exact event, state, or instruction
- **Observation end:** Exact event, state, or output
- **Method and protocol:** Test, inspection, analysis, review, or demonstration
  and its controlled procedure
- **Participants or configurations:** Exact sample size, inclusion and
  exclusion rules, supported-configuration selection rule, and repetitions
- **Permitted prior knowledge:** Training, documentation, assistance, practice,
  and warm-up allowed by the protocol
- **Pass threshold:** Exact boundary, percentile or worst-case rule, rounding,
  treatment of incomplete observations, and required confidence rule when used
- **Required evidence:** Raw observations, logs, recordings when permitted,
  screenshots, accessibility trees or events, calculations, result, and tool
  versions
- **Deviation rule:** Conditions that invalidate a result and the authority
  permitted to approve a protocol change before re-execution
- **Rationale:** Evidence supporting the selected measure, sample, and threshold
- **Approval:** Role, record, and date before evaluation

## Feedback-Timing Allocation

Use this table for WSP-UX-0016. Values below are placeholders, not WSP defaults.
Every duration identifies its start and observable end events in a detailed
criterion.

| Action or operation class | Criterion | Acknowledgement threshold | Processing-state threshold | Progress-update rule | Completion or timeout rule |
| --- | --- | --- | --- | --- | --- |
| Keystroke, command, navigation, background task, or remote operation | `UX-AC-NNNN` | Project value and percentile rule | Project value and percentile rule | Interval or event rule, or justified N/A | Project value, cancellation, timeout, or failure behavior |

## Participant and Sampling Plan

| Protocol | User groups | Recruitment and exclusion | Sample size | Task order and repetitions | Analysis and stopping rule |
| --- | --- | --- | --- | --- | --- |
| Controlled protocol reference | `UG-NNNN` | Observable criteria and conflict controls | Exact number per group | Randomization, counterbalancing, practice, and repetitions | Calculation, missing data, outlier, and early-stop rules |

Record why the selected sample and analysis can decide each assigned
criterion. A convenience sample is not automatically representative.

## Accessibility Compatibility Matrix

Record the coverage algorithm before selecting combinations. Examples include
exhaustive, pairwise with named factors and strengths, or risk-based selection
with an approved risk record.

**Coverage rule:** Exact algorithm or controlled rationale

| Matrix entry | Configurations | Principal tasks | Input-only and display modes | Assistive technology, version, and settings | Expected results | Procedure and evidence |
| --- | --- | --- | --- | --- | --- | --- |
| `AT-NNNN` | `CFG-NNNN` | `TASK-NNNN` | Keyboard, forced colors, scaling, reduced motion, or other mode | Exact product and configuration | Observable output, operation, focus, semantics, and events | Test and result references |

## Traceability and Coverage

| Source item | Required contexts | Acceptance criteria | Verification evidence | Coverage status |
| --- | --- | --- | --- | --- |
| User group, principal task, WSP requirement, project requirement, critical use error, or EN clause | `CTX-NNNN` | `UX-AC-NNNN` | Test, analysis, inspection, review, or demonstration | Covered / Missing / Not applicable with approval |

Missing coverage, an unapproved criterion, or an invalid or unknown result is
not a passing result.

## Results and Release Decision

| Criterion or matrix entry | Result | Evidence | Deviations | Finding or risk disposition |
| --- | --- | --- | --- | --- |
| `UX-AC-NNNN` or `AT-NNNN` | Pass / Fail / Invalid / Not run / N/A | Exact retained record | None or approved deviation | Finding, risk, tailoring, or `None` |

**Coverage check:** Pass / Fail

**UX/UI release gate:** Pass / Fail

**Unresolved non-passing results:** Controlled records or `None`

**Decision authority and approval:** Role, record, and date

## Baseline History

| Date | Product baseline | Specification revision | Change and impact summary | Approval |
| --- | --- | --- | --- | --- |
| YYYY-MM-DD | Version or revision | Controlled revision | Initial baseline or changed users, tasks, configurations, criteria, or thresholds | Review reference |
