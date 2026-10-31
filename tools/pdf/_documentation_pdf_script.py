#!/usr/bin/env python3
"""Verify a WSP release-documentation PDF against its controlled manifest."""

from __future__ import annotations

import argparse
import hashlib
import json
import re
import sys
from pathlib import Path
from typing import Any

import pdfplumber
from pypdf import PdfReader


REQUIRED_MANIFEST_PROPERTIES = (
    "title",
    "author",
    "subject",
    "keywords",
    "language",
    "repositoryUrl",
    "outputName",
    "files",
)
BUILD_INFORMATION_TITLE = "Build Information"
BOUNDARY_TOLERANCE_POINTS = 1.0


class VerificationFailure(RuntimeError):
    """Raised when one or more documentation-PDF checks fail."""

    def __init__(self, errors: list[str], result: dict[str, Any]):
        super().__init__("; ".join(errors))
        self.errors = errors
        self.result = result


def _plain_heading(value: str) -> str:
    value = re.sub(r"!\[([^]]*)\]\([^)]*\)", r"\1", value)
    value = re.sub(r"\[([^]]+)\]\([^)]*\)", r"\1", value)
    value = value.replace("`", "").replace("*", "").replace("_", "")
    return re.sub(r"\s+", " ", value).strip()


def _first_level_one_heading(path: Path) -> str:
    for line in path.read_text(encoding="utf-8-sig").splitlines():
        match = re.match(r"^#\s+(.+?)\s*#*\s*$", line)
        if match:
            return _plain_heading(match.group(1))
    raise ValueError(f"Documentation input has no level-one heading: {path}")


def _load_manifest(repository_root: Path, manifest_path: Path) -> dict[str, Any]:
    try:
        manifest = json.loads(manifest_path.read_text(encoding="utf-8-sig"))
    except (OSError, json.JSONDecodeError) as error:
        raise ValueError(f"Documentation manifest is invalid: {error}") from error

    if not isinstance(manifest, dict):
        raise ValueError("Documentation manifest root must be an object.")
    for property_name in REQUIRED_MANIFEST_PROPERTIES:
        if property_name not in manifest or not manifest[property_name]:
            raise ValueError(
                f"Documentation manifest is missing '{property_name}'."
            )
    if not isinstance(manifest["keywords"], list) or not all(
        isinstance(value, str) and value for value in manifest["keywords"]
    ):
        raise ValueError("Documentation manifest 'keywords' must be strings.")
    if not isinstance(manifest["files"], list) or not all(
        isinstance(value, str) and value for value in manifest["files"]
    ):
        raise ValueError("Documentation manifest 'files' must be paths.")

    normalized_files: set[str] = set()
    headings: list[str] = []
    for entry in manifest["files"]:
        input_path = Path(entry)
        if not input_path.is_absolute():
            input_path = repository_root / input_path
        input_path = input_path.resolve()
        key = str(input_path).casefold()
        if key in normalized_files:
            raise ValueError(f"Documentation input is duplicated: {entry}")
        normalized_files.add(key)
        if not input_path.is_file():
            raise ValueError(f"Documentation input was not found: {entry}")
        headings.append(_first_level_one_heading(input_path))
    manifest["expectedHeadings"] = headings
    return manifest


def _metadata_value(metadata: Any, name: str) -> str:
    value = metadata.get(name) if metadata else None
    return "" if value is None else str(value)


def _strip_section_number(title: str) -> str:
    return re.sub(r"^\s*\d+(?:\.\d+)*\.?\s+", "", title).strip()


def _outline_entries(reader: PdfReader) -> list[Any]:
    entries: list[Any] = []
    for item in reader.outline:
        if not isinstance(item, list) and getattr(item, "title", None):
            entries.append(item)
    return entries


def _count_links(reader: PdfReader) -> tuple[int, int]:
    internal = 0
    external = 0
    for page in reader.pages:
        for annotation_reference in page.get("/Annots", []):
            annotation = annotation_reference.get_object()
            if str(annotation.get("/Subtype")) != "/Link":
                continue
            action = annotation.get("/A")
            if action:
                action = action.get_object()
            action_type = str(action.get("/S")) if action else ""
            if action_type == "/URI":
                external += 1
            elif annotation.get("/Dest") is not None or action_type == "/GoTo":
                internal += 1
    return internal, external


