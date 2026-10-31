# Information-for-Users Requirements

**Content type:** Selectable profile requirements

## Scope

These requirements apply when a project selects the information-for-users
profile. They cover every supplier-controlled manual, help system, quick start,
tutorial, reference, administrator guide, API guide, and embedded information
product in the adopted scope.

The requirements are WSP obligations informed by [ISO/IEC/IEEE 26514:2022](standards-alignment.md).
Their standards relationships are thematic unless a project with authorized
access establishes a controlled clause-level mapping.

## Controlled Terms

- **Acceptance criterion** — a stable project-owned identifier stating one
  observable information outcome, its audience and task, method, exact pass
  threshold, sample or configurations, and required evidence.
- **Authoritative product source** — the controlled implementation, interface
  specification, schema, test, support policy, release record, or subject-matter
  approval from which a product statement can be verified.
- **Information for users** — supplier-provided conceptual, procedural, or
  reference information needed to use or support the software safely,
  effectively, and efficiently, whether separate from or embedded in it.
- **Information product** — one uniquely identified deliverable or channel
  containing information for users, such as a manual, command reference, help
  site, in-product topic set, tutorial, or API guide.
- **Material information defect** — missing or inaccurate content that can
  prevent a principal task, cause data loss, security, privacy, or safety harm,
  direct a user to an unsupported action, or misstate product support or
  compatibility.
- **Principal information-use task** — a principal product task for which a
  user must find, understand, or act on supplier-provided information, plus the
  tasks of finding support, resolving failure, and identifying applicable
  product and information versions.
- **Representative information user** — a person meeting the approved
  characteristics of an in-scope audience, evaluated with only the product
  knowledge, training, tools, and assistance permitted by the protocol.
- **Supported information configuration** — an exact or bounded combination
  of product version, information product and version, delivery medium,
  platform, locale, access method, display or output settings, and applicable
  assistive technology.

The project records the exact inventories, thresholds, samples, and
configurations used for acceptance in its controlled [information plan and
acceptance record](../templates/user-information-plan-template.md).

## Management and Analysis

### WSP-INFO-0001 — Information scope and baseline

**Requirement:** The project shall maintain an inventory that uniquely
identifies every in-scope information product, its purpose, owner, audience,
delivery medium, supported product versions, source location, and release
status.

**Applicability:** Every project selecting this profile.

**Verification:** Compare the approved inventory with product entry points,
packages, support channels, published locations, and the release artifact set.

**Standards relationship:** ISO/IEC/IEEE 26514:2022, Clauses 5 and 6.1.

### WSP-INFO-0002 — Information-development plan

**Requirement:** The project shall approve an information-development plan
that identifies objectives, constraints, dependencies, deliverables, roles,
milestones, review and validation activities, acceptance criteria, packaging,
release, translation when applicable, and maintenance arrangements.

**Applicability:** Every in-scope information set; a project plan can cover
multiple products when their controls and milestones are the same.

**Verification:** Inspect the approved plan and trace its activities and
completion criteria to scheduled work and retained records.

**Standards relationship:** ISO/IEC/IEEE 26514:2022, Clause 5 and Clause 6.1.

### WSP-INFO-0003 — Assigned responsibilities

**Requirement:** The project shall assign responsibility for information
architecture, content development, subject-matter accuracy, editorial quality,
accessibility, configuration control, release approval, localization when
applicable, and post-release maintenance.

**Applicability:** Every in-scope information set. One person can hold multiple
roles when project independence rules permit it.

**Verification:** Inspect responsibility assignments and sampled approvals,
reviews, and maintenance records.

**Standards relationship:** ISO/IEC/IEEE 26514:2022, Clauses 5 and 6.

### WSP-INFO-0004 — Audience analysis

**Requirement:** For each in-scope audience, the project shall document its
goals, product roles, expected prior knowledge, language and terminology,
abilities and accessibility needs, environments, access constraints, and
permitted training or assistance.

**Applicability:** Every distinct audience whose characteristics can change
content, presentation, access, or acceptance results.

**Verification:** Review the audience register against user research, product
scope, support records, and representative-user inclusion criteria.

**Standards relationship:** ISO/IEC/IEEE 26514:2022, Clause 6.2.

### WSP-INFO-0005 — Task analysis

