# Documentation Style

**Content type:** Guidance

## General Principles

Project documentation should be concise, direct, and maintainable as plain
text. Write for a reader who understands the engineering domain but does not
have access to the original discussion.

- State the purpose and scope near the beginning.
- Prefer active voice and concrete nouns.
- Define uncommon abbreviations on first use.
- Keep normative rules separate from explanation and examples.
- Record rationale where a choice would otherwise appear arbitrary.
- Link to the authoritative artifact instead of copying content that can drift.
- Use examples to clarify a convention, not to introduce an undocumented rule.

## Markdown

- Use ATX headings (`#`, `##`, and so on) in a logical hierarchy.
- Use one level-one heading as the document title.
- Use fenced code blocks with a language identifier when one is available.
- Use tables for compact comparisons and mappings, not long prose.
- Use repository-relative links for files within the same repository.
- Give links descriptive text rather than using a raw path as the label.
- Wrap prose at no more than 80 characters when practical. URLs, tables,
  commands, code, and other content whose meaning depends on one line may
  exceed the limit unless a technology profile states otherwise.
- Use UTF-8 text. Projects should configure consistent line endings through
  `.gitattributes` when contributors use multiple operating systems.

## Terminology

Use the same name for a concept throughout a repository. Maintain a glossary
when domain terms, acronyms, or status values have meanings that are not
obvious. Avoid using requirement words such as *shall* casually in informative
text.

Use these normative terms consistently:

- **shall** — mandatory;
- **should** — recommended, with justified alternatives permitted;
- **may** — permitted or optional; and
- **will** — a statement of expected future fact, not an obligation.

## File Naming

Use lowercase, hyphen-separated Markdown filenames except for conventional
repository files such as `README.md`, `LICENSE`, and `CHANGELOG.md`. A filename
should describe the artifact and remain meaningful when linked from elsewhere.

Generated documentation should be written beneath an ignored output directory.
Commit a generated artifact only when it is itself a controlled deliverable and
the project defines how its source and generated form remain synchronized.
