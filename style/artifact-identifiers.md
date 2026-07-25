# Artifact Identifiers

**Content type:** Guidance

Stable identifiers allow requirements, tests, reports, and decisions to be
linked without depending on titles or file locations.

## Common WSP Requirements

WSP-owned requirements use:

```text
WSP-<AREA>-NNNN
```

`AREA` is a short uppercase category such as `ARCH`, `TEST`, `REL`, or `SEC`.
Numbers contain four digits and are unique within an area.

## Project Requirements and Tests

The established project convention is:

```text
REQ-NNNN
TC-NNNN
```

Corresponding filenames use lowercase identifiers and a descriptive suffix:

```text
req-0001-command-line-invocation.md
tc-0001-usage-version-check.tex
```

Matching numbers are encouraged when a requirement has one principal test, as
in WPM and WCRT. The number does not imply a one-to-one relationship: a
requirement may need several test cases, and one test case may verify several
requirements. Traceability records the actual relationship.

## Architecture Decisions

Architecture decisions use:

```text
ADR-NNNN
adr-NNNN-short-descriptive-title.md
```

## Stability

- Assign identifiers sequentially within their namespace.
- Do not renumber an artifact merely to reorder a document set.
- Do not reuse the identifier of a removed, rejected, or superseded artifact.
- Preserve references to historical identifiers.
- Resolve duplicate identifiers before accepting a change.
- Treat the identifier as metadata; do not encode mutable status or ownership
  in it.

Repositories with an established namespace may retain it, but should document
the format and apply the same stability rules.