**Requirement:** For each principal information-use task, the project shall
document the user goal, preconditions, inputs, ordered actions, product
responses, successful outcome, foreseeable errors, recovery, frequency, and
consequence of failure.

**Applicability:** Every in-scope audience and principal information-use task.

**Verification:** Inspect the task register and compare sampled tasks with
implemented product behavior, user research, risks, and support cases.

**Standards relationship:** ISO/IEC/IEEE 26514:2022, Clause 6.2.

### WSP-INFO-0006 — Information needs and requirements

**Requirement:** The project shall derive the audience and task analyses into
uniquely identified information requirements that state the required content,
audience, task or decision supported, delivery context, and measurable
acceptance criteria.

**Applicability:** Every identified information need that the supplier accepts
into scope.

**Verification:** Inspect information requirements for the required fields and
execute their acceptance methods.

**Standards relationship:** ISO/IEC/IEEE 26514:2022, Clauses 6.1 through 6.3.

### WSP-INFO-0007 — Information traceability

**Requirement:** The project shall maintain bidirectional traceability among
in-scope audiences, tasks, product requirements or features, information
requirements, topics, applicable risks, validation evidence, and information
products.

**Applicability:** Every in-scope information requirement and topic.

**Verification:** Trace samples in both directions and run the project's
traceability completeness check.

**Standards relationship:** ISO/IEC/IEEE 26514:2022, Clauses 5 and 6.

### WSP-INFO-0008 — Product-lifecycle integration

**Requirement:** Each planned product change shall receive an information
impact assessment before its implementation is accepted, and affected
information work shall be included in the same change or in an approved
release-blocking dependency.

**Applicability:** Changes to user-visible behavior, commands, interfaces,
outputs, compatibility, installation, configuration, security, support, or
known limitations.

**Verification:** Sample product changes and inspect impact decisions, linked
information work, review, and release status.

**Standards relationship:** ISO/IEC/IEEE 26514:2022, Clauses 5, 6.10, and 6.11.

## Information Architecture and Access

### WSP-INFO-0009 — Controlled information architecture

**Requirement:** The project shall maintain an information architecture that
maps each audience and principal information-use task to the applicable
information products, topic hierarchy, navigation paths, and delivery media.

**Applicability:** Every in-scope information set.

**Verification:** Inspect the architecture and demonstrate every mapped path
in each supported information configuration.

**Standards relationship:** ISO/IEC/IEEE 26514:2022, Clause 6.3 and the
standard's structure and presentation scope.

### WSP-INFO-0010 — Topic purpose and content type

**Requirement:** Each topic shall have one identified purpose and shall be
classified as conceptual, procedural, reference, troubleshooting, support, or
another project-defined content type with controlled required fields.

**Applicability:** Topic-based information and uniquely headed sections of a
linear manual.

**Verification:** Inspect every topic or an approved risk-based sample against
the controlled content model.

**Standards relationship:** ISO/IEC/IEEE 26514:2022, Clause 6.3.

### WSP-INFO-0011 — Information identity and applicability

**Requirement:** Each information product shall expose its title, unique
identifier, revision or version, publication status and date, supplier, covered
product names and versions, supported platforms or configurations, locale, and
the authoritative location for updates.

**Applicability:** Every information product.

**Verification:** Inspect displayed identity and metadata and compare them
with the information inventory and approved release baseline.

**Standards relationship:** ISO/IEC/IEEE 26514:2022, Clauses 6.9, 6.10, and
6.12.

### WSP-INFO-0012 — Navigation and findability

**Requirement:** For each principal information-use task, every supported
information configuration shall provide at least one controlled access path
and shall meet the project's exact findability threshold for that audience
without requiring knowledge excluded by the audience definition.

**Applicability:** Every principal information-use task and supported
information configuration.

**Verification:** Execute identified findability acceptance criteria with
representative information users and inspect navigation, search, index, and
cross-reference coverage as applicable.

**Standards relationship:** ISO/IEC/IEEE 26514:2022, presentation and usability
scope; Clauses 6.3 and 7.

### WSP-INFO-0013 — Embedded and context-sensitive help

**Requirement:** Embedded or context-sensitive help shall identify the active
product state or task, open the topic mapped to that context, preserve the
user's task state, and provide a path to the containing information set.

**Applicability:** Every implemented embedded or context-sensitive help entry
point.

