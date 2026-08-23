# UX/UI Requirements

**Content type:** Selectable profile requirements

## Scope

These requirements apply when a project selects the UX/UI profile. They cover
the human-centred development process, interaction and interface design,
information presentation, software accessibility, assistive-technology
interoperability, and verification.

The requirements are WSP obligations informed by the standards described in
[UX/UI standards alignment](standards-alignment.md). Except for the explicit
EN 301 549 baseline in WSP-UX-0028 and WSP-UX-0029, a standards relationship is
thematic rather than a clause-level conformity claim. WSP-UX-0030 through
WSP-UX-0036 and WSP-UX-0048 through WSP-UX-0057 make important accessibility
outcomes explicit; they do not narrow the complete applicability assessment
required by WSP-UX-0028 or the baseline required by WSP-UX-0029.

## Controlled Terms

The following terms govern this profile. An adopting project records the
identified items in controlled artifacts before using them to make a pass,
fail, or applicability decision.

- **Acceptance criterion** — a stable project-owned identifier stating one
  observable measure or classification, its context, method, exact pass
  threshold, required sample or configurations, and evidence.
- **Approved** — accepted by the role authorized in the project process before
  the activity or result that depends on the approval.
- **Critical use error** — a use error that causes or can cause loss or
  corruption of user data, unauthorized disclosure or action, safety or
  security harm, an irreversible unintended action, or failure of a principal
  task. A project can classify additional consequences as critical.
- **Equivalent** — enabling the same task outcome and conveying the same
  essential information, order, accuracy, and time sensitivity without
  requiring the excluded modality or capability.
- **Evaluation context** — a controlled identifier for one user group, task,
  environment, supported configuration, and prior-knowledge condition. Two
  contexts are distinct when an identified difference can change an acceptance
  result or applicable risk.
- **Foreseeable use error** — a use error observed in research or operation,
  identified by use-error or risk analysis, covered by an applicable standard
  or established platform convention, or produced by invalid, missing,
  boundary, repeated, or out-of-sequence input.
- **Material finding** — a failed requirement or acceptance criterion, a
  critical use error, or a usability or accessibility risk above the project's
  approved acceptance threshold.
- **Material UX/UI change** — a change to an in-scope user group or context; a
  principal task's outcome, sequence, semantics, input, output, navigation, or
  recovery; an accessibility service or supported configuration; or an
  applicable UX/UI requirement or acceptance criterion.
- **Principal task** — a task listed in the approved principal-task register
  because it is required by a product or stakeholder commitment, is necessary
  to achieve a primary product outcome, can produce a critical use error, or
  installs, configures, updates, repairs, recovers, or makes the product
  accessible.
- **Representative participant** — a participant who meets the approved
  inclusion criteria for an in-scope user group and is evaluated with only the
  prior knowledge, training, and assistance permitted by the protocol.
- **Representative method** — direct evaluation with representative
  participants or a proxy method whose validity for the criterion, limitations,
  and approval are recorded before results are accepted.
- **Supported configuration** — an exact or bounded combination recorded in
  the support baseline, including the product build, platform, host interface,
  input and output methods, locale, relevant display settings, assistive
  technology, and accessibility settings.
- **Task-relevant** — traceable to the active task, a user requirement, an
  applicable legal, safety, security, or accessibility obligation, or a global
  navigation, help, status, or recovery function.
- **Timely** — meeting an approved acceptance criterion that states the event
  from which time is measured, the observable response, the percentile or
  worst-case rule, and the maximum duration.

When this profile uses *safe*, *unsafe*, *feasible*, or *practicable*, the
classification is supported by an approved risk or feasibility analysis that
identifies the evidence, decision authority, and affected acceptance criteria.
The [UX acceptance specification template](../templates/ux-acceptance-specification-template.md)
provides the expected project-owned structure.

## Human-Centred Development

### WSP-UX-0001 — Human-centred design plan

**Requirement:** The project shall maintain a human-centred design plan that
identifies the in-scope interfaces, responsible role, activities, participants,
artifacts, decision points, evaluation methods, and lifecycle milestones.

**Rationale:** Human-centred work is repeatable and reviewable when it is
planned as part of development rather than deferred to final acceptance.

**Applicability:** Every project selecting the UX/UI profile.

**Verification:** Inspect the approved plan and its allocation to project
milestones and work records.

**Standards relationship:** ISO 9241-210:2019.

### WSP-UX-0002 — Context of use

**Requirement:** Before baselining UX/UI acceptance criteria, the project shall
document the intended and foreseeable user groups, goals, tasks,
environments, platforms, input and output modalities, assistive technologies,
and relevant physical, sensory, cognitive, technical, and organizational
constraints.

**Rationale:** Interface decisions and evaluation results are meaningful only
for a stated context of use.

**Applicability:** Every in-scope interface or a justified group of interfaces
with the same context.

**Verification:** Review the context description against research evidence,
product scope, support policy, and test configurations.

**Standards relationship:** ISO 9241-210:2019; ISO 9241-171:2025.

