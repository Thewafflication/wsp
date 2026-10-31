# Common Tool Requirements

**Content type:** Requirements and guidance

## WSP-TOOL-0001 — Pinned Tool Revision

An adopting project shall invoke common tools from its pinned WSP submodule or
from an artifact demonstrably produced from the same WSP revision.

**Verification:** CI configuration and WSP gitlink inspection.

## WSP-TOOL-0002 — Explicit Project Context

A common tool shall accept the project root and other project-owned locations
as parameters. It shall not assume that the WSP repository or caller's current
directory is the adopting-project root.

**Verification:** Tool inspection and invocation from another working directory.

## WSP-TOOL-0003 — Deterministic Result

A common validation tool shall produce the same verdict for the same input
files, parameters, tool versions, and declared environment.

**Verification:** Repeated execution.

## WSP-TOOL-0004 — Failure Contract

A common validation tool shall return exit code zero only when all required
checks pass and a nonzero exit code when a required check cannot be performed
or fails.

Advisory tools shall identify their advisory status in their documentation and
shall distinguish execution failure from a reported advisory condition.

**Verification:** Positive, negative, and missing-dependency tests.

## WSP-TOOL-0005 — Actionable Diagnostics

A common validation tool shall identify the failed rule and affected artifact.
When applicable, it shall report the line number, identifier, configuration, or
command needed to locate the failure.

**Verification:** Negative test and diagnostic inspection.

## WSP-TOOL-0006 — Project Output Isolation

A common tool shall not write generated output into the WSP submodule. It shall
write only to an explicit project-owned output path or emit data to the caller.

**Verification:** Filesystem inspection after execution.

## WSP-TOOL-0007 — Secret Safety

A common tool shall not print, persist, or incorporate a secret into generated
evidence. Parameters that may contain secrets shall be identified and redacted
from commands and diagnostics.

**Verification:** Tool review and controlled secret-value test.

## WSP-TOOL-0008 — Tool Self-Verification

Each common tool shall have automated positive and negative tests before its
behavior is used as a required release gate by an adopting project.

**Verification:** WSP test inventory and CI evidence.

## WSP-TOOL-0009 — GitHub Action Runtime Currency

A project using GitHub Actions shall select maintained action releases whose
declared JavaScript runtime is supported by GitHub Actions. New and updated
workflows should default to the latest stable compatible major release rather
than rely on the runner to force an action from a deprecated runtime onto a
newer runtime.

Before upgrading an action, a project using self-hosted runners shall verify
that its runner version, operating system, and architecture satisfy the
action's requirements. A temporary compatibility exception shall identify the
affected action, reason, owner, and removal condition.

**Verification:** Workflow action-version inspection, action runtime review,
and self-hosted runner compatibility evidence when applicable.

## GitHub Action Maintenance Guidance

GitHub deprecated the Node.js 20 runtime used by JavaScript actions and began
forcing affected actions to run on Node.js 24 in June 2026. A warning that an
action targets Node.js 20 means that the workflow still selects an action
release built for the deprecated runtime. The forced runtime is a transition
aid, not evidence that the selected release is maintained or compatible.

### WSP Migration Baseline

The WSP workflow baseline dated 2026-07-26 uses:

| Purpose | WSP baseline |
| --- | --- |
| Repository checkout | `actions/checkout@v6` |
| Workflow artifact upload | `actions/upload-artifact@v7` |
| Workflow artifact download | `actions/download-artifact@v8` |
| Build provenance attestation | `actions/attest@v4` |

These versions document the integrated migration baseline; they are not
permanent defaults. A project creating or materially changing a workflow
reviews upstream release notes for a newer maintained compatible major.

### Migration Review

When resolving a JavaScript-action runtime deprecation, maintainers:

1. identify every affected `uses:` reference;
2. review the selected action's current maintained major and breaking changes;
3. update paired actions, including artifact upload and download, to compatible
   releases;
4. confirm the minimum runner, operating-system, and architecture requirements
   of self-hosted runners;
5. execute the workflow and inspect its artifacts, permissions, provenance,
   and retention behavior; and
6. retain or reference the successful run as verification evidence.

`ACTIONS_ALLOW_USE_UNSECURE_NODE_VERSION` is not a permanent resolution.
`FORCE_JAVASCRIPT_ACTIONS_TO_NODE24` changes runner behavior but does not update
the selected action release and does not establish runtime currency.

### Compatibility Exceptions

A temporary older-major exception records the action and selected version, the
platform or runner constraint, security and support impact, responsible owner,
and the runner upgrade, platform update, or date that ends the exception.

### References

- [GitHub — Deprecation of Node 20 on GitHub Actions runners][github-node20]
- [GitHub — actions/checkout][checkout]
- [GitHub — actions/upload-artifact][upload]
- [GitHub — actions/download-artifact][download]
- [GitHub — actions/attest][attest]

[github-node20]: https://github.blog/changelog/2025-09-19-deprecation-of-node-20-on-github-actions-runners/
[checkout]: https://github.com/actions/checkout
[upload]: https://github.com/actions/upload-artifact
[download]: https://github.com/actions/download-artifact
[attest]: https://github.com/actions/attest