**Verification:** Activate every entry point or an approved risk-based sample
from each mapped product state and verify topic, context, task-state, and
navigation results.

**Standards relationship:** ISO/IEC/IEEE 26514:2022, information incorporated
into the user interface and Clause 6.3.

## Content

### WSP-INFO-0014 — Product purpose, scope, and limitations

**Requirement:** The information set shall state the product's intended
purpose, supported uses, excluded or unsupported uses, principal capabilities,
material limitations, and the audience for each information product.

**Applicability:** Every released product information set.

**Verification:** Compare the statements with approved product scope,
requirements, risk records, and support policy.

**Standards relationship:** ISO/IEC/IEEE 26514:2022, content scope and Clause
6.1.

### WSP-INFO-0015 — Prerequisites and system requirements

**Requirement:** Before the first dependent instruction, the information shall
identify the required product version, platform, hardware, software,
permissions, accounts, connectivity, inputs, dependencies, prior state,
knowledge, and safety or backup preparations.

**Applicability:** Every procedure with one or more prerequisites.

**Verification:** Execute the procedure from the documented prerequisite
state and test omission or mismatch of each material prerequisite.

**Standards relationship:** ISO/IEC/IEEE 26514:2022, content and correctness
scope.

### WSP-INFO-0016 — Product lifecycle procedures

**Requirement:** The information set shall provide procedures for every
supported user-performed installation, initial configuration, migration,
update, repair, backup, restore, reset, and uninstallation operation, or shall
state that the operation is unsupported.

**Applicability:** Each listed operation exposed to or required of a user.

**Verification:** Compare procedure coverage with product capabilities and
execute each applicable procedure on every materially distinct supported
configuration.

**Standards relationship:** ISO/IEC/IEEE 26514:2022, content and life-cycle
scope.

### WSP-INFO-0017 — Procedure structure

**Requirement:** Each procedure shall state its goal, applicability,
prerequisites, ordered user actions, expected product response after each
observable transition, completion result, and recovery or escalation path for
each documented failure.

**Applicability:** Every procedural topic.

**Verification:** Inspect the procedure fields and execute its normal,
boundary, interruption, failure, and recovery paths.

**Standards relationship:** ISO/IEC/IEEE 26514:2022, structure and content
scope; Clauses 6.3 and 7.

### WSP-INFO-0018 — User-interface reference

**Requirement:** Reference information shall identify every in-scope
user-visible control, field, indicator, mode, setting, value, default, unit,
range, dependency, persistent effect, and unavailable state not fully
self-described by the interface.

**Applicability:** Graphical, web, mobile, terminal, and other interactive
interfaces with reference information in scope.

**Verification:** Compare the reference inventory with the implemented
interface and its controlled design specification.

**Standards relationship:** ISO/IEC/IEEE 26514:2022, reference-information,
content, and correctness scope.

### WSP-INFO-0019 — Command-line reference

**Requirement:** For each supported command, the reference shall state its
syntax, subcommands, options, operands, defaults, accepted values and ranges,
environment or configuration inputs, precedence, outputs, exit statuses, side
effects, error conditions, and at least one valid example.

**Applicability:** Command-line, shell, console, and terminal-command
interfaces.

**Verification:** Generate or inspect a command inventory, compare every
documented element with the implemented parser and help output, and execute
every example and exit-status class.

**Standards relationship:** ISO/IEC/IEEE 26514:2022, command reference,
content, and correctness scope.

### WSP-INFO-0020 — Outputs, status, and error information

**Requirement:** The information shall define every user-actionable output,
status, warning, error identifier, and exit-status class, including its
meaning, triggering condition, effect on user data or task state, and next
action.

**Applicability:** User-visible or machine-consumed results needed to operate,
automate, diagnose, or recover the product.

**Verification:** Compare the information with the controlled message and
status inventory and induce each class in test.

**Standards relationship:** ISO/IEC/IEEE 26514:2022, content and correctness
scope.

### WSP-INFO-0021 — Troubleshooting and recovery

**Requirement:** For each supported diagnosable failure, troubleshooting
information shall identify the observable symptom or identifier, known causes,
diagnostic steps, corrective action, data-preservation precautions, recovery
result, and escalation condition.

**Applicability:** Failures selected by risk analysis, support frequency, or
principal-task impact.

**Verification:** Induce or simulate each selected failure and execute the
documented diagnosis, correction, recovery, and escalation path.

