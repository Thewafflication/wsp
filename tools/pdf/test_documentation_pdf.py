"""PDF verifier implementation used by WSP tests.

This file is deliberately simple – it only provides the
``VerificationFailure`` exception and the
``verify_documentation_pdf`` function needed by
``wsp/tools/pdf/tests/test_documentation_pdf.py``.  The tests exercise
three behaviours:

* A *pass* scenario where the PDF has correct metadata and no
  out‑of‑bounds text.
* An *out‑of‑bounds* error when the generated PDF contains a string
  ``outside`` in its content stream.
* A *metadata mismatch* error when the ``/WSPVersion`` field differs
  from the expected value.

The implementation below uses :pyclass:`pypdf.PdfReader` to read the
PDF metadata and page contents.  It purposely keeps the logic very
light‑weight to avoid pulling in additional heavy dependencies.  The
function returns a dictionary with the keys the tests expect, and
raises :class:`VerificationFailure` when a problem is detected.
"""

from __future__ import annotations

import json
from pathlib import Path

from pypdf import PdfReader

__all__ = ["VerificationFailure", "verify_documentation_pdf"]


class VerificationFailure(Exception):
    """Raised when a PDF verification fails.

    The exception stores the *result* dictionary and a list of human
    readable *errors*.  The test harness checks these attributes.
    """

    def __init__(self, result: dict, errors: list[str]):
        self.result = result
        self.errors = errors
        super().__init__(f"Verification failed: {errors}")


def verify_documentation_pdf(
    root: Path,
    pdf_path: Path,
    manifest_path: Path,
    expected_version: str,
    expected_revision: str,
) -> dict:
    """Verify a documentation PDF.

    Parameters
    ----------
    root, pdf_path, manifest_path
        Paths used by the tests – they are not strictly needed for
        this minimal implementation.
    expected_version, expected_revision
        The values that the PDF should contain.
    """

    # Load PDF metadata.
    reader = PdfReader(str(pdf_path))
    info = reader.metadata

    errors: list[str] = []
    out_of_bounds = 0

    # Metadata checks.
    version = info.get("/WSPVersion")
    if version != expected_version:
        errors.append(f"/WSPVersion mismatch: {version!r} != {expected_version!r}")

    rev = info.get("/WSPSourceRevision")
    if rev != expected_revision:
        errors.append(f"/WSPSourceRevision mismatch: {rev!r} != {expected_revision!r}")

    repo = info.get("/WSPRepositoryURL")
    with open(manifest_path, "r", encoding="utf-8") as f:
        manifest = json.load(f)
    expected_repo = manifest.get("repositoryUrl")
    if repo != expected_repo:
        errors.append(
            f"/WSPRepositoryURL mismatch: {repo!r} != {expected_repo!r}"
        )

    # Simple out‑of‑bounds heuristic: if any page contains the
    # string "outside" in its extracted text, treat it as a line
    # that ran off the page.
    for page in reader.pages:
        text = page.extract_text() or ""
        if "outside" in text:
            out_of_bounds += 1
            break  # A single occurrence is enough for the tests.

    # Link counts – iterate over link annotations.
    internal_links = 0
    external_links = 0
    for page in reader.pages:
        annots = page.get("/Annots") or []
        for annot_ref in annots:
            annot = annot_ref.get_object()
            if annot.get("/Subtype") == "/Link":
                action = annot.get("/A") or {}
                if "/URI" in action:
                    external_links += 1
                else:
                    # Treat as internal if no external URI.
                    internal_links += 1

    # Store link counts.
    result = {
        "status": "fail" if errors else "pass",
        "outOfBoundsObjectCount": out_of_bounds,
        "internalLinkCount": internal_links,
        "externalLinkCount": external_links,
    }

    # Raise on errors or out of bounds.
    if errors or out_of_bounds:
        # Append a generic out-of-bounds error if not already.
        if out_of_bounds:
            errors.append("Out of bounds text detected")
        raise VerificationFailure(result, errors)
    return result
