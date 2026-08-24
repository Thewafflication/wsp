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

### UG-NNNN — User-group name

- **Goals and tasks:** Controlled task references
- **Inclusion criteria:** Exact participant or proxy criteria
- **Relevant capabilities and limitations:** Physical, sensory, cognitive,
  domain, and technical factors
- **Research evidence:** Study, field, support, or stakeholder record

## Principal-Task Register

Completion conditions identify the observable product and user state that ends
the task successfully. Record every applicable principal-task qualification
from the WSP definition.

### TASK-NNNN — Task title

- **User group:** `UG-NNNN`
- **Entry state:** Exact initial state and data
- **Intended outcome and completion condition:** Observable final state
- **Principal-task qualification:** Product commitment, primary outcome,
  critical consequence, or lifecycle or accessibility task
- **Critical use errors:** Use-error identifiers

## Supported-Configuration Register

A bounded version range needs an objective inclusion rule and a method for
selecting exact verification versions.

### CFG-NNNN — Configuration title

- **Product build:** Exact revision or bounded release
- **Platform and host:** OS, terminal, browser, runtime, or device versions
- **Input and output:** Keyboard, pointer, touch, speech, visual, audio, or
  haptic modes
- **Locale and presentation:** Locale, scale, contrast, font, motion, and focus
  settings
- **Assistive technology and settings:** Product, version, accessibility mode,
  and relevant preferences
- **Support source:** Support-policy reference

## Evaluation-Context Register

Use a separate context when a difference can change an acceptance result or
applicable risk.

### CTX-NNNN — Context title

- **User group:** `UG-NNNN`
- **Task:** `TASK-NNNN`
- **Environment and data:** Location, noise, lighting, workload, connectivity,
  and controlled data
- **Configuration:** `CFG-NNNN` or a stated configuration rule
- **Prior knowledge, training, and assistance:** Exact permitted conditions

## Glossary and Convention Register

### TERM-NNNN — Term, symbol, unit, or pattern

- **Approved meaning or behavior:** Exact wording, semantics, sequence, or
  presentation
- **User groups and contexts:** `UG-NNNN`, `CTX-NNNN`
- **Source:** Domain, platform, research, or product source
- **Approved exception:** Exception reference or `None`

## Use-Error Register

### UE-NNNN — Use-error title

- **Trigger or sequence:** Invalid, missing, boundary, repeated,
  out-of-sequence, or observed action
- **Consequence:** Observable result
- **Foreseeability source:** Research, field report, analysis, standard, or
  convention
- **Critical:** Yes / No with rationale
- **Preventable:** Yes / No with feasibility reference
- **Control and verification:** Requirement and test reference

## Acceptance-Criterion Index

Each applicable user group and principal-task context, WSP-UX-0011 through
WSP-UX-0027 requirement, and critical use error needs criterion coverage. One
criterion can cover several sources only when one result passes or fails them
together.

### UX-AC-NNNN — Criterion index entry

- **Source requirements, tasks, or risks:** WSP or project requirement,
  `TASK-NNNN`, or `UE-NNNN`
- **Contexts:** `CTX-NNNN`
- **Measure or classification:** One observable outcome
- **Pass threshold:** Exact numeric or enumerated condition
- **Detailed record:** Heading or controlled protocol reference

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

Use this section for WSP-UX-0016. Values below are placeholders, not WSP
defaults. Every duration identifies its start and observable end events in a
detailed criterion.

### TIMING-NNNN — Action or operation class

- **Criterion:** `UX-AC-NNNN`
- **Acknowledgement threshold:** Project value and percentile rule
- **Processing-state threshold:** Project value and percentile rule
- **Progress-update rule:** Interval or event rule, or justified `N/A`
- **Completion or timeout rule:** Project value, cancellation, timeout, or
  failure behavior

## Participant and Sampling Plan

### PROTOCOL-NNNN — Protocol title

- **User groups:** `UG-NNNN`
- **Recruitment and exclusion:** Observable criteria and conflict controls
- **Sample size:** Exact number per group
- **Task order and repetitions:** Randomization, counterbalancing, practice,
  and repetitions
- **Analysis and stopping rule:** Calculation, missing data, outlier, and
  early-stop rules

Record why the selected sample and analysis can decide each assigned
criterion. A convenience sample is not automatically representative.

## Accessibility Compatibility Matrix

Record the coverage algorithm before selecting combinations. Examples include
exhaustive, pairwise with named factors and strengths, or risk-based selection
with an approved risk record.

**Coverage rule:** Exact algorithm or controlled rationale

### AT-NNNN — Compatibility entry

- **Configurations:** `CFG-NNNN`
- **Principal tasks:** `TASK-NNNN`
- **Input-only and display modes:** Keyboard, forced colors, scaling, reduced
  motion, or other mode
- **Assistive technology, version, and settings:** Exact product and
  configuration
- **Expected results:** Observable output, operation, focus, semantics, and
  events
- **Procedure and evidence:** Test and result references

## Traceability and Coverage

### COVERAGE-NNNN — Source item

- **Source type:** User group, principal task, WSP requirement, project
  requirement, critical use error, or EN clause
- **Required contexts:** `CTX-NNNN`
- **Acceptance criteria:** `UX-AC-NNNN`
- **Verification evidence:** Test, analysis, inspection, review, or
  demonstration
- **Coverage status:** Covered / Missing / Not applicable with approval

Missing coverage, an unapproved criterion, or an invalid or unknown result is
not a passing result.

## Results and Release Decision

### RESULT-NNNN — Criterion or matrix entry

- **Item:** `UX-AC-NNNN` or `AT-NNNN`
- **Result:** Pass / Fail / Invalid / Not run / N/A
- **Evidence:** Exact retained record
- **Deviations:** None or approved deviation
- **Finding or risk disposition:** Finding, risk, tailoring, or `None`

**Coverage check:** Pass / Fail

**UX/UI release gate:** Pass / Fail

**Unresolved non-passing results:** Controlled records or `None`

**Decision authority and approval:** Role, record, and date

## Baseline History

### YYYY-MM-DD — Baseline entry

- **Product baseline:** Version or revision
- **Specification revision:** Controlled revision
- **Change and impact summary:** Initial baseline or changed users, tasks,
  configurations, criteria, or thresholds
- **Approval:** Review reference