**Standards relationship:** ISO/IEC/IEEE 26514:2022, information-use and
quality scope.

### WSP-INFO-0022 — Safety, security, privacy, and data effects

**Requirement:** Before an action that can cause injury, data loss, disclosure,
unauthorized access, service disruption, irreversible change, or another
approved material consequence, the information shall identify the condition,
consequence, avoidance or protection action, and recovery or emergency action.

**Applicability:** Every action with an identified safety, security, privacy,
availability, financial, or data-integrity consequence.

**Verification:** Trace risk controls to information topics and inspect the
placement and content before executing the protected action in a safe test
environment.

**Standards relationship:** ISO/IEC/IEEE 26514:2022, safe-use and content
scope.

### WSP-INFO-0023 — Validated examples

**Requirement:** Each example shall identify its prerequisites and input,
distinguish user-entered content from product output, state the expected
result, avoid live secrets and unintended destructive effects, and pass against
every product version and configuration to which it claims applicability.

**Applicability:** Every code, command, configuration, workflow, data, or API
example.

**Verification:** Execute examples in controlled configurations and compare
actual with expected results; inspect secret and destructive-operation
controls.

**Standards relationship:** ISO/IEC/IEEE 26514:2022, development and
correctness scope.

### WSP-INFO-0024 — Support and service-life information

**Requirement:** The information set shall identify supported product
versions, support and vulnerability-reporting channels, diagnostic information
users may be asked to provide, maintenance and update sources, known
limitations, and the end-of-support status or policy.

**Applicability:** Every supported release.

**Verification:** Compare published information with the approved support,
security-response, update, and end-of-support records and exercise every
published channel or link.

**Standards relationship:** ISO/IEC/IEEE 26514:2022, life-cycle and maintenance
scope.

## Information Quality and Presentation

### WSP-INFO-0025 — Accessibility-use information

**Requirement:** The information set shall describe every supported
accessibility feature, setting, shortcut, alternative input or output, known
assistive-technology compatibility constraint, and accessible support channel
needed to operate the product.

**Applicability:** Every product feature or supported configuration within the
UX/UI accessibility scope.

**Verification:** Compare the information with the accessibility support
baseline and execute each instruction with its applicable assistive technology
or representative method.

**Standards relationship:** ISO/IEC/IEEE 26514:2022, accessibility and
information-for-users scope; WSP UX/UI profile.

### WSP-INFO-0026 — API and integration information

**Requirement:** Each user-facing API or integration point shall document its
purpose, version, authentication and authorization, endpoint or callable
element, inputs and constraints, requests and responses, errors, rate or
resource limits, compatibility and deprecation rules, security effects, and a
validated integration example.

**Applicability:** APIs, protocols, extension points, automation contracts, and
other supplier-supported integration interfaces.

**Verification:** Compare coverage with the exported interface or schema and
execute contract, error, compatibility, and example tests.

**Standards relationship:** ISO/IEC/IEEE 26514:2022, API information and
content scope.

### WSP-INFO-0027 — Technical correctness

**Requirement:** Every factual product statement, instruction, interface name,
value, example, screen representation, compatibility claim, and support claim
shall agree with its identified authoritative product source for the stated
baseline.

**Applicability:** Every in-scope topic.

**Verification:** Subject-matter review plus automated or manual comparison
with authoritative sources; record discrepancies as defects.

**Standards relationship:** ISO/IEC/IEEE 26514:2022, Clause 7.2.

### WSP-INFO-0028 — Coverage completeness

**Requirement:** The released information set shall cover every approved
information requirement, principal information-use task, supported user-
operated lifecycle operation, user-facing interface inventory item, and
material risk control, or record an approved item-specific exclusion.

**Applicability:** Every release acceptance baseline.

**Verification:** Run the bidirectional coverage matrix and inspect every
missing, excluded, and orphaned item.

**Standards relationship:** ISO/IEC/IEEE 26514:2022, information quality and
content scope.

### WSP-INFO-0029 — Terminology and product consistency

**Requirement:** User-visible names, commands, concepts, units, symbols,
capitalization, and action verbs shall match the approved product glossary and
implemented interface across every information product for the same audience
and baseline.

**Applicability:** Every in-scope topic and product interface term.

