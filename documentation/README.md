# Documentation Build

**Content type:** Requirements, guidance, and build configuration

WSP uses Pandoc and MiKTeX to assemble controlled Markdown documentation into
one consistently formatted release PDF. The output includes:

- a title page with project and version metadata;
- a linked, numbered table of contents;
- numbered chapters and sections;
- clickable internal and external links;
- consistent headings, tables, lists, and code blocks;
- running headers and page numbers; and
- PDF bookmarks and document metadata.

The [documentation requirements](requirements.md) define the release baseline.
Time-sensitive guidance developed between releases is retained as a lettered
annex at the end of the controlled document until it is incorporated into or
superseded by a later WSP release.

## Dependencies

- Pandoc 3 or newer
- MiKTeX with `pdflatex`
- PowerShell 7

The build tool searches `PATH`, common Windows installation locations, and an
optional `-Pandoc` or `-PdfLatex` path. CI should install pinned dependency
versions and record them with the release evidence.

## WSP Build

From the WSP repository root:

```powershell
pwsh -File tools/Build-Documentation.ps1
```

The build reads [documentation-manifest.json](documentation-manifest.json) and
writes `output/pdf/wsp-documentation.pdf` by default.

## Manifest

The JSON manifest controls identity and document order:

```json
{
  "title": "Project Engineering Documentation",
  "subtitle": "Requirements, architecture, verification, and practices",
  "author": "Project publisher",
  "subject": "Project engineering documentation",
  "keywords": ["requirements", "architecture", "testing"],
  "language": "en-US",
  "repositoryUrl": "https://github.com/example/project",
  "outputName": "project-documentation.pdf",
  "files": [
    "README.md",
    "docs/requirements.md",
    "wsp/requirements/requirements-management.md",
    "wsp/testing/test-strategy.md"
  ]
}
```

The repository URL is displayed as a hyperlink on the title page. The build
adds the release date, version, and abbreviated source commit beside it. The
identity fields populate the PDF information dictionary and document language.
Every path is relative to the adopting-project root unless it is absolute. The
array order is the PDF chapter order. Missing, duplicate, or incomplete
manifest data fails the build.

## Adopting Projects

An adopting project should store its manifest in
`documentation/documentation-manifest.json` and invoke the build tool through
the pinned submodule:

```powershell
pwsh -File wsp/tools/Build-Documentation.ps1 `
  -RepositoryRoot . `
  -ManifestPath documentation/documentation-manifest.json
```

The manifest may mix project-owned files with pinned `wsp/` files. This keeps a
release's product documentation and applicable WSP baseline in one PDF without
copying WSP source.

## Styling

The shared `preamble.tex` file is applied by the build tool. Projects may supply
an additional `-HeaderPath` only to add project identity or narrowly scoped
formatting. They should not override the semantic hierarchy, hyperlink
behavior, margins, or status colors without a documented tailoring decision.

Markdown remains authoritative. Generated TeX, logs, rendered pages, and PDFs
are written beneath `tmp/pdfs/` and `output/pdf/` and are not committed by
default.

## Release Use

Release automation should:

1. initialize the pinned WSP submodule;
2. install the pinned Pandoc and MiKTeX toolchain;
3. invoke `Build-Documentation.ps1` with the release version;
4. inspect the PDF metadata, page count, links, and rendered pages;
5. retain the build log and verification results; and
6. publish the PDF with the other release artifacts.

The document version should match the software or WSP release tag. Development
builds may use the source revision returned by Git.

## GitHub Actions

The `Documentation PDF` workflow builds and validates the PDF for pushes to
the primary branch, semantic-version tags, pull requests, and manual
dispatches. Every successful build retains the PDF as a workflow artifact for
14 days.

Trusted non-pull-request builds generate GitHub build-provenance attestation
for the PDF. Pull requests still build and validate the document but do not
receive the OIDC and attestation permissions used for signed provenance.

When a semantic-version tag such as `1.0.0` is pushed, a second job downloads
the exact artifacts produced by the successful build job, creates the
corresponding GitHub release, and uploads `wsp-documentation.pdf` and
`SHA256SUMS`. The publish job uses the tag as the document version and requires
only the workflow-provided `GITHUB_TOKEN` with release-content write
permission. No long-lived publication credential is required.

Verify provenance after downloading a public release with:

```powershell
gh attestation verify wsp-documentation.pdf `
  --repo Thewafflication/wsp
```

Compare the independently calculated SHA-256 digest with `SHA256SUMS` as a
separate exact-file check.

## Selectable PDF Signing

An adopting project may apply a PAdES signature after the PDF is completely
built and verified. It should select at least PAdES-B-T with an RFC 3161 trusted
timestamp, or PAdES-B-LT where long-term validation data must be embedded.

PAdES signing requires a document-signing certificate and protected private
key. A Windows Authenticode certificate is not assumed to authorize document
signing. The certificate policy, extended-key usage, and issuer terms must
explicitly allow the intended use. Signing occurs before calculating the
published digest and generating provenance for the final PDF bytes.
