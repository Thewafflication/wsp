# Windows Code Signing and Defender

**Content type:** Requirements and guidance

## Purpose

This selectable profile defines release controls for Windows executables,
dynamic-link libraries, installers, and other Portable Executable (PE) files.
It addresses Authenticode publisher identity, trusted timestamps, Microsoft
Defender scanning, and the disciplined handling of suspected false positives.

These trust mechanisms have distinct purposes:

- Authenticode identifies a Windows publisher and protects PE-file integrity;
- a WPM Ed25519 signature authenticates a WPM package and its contents;
- a SHA-256 digest identifies the exact artifact reviewed or distributed;
- Defender Antivirus detects malware and potentially unwanted applications;
  and
- Microsoft Defender SmartScreen separately considers download reputation.

No one mechanism replaces the others or proves that software is free of
malicious behavior.

## Requirements

## WSP-SIGN-0001 — Release signing plan

**Requirement:** A project that distributes Windows PE files shall maintain a
controlled signing plan that identifies the in-scope artifacts, signing
identity, responsible roles, signing service or equipment, timestamp service,
verification method, and retained evidence.

**Rationale:** Signing is a release control whose ownership and boundaries must
be known before credentials or artifacts are handled.

**Applicability:** Projects selecting this profile.

**Verification:** Review the approved plan against the release workflow.

## WSP-SIGN-0002 — Trust-layer separation

**Requirement:** Release documentation shall distinguish Authenticode
signatures, package signatures, cryptographic digests, malware detections, and
download-reputation warnings, and shall state which controls apply to each
distributed artifact.

**Rationale:** WPM package signing does not create a Windows publisher identity,
and an Authenticode signature does not replace package authentication or
malware analysis.

**Applicability:** Projects selecting this profile.

**Verification:** Inspect the DFS, release plan, and user-facing documentation.

## WSP-SIGN-0003 — Protected signing identity

**Requirement:** A project shall use a consistently named publisher identity
and shall protect the code-signing private key with approved hardware-backed,
managed, or non-exportable storage, least-privilege access, and auditable use.
The private key shall not be stored in source control, build artifacts, or
logs.

**Rationale:** A stolen signing identity can make malicious software appear to
originate from the legitimate publisher.

**Applicability:** Projects selecting this profile.

**Verification:** Review certificate records, access controls, key-storage
configuration, and signing audit evidence.

## WSP-SIGN-0004 — SHA-256 Authenticode signature

**Requirement:** Each in-scope release PE file shall carry a valid
Authenticode signature using SHA-256 as the file-digest algorithm.

**Rationale:** SHA-256 is the current Windows signing baseline and avoids a
sole dependency on deprecated SHA-1 signatures.

**Applicability:** Final project-owned PE files delivered to users.

**Verification:** Verify each signature and digest algorithm with SignTool or
an approved equivalent.

## WSP-SIGN-0005 — Trusted timestamp

**Requirement:** Each Authenticode signature shall include a trusted RFC 3161
timestamp using SHA-256 as the timestamp digest, and verification shall confirm
the timestamp and its trust chain.

**Rationale:** A trusted timestamp permits a valid signature to remain
verifiable after the signing certificate expires.

**Applicability:** Authenticode-signed release artifacts.

**Verification:** Inspect verbose signature-verification output.

## WSP-SIGN-0006 — Legacy signing exception

**Requirement:** SHA-1 shall not be the sole file or timestamp digest. Dual
signing for an approved legacy Windows target shall preserve a primary SHA-256
signature and shall be documented as a compatibility exception.

**Rationale:** Legacy compatibility must not silently weaken the normal release
baseline.

**Applicability:** Projects supporting a Windows platform that cannot validate
the normal SHA-256 signature configuration.

**Verification:** Review the platform rationale and inspect all signatures.

## WSP-SIGN-0007 — Signing order and artifact immutability

**Requirement:** A release workflow shall finalize version resources,
manifests, and PE content before Authenticode signing; verify and scan the exact
signed PE files; package those unchanged files; and then apply any WPM or other
package signature.

**Rationale:** Modifying a PE file after Authenticode signing invalidates its
signature, while signing a package first can authenticate the wrong content.

**Applicability:** Automated and manual Windows release workflows.

**Verification:** Review workflow ordering and compare recorded digests across
signing, scanning, and packaging stages.

## WSP-SIGN-0008 — Signature verification gate

**Requirement:** The release process shall verify every in-scope artifact under
the applicable Windows Authenticode policy and shall fail on an invalid,
missing, untrusted, expired-without-valid-timestamp, or unexpectedly warned
signature unless an approved release disposition documents the warning.

**Rationale:** Signing without independent verification can publish an
unsigned, corrupted, or incorrectly timestamped artifact.

**Applicability:** Every supported architecture and release package.

**Verification:** Inspect verification commands, exit status, and retained
output. SignTool warning exit status shall not be treated as unconditional
success.

## WSP-SIGN-0009 — Exact artifact identity

**Requirement:** Release evidence shall record each artifact's file name,
architecture, product version, source revision, SHA-256 digest, signer subject
or certificate thumbprint, and trusted timestamp.

**Rationale:** False-positive investigation and user support require an exact,
unambiguous artifact identity.

**Applicability:** Every signed release artifact.

**Verification:** Recalculate digests and compare the evidence with the
published files and version resources.

## WSP-SIGN-0010 — Defender release scan

