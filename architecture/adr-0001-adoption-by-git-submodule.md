# ADR-0001: Adopt WSP by Git Submodule

**Status:** Accepted

**Date:** 2026-07-25

## Context

Adopting projects need a reproducible way to consume WSP requirements,
templates, and validation tools. A project must be able to identify its exact
WSP baseline, review upgrades, use shared files during local and CI execution,
and continue building without depending on the current state of another
working directory.

Copying files into each project causes common material to drift. Referring only
to a release tag identifies a baseline but does not place templates or tools in
the project workspace. Downloading WSP during every build adds network and
availability dependencies.

## Decision Drivers

- Pin one immutable WSP revision per adopting-project revision.
- Make WSP upgrades explicit and reviewable.
- Provide templates and validation tools at a predictable local path.
- Support local and CI operation from a normal project checkout.
- Avoid silently copying or modifying controlled WSP content.

## Considered Options

1. Include WSP as a Git submodule.
2. Copy selected WSP files into each project.
3. Download a WSP release during configuration or CI.
4. Refer to WSP documentation without including its files.

## Decision

Adopting projects shall include WSP as a Git submodule at the repository-root
path `wsp/`.

The adopting repository's gitlink is the authoritative WSP revision. Projects
shall normally pin a tagged WSP release and shall record both the release and
full commit identifier in their adoption record.

Projects shall treat submodule content as read-only. Proposed WSP changes shall
be made in the WSP repository, reviewed there, and consumed by updating the
adopting project's gitlink.

CI and documented developer setup shall initialize the `wsp` submodule before
using its templates or tools. Builds shall not silently substitute another WSP
checkout when the pinned submodule is absent.

## Rationale

A submodule stores an exact WSP commit in every adopting-project revision while
making the repository content available locally. A WSP upgrade appears as a
small, explicit gitlink change and can be reviewed together with the updated
adoption record and any required project changes.

This model matches existing use of Git submodules in WPM and the TinyCC package
project and does not require a new package-distribution mechanism.

## Consequences

### Positive

- Every project revision identifies an immutable WSP baseline.
- Local development and CI use the same requirements, templates, and tools.
- Upgrades are deliberate changes with clear version-control history.
- Shared content remains owned and maintained in one repository.

### Negative

- Developers and CI must initialize the submodule after cloning.
- A detached `HEAD` within the submodule is normal but can confuse unfamiliar
  contributors.
- Changes spanning WSP and an adopting project require coordinated reviews.
- Moving or renaming the conventional `wsp/` path becomes a migration.

### Follow-up

- Add a project adoption-record example.
- Provide validation that compares the adoption record with the `wsp` gitlink.
- Document CI initialization in the future testing and process guidance.
- Define how shared WSP tools are invoked without modifying submodule content.

## References

- [WSP adoption and tailoring](../README.md#adoption-and-tailoring)
- [Requirements management](../requirements/requirements-management.md)
- [Adoption record template](../requirements/adoption-record-template.md)
