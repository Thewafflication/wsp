#!/usr/bin/env python3
"""Self-tests for the WSP documentation-PDF verifier."""

from __future__ import annotations

import importlib.util
import json
import tempfile
import unittest
from pathlib import Path

from pypdf import PdfReader, PdfWriter
from pypdf.generic import NameObject, TextStringObject
from reportlab.lib.pagesizes import letter
from reportlab.pdfgen import canvas


VERIFIER_PATH = Path(__file__).parents[1] / "test_documentation_pdf.py"
SPECIFICATION = importlib.util.spec_from_file_location(
    "wsp_pdf_verifier", VERIFIER_PATH
)
if SPECIFICATION is None or SPECIFICATION.loader is None:
    raise RuntimeError(f"Unable to load verifier: {VERIFIER_PATH}")
VERIFIER = importlib.util.module_from_spec(SPECIFICATION)
SPECIFICATION.loader.exec_module(VERIFIER)

TITLE = "Documentation verifier fixture"
AUTHOR = "WSP tests"
SUBJECT = "Positive and negative PDF verification"
REPOSITORY_URL = "https://github.com/example/wsp-tests"
VERSION = "9.8.7"
SOURCE_REVISION = "0123456789abcdef0123456789abcdef01234567"


class DocumentationPdfVerifierTests(unittest.TestCase):
    def setUp(self) -> None:
        self.temporary_directory = tempfile.TemporaryDirectory()
        self.root = Path(self.temporary_directory.name)
        (self.root / "alpha.md").write_text(
            "# Alpha\n\nFixture chapter.\n", encoding="utf-8"
        )
        self.manifest_path = self.root / "manifest.json"
        self.manifest_path.write_text(
            json.dumps(
                {
                    "title": TITLE,
                    "author": AUTHOR,
                    "subject": SUBJECT,
                    "keywords": ["documentation", "verification"],
                    "language": "en-US",
                    "repositoryUrl": REPOSITORY_URL,
                    "outputName": "fixture.pdf",
                    "files": ["alpha.md"],
                }
            ),
            encoding="utf-8",
        )

    def tearDown(self) -> None:
        self.temporary_directory.cleanup()

    def _create_pdf(
        self,
        *,
        out_of_bounds: bool = False,
        metadata_version: str = VERSION,
    ) -> Path:
        reportlab_pdf = self.root / "reportlab.pdf"
        final_pdf = self.root / "fixture.pdf"
        document = canvas.Canvas(str(reportlab_pdf), pagesize=letter)
        document.setTitle(TITLE)
        document.setAuthor(AUTHOR)
        document.setSubject(SUBJECT)
        document.setKeywords("documentation, verification")
        document.setCreator("Pandoc fixture")

        document.drawString(72, 720, TITLE)
        document.drawString(72, 696, REPOSITORY_URL)
        document.drawString(
            72,
            672,
            f"2026-08-23 - Version {VERSION} - Commit "
            f"{SOURCE_REVISION[:12]}",
        )
        document.linkURL(REPOSITORY_URL, (72, 692, 330, 706))
        document.showPage()

        document.bookmarkPage("contents")
        document.drawString(72, 720, "Contents")
        document.drawString(72, 696, "1 Alpha")
        document.linkRect("", "alpha", (72, 692, 130, 706))
        document.showPage()

        document.bookmarkPage("alpha")
        document.drawString(72, 720, "1 Alpha")
        document.drawString(72, 696, "Fixture chapter with extractable text.")
        if out_of_bounds:
            document.drawString(letter[0] + 10, 672, "outside")
        document.showPage()

        document.bookmarkPage("build-information")
        document.drawString(72, 720, "2 Build Information")
        document.drawString(72, 696, f"Source revision {SOURCE_REVISION}")
        document.drawString(72, 672, "Pandoc 3.8 fixture")
        document.drawString(72, 648, "PDF engine pdfTeX fixture")
        document.save()

        reader = PdfReader(str(reportlab_pdf))
        writer = PdfWriter()
        writer.clone_document_from_reader(reader)
        writer.add_metadata(
            {
                "/Title": TITLE,
                "/Author": AUTHOR,
                "/Subject": SUBJECT,
                "/Keywords": "documentation, verification",
                "/Creator": "Pandoc fixture",
                "/Producer": "pdfTeX fixture",
                "/CreationDate": "D:20260823000000-05'00'",
                "/WSPVersion": metadata_version,
                "/WSPSourceRevision": SOURCE_REVISION,
                "/WSPRepositoryURL": REPOSITORY_URL,
            }
        )
        writer.root_object[NameObject("/Lang")] = TextStringObject("en-US")
        writer.add_outline_item("1 Alpha", 2)
        writer.add_outline_item("2 Build Information", 3)
        with final_pdf.open("wb") as stream:
            writer.write(stream)
        return final_pdf

    def _verify(self, pdf_path: Path):
        return VERIFIER.verify_documentation_pdf(
            self.root,
            pdf_path,
            self.manifest_path,
            VERSION,
            SOURCE_REVISION,
        )

    def test_accepts_complete_pdf(self) -> None:
        result = self._verify(self._create_pdf())
        self.assertEqual("pass", result["status"])
        self.assertEqual(0, result["outOfBoundsObjectCount"])
        self.assertGreater(result["internalLinkCount"], 0)
        self.assertGreater(result["externalLinkCount"], 0)

    def test_rejects_out_of_bounds_text(self) -> None:
        with self.assertRaises(VERIFIER.VerificationFailure) as context:
            self._verify(self._create_pdf(out_of_bounds=True))
        self.assertGreater(
            context.exception.result["outOfBoundsObjectCount"], 0
        )

    def test_rejects_identity_metadata_mismatch(self) -> None:
        with self.assertRaises(VERIFIER.VerificationFailure) as context:
            self._verify(self._create_pdf(metadata_version="incorrect"))
        self.assertTrue(
            any("/WSPVersion" in error for error in context.exception.errors)
        )


if __name__ == "__main__":
    unittest.main(verbosity=2)