### WSP-UX-0003 — Inclusive user-group coverage

**Requirement:** For each functional performance need in EN 301 549 V3.2.1
Clause 4, the project's user-group model shall identify an in-scope user group
and permanent, temporary, and situational contexts or record a clause-specific
not-applicable rationale supported by product-scope and user evidence.

**Rationale:** A model based only on fully able expert users conceals common
accessibility and usability failures.

**Applicability:** Every in-scope interface.

**Verification:** Compare every Clause 4 functional performance need with the
user-group register, research recruitment, contexts, and excluded-user
rationales.

**Standards relationship:** ISO 9241-171:2025; EN 301 549 V3.2.1, Clause 4.

### WSP-UX-0004 — User needs and measurable requirements

**Requirement:** The project shall derive user needs into traceable user,
interaction, accessibility, usability, and use-related quality requirements
with observable acceptance criteria for the applicable context of use.

**Rationale:** Traceable and measurable requirements connect research to
design decisions and objective acceptance evidence.

**Applicability:** Every in-scope user group and principal task.

**Verification:** Trace sampled research findings and user needs forward to
requirements, design elements, tests, and acceptance thresholds, and trace
sampled requirements back to their sources.

**Standards relationship:** ISO 9241-210:2019; ISO 9241-115:2024.

### WSP-UX-0005 — User involvement

**Requirement:** The project shall involve representative participants before
the initial user-requirements baseline, before commitment to the selected
principal-task design, and during evaluation of the implemented interface.

**Rationale:** Early and continuing user involvement reveals incorrect
assumptions before they become expensive constraints.

**Applicability:** Every in-scope interface; a representative proxy method can
replace direct participation only when direct participation is unsafe,
unethical, or impracticable.

**Verification:** Inspect research plans, participant coverage, session
records, findings, resulting changes, and surrogate-method rationale.

**Standards relationship:** ISO 9241-210:2019.

### WSP-UX-0006 — Multidisciplinary design responsibility

**Requirement:** Each material UX/UI decision shall be reviewed by the assigned
UX/UI, implementation, verification, and accessibility roles and, when the
decision affects them, the assigned security, safety, privacy, localization,
documentation, and support roles.

**Rationale:** Interface outcomes cross organizational and technical
boundaries that one discipline cannot assess alone.

**Applicability:** Material UX/UI decisions and changes. One person can hold
multiple roles when project independence rules permit it.

**Verification:** Inspect design and review records for required disciplines,
findings, conflicts, decisions, and approvals.

**Standards relationship:** ISO 9241-210:2019.

### WSP-UX-0007 — Design alternatives

**Requirement:** Before committing an interaction pattern that materially
affects a principal task, the project shall evaluate at least two feasible
design alternatives or record why only one feasible alternative exists.

**Rationale:** Explicit alternatives reduce premature commitment to a design
driven by implementation convenience.

**Applicability:** New or materially changed principal-task interactions.

**Verification:** Inspect sketches, prototypes, trade studies, evaluation
results, and the selected-design rationale.

**Standards relationship:** ISO 9241-210:2019; ISO 9241-115:2024.

### WSP-UX-0008 — Iterative formative evaluation

**Requirement:** The project shall perform at least one formative evaluation
before committing the selected principal-task design and one on the
implemented interface, and shall repeat the affected evaluation after a
material finding until its approved exit criteria pass.

**Rationale:** Iteration based on evaluation is the control loop that makes the
design human-centred.

**Applicability:** From early design through implementation of every principal
task.

**Verification:** Inspect the two required evaluation stages, protocols,
participants or representative methods, findings, design changes, repeated
evaluations, and exit-criterion results.

**Standards relationship:** ISO 9241-210:2019.

### WSP-UX-0009 — Lifecycle feedback

**Requirement:** The project shall collect and assess post-release usability
and accessibility feedback at the interval stated in the support plan and
shall route every material finding into defect, requirement, risk, or
improvement control.

**Rationale:** Contexts, platforms, assistive technologies, and user needs can
change after release.

**Applicability:** Supported releases with an in-scope interface.

**Verification:** Inspect feedback channels, support and telemetry review where
permitted, issue classification, and resulting controlled records.

**Standards relationship:** ISO 9241-210:2019.

## Interaction and Interface Design

### WSP-UX-0010 — Controlled design specification

**Requirement:** The project shall maintain a design specification that covers
the conceptual design, user-system interactions, interface elements and their
behavior, navigation, information presentation, and the supported states and
transitions of each principal task.

**Rationale:** A controlled design makes intended interaction testable without
requiring evaluators to infer it from implementation.

**Applicability:** Every in-scope interface; the information can be distributed
across linked controlled artifacts.

**Verification:** Inspect design coverage and trace sampled design elements to
user requirements and implemented behavior.

**Standards relationship:** ISO 9241-115:2024.

### WSP-UX-0011 — Suitability for user tasks

**Requirement:** Every user-visible step, required input, output, control, and
default in a principal task flow shall trace to its approved task model, a user
requirement, or an approved technical constraint.

