# Windows Version Resources

**Content type:** Selectable profile requirements and guidance

## Purpose and Applicability

This profile applies to project-owned Windows `.exe` and `.dll` files that are
published, installed, packaged, or otherwise delivered to a user or another
product. Build-only probes and third-party binaries are excluded unless the
project explicitly places them in scope.

Windows version information supports file identification, installation,
inventory, diagnostics, support, and release traceability. The compiled binary,
not merely its `.rc` source, is the controlled result.

## Requirements

### WSP-WINRES-0001 — VERSIONINFO Presence

Every in-scope `.exe` and `.dll` shall contain exactly one readable Windows
`VERSIONINFO` resource.

An executable may also contain icons, manifests, dialogs, or other resources;
those resources shall not replace its version information.

**Verification:** Inspect the resource table and query the built binary.

### WSP-WINRES-0002 — Generated Version Source

Numeric and string version values shall be generated from the same controlled
version source used for the release, normally the release tag and source
revision. Projects shall not require manual edits to multiple resource files to
change one release version.

Generated `.rc` files shall be build outputs. A checked-in `.rc` or `.rc.in`
template may define stable identity fields and substitutions.

**Verification:** Build-definition and generated-resource inspection.

### WSP-WINRES-0003 — Numeric Version Format

`FILEVERSION` and `PRODUCTVERSION` shall each contain four integers in the
range 0 through 65535.

The project shall document its mapping from semantic or Git-derived versions
to the four numeric components. The recommended mapping is:

```text
major, minor, patch, build
```

The build component should be zero for a tagged release and may use a bounded
commit count for a development build. Text such as prerelease labels and commit
identifiers shall not be placed in numeric components.

**Verification:** Resource-source and compiled fixed-file-info inspection.

### WSP-WINRES-0004 — Product and File Version Meaning

`ProductVersion` shall identify the product release that distributes the file.
All binaries in one product release shall use the same product version.

`FileVersion` shall identify the binary itself. It should equal the product
version unless the binary has an independently controlled version with a
documented reason.

String versions shall preserve the full release or development identity,
including prerelease or source-revision information needed for traceability.

**Verification:** Cross-artifact version comparison and release inspection.

### WSP-WINRES-0005 — Required String Information

Each language and code-page string table shall provide nonempty values for:

- `CompanyName`;
- `FileDescription`;
- `FileVersion`;
- `InternalName`;
- `LegalCopyright`;
- `OriginalFilename`;
- `ProductName`; and
- `ProductVersion`.

`Comments` should contain the canonical project or product repository URL when
that URL is appropriate for public support and source identification.

Placeholder values shall not appear in a released binary.

**Verification:** Query every required string from each built binary.

### WSP-WINRES-0006 — Binary Identity

`OriginalFilename` shall equal the intended output filename, including `.exe`
or `.dll`, without a path. `InternalName` shall identify the program or module
and should omit the filename extension.

`FileDescription` shall distinguish the binary's function. It shall not use one
generic description for unrelated executables, libraries, tools, or helpers.

**Verification:** Compare resource strings with target and artifact names.

### WSP-WINRES-0007 — File Type and Operating System

An `.exe` shall use `VFT_APP`, and a `.dll` shall use `VFT_DLL`. Both shall use
`VOS_NT_WINDOWS32` unless a documented target requires a different value.

`FILESUBTYPE` shall be `VFT2_UNKNOWN` for an application or DLL. A driver, font,
or other specialized PE file requires its applicable file type and a separate
project profile or tailoring decision.

**Verification:** Inspect compiled fixed-file information by artifact type.

### WSP-WINRES-0008 — File Flags

`FILEFLAGSMASK` shall use `VS_FFI_FILEFLAGSMASK`. `FILEFLAGS` shall accurately
describe the produced binary:

- use `VS_FF_DEBUG` when the binary contains debug features or information;
- use `VS_FF_PRERELEASE` for a non-final product version;
- use `VS_FF_PRIVATEBUILD` only with a matching `PrivateBuild` string; and
- use `VS_FF_SPECIALBUILD` only with a matching `SpecialBuild` string.

A final release shall not retain a debug, prerelease, private-build, or
special-build flag unless the approved release definition requires it.

**Verification:** Compare build configuration, version identity, flags, and
conditional strings.

### WSP-WINRES-0009 — Language and Code Page

Every `StringFileInfo` table shall have a corresponding language and code-page
pair in `VarFileInfo`. String-table identifiers and `Translation` values shall
agree.

Projects using United States English and Unicode should use string table
`040904B0` with translation `0x0409, 1200`. Other localizations shall document
and verify their selected values.

**Verification:** Compare string tables with translation pairs.

### WSP-WINRES-0010 — Architecture Consistency

The x86, x64, ARM64, and other architecture builds of one logical binary shall
use the same product identity, product version, company, legal notice, internal
name, and original filename unless an architecture-specific filename or product
is an approved release decision.

Architecture distinctions should be carried by the package, directory,
artifact name, or machine type rather than by changing the product identity.

**Verification:** Cross-architecture resource and PE-header comparison.

### WSP-WINRES-0011 — Legal and Public Information

Company, copyright, product, repository, and descriptive strings shall be
approved project information. Resource strings shall not expose credentials,
private paths, developer usernames, build-host names, or other unintended build
environment data.

**Verification:** Release-resource and information-disclosure review.

### WSP-WINRES-0012 — Artifact Verification

Release verification shall query version information from every in-scope
compiled `.exe` and `.dll` for every released architecture and configuration.

Verification shall fail for a missing resource, missing required string,
placeholder, type mismatch, filename mismatch, version mismatch, inconsistent
translation, invalid flag combination, or disagreement with the approved
release identity.

The result shall be retained with build or release evidence.

**Verification:** Automated binary inspection and release-report review.

## WPM Baseline

WPM generates a `VERSIONINFO` resource from its Git-derived version and already
implements numeric version mapping, full string versions, `VFT_APP`, Windows
file OS, filename identity, Unicode translation, and a repository URL.

When WPM adopts this profile, it should add or formally disposition the
`CompanyName` and `LegalCopyright` fields, file flags, and compiled-artifact
verification introduced by these requirements.

## Authoritative References

- [Microsoft VERSIONINFO resource][m1]
- [Microsoft version information][m2]
- [Microsoft VS_VERSIONINFO structure][m3]

[m1]: https://learn.microsoft.com/windows/win32/menurc/versioninfo-resource
[m2]: https://learn.microsoft.com/windows/win32/menurc/version-information
[m3]: https://learn.microsoft.com/windows/win32/menurc/vs-versioninfo
