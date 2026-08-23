# User Experience and User Interface

**Content type:** Requirements and standards guidance

This directory defines the selectable WSP UX/UI profile for projects that
design, change, or deliver an interactive system. It applies to graphical,
web, mobile, terminal, command-line, and other software-controlled interfaces
and to information exported from those interfaces.

The profile separates two kinds of obligation:

- [UX/UI requirements](requirements.md) define WSP-owned, verifiable process,
  design, accessibility, presentation, and evaluation requirements.
- [Standards alignment](standards-alignment.md) explains how those requirements
  draw on the selected ISO 9241 editions and EN 301 549 V3.2.1 without
  reproducing controlled ISO text or implying conformity.

## Adoption

A project should select this profile when it owns any user interaction or
software-controlled presentation of information. A library or infrastructure
component with no direct or indirect effect on an interface can record the
profile as not selected. An adopting project dispositions every requirement in
the profile and derives project-specific thresholds, supported platforms,
representative users, assistive technologies, tasks, and test configurations.

For a terminal application, the interface includes prompts, commands,
completion, history, editing, focus or cursor behavior, status and error
output, structured text, and interaction through the host terminal's
accessibility services. Delegating rendering to a terminal does not remove the
application's responsibility for the order, meaning, timing, or operability of
the information and controls it supplies.

## Expected Project Evidence

The profile does not require one document format. Existing project artifacts
can satisfy it when they collectively provide:

- a UX plan, scope, responsible role, and human-centred activities;
- context-of-use findings and traceable user needs and requirements;
- conceptual, interaction, interface, navigation, and information designs;
- formative findings and design iterations;
- an EN 301 549 applicability and results matrix;
- a completed project-owned
  [UX acceptance specification](../templates/ux-acceptance-specification-template.md)
  with exact thresholds and coverage;
- usability and assistive-technology test specifications and results; and
- release evidence showing the disposition of every applicable requirement.

Automated accessibility scans can contribute evidence but do not replace
inspection, representative-user evaluation, keyboard testing, or
assistive-technology interoperability testing.