**Rationale:** Users should perform their work rather than translate it into
the system's architecture or data model.

**Applicability:** Every principal task in the defined context of use.

**Verification:** Trace every implemented principal-task step and interface
item to its source and execute the task against its approved acceptance
criteria.

**Standards relationship:** ISO 9241-110:2020, suitability for the user's tasks.

### WSP-UX-0012 — Conceptual model and user vocabulary

**Requirement:** Interface nouns, verbs, relationships, units, and symbols
shall match the approved user and domain glossary for the applicable user group.

**Rationale:** A coherent conceptual model reduces translation, memory, and
learning effort.

**Applicability:** Every in-scope interface.

**Verification:** Compare interface content with the approved glossary and
execute its comprehension acceptance criteria with representative
participants.

**Standards relationship:** ISO 9241-115:2024; ISO 9241-110:2020, conformity
with user expectations.

### WSP-UX-0013 — Interaction sequences

**Requirement:** The design shall specify each principal task's entry
conditions, user actions, system responses, alternatives, interruptions,
completion states, and failure and recovery paths.

**Rationale:** Complete interaction sequences expose missing states and
unrecoverable paths before implementation.

**Applicability:** Every principal task and destructive or high-consequence
secondary task.

**Verification:** Inspect scenarios and state models; execute positive,
alternative, interrupted, and failure paths.

**Standards relationship:** ISO 9241-115:2024.

### WSP-UX-0014 — Navigation and orientation

**Requirement:** Every state in a multi-state interaction shall present the
current view, mode, scope, or command context and the available next, previous,
exit, and principal-task paths that exist from that state.

**Rationale:** Users cannot control an interaction when location and available
paths are hidden or unpredictable.

**Applicability:** Interfaces with multiple views, modes, scopes, nested
contexts, or command levels.

**Verification:** Compare every implemented interaction state with the state
model and execute every path using the keyboard and applicable assistive
technologies.

**Standards relationship:** ISO 9241-115:2024; ISO 9241-110:2020,
self-descriptiveness and conformity with user expectations.

### WSP-UX-0015 — Self-descriptive controls and actions

**Requirement:** Before activation, each control or command shall expose its
purpose, availability, current state, required input, and means of operation
visually and through the applicable accessibility service or text interface.

**Rationale:** Users should not need external documentation or trial activation
to discover basic operation and state.

**Applicability:** Every interactive control, command, and action.

**Verification:** Interface and semantic-tree inspection, first-use task test,
and assistive-technology test.

**Standards relationship:** ISO 9241-110:2020, self-descriptiveness;
ISO 9241-171:2025.

### WSP-UX-0016 — Timely system feedback

**Requirement:** Each user action and background operation affecting the
current task shall expose acknowledgement, processing, progress when
measurable, completion, and failure states within the exact timing thresholds
assigned in the UX acceptance specification.

**Rationale:** Timely feedback supports control, confidence, and safe recovery.

**Applicability:** Every user action and background operation that affects the
current task.

**Verification:** Measure every assigned state transition under normal, slow,
failure, and assistive-technology configurations using the event, percentile
or worst-case rule, and threshold in its acceptance criterion.

**Standards relationship:** ISO 9241-110:2020, self-descriptiveness;
ISO 9241-112:2025, detectability; EN 301 549 V3.2.1, 11.4.1.3 where applicable.

### WSP-UX-0017 — Conformity with expectations

**Requirement:** Each interface pattern shall conform to the project's approved
pattern and convention register or identify an approved exception supported by
user evidence and an acceptance criterion.

**Rationale:** Predictable behavior lets users transfer prior knowledge and
avoids surprising consequences.

**Applicability:** Every in-scope interface.

**Verification:** Inventory implemented patterns and compare every instance
with its registered internal, supported-platform, and task-domain convention
or approved exception.

**Standards relationship:** ISO 9241-110:2020, conformity with user
expectations; ISO 9241-112:2025, consistency.

### WSP-UX-0018 — Learnability and assistance

**Requirement:** First-use and returning representative participants shall meet
the approved principal-task completion, assistance, critical-use-error, and
retention thresholds without training or help beyond that permitted by the
acceptance criterion.

**Rationale:** Learnability reduces dependence on training without withholding
needed help.

**Applicability:** Every principal task, including first use and infrequent
high-consequence tasks.

**Verification:** Execute the first-use and returning-user protocols and
calculate each result using the approved sampling and threshold rules.

**Standards relationship:** ISO 9241-110:2020, learnability;
ISO 9241-115:2024.

### WSP-UX-0019 — Control of task progress

**Requirement:** A user-initiated task shall advance only after the initiating
user action or an automatic transition identified in the approved interaction
sequence, and the user shall be able to control every user-selectable branch
and pacing point in that sequence.

**Rationale:** Predictable authority over sequence and pace supports changing
goals and capabilities.

**Applicability:** User-initiated tasks.

**Verification:** Execute every manual and automatic transition and compare its
trigger and available branches with the approved interaction sequence.

**Standards relationship:** ISO 9241-110:2020, controllability.

