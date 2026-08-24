# UX/UI Standards Alignment

**Content type:** Informative standards guidance and mapping

## Purpose

The WSP UX/UI profile uses complementary standards in a deliberate sequence:

```text
ISO 9241-210:2019
Human-centred development process
        ↓ produces and iterates
ISO 9241-115:2024 + ISO 9241-110:2020
Conceptual, interaction, interface, and navigation design
        ↓ made inclusive and perceivable through
ISO 9241-171:2025 + ISO 9241-112:2025
Software accessibility and presentation of information
        ↓ assessed with concrete ICT behavior from
EN 301 549 V3.2.1 (2021-03)
```

The ISO catalogue describes the scope of each ISO publication, while the full
EN 301 549 V3.2.1 is publicly available from ETSI. The WSP requirements are
original, implementation-oriented requirements. They do not reproduce the ISO
standards.

## Referenced Editions

### ISO 9241-210:2019

- **Published scope:** Human-centred principles and activities across the
  lifecycle of computer-based interactive systems
- **WSP use:** Planning, context of use, user involvement, iteration, and
  evaluation

### ISO 9241-115:2024

- **Published scope:** Conceptual, user-system interaction, user-interface, and
  navigation design
- **WSP use:** Required design outcomes and interaction specifications

### ISO 9241-110:2020

- **Published scope:** Technology-independent interaction principles
- **WSP use:** Task suitability, self-description, expectations, learnability,
  controllability, error robustness, and engagement

### ISO 9241-171:2025

- **Published scope:** Accessible software for a wide range of physical,
  sensory, and cognitive abilities
- **WSP use:** Inclusive user coverage, software behavior, preferences, and
  assistive-technology compatibility

### ISO 9241-112:2025

- **Published scope:** Visual, auditory, and tactile or haptic presentation and
  exported information
- **WSP use:** Detectability, discriminability, conciseness, interpretation,
  freedom from distraction, and consistency

### EN 301 549 V3.2.1 (2021-03)

- **Published scope:** Testable accessibility requirements for ICT products and
  services
- **WSP use:** Clause-level applicability, behavioral acceptance, Annex C
  procedures, documentation, and support

ISO 9241-210:2019 and ISO 9241-110:2020 were reviewed and confirmed in
2025. ISO 9241-115:2024 is the first edition. ISO 9241-112:2025 and
ISO 9241-171:2025 are the second editions and replace their earlier editions.
This profile intentionally pins EN 301 549 V3.2.1; a later draft or published
edition does not change an adopted WSP baseline without controlled review.

## WSP Mapping

### Human-centred planning and scope

- **Requirements:** WSP-UX-0001 through WSP-UX-0003
- **Principal references:** ISO 9241-210 and ISO 9241-171

### User needs, involvement, and iteration

- **Requirements:** WSP-UX-0004 through WSP-UX-0009
- **Principal reference:** ISO 9241-210

### Controlled UI design outcomes

- **Requirements:** WSP-UX-0010 and WSP-UX-0012 through WSP-UX-0014
- **Principal reference:** ISO 9241-115

### Interaction principles and atomic controls

- **Requirements:** WSP-UX-0011, WSP-UX-0015 through WSP-UX-0021, and
  WSP-UX-0041 through WSP-UX-0047
- **Principal reference:** ISO 9241-110

### Presentation of information

- **Requirements:** WSP-UX-0022 through WSP-UX-0027
- **Principal reference:** ISO 9241-112

### Accessibility applicability and baseline

- **Requirements:** WSP-UX-0028 and WSP-UX-0029
- **Principal reference:** EN 301 549

### Keyboard and assistive-technology behavior

- **Requirements:** WSP-UX-0030 through WSP-UX-0035 and WSP-UX-0048 through
  WSP-UX-0055
- **Principal references:** ISO 9241-171 and EN 301 549

### Accessible documentation and support

- **Requirements:** WSP-UX-0036, WSP-UX-0056, and WSP-UX-0057
- **Principal references:** ISO 9241-171 and EN 301 549 Clause 12

### Acceptance and release evidence

- **Requirements:** WSP-UX-0037 through WSP-UX-0040 and WSP-UX-0058
- **Principal references:** ISO 9241-210, ISO 9241-171, and EN 301 549 Annex C

## Applying EN 301 549

EN 301 549 V3.2.1 Clause 4 states functional performance needs, while
Clauses 5 through 13 contain specific criteria for ICT capabilities. Their
applicability depends on what the product provides. For example:

- Clause 5 contains generic and closed-functionality requirements;
- Clauses 6 and 7 apply to two-way communication and video capabilities;
- Clause 8 applies to hardware;
- Clauses 9, 10, and 11 apply respectively to web content, non-web documents,
  and software;
- Clause 12 covers product documentation and support services; and
- Clause 13 applies to relay and emergency-service access.

For non-web software, Clause 11 includes WCAG-derived criteria and additional
software interoperability requirements. Clause 11.5 requires accessibility-
service exposure of object semantics, relationships, text, actions, focus,
selection, and change notifications. Annex C supplies assessment preconditions,
procedures, and pass, fail, or not-applicable results. WSP-UX-0028 preserves
this conditional structure rather than declaring an entire clause inapplicable
based only on product category.

Automated analysis can identify some failures, but the EN procedures also call
for inspection and testing. WSP therefore requires end-to-end keyboard,
platform-mode, and representative assistive-technology execution in addition
to clause-level results.

## Terminal and Command Interfaces

A terminal application remains an interactive system even when a host terminal
renders its text and supplies platform accessibility services. The adopting
project assesses the combined supported configuration and allocates each
requirement to the application, terminal, operating-system service, or their
interaction. Important application-controlled behavior includes:

- logical output and reading order;
- stable text, prompts, labels, commands, status, and error meaning;
- keyboard-only operation and cursor or focus behavior;
- discoverable completion, history, modes, and available actions;
- timely status and nonvisual error output;
- preservation of user data during correction and recovery; and
- avoiding rendering or input techniques that bypass or disrupt the host's
  accessibility services and preferences.

The context of use identifies the host terminals and assistive technologies
that form supported product configurations. Passing with one terminal or one
screen reader is not evidence for an untested configuration.

## Conformity Position

Adopting WSP does not establish conformity with an ISO standard or EN 301 549.
A project making a conformity, contractual, or regulatory claim needs
authorized access to the complete applicable standards, a controlled
clause-level matrix, objective evidence, resolved gaps and tailoring, and the
assessment or approval required by the claim. WSP-UX-0029 is a project
baseline, not certification.

## Official References

- [ISO 9241-210:2019 — Human-centred design for interactive systems][iso-210]
- [ISO 9241-115:2024 — Conceptual, interaction, interface, and navigation
  design][iso-115]
- [ISO 9241-110:2020 — Interaction principles][iso-110]
- [ISO 9241-171:2025 — Software accessibility][iso-171]
- [ISO 9241-112:2025 — Principles for the presentation of information][iso-112]
- [ETSI EN 301 549 V3.2.1 (2021-03) — Accessibility requirements for ICT
  products and services][en-301-549]

[iso-210]: https://www.iso.org/standard/77520.html
[iso-115]: https://www.iso.org/standard/80773.html
[iso-110]: https://www.iso.org/standard/75258.html
[iso-171]: https://www.iso.org/standard/86308.html
[iso-112]: https://www.iso.org/standard/87518.html
[en-301-549]: https://www.etsi.org/deliver/etsi_en/301500_301599/301549/03.02.01_60/en_301549v030201p.pdf