def _boundary_failures(pdf_path: Path) -> tuple[int, list[str]]:
    count = 0
    examples: list[str] = []

    def record(page_number: int, kind: str, label: str, box: tuple[float, ...]):
        nonlocal count
        count += 1
        if len(examples) < 20:
            coordinates = ", ".join(f"{value:.2f}" for value in box)
            examples.append(
                f"page {page_number} {kind} {label!r} outside page: "
                f"({coordinates})"
            )

    with pdfplumber.open(pdf_path) as document:
        for page_number, page in enumerate(document.pages, start=1):
            width = float(page.width)
            height = float(page.height)
            for word in page.extract_words():
                box = (
                    float(word["x0"]),
                    float(word["top"]),
                    float(word["x1"]),
                    float(word["bottom"]),
                )
                if (
                    box[0] < -BOUNDARY_TOLERANCE_POINTS
                    or box[1] < -BOUNDARY_TOLERANCE_POINTS
                    or box[2] > width + BOUNDARY_TOLERANCE_POINTS
                    or box[3] > height + BOUNDARY_TOLERANCE_POINTS
                ):
                    record(page_number, "word", word["text"], box)

            for object_kind in ("lines", "rects", "curves", "images"):
                for item in page.objects.get(object_kind, []):
                    if not all(
                        coordinate in item
                        for coordinate in ("x0", "top", "x1", "bottom")
                    ):
                        continue
                    box = (
                        float(item["x0"]),
                        float(item["top"]),
                        float(item["x1"]),
                        float(item["bottom"]),
                    )
                    if (
                        box[0] < -BOUNDARY_TOLERANCE_POINTS
                        or box[1] < -BOUNDARY_TOLERANCE_POINTS
                        or box[2] > width + BOUNDARY_TOLERANCE_POINTS
                        or box[3] > height + BOUNDARY_TOLERANCE_POINTS
                    ):
                        record(page_number, object_kind[:-1], "", box)
    return count, examples