### WSP-UX-0041 — Operation interruption and cancellation

**Requirement:** Each operation classified as safely interruptible shall
provide an operable cancel or interrupt action while it is pending.

**Rationale:** Users need a defined way to stop work that is no longer wanted.

**Applicability:** Pending user-initiated and background operations; every
non-interruptible classification requires the analysis defined under
Controlled Terms.

**Verification:** Invoke cancellation at each supported pending state and
verify the resulting state and retained data against the interaction sequence.

**Standards relationship:** ISO 9241-110:2020, controllability.

### WSP-UX-0042 — Recovery from unintended navigation state

**Requirement:** Every nonterminal interaction state shall provide an operable
path to its preceding recoverable state or to the principal task's defined safe
exit state.

**Rationale:** A user should not be trapped in an unintended mode or branch.

**Applicability:** Multi-state interactions; a state with no return path
requires an approved safety or security rationale and advance user warning.

**Verification:** Enter every state through each supported path and execute its
documented return or safe-exit path using each applicable input method.

**Standards relationship:** ISO 9241-110:2020, controllability.

### WSP-UX-0043 — Preference-change data preservation

**Requirement:** Changing an interaction or presentation preference shall
preserve committed user data and shall preserve uncommitted input unless the
user confirms its loss before the change is applied.

**Rationale:** Personalization should not unexpectedly destroy work.

**Applicability:** Runtime and restart-persistent interface preferences.

**Verification:** Change each preference with committed and uncommitted data
present and compare the resulting data with the requirement.

**Standards relationship:** ISO 9241-110:2020, controllability and
individualization.

### WSP-UX-0020 — Foreseeable use-error prevention

**Requirement:** Each foreseeable use error classified as practicably
preventable shall have an implemented constraint, validation, default, or
interaction sequence that prevents the error before commitment.

**Rationale:** Prevention avoids recovery burden and protects users from known
failure paths.

**Applicability:** Inputs, commands, and state transitions covered by the
project's use-error analysis.

**Verification:** Trace every preventable use error to its control and execute
the error-inducing input or sequence to demonstrate prevention.

**Standards relationship:** ISO 9241-110:2020, use error robustness;
EN 301 549 V3.2.1, 11.3.3 where applicable.

### WSP-UX-0044 — Error identification

**Requirement:** When an input or action is rejected, the interface shall
identify the affected item, the rejected value or action when safe to disclose,
and the violated constraint in text and through the applicable accessibility
service.

**Rationale:** Users need a specific diagnosis before they can correct an
error.

**Applicability:** Rejected input, command, and action results.

**Verification:** Trigger every defined validation and action error and inspect
the visible or textual output and assistive-technology announcement.

**Standards relationship:** ISO 9241-110:2020, use error robustness;
EN 301 549 V3.2.1, 11.3.3.1 where applicable.

### WSP-UX-0045 — Correction and valid-input preservation

**Requirement:** After a rejected submission, the interface shall preserve
every valid user-supplied value and place the user at, or provide an operable
path to, each item requiring correction.

**Rationale:** Correction should not require re-entry of unrelated valid work.

**Applicability:** Interfaces that accept two or more user-supplied values or
commands before submission.

**Verification:** Submit each combination of valid and invalid values and
verify preservation, focus or cursor placement, and correction paths.

**Standards relationship:** ISO 9241-110:2020, use error recovery;
EN 301 549 V3.2.1, 11.3.3 where applicable.

### WSP-UX-0046 — High-consequence commitment control

**Requirement:** Before executing an action that can cause a critical use
error, the interface shall either present the exact affected object and
consequence for confirmation or provide a tested reversal that restores the
pre-action state.

**Rationale:** Explicit confirmation or reversal limits irreversible harm.

**Applicability:** Actions identified by use-error, safety, security, privacy,
or data-loss analysis as capable of causing a critical use error.

**Verification:** Execute each action through its confirmation and cancellation
paths or execute and reverse it, then compare state and data with the baseline.

**Standards relationship:** ISO 9241-110:2020, use error prevention and
recovery; EN 301 549 V3.2.1, 11.3.3.4 where applicable.

### WSP-UX-0021 — Trustworthy user engagement

**Requirement:** Interface claims about capabilities, limitations,
consequences, provenance, privacy-relevant behavior, and system state shall
match the authoritative product, security, privacy, and operational records
identified by the design specification.

**Rationale:** Engagement is sustainable only when the system earns informed
user trust.

**Applicability:** Every in-scope interface, especially consent, installation,
configuration, purchase, update, security, and data-handling interactions.

**Verification:** Trace each in-scope claim to its authoritative record and
execute the associated comprehension acceptance criterion.

**Standards relationship:** ISO 9241-110:2020, user engagement.

### WSP-UX-0047 — Informed user choice

**Requirement:** When options produce different cost, privacy, security, data-
retention, installation, or support consequences, the interface shall present
those consequences before selection without preselecting the option with the
greater consequence.

**Rationale:** A choice is informed only when material differences are visible
before commitment and the interface does not choose the greater consequence
for the user.