**Verification:** Run terminology checks and compare a complete inventory or
approved risk-based sample across the glossary, product, and information set.

**Standards relationship:** ISO/IEC/IEEE 26514:2022, quality and presentation
scope.

### WSP-INFO-0030 — Necessary and non-duplicative content

**Requirement:** Each topic shall trace to an approved information
requirement, risk control, legal or contractual obligation, support need, or
navigation purpose, and duplicated factual content shall have one controlled
authoritative source or an automated consistency check.

**Applicability:** Every in-scope topic and repeated factual statement.

**Verification:** Inspect topic traceability and duplicate-content controls;
identify orphaned topics and uncontrolled copies.

**Standards relationship:** ISO/IEC/IEEE 26514:2022, information quality and
managed-reuse scope.

### WSP-INFO-0031 — Comprehension and task success

**Requirement:** Representative information users shall meet the approved
findability, comprehension, principal-task completion, time, assistance,
material-error, and satisfaction thresholds in each required supported
information configuration.

**Applicability:** Principal information-use tasks and audiences selected in
the acceptance plan.

**Verification:** Execute the controlled evaluation protocol, calculate every
criterion using its stated sampling and scoring rule, and retain findings and
resulting changes.

**Standards relationship:** ISO/IEC/IEEE 26514:2022, usability and information
quality scope; Clauses 6.5 and 7.

### WSP-INFO-0032 — Accessible information products

**Requirement:** Every information product shall expose equivalent content,
structure, reading order, navigation, controls, status, alternatives for non-
text media, and reflow or adaptation behavior through the applicable
accessibility services and user preferences defined in its acceptance criteria.

**Applicability:** Every electronic, printable, audio, video, or embedded
information product. Exact criteria derive from the project's accessibility
commitments and supported information configurations and, when applicable,
the selected WSP UX/UI profile and EN 301 549 applicability matrix.

**Verification:** Automated inspection plus keyboard, visual adaptation,
document-structure, media-alternative, and representative assistive-technology
tests for every required supported information configuration.

**Standards relationship:** ISO/IEC/IEEE 26514:2022, accessibility and format
scope; WSP UX/UI profile; EN 301 549 V3.2.1.

### WSP-INFO-0033 — Translation and localization controls

**Requirement:** When an information product is localized, the project shall
control source readiness, terminology, locale and language metadata,
translator context, non-text and embedded text, variables, links, product
labels, review, functional validation, and synchronization with the source
baseline.

**Applicability:** Every translated or localized information product.

**Verification:** Inspect localization records and execute linguistic,
functional, layout, link, and product-label validation for every released
locale.

**Standards relationship:** ISO/IEC/IEEE 26514:2022, Clause 6.7.

## Review, Release, and Maintenance

### WSP-INFO-0034 — Drafts and prototypes

**Requirement:** Before final assembly, the project shall evaluate a draft or
prototype of every materially distinct information product and revise it until
all release-blocking content, architecture, access, and usability findings are
resolved or approved as accepted risk.

**Applicability:** New information products and material changes to audience,
tasks, architecture, delivery medium, or principal procedures.

**Verification:** Inspect draft or prototype baselines, evaluation results,
findings, revisions, and approvals.

**Standards relationship:** ISO/IEC/IEEE 26514:2022, Clauses 6.4 and 6.5.

### WSP-INFO-0035 — Technical and editorial review

**Requirement:** Before release, every changed topic shall receive a technical
accuracy review by an assigned subject-matter authority and an editorial
review against the controlled content model, glossary, style, and audience
criteria.

**Applicability:** Every new or changed topic. One reviewer can perform both
reviews only when qualified and project independence rules permit it.

**Verification:** Inspect review coverage, reviewer authority, findings,
resolutions, and approval for the exact topic revision.

**Standards relationship:** ISO/IEC/IEEE 26514:2022, Clauses 6.4 and 6.8;
Clause 7.

### WSP-INFO-0036 — Content validation

**Requirement:** Before release, the project shall validate all internal and
external links, references, navigation entries, identifiers, generated
content, commands, examples, media alternatives, metadata, and package entry
points, and shall fail acceptance for an unresolved release-blocking result.

**Applicability:** Every assembled information product.

**Verification:** Retain the automated and manual validation results for the
exact release candidate and inspect every excluded or unresolved result.

**Standards relationship:** ISO/IEC/IEEE 26514:2022, Clauses 6.8 and 7.

