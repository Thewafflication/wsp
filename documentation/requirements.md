# Release Documentation Requirements

**Content type:** Requirements

## WSP-DOC-0001 — Single Release PDF

Each release shall provide one PDF containing every controlled document listed
in the release documentation manifest.

**Verification:** Manifest-to-PDF content and chapter inspection.

## WSP-DOC-0002 — Controlled Document Order

The release PDF chapter order shall be defined by a version-controlled manifest.
The build shall fail when a listed source is missing or duplicated.

**Verification:** Positive and negative manifest-build tests.

## WSP-DOC-0003 — Reproducible Identity

The release PDF shall identify the project, repository URL, release version,
source revision, build date, Pandoc version, and PDF engine version. The title
page shall display the repository URL as a hyperlink and shall show its version
and abbreviated source commit with the build date.

**Verification:** PDF metadata and generated title-page inspection.

## WSP-DOC-0004 — Navigation

The release PDF shall contain a numbered table of contents, PDF bookmarks,
clickable table-of-contents entries, clickable cross-document links, and
clickable external references.

**Verification:** PDF outline, annotation, and rendered-content inspection.

## WSP-DOC-0005 — Consistent Presentation

All included documents shall use the shared WSP page geometry, typography,
heading hierarchy, table style, code style, headers, footers, and hyperlink
colors.

**Verification:** Rendered-page inspection across every document type.

## WSP-DOC-0006 — Source Authority

Controlled Markdown and the documentation manifest shall remain authoritative.
Generated TeX and PDF files shall not be edited to change controlled content.

**Verification:** Build and configuration-management inspection.

## WSP-DOC-0007 — Build Isolation

Intermediate files shall be written beneath `tmp/pdfs/` and final PDFs beneath
`output/pdf/`, or equivalent explicit project-owned locations. An adopting
project shall not write generated files beneath its `wsp/` submodule.

**Verification:** Filesystem inspection after a documentation build.

## WSP-DOC-0008 — Build Failure

The documentation build shall return a nonzero exit code for a missing input,
invalid manifest, Pandoc error, LaTeX error, missing expected PDF, or empty PDF.

**Verification:** Controlled negative tests.

## WSP-DOC-0009 — Release Verification

Before publication, the final PDF shall be checked for metadata, page count,
extractable text, table-of-contents presence, bookmarks, link annotations, and
visual defects in rendered pages.

**Verification:** Automated PDF inspection and documented visual review.