**Applicability:** Consent, purchase, installation, configuration, update,
account, telemetry, privacy, security, and data-handling choices.

**Verification:** Inspect default selection and execute every choice path,
comparing presented consequences with the authoritative records.

**Standards relationship:** ISO 9241-110:2020, user engagement and
trustworthiness.

## Presentation of Information

### WSP-UX-0022 — Detectable presentation

**Requirement:** Each task-relevant information item and control shall meet its
assigned detectability acceptance criterion for prominence, presentation time,
persistence, and continuity in every supported modality and configuration.

**Rationale:** Information cannot support a task if users cannot perceive that
it is present.

**Applicability:** All interface output and controls.

**Verification:** Measure the assigned visual, auditory, tactile, or haptic
properties and execute the detection protocol in every configuration named by
the acceptance criterion.

**Standards relationship:** ISO 9241-112:2025, detectability;
ISO 9241-171:2025.

### WSP-UX-0023 — Discriminable presentation

**Requirement:** Items with different meaning, state, priority, or action shall
be distinguishable without relying on color, location, shape, sound, or another
single sensory characteristic alone.

**Rationale:** Redundant cues preserve meaning across user capabilities,
assistive technologies, and degraded environments.

**Applicability:** All presented information and controls.

**Verification:** Remove or suppress each individual cue in turn, test forced-
colors and required contrast modes, and verify that the remaining cue conveys
the same distinction visually and through applicable assistive technology.

**Standards relationship:** ISO 9241-112:2025, discriminability;
ISO 9241-171:2025; EN 301 549 V3.2.1, Clauses 9 through 11 where applicable.

### WSP-UX-0024 — Concise and task-relevant presentation

**Requirement:** Every information item and control presented in a task state
shall trace to a task-relevant source, and every source allocated to that state
shall be directly present or reachable through an identified operable path.

**Rationale:** Concision reduces cognitive effort, but minimalism must not hide
information needed for correct or accessible operation.

**Applicability:** Every task state and product-generated output.

**Verification:** Compare the complete state inventory bidirectionally with its
task-relevant sources and execute each indirect path by keyboard and applicable
assistive technology.

**Standards relationship:** ISO 9241-112:2025, conciseness.

### WSP-UX-0025 — Unambiguous interpretation

**Requirement:** Presented information shall conform to the approved glossary,
unit, symbol, ordering, and grouping rules and shall meet its assigned
comprehension acceptance criterion without undisclosed context.

**Rationale:** Ambiguous labels and incomplete state information create use
errors even when content is technically perceivable.

**Applicability:** Labels, prompts, messages, help, data, status, and exported
information.

**Verification:** Compare every content pattern with the controlled rules and
execute its comprehension protocol with representative participants.

**Standards relationship:** ISO 9241-112:2025, unambiguous interpretability.

### WSP-UX-0026 — Freedom from distraction

**Requirement:** Each recurring or continuous motion, sound, haptic output, or
system-initiated interruption that is not task-relevant shall provide a
keyboard- and assistive-technology-operable pause, stop, hide, or disable
control.

**Rationale:** Distraction can mask important information and impose sensory or
cognitive barriers.

**Applicability:** System-initiated and continuous presentation.

**Verification:** Inventory recurring and continuous output, verify its task
trace, and operate every required suppression control using all applicable
input methods.

**Standards relationship:** ISO 9241-112:2025, freedom from distraction;
ISO 9241-171:2025.

### WSP-UX-0027 — Presentation consistency across modalities and outputs

**Requirement:** Each alternate modality and exported format shall contain the
same task-relevant fields, relationships, order dependencies, units, and status
as its authoritative source or an approved equivalent representation of each.

**Rationale:** Equivalent representations should not contradict one another or
lose semantics during transformation.

**Applicability:** Information presented through more than one modality or
converted, copied, printed, or exported.

**Verification:** Compare every source field and relationship with each
alternate presentation, inspect exported semantics, and execute the applicable
assistive-technology reading sequence.

**Standards relationship:** ISO 9241-112:2025, consistency;
EN 301 549 V3.2.1, 5.4 and applicable Clauses 7, 9, and 10.

## Accessibility and Assistive Technology

### WSP-UX-0028 — EN 301 549 applicability matrix

**Requirement:** The project shall maintain a clause-level applicability
matrix for EN 301 549 V3.2.1 Clauses 5 through 13 that records each
requirement's applicability, product allocation, verification method, result,
evidence, and approved rationale for every not-applicable determination.

**Rationale:** EN 301 549 contains conditional requirements for different ICT
capabilities; a clause-level matrix prevents silent omissions.

**Applicability:** Every release within the UX/UI profile. A contract or
regulation that mandates a different edition requires a documented baseline
and impact assessment.

**Verification:** Inspect the matrix for complete clause coverage and compare
its conditions with shipped software, content, documentation, hardware, and
services.

**Standards relationship:** EN 301 549 V3.2.1, Clauses 5 through 13 and Annex C.

### WSP-UX-0029 — EN 301 549 accessibility baseline

