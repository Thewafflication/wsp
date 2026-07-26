# Annex A — GitHub Node 20 Deprecation

**Content type:** Interim implementation guidance

## A.1 Purpose and Status

This annex records time-sensitive guidance developed after WSP 1.0.0 and before
the next WSP release. It supports `WSP-TOOL-0009` without making current action
major versions permanent normative requirements.

GitHub deprecated the Node.js 20 runtime used by JavaScript actions and began
forcing affected actions to run on Node.js 24 in June 2026. A warning that an
action targets Node.js 20 means the workflow still selects an action release
built for the deprecated runtime. The forced runtime is a transition aid, not
evidence that the selected action release is current.

## A.2 WSP Default

New and materially updated GitHub Actions workflows should select the latest
stable compatible major release of each action. As of 2026-07-26, WSP uses:

| Purpose | WSP default |
| --- | --- |
| Repository checkout | `actions/checkout@v6` |
| Workflow artifact upload | `actions/upload-artifact@v7` |
| Workflow artifact download | `actions/download-artifact@v8` |
| Build provenance attestation | `actions/attest@v4` |

These defaults are a dated migration baseline. Maintainers should consult each
action's upstream release notes when creating or materially changing a
workflow, because a newer supported major may exist.

## A.3 Migration Review

When resolving a Node.js runtime deprecation warning, maintainers should:

1. identify every `uses:` reference reported by the workflow;
2. review the upstream action's current major and breaking changes;
3. update paired actions, such as artifact upload and download actions, to
   compatible releases;
4. confirm that self-hosted runners meet the action's minimum runner, operating
   system, and architecture requirements;
5. run the workflow and inspect its artifacts, permissions, and retention
   behavior; and
6. retain or reference the successful run as verification evidence.

Do not set `ACTIONS_ALLOW_USE_UNSECURE_NODE_VERSION` as a permanent solution.
Do not rely on `FORCE_JAVASCRIPT_ACTIONS_TO_NODE24` to make an action release
current; it changes runner behavior but does not update the selected action.

## A.4 Compatibility Exceptions

A project may temporarily retain an older action major when GitHub Enterprise
Server or a self-hosted runner cannot execute the current release. The project
should record:

- the action and selected version;
- the platform or runner constraint;
- the resulting security and support impact;
- the responsible owner; and
- the runner upgrade, platform update, or date that ends the exception.

## A.5 References

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