### WSP-INFO-0037 — Final assembly and packaging

**Requirement:** The final information package shall contain exactly the
approved information-product versions, required notices and metadata,
navigation and entry points, assets, locale variants, and machine-readable or
offline forms identified in the release inventory.

**Applicability:** Every information package and product-integrated help set.

**Verification:** Compare the assembled package manifest and extracted
contents with the approved inventory and inspect every entry point.

**Standards relationship:** ISO/IEC/IEEE 26514:2022, Clauses 6.8 and 6.9.

### WSP-INFO-0038 — Availability at point of need

**Requirement:** Each information product shall be available from every
approved product, package, installation, support, and external publication
entry point at the lifecycle stage and under the connectivity conditions stated
in its acceptance criteria.

**Applicability:** Every entry point and offline or restricted-connectivity
condition in the information architecture.

**Verification:** Retrieve the released information through every entry point
under each required connectivity and permission condition.

**Standards relationship:** ISO/IEC/IEEE 26514:2022, availability scope and
Clauses 6.9 and 6.10.

### WSP-INFO-0039 — Product and information release synchronization

**Requirement:** A product release shall not be approved until every required
information product is validated against the exact release candidate, carries
the approved applicability identity, and has no unresolved material
information defect unless the designated authority accepts and communicates
the residual risk.

**Applicability:** Every product release containing an in-scope information
change or requiring an information product.

**Verification:** Inspect release-candidate identity, information validation,
defect status, acceptance decisions, and the final published versions.

**Standards relationship:** ISO/IEC/IEEE 26514:2022, Clause 6.10 and Clause 7.

### WSP-INFO-0040 — Content and configuration management

**Requirement:** Information sources, reusable content, generated outputs,
assets, schemas, tools, dependencies, translations, approvals, and release
packages shall be uniquely versioned or immutably identified so the project can
reproduce and audit each supported information baseline.

**Applicability:** Every controlled information product.

**Verification:** Reproduce a selected released information product from its
recorded baseline and compare its content and identity with the retained or
published artifact.

**Standards relationship:** ISO/IEC/IEEE 26514:2022, Clauses 6.6 and 6.12.

### WSP-INFO-0041 — Change impact and update

**Requirement:** A change to product behavior, supported configurations,
audiences, terminology, risks, information architecture, delivery technology,
localization, or support policy shall identify and update every affected
requirement, topic, cross-reference, example, test, translation, and published
information product before the change is closed.

**Applicability:** Every material product or information change.

**Verification:** Inspect impact-analysis coverage and trace sampled changes
through updated content, validation, translation, and publication records.

**Standards relationship:** ISO/IEC/IEEE 26514:2022, Clauses 6.11 and 6.12.

### WSP-INFO-0042 — Feedback and information defects

**Requirement:** The project shall provide an accessible feedback channel and
shall record each reported information defect with the affected product and
information versions, audience and task impact, severity, owner, status,
resolution, verification, and publication disposition.

**Applicability:** Every supported information product.

**Verification:** Exercise the feedback channel and inspect sampled feedback,
triage, correction, verification, and publication records.

**Standards relationship:** ISO/IEC/IEEE 26514:2022, Clause 6.11 and Clause 7.

### WSP-INFO-0043 — Supported and superseded information

**Requirement:** Published information shall visibly distinguish current,
superseded, and unsupported product baselines, prevent an unqualified obsolete
topic from being presented as current, and retain or redirect historical
information according to the approved support and records policy.

**Applicability:** Information for more than one product version or support
state.

**Verification:** Inspect version selectors, search results, direct links,
archives, redirects, notices, and removal records for current and superseded
baselines.

**Standards relationship:** ISO/IEC/IEEE 26514:2022, Clauses 6.11 and 6.12.

### WSP-INFO-0044 — Information acceptance record

**Requirement:** Before release approval, the project shall record the exact
product and information baselines, applicable WSP-INFO requirements,
acceptance-criterion results, supported configurations and locales, review and
validation evidence, unresolved defects and accepted risks, approving
authority, and publication locations.

**Applicability:** Every released information set.

**Verification:** Inspect the completed acceptance record and trace every
claim to evidence for the exact released artifacts.

**Standards relationship:** ISO/IEC/IEEE 26514:2022, Clauses 5 through 7.