**Requirement:** The released product, its in-scope content and documentation,
and its provided support services shall pass every EN 301 549 V3.2.1
requirement identified as applicable by WSP-UX-0028 using the corresponding
Annex C assessment procedure or an approved method that is at least as
conclusive.

**Rationale:** A common, testable accessibility baseline converts broad
inclusive-design goals into observable product behavior.

**Applicability:** Every release within the UX/UI profile; any tailored failure
remains unsatisfied and cannot be represented as conformity.

**Verification:** Review the completed matrix, procedures, results, retained
evidence, deviations, and independent review record.

**Standards relationship:** EN 301 549 V3.2.1.

### WSP-UX-0030 — Keyboard operation

**Requirement:** Every function available through an in-scope interface shall
be operable through the supported keyboard interface without requiring a
specific timing of individual keystrokes.

**Rationale:** Keyboard behavior supports users of keyboards, switch devices,
voice control, and other assistive input.

**Applicability:** Interfaces that support a keyboard or platform keyboard
interface; closed functionality follows its applicable EN 301 549 provisions.

**Verification:** Execute every function with the pointing device unavailable
and vary the interval between individual keystrokes across the supported input
range.

**Standards relationship:** ISO 9241-171:2025; EN 301 549 V3.2.1, 11.2.1.1 and
other applicable keyboard-operation requirements.

### WSP-UX-0048 — Focus order

**Requirement:** Sequential keyboard focus shall visit each operable element
once in an order that preserves the relationships and operation sequence in the
approved interaction design.

**Rationale:** A controlled order makes keyboard navigation predictable and
preserves meaning.

**Applicability:** Interfaces with sequential keyboard focus.

**Verification:** Record forward and reverse focus traversal for every state
and compare the sequence with the interaction design and accessibility tree.

**Standards relationship:** ISO 9241-171:2025; EN 301 549 V3.2.1, applicable
focus-order requirements in Clauses 9 through 11.

### WSP-UX-0049 — Focus indication

**Requirement:** The element holding keyboard focus shall have a visible focus
indicator that passes every applicable EN 301 549 contrast requirement in each
supported display and platform accessibility mode.

**Rationale:** Keyboard users need to locate the current interaction target.

**Applicability:** Interfaces that present a visual keyboard focus.

**Verification:** Traverse every element in every supported display mode and
measure the indicator using the applicable EN 301 549 assessment procedure.

**Standards relationship:** ISO 9241-171:2025; EN 301 549 V3.2.1, applicable
focus-visible and contrast requirements in Clauses 9 through 11.

### WSP-UX-0050 — No focus trap

**Requirement:** Keyboard focus entering an interface element or nested
interaction region shall leave it using a supported standard exit method or a
documented keyboard method announced before the user enters the region.

**Rationale:** A keyboard trap can make the rest of an interface unreachable.

**Applicability:** Every focusable element and nested interaction region.

**Verification:** Enter every region by each supported keyboard path and leave
it in every direction using only the documented keyboard method.

**Standards relationship:** ISO 9241-171:2025; EN 301 549 V3.2.1, 11.2.1.2 and
corresponding web requirements where applicable.

### WSP-UX-0031 — Programmatic object semantics

**Requirement:** Each user-interface element shall expose an accurate
programmatic role, name, state, and bounds; every description assigned by the
design specification; and every current, minimum, and maximum value supported
by the element type through documented platform accessibility services.

**Rationale:** Assistive technologies require semantics rather than a visual
approximation of the interface.

**Applicability:** Software with a user interface that is open to assistive
technology.

**Verification:** Accessibility-tree inspection and representative screen-
reader and automation tests for every component type and state.

**Standards relationship:** ISO 9241-171:2025; EN 301 549 V3.2.1, 11.4.1.2 and
11.5.2.5 through 11.5.2.7.

### WSP-UX-0032 — Programmatic structure

**Requirement:** The interface shall expose label, parent-child, table, and
reading-order relationships through documented platform accessibility
services.

**Rationale:** Structure and operability are lost when assistive technologies
receive disconnected labels or a flat stream of visual text.

**Applicability:** Software with a user interface that is open to assistive
technology.

**Verification:** Inspect the accessibility tree and test forms, tables,
hierarchies, and structured output with each representative assistive
technology.

**Standards relationship:** ISO 9241-171:2025; EN 301 549 V3.2.1, 11.5.2.6,
11.5.2.8, and 11.5.2.9.

### WSP-UX-0051 — Programmatic text

**Requirement:** Text rendered by the interface shall expose its content,
attributes, and screen bounds through documented platform accessibility
services in the same logical reading order as the authoritative text.

**Rationale:** Assistive technologies need programmatic text rather than a
visual image or unordered stream.

**Applicability:** Software that renders text and is open to assistive
technology.

**Verification:** Compare rendered text and its accessibility representation
for content, attributes, bounds, and reading order in every text state.

**Standards relationship:** ISO 9241-171:2025; EN 301 549 V3.2.1, 11.5.2.10.

### WSP-UX-0052 — Programmatic actions