**Requirement:** The release process shall scan the exact final signed PE files
and their distributed packages with a supported Microsoft Defender Antivirus
engine and current security intelligence, and shall record the scan time,
result, artifact digest, engine version, and security-intelligence version.

**Rationale:** Scanning earlier or different bytes does not establish the state
of the released artifact.

**Applicability:** Windows release artifacts.

**Verification:** Inspect scan records and compare their digests with the
release manifest.

## WSP-SIGN-0011 — Detection release gate

**Requirement:** A malware or potentially unwanted application detection on an
in-scope artifact shall block release until the project investigates the exact
artifact and records a resolved detection or an explicitly approved release
decision.

**Rationale:** A presumed false positive may instead reveal a compromised
dependency, build environment, signing identity, or product behavior.

**Applicability:** Any release scan or pre-release reputation check that
reports a detection.

**Verification:** Review the release gate and associated finding disposition.

## WSP-SIGN-0012 — Detection classification

**Requirement:** A project shall classify a Windows trust report as a Defender
malware detection, potentially unwanted application detection, signature or
certificate failure, or SmartScreen download-reputation warning before
selecting a response.

**Rationale:** These reports come from different controls and require different
corrective actions.

**Applicability:** Reported Windows security or trust warnings.

**Verification:** Review the issue record, displayed message, detection name,
and responsible Windows component.

## WSP-SIGN-0013 — False-positive investigation

**Requirement:** Before classifying a detection as a suspected false positive,
the project shall reproduce it against the exact digest; verify the signature,
provenance, clean-build history, dependencies, and release workflow; review the
flagged behavior; and evaluate evidence of key, host, or dependency compromise.

**Rationale:** The term false positive is a conclusion supported by evidence,
not a workaround for a release failure.

**Applicability:** Suspected Defender false positives.

**Verification:** Review the investigation record and evidence references.

## WSP-SIGN-0014 — Microsoft submission and tracking

**Requirement:** A project that disputes a Defender detection shall submit the
exact file or digest through the applicable Microsoft software-developer or
security-intelligence submission channel and shall retain the submission ID,
detection name, submission date, artifact digest, Microsoft determination, and
resulting release decision.

**Rationale:** Microsoft analysis can correct a security-intelligence
classification and provides traceable evidence for the project decision.

**Applicability:** Disputed Microsoft security-product detections.

**Verification:** Inspect the submission confirmation, determination, and issue
closure record.

## WSP-SIGN-0015 — No evasion or routine exclusions

**Requirement:** A project shall not disable endpoint protection, recommend a
broad customer exclusion, or alter software specifically to evade detection.
Any temporary internal exclusion shall be necessary, narrowly scoped,
time-limited, risk-assessed, approved, and removed when the investigation ends.

**Rationale:** Exclusions and evasion create protection gaps and conceal the
underlying cause.

**Applicability:** Detection investigation and user-support guidance.

**Verification:** Review investigation actions, support documentation, and
endpoint-policy changes.

## WSP-SIGN-0016 — Publisher and user guidance

**Requirement:** A project shall keep the Authenticode publisher and Windows
version-resource company identity consistent and shall publish the expected
publisher, artifact digests, signature-verification instructions, secure
download location, and a channel for reporting warnings.

**Rationale:** Stable identity and verifiable release information help users
distinguish legitimate files from impersonation without promising automatic
Defender or SmartScreen trust.

**Applicability:** Public or customer-facing Windows releases.

**Verification:** Compare signed artifacts, version resources, and release
documentation.

## WSP-SIGN-0017 — Certificate lifecycle and compromise

**Requirement:** The signing plan shall define certificate renewal, expiration,
revocation, and suspected-key-compromise response, including an immediate stop
to signing, investigation, notification, credential replacement, and review of
artifacts signed during the affected period.

**Rationale:** Signing credentials require lifecycle and incident controls,
not only release-time handling.

**Applicability:** Projects controlling a Windows code-signing identity.

**Verification:** Review the plan and exercise or incident evidence.

## WSP-SIGN-0018 — Release trust evidence

**Requirement:** A project shall retain signing, timestamp, verification,
digest, Defender-scan, exception, and false-positive evidence with the release
record for the project's defined retention period.

**Rationale:** Release trust decisions must remain reproducible after tools,
certificates, security intelligence, or download reputation change.

**Applicability:** Every Windows release under this profile.

**Verification:** Audit a release against the Windows release-trust record.

## Recommended Signing Sequence

The normal sequence is:

1. build and test the final PE content;
2. embed and verify final version resources and manifests;
3. Authenticode-sign and timestamp each PE file;
4. verify signatures and record exact SHA-256 digests;
5. scan the exact signed artifacts with Defender;
6. package the unchanged signed files;
7. sign the WPM package or other package envelope;
8. verify the package, contents, and retained release evidence; and
9. publish through the approved secure release channel.

## References

- Microsoft, Software developer FAQ:
  <https://learn.microsoft.com/defender-xdr/developer-faq>
- Microsoft, SignTool:
  <https://learn.microsoft.com/windows/win32/seccrypto/signtool>
- Microsoft, Time Stamping Authenticode Signatures.
- Microsoft, Microsoft Defender Antivirus exclusions.
- Microsoft, Submit files in Microsoft Defender for Endpoint.
- CA/Browser Forum, Code Signing Baseline Requirements:
  <https://cabforum.org/working-groups/code-signing/>
