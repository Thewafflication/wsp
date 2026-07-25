# Architecture

**Content type:** Guidance and templates

This directory defines how projects record architectural decisions. An
architecture decision record (ADR) captures a consequential decision together
with the context, alternatives, rationale, and consequences needed to understand
it later.

ADRs complement requirements and design documentation:

- requirements state what a system shall do or constrain;
- ADRs explain why a durable technical or process choice was made; and
- design documentation describes the resulting system.

## Contents

- [ADR guidance](adr-guidance.md) explains when and how to create, review, and
  supersede a decision record.
- [ADR template](adr-template.md) provides the standard document structure.

## WSP Decisions

- [ADR-0001](adr-0001-adoption-by-git-submodule.md) selects a Git submodule as
  the WSP adoption and distribution mechanism.

## Adoption

Projects should store ADRs in a documented location, normally `docs/`, and use
the filename convention:

```text
adr-NNNN-short-descriptive-title.md
```

Numbers are assigned sequentially and are never reused. Existing projects may
retain their established numbering and location.

An ADR belongs to the project whose architecture it governs. WSP owns the
common method and template, not the project decision itself.