**Requirement:** Each action available on a user-interface element shall be
exposed by documented platform accessibility services with a programmatic
method that invokes the same product behavior when security rules permit it.

**Rationale:** Identifying a control is insufficient when assistive technology
cannot activate it.

**Applicability:** Software with actionable interface elements that is open to
assistive technology.

**Verification:** Enumerate and invoke every exposed action through the
platform accessibility service and compare its result with standard input.

**Standards relationship:** ISO 9241-171:2025; EN 301 549 V3.2.1, 11.5.2.11 and
11.5.2.12.

### WSP-UX-0033 — Assistive-technology equivalent operation

**Requirement:** Where the user can act on, focus, select, or edit an element,
the interface shall permit the equivalent operation through documented
platform accessibility services when security rules permit it.

**Rationale:** Static exposure is insufficient when an assistive-technology
user cannot perform actions or learn that the interface changed.

**Applicability:** Software with a user interface that is open to assistive
technology, subject to documented EN 301 549 security conditions.

**Verification:** Perform each standard-input operation through representative
assistive technology and compare results, recording each security exception.

**Standards relationship:** ISO 9241-171:2025; EN 301 549 V3.2.1, 11.5.2.12,
11.5.2.14, 11.5.2.16, and 11.5.2.17.

### WSP-UX-0053 — Programmatic focus and selection

**Requirement:** The interface shall expose the current keyboard focus, text
insertion point, and selection and shall permit assistive technology to modify
each attribute that standard user input can modify when security rules permit
it.

**Rationale:** Assistive technologies need to track and control the user's
current interaction position.

**Applicability:** Software with focus, editable text, or selectable content
that is open to assistive technology.

**Verification:** Read and modify every applicable attribute through the
platform accessibility service and compare it with visible or textual state.

**Standards relationship:** ISO 9241-171:2025; EN 301 549 V3.2.1, 11.5.2.13 and
11.5.2.14.

### WSP-UX-0054 — Accessibility change notification

**Requirement:** A change to an exposed element's role, name, description,
state, value, text, relationship, available actions, focus, insertion point, or
selection shall emit the corresponding platform accessibility notification.

**Rationale:** Assistive technologies cannot track dynamic interfaces without
change events.

**Applicability:** Dynamic software interfaces that are open to assistive
technology.

**Verification:** Trigger every supported change type and inspect the event,
changed object, new value, ordering, and assistive-technology announcement.

**Standards relationship:** ISO 9241-171:2025; EN 301 549 V3.2.1, 11.4.1.3 and
11.5.2.15.

### WSP-UX-0034 — Platform accessibility feature non-interference

**Requirement:** While running, the interface shall not disable, intercept, or
change a documented platform accessibility feature unless the user explicitly
requests that change through an accessible product control.

**Rationale:** Users depend on a consistent configured environment across
applications.

**Applicability:** Software that is not isolated from the platform.

**Verification:** Enable each applicable platform accessibility feature before
launch and while running, then verify its state and operation before, during,
and after product use.

**Standards relationship:** ISO 9241-171:2025; EN 301 549 V3.2.1, 11.6.2 and
11.7.

### WSP-UX-0055 — Platform preference conformance

**Requirement:** In the product mode designated to follow platform settings,
the interface shall apply the supported platform values for units, color,
contrast, font, text size, reduced motion, input, and focus presentation until
the user selects an explicit product override.

**Rationale:** Users depend on configured presentation and input settings
across applications.

**Applicability:** Software that can read the named platform settings; each
unavailable setting requires a platform-evidence-based not-applicable result.

**Verification:** Vary each setting across its supported values before launch
and while running and compare every affected interface property with the
platform value or explicit override.

**Standards relationship:** ISO 9241-171:2025; EN 301 549 V3.2.1, 11.7 and
applicable platform preference requirements.

### WSP-UX-0035 — Accessible alternatives and timing

**Requirement:** Information and functions that use audio, video, color,
motion, gesture, biometrics, or a time limit shall provide every alternative,
equivalent, adjustment, warning, and control required by the applicable
EN 301 549 V3.2.1 clauses.

**Rationale:** A single sensory, motor, biological, or timing path excludes
users who cannot perceive or perform it.

**Applicability:** Interfaces containing the named presentation, input, or
timing characteristics.

**Verification:** Applicability-driven tests using the corresponding EN 301 549
Annex C procedures and the representative participants or assistive-technology
configurations stated by those procedures and the acceptance specification.

**Standards relationship:** ISO 9241-171:2025; ISO 9241-112:2025;
EN 301 549 V3.2.1, applicable Clauses 5 through 11.

### WSP-UX-0036 — Accessibility-feature documentation

**Requirement:** Product documentation shall identify every shipped
accessibility and assistive-technology compatibility feature and explain its
activation, operation, limitations, supported configurations, and known
conflicts.

**Rationale:** Accessibility features are ineffective when users cannot
discover, learn, or obtain support for them.

**Applicability:** Shipped product documentation.

**Verification:** Trace every implemented feature and supported configuration
to its documentation and execute the documented activation and operation steps.

