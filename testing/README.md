# Testing

**Content type:** Requirements, guidance, and templates

This directory defines the WSP testing and objective-evidence model. The model
is aligned with ISO/IEC/IEEE 29119 and applies that series through the automated
approach already used by WPM and WCRT:

```text
Requirement
    ↓ traced to
Structured test-case specification
    ↓ implemented by
Automated or controlled manual procedure
    ↓ produces
Execution evidence
    ↓ incorporated into
Generated test report
```

## Contents

- [ISO/IEC/IEEE 29119 alignment](iso-iec-ieee-29119-alignment.md) identifies
  the editions used by WSP and maps them to WSP artifacts and requirements.
- [Test strategy](test-strategy.md) defines requirements for coverage,
  specifications, execution, evidence, reporting, CI, and release gates.
- `test-case-library.tex` provides shared LaTeX definitions aligned with
  ISO/IEC/IEEE 29119-3 and the structure used by WPM and WCRT.
- `test-case-template.tex` is a starting point for a project-owned test
  specification.
- [Test-report template](test-report-template.md) defines the required report
  structure independently of its rendered format.

## Artifact Ownership

WSP owns the common rules and templates. An adopting project owns its test-case
specifications, runners, results, reports, and retained evidence.

The WSP submodule shall be treated as read-only. Projects shall not write test
results or generated reports beneath `wsp/`; outputs belong in an ignored
project directory or a controlled evidence store.

## Standards Position

WSP references ISO/IEC/IEEE 29119 as a framework and source of testing concepts,
processes, documentation, and techniques. Adoption of WSP does not by itself
establish formal conformity to ISO/IEC/IEEE 29119. A project making a conformity
claim shall identify the applicable parts, perform a clause-level assessment,
record tailoring, and retain the required evidence.

## Established Naming

The existing project convention is:

```text
docs/tc-NNNN-short-title.tex
tests/tc-NNNN-short-title.ps1
```

Projects may organize tests by milestone or profile, as WCRT does beneath
`tests/c89/`, provided identifiers and traceability remain unique and
machine-checkable.
