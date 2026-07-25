# Waughtal Software Practices

Waughtal Software Practices (**WSP**) contains reusable engineering
requirements, practices, templates, and validation tools for Waughtal projects.
It provides a common foundation for architecture, implementation, verification,
release, and reporting while allowing each project to document justified
deviations and project-specific needs.

The repository is intended to answer two questions:

1. What engineering expectations apply to our projects?
2. What evidence demonstrates that a project met those expectations?

## Scope

Content in this repository may include:

- common software, quality, security, safety, and documentation requirements;
- architecture decision record (ADR) guidance and templates;
- requirements-writing and documentation style guidance;
- test plans, test cases, test procedures, and report templates;
- verification and traceability conventions;
- review, change-control, and release practices; and
- reusable schemas or tools that validate engineering artifacts.

The initial practices are drawn from conventions already used by WPM, WCRT, and
the TinyCC package project. In particular, these projects share Windows x86,
x64, and ARM64 build targets; GitHub-based release automation; semantic version
identification; signed WPM packages; and architecture-specific release
artifacts. WPM and WCRT also share a requirements-to-evidence model based on
stable requirement and test-case identifiers.

Project-specific product behavior, design decisions, source code, test results,
and release evidence belong in the project that owns them. This repository
defines shared expectations and reusable starting points; it does not replace a
project's own requirements or records.

## Content Types

Every document should clearly identify which of the following types it contains:

| Type | Meaning |
| --- | --- |
| **Requirement** | A normative rule that an adopting project must satisfy or formally tailor. |
| **Guidance** | Recommended practices, rationale, and examples that help satisfy requirements. |
| **Template** | A reusable starting point for a project-owned engineering artifact. |
| **Example** | An illustrative artifact that is informative and not binding. |

The key words **shall**, **should**, and **may** have the following meanings:

- **shall** indicates a mandatory requirement;
- **should** indicates a recommendation for which alternatives may be justified;
  and
- **may** indicates permission or an available option.

## Practice Profiles

Not every practice applies to every project. WSP separates broadly applicable
engineering practices from technology and delivery profiles such as:

- Windows software projects;
- C and C-compatible projects;
- PowerShell automation;
- CMake-based builds; and
- WPM packages and signed releases.

An adopting project should select only the profiles that match its product,
toolchain, and delivery model. Profile-specific requirements supplement rather
than replace the common engineering requirements.

## Repository Organization

The initial organization is expected to evolve as content is added:

```text
requirements/    Common, uniquely identified requirements
architecture/    Architecture decision record guidance and templates
testing/         Test strategy, case, procedure, and report guidance
processes/       Review, change-control, and release practices
style/           Requirements, code, and documentation conventions
templates/       Reusable project document templates
schemas/         Machine-readable artifact definitions
tools/           Validation and report-generation utilities
```

Each directory should contain a README that describes its scope and distinguishes
normative content from supporting guidance.

The established sections are:

- [Architecture](architecture/README.md), which defines how projects record
  durable architectural decisions; and
- [Style](style/README.md), which defines shared writing, identifier, source,
  PowerShell, and CMake conventions.

## Requirement Format

Common requirements should be atomic, unambiguous, verifiable, and assigned a
stable `WSP-<AREA>-####` identifier. Project requirements may retain the
established `REQ-####` form. A requirement should include, where applicable:

- a unique identifier and short title;
- one normative statement;
- rationale;
- applicability and tailoring conditions;
- verification method;
- relationships to other requirements or external standards; and
- change history when the reason for a revision is not otherwise clear.

Example:

```markdown
## WSP-ROB-0001 — External input validation

**Requirement:** Software components shall validate externally supplied input
before using it in security-, safety-, or availability-relevant operations.

**Rationale:** Prevents malformed or unexpected data from propagating into
critical behavior.

**Applicability:** Components that receive data across a trust boundary.

**Verification:** Test and code review.
```

Identifiers are permanent. An identifier must not be reused after its requirement
is removed or superseded.

## Adoption and Tailoring

A project adopts this repository by referencing a released version or immutable
commit. For example:

> This project adopts Waughtal Software Practices v1.2.0.

The adopting project should record each applicable common requirement with one
of these dispositions:

- **Applicable** — implemented and verified by the project;
- **Tailored** — modified for the project's context, with rationale;
- **Not applicable** — excluded, with rationale; or
- **Deferred** — planned for a later milestone, with an owner and due condition.

Projects should not silently modify copied requirements. Project-specific
refinements should retain a reference to the originating common requirement.

## Traceability and Evidence

Projects should maintain bidirectional traceability between applicable
requirements and their verification evidence:

```text
Common requirement
        ↓ adopted or tailored by
Project requirement
        ↓ verified by
Test case, analysis, inspection, or review
        ↓ produces
Result and objective evidence
        ↓ summarized by
Verification or test report
```

WPM and WCRT currently implement this with `REQ-####.md` requirement documents,
`TC-####.tex` test specifications, PowerShell test runners, and generated test
reports. WSP preserves that proven convention while permitting a requirement to
map to multiple verification methods or test cases where necessary.

The evidence itself remains in the adopting project or its approved records
system. This repository may provide the format and rules used to produce it.

## Versioning

Released versions of this repository use semantic versioning:

- **Major** versions may change or remove existing obligations.
- **Minor** versions may add requirements or backward-compatible guidance.
- **Patch** versions clarify content without changing its intended obligation.

Projects remain bound to the version they adopted until they intentionally
upgrade. Changes to normative content should be summarized in a changelog so
projects can assess the impact of upgrading.

## Contributing

Changes should be proposed through review and should:

- state the problem being solved;
- identify whether the change is normative or informative;
- preserve stable identifiers and traceability;
- include rationale and verification expectations for new requirements;
- avoid introducing project-specific policy into common content; and
- describe the expected impact on adopting projects.

Detailed contribution and review procedures will be added as the repository
matures.

## Status

This repository is being established. Its structure and conventions may change
before the first tagged release. Content should not be treated as a controlled
baseline until that release is published.
