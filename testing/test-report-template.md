# Template — Test Report: Project and Baseline

**Content type:** Template

This report structure is aligned with the test-documentation purpose of
ISO/IEC/IEEE 29119-3:2021. Projects claiming conformity require a separate
clause-level assessment; use of this template alone is not sufficient.

**Report status:** Draft or Approved

**Software baseline:** Version and source revision

**Test baseline:** Test-specification revision

**Execution period:** Start and finish timestamps

**Approval:** Controlled review or release reference

## Purpose and Scope

Identify the release, milestone, change, or conformance claim addressed by the
report. State included and excluded test levels and configurations.

## Tested Configuration

| Attribute | Value |
| --- | --- |
| Source revision | Full commit identifier |
| Package or artifact | Immutable name, version, and digest |
| Architecture | x86, x64, ARM64, or other target |
| Build configuration | Debug, Release, or another configuration |
| Operating system | Name, version, and relevant compatibility mode |
| Toolchain | Compiler, linker, test framework, and versions |
| Dependencies | Relevant names and exact versions |

Add rows for every environmental property needed to reproduce or interpret the
results.

## Result Summary

| Status | Count |
| --- | ---: |
| Pass | 0 |
| Fail | 0 |
| Blocked | 0 |
| Inconclusive | 0 |
| Not run | 0 |
| Not applicable | 0 |

**Overall result:** Pass or Fail

The overall result is Pass only when every required result is Pass.

## Requirement Coverage

| Requirement | Verification | Configuration | Status | Evidence |
| --- | --- | --- | --- | --- |
| `REQ-NNNN` | `TC-NNNN` | Target and build | Pass | Evidence link |

Identify requirements without completed verification explicitly; do not omit
them from the table.

## Detailed Results

For each execution, incorporate or link:

- the controlled test-case specification;
- execution metadata;
- actual result and status;
- captured output, logs, measurements, or review records; and
- deviations, failures, and rerun relationships.

Generated reports should obtain this content from controlled specifications and
execution records rather than manually duplicating it.

## Deviations and Unresolved Issues

List blocked, inconclusive, failed, deferred, waived, or not-applicable results
with their rationale, impact, owner, and approval or resolution reference.

## Conclusion

State whether the tested baseline satisfies the report scope and release gate.
Identify residual risk and any claim that the evidence does not support.

## Evidence Inventory

| Evidence ID or path | Test case | Digest | Retention location |
| --- | --- | --- | --- |
| Evidence reference | `TC-NNNN` | SHA-256 or equivalent | Location |