def verify_documentation_pdf(
    repository_root: Path,
    pdf_path: Path,
    manifest_path: Path,
    expected_version: str,
    expected_source_revision: str,
) -> dict[str, Any]:
    """Return verification measurements or raise VerificationFailure."""

    repository_root = repository_root.resolve()
    pdf_path = pdf_path.resolve()
    manifest_path = manifest_path.resolve()
    result: dict[str, Any] = {
        "status": "fail",
        "pdf": str(pdf_path),
        "manifest": str(manifest_path),
        "expectedVersion": expected_version,
        "expectedSourceRevision": expected_source_revision,
    }
    errors: list[str] = []

    try:
        manifest = _load_manifest(repository_root, manifest_path)
    except ValueError as error:
        raise VerificationFailure([str(error)], result) from error

    if not pdf_path.is_file():
        raise VerificationFailure(
            [f"Documentation PDF was not found: {pdf_path}"], result
        )
    if pdf_path.stat().st_size == 0:
        raise VerificationFailure(
            [f"Documentation PDF is empty: {pdf_path}"], result
        )
    result["fileSizeBytes"] = pdf_path.stat().st_size
    digest = hashlib.sha256()
    with pdf_path.open("rb") as stream:
        for block in iter(lambda: stream.read(1024 * 1024), b""):
            digest.update(block)
    result["sha256"] = digest.hexdigest()

    try:
        reader = PdfReader(str(pdf_path))
    except Exception as error:
        raise VerificationFailure(
            [f"Documentation PDF is unreadable: {error}"], result
        ) from error

    page_count = len(reader.pages)
    result["pageCount"] = page_count
    if page_count < 1:
        errors.append("Documentation PDF contains no pages.")

    metadata = reader.metadata
    expected_metadata = {
        "/Title": str(manifest["title"]),
        "/Author": str(manifest["author"]),
        "/Subject": str(manifest["subject"]),
        "/WSPVersion": expected_version,
        "/WSPSourceRevision": expected_source_revision,
        "/WSPRepositoryURL": str(manifest["repositoryUrl"]),
    }
    for name, expected in expected_metadata.items():
        actual = _metadata_value(metadata, name)
        if actual != expected:
            errors.append(
                f"PDF metadata {name} is {actual!r}; expected {expected!r}."
            )

    keywords = _metadata_value(metadata, "/Keywords").casefold()
    missing_keywords = [
        keyword
        for keyword in manifest["keywords"]
        if str(keyword).casefold() not in keywords
    ]
    if missing_keywords:
        errors.append(
            "PDF metadata is missing keywords: " + ", ".join(missing_keywords)
        )
    for name in ("/CreationDate", "/Creator", "/Producer"):
        if not _metadata_value(metadata, name):
            errors.append(f"PDF metadata {name} is missing.")

    catalog = reader.trailer["/Root"]
    language = str(catalog.get("/Lang", ""))
    if language != str(manifest["language"]):
        errors.append(
            f"PDF catalog language is {language!r}; "
            f"expected {manifest['language']!r}."
        )

    outline_entries = _outline_entries(reader)
    outline_titles = [
        _strip_section_number(str(entry.title)) for entry in outline_entries
    ]
    expected_titles = list(manifest["expectedHeadings"]) + [
        BUILD_INFORMATION_TITLE
    ]
    result["bookmarkCount"] = len(outline_entries)
    result["expectedDocumentCount"] = len(expected_titles)
    if outline_titles != expected_titles:
        mismatch_index = next(
            (
                index
                for index, values in enumerate(
                    zip(outline_titles, expected_titles, strict=False)
                )
                if values[0] != values[1]
            ),
            min(len(outline_titles), len(expected_titles)),
        )
        actual = (
            outline_titles[mismatch_index]
            if mismatch_index < len(outline_titles)
            else "<missing>"
        )
        expected = (
            expected_titles[mismatch_index]
            if mismatch_index < len(expected_titles)
            else "<no additional bookmark>"
        )
        errors.append(
            "PDF bookmark order does not match the manifest at position "
            f"{mismatch_index + 1}: {actual!r}; expected {expected!r}."
        )

    page_text = [page.extract_text() or "" for page in reader.pages]
    full_text = "\n".join(page_text)
    result["extractableCharacterCount"] = len(full_text.strip())
    if not full_text.strip():
        errors.append("PDF has no extractable text.")

    identity_values = (
        str(manifest["title"]),
        str(manifest["repositoryUrl"]),
        expected_version,
        expected_source_revision[:12],
    )
    title_page_text = page_text[0] if page_text else ""
    for identity in identity_values:
        if identity not in title_page_text:
            errors.append(f"PDF title page is missing {identity!r}.")
    if not re.search(r"\b\d{4}-\d{2}-\d{2}\b", title_page_text):
        errors.append("PDF title page is missing an ISO-format build date.")

    for identity in (
        BUILD_INFORMATION_TITLE,
        expected_source_revision,
        "Pandoc",
        "PDF engine",
    ):
        if identity not in full_text:
            errors.append(f"PDF build information is missing {identity!r}.")

    toc_page = next(
        (
            index
            for index, text in enumerate(page_text)
            if re.search(r"(?m)^\s*Contents\s*$", text)
        ),
        None,
    )
    result["tableOfContentsPage"] = (
        toc_page + 1 if toc_page is not None else None
    )
    if toc_page is None:
        errors.append("PDF has no extractable table-of-contents heading.")
    elif outline_entries:
        try:
            first_document_page = reader.get_destination_page_number(
                outline_entries[0]
            )
            if toc_page >= first_document_page:
                errors.append(
                    "PDF table of contents does not precede the first document."
                )
        except Exception as error:
            errors.append(f"First PDF bookmark has no resolvable page: {error}")

    internal_links, external_links = _count_links(reader)
    result["internalLinkCount"] = internal_links
    result["externalLinkCount"] = external_links
    if internal_links < 1:
        errors.append("PDF has no internal link annotations.")
    if external_links < 1:
        errors.append("PDF has no external URI link annotations.")

    try:
        boundary_count, boundary_examples = _boundary_failures(pdf_path)
    except Exception as error:
        errors.append(f"PDF page-boundary inspection failed: {error}")
        boundary_count = -1
        boundary_examples = []
    result["outOfBoundsObjectCount"] = boundary_count
    result["outOfBoundsExamples"] = boundary_examples
    if boundary_count > 0:
        errors.append(
            f"PDF contains {boundary_count} text or graphic objects outside "
            "page boundaries."
        )

    result["errors"] = errors
    if errors:
        raise VerificationFailure(errors, result)
    result["status"] = "pass"
    return result


def _write_result(path: Path | None, result: dict[str, Any]) -> None:
    if path is None:
        return
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(
        json.dumps(result, indent=2, ensure_ascii=False) + "\n",
        encoding="utf-8",
    )


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--repository-root", type=Path, required=True)
    parser.add_argument("--pdf", type=Path, required=True)
    parser.add_argument("--manifest", type=Path, required=True)
    parser.add_argument("--expected-version", required=True)
    parser.add_argument("--expected-source-revision", required=True)
    parser.add_argument("--output", type=Path)
    arguments = parser.parse_args()

    try:
        result = verify_documentation_pdf(
            arguments.repository_root,
            arguments.pdf,
            arguments.manifest,
            arguments.expected_version,
            arguments.expected_source_revision,
        )
    except VerificationFailure as error:
        _write_result(arguments.output, error.result)
        print("Documentation PDF verification failed:", file=sys.stderr)
        for message in error.errors:
            print(f"- {message}", file=sys.stderr)
        for example in error.result.get("outOfBoundsExamples", []):
            print(f"  {example}", file=sys.stderr)
        return 1

    _write_result(arguments.output, result)
    print(
        "Documentation PDF verification passed: "
        f"{result['pageCount']} pages, {result['bookmarkCount']} bookmarks, "
        f"{result['internalLinkCount']} internal links, "
        f"{result['externalLinkCount']} external links, no out-of-bounds objects."
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