**Standards relationship:** ISO 9241-171:2025; EN 301 549 V3.2.1, Clause 12.

### WSP-UX-0056 — Accessible electronic documentation format

**Requirement:** Product documentation shall be available in at least one
electronic format that passes every applicable EN 301 549 V3.2.1 Clause 9 or
Clause 10 requirement.

**Rationale:** Users need an accessible path to product and accessibility
information.

**Applicability:** Product documentation supplied with the ICT.

**Verification:** Execute the applicable EN 301 549 Annex C procedures against
the exact published documentation artifact.

**Standards relationship:** ISO 9241-171:2025; EN 301 549 V3.2.1, 12.1.2.

### WSP-UX-0057 — Accessible support communication

**Requirement:** Each provided support service shall either communicate
through at least one method usable without vision, hearing, speech, or fine
motor input or publish an accessible referral path that provides such a method.

**Rationale:** Users who need accessibility support must be able to reach it.

**Applicability:** Product support services.

**Verification:** Demonstrate the supported communication method or referral
from the published support entry point and inspect information supplied about
accessibility features.

**Standards relationship:** ISO 9241-171:2025; EN 301 549 V3.2.1, 12.2.2
through 12.2.4.

## Evaluation and Release Evidence

### WSP-UX-0037 — Predefined UX acceptance criteria

**Requirement:** Before summative evaluation, the project shall approve a UX
acceptance specification in which every criterion has a stable identifier,
source, evaluation context, observable measure or classification, method,
exact pass threshold, sampling or configuration rule, and required evidence.

**Rationale:** Thresholds chosen after observing results cannot provide an
independent acceptance decision.

**Applicability:** Every release that introduces or materially changes an
in-scope interface; unchanged interfaces can reuse criteria after confirming
that their sources, contexts, methods, thresholds, and configurations remain
current.

**Verification:** Inspect every criterion for all required fields, approval
before evaluation, and current traceability.

**Standards relationship:** ISO 9241-210:2019; ISO 9241-110:2020.

### WSP-UX-0058 — Acceptance-criterion coverage

**Requirement:** The UX acceptance specification shall allocate at least one
criterion to every applicable user group and principal-task evaluation context,
every applicable WSP-UX-0011 through WSP-UX-0027 requirement, and every
identified critical use error.

**Rationale:** Exact criteria do not establish acceptance when important users,
tasks, design principles, or consequences are missing from coverage.

**Applicability:** Every UX acceptance specification.

**Verification:** Perform bidirectional traceability checks among contexts,
user groups, principal tasks, WSP requirements, critical use errors, and
acceptance criteria; every uncovered item fails verification.

**Standards relationship:** ISO 9241-210:2019; ISO 9241-110:2020;
ISO 9241-112:2025.

### WSP-UX-0038 — Representative summative evaluation

**Requirement:** The project shall execute every approved UX acceptance
criterion using the participants, environments, data, supported
configurations, prior knowledge, assistance limits, repetitions, and analysis
rule stated by that criterion.

**Rationale:** A summative result cannot be generalized beyond the conditions
and users represented in the evaluation.

**Applicability:** Release acceptance for new or materially changed interfaces.

**Verification:** Compare execution records with every protocol field,
recalculate results from raw observations, and treat an undeclared substitution
or deviation as a failed or invalid result.

**Standards relationship:** ISO 9241-210:2019.

### WSP-UX-0039 — Assistive-technology compatibility matrix

**Requirement:** Before compatibility execution, the project shall approve a
coverage matrix identifying the exact supported configurations, principal
tasks, input-only modes, display accessibility modes, assistive technologies,
versions, settings, expected results, and the pairwise, exhaustive, or
risk-based coverage rule used to select each test combination.

**Rationale:** Static inspection cannot establish end-to-end interoperability
among the product, platform, host interface, and assistive technology.

**Applicability:** Every release within the UX/UI profile; the matrix includes
at least one screen reader configuration when the interface presents text or
programmatic semantics.

**Verification:** Recalculate coverage from the support baseline and selection
rule, then inspect exact versions, settings, procedures, results, evidence, and
unresolved findings for every selected combination.

**Standards relationship:** ISO 9241-171:2025; EN 301 549 V3.2.1, Clauses 9
through 12 as applicable.

### WSP-UX-0040 — UX/UI release gate and evidence

**Requirement:** Before release approval, every applicable WSP-UX requirement
and EN 301 549 matrix entry shall have a passing result with retained evidence
or an approved non-passing disposition that is excluded from any satisfaction
or conformity claim and handled under the project's release-risk process; a
missing, invalid, or unknown result shall fail the UX/UI release gate.

**Rationale:** A complete decision record prevents missing, unknown, or
deferred accessibility and usability work from being reported as verified.

**Applicability:** Every release within the UX/UI profile.

**Verification:** Traceability inspection of requirements, tests, findings,
evidence, tailoring, residual risk, and the signed release decision.

**Standards relationship:** ISO 9241-210:2019; EN 301 549 V3.2.1, Annex C.
