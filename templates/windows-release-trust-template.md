# Template — Windows Release Trust Record

**Content type:** Template

**Project:** Project name

**Release:** Version and source revision

**Record status:** Draft / Approved

**Signing operator or service:** Role or controlled service

**Approval:** Change, review, or release approval reference

## Artifact Identity

| File | Architecture | Product version | SHA-256 digest |
| --- | --- | --- | --- |
| `product.exe` | x86 / x64 / ARM64 | `X.Y.Z` | Digest |

Record installers, DLLs, executable tools, and package envelopes separately.

## Authenticode Evidence

| Field | Recorded value |
| --- | --- |
| Publisher subject | Certificate subject |
| Certificate issuer | Issuing certification authority |
| Serial or thumbprint | Certificate identifier |
| File digest | SHA-256 |
| Timestamp authority | RFC 3161 authority |
| Timestamp digest | SHA-256 |
| Signing time | ISO 8601 timestamp |
| Verification command | Exact command or controlled tool reference |
| Verification result | Pass, warning with disposition, or fail |
| Evidence location | Log, CI run, or controlled record |

Repeat or attach machine-readable evidence for every signed artifact.

## Signing and Packaging Sequence

- [ ] Version resources and manifests were finalized before signing.
- [ ] Every distributed PE file was Authenticode-signed and timestamped.
- [ ] Signature verification used the applicable Windows trust policy.
- [ ] Recorded digests identify the exact signed and verified bytes.
- [ ] Defender scanned the exact signed files and distributed packages.
- [ ] Packaging did not modify signed PE files.
- [ ] WPM or other package signatures were applied after PE signing.
- [ ] The final package and its contents were independently verified.

## Microsoft Defender Evidence

| Field | Recorded value |
| --- | --- |
| Artifact and SHA-256 | Exact scanned artifact |
| Scan time | ISO 8601 timestamp |
| Defender platform version | Version |
| Defender engine version | Version |
| Security-intelligence version | Version |
| Detection result | Clean or exact detection name |
| Evidence location | Log, screenshot, CI run, or record |

## Windows Trust Classification

| Observation | Status and evidence |
| --- | --- |
| Defender malware detection | None / finding reference |
| Potentially unwanted application | None / finding reference |
| Authenticode or certificate failure | None / finding reference |
| SmartScreen download reputation | Not evaluated / warning / no warning |

SmartScreen reputation is recorded separately from Defender Antivirus results.

## Suspected False-Positive Record

Complete this section for every disputed detection.

| Field | Recorded value |
| --- | --- |
| Exact artifact and SHA-256 | File and digest |
| Detection name and component | Reported classification and source |
| Reproduction environment | Windows, Defender, and intelligence versions |
| Signature and provenance result | Findings |
| Clean-build and dependency review | Findings and evidence |
| Behavior and compromise review | Findings and evidence |
| Microsoft submission ID | Identifier |
| Submission date | ISO 8601 date |
| Microsoft determination | Determination and date |
| Corrective action | Code, build, intelligence, or documentation action |
| Release decision | Blocked, rebuilt, approved, or withdrawn |
| Decision approval | Role and controlled reference |

## Exceptions and Residual Risk

Record any signing warning, legacy dual-signing exception, temporary internal
exclusion, unavailable reputation check, or unresolved risk. Include its scope,
owner, approval, expiration or completion condition, and compensating control.

## Final Approval

**Prepared by:** Name or role and date

**Security review:** Name or role and date

**Release approval:** Name or role and date
