# Common Tool Requirements

**Content type:** Requirements

## WSP-TOOL-0001 — Pinned Tool Revision

An adopting project shall invoke common tools from its pinned WSP submodule or
from an artifact demonstrably produced from the same WSP revision.

**Verification:** CI configuration and WSP gitlink inspection.

## WSP-TOOL-0002 — Explicit Project Context

A common tool shall accept the project root and other project-owned locations
as parameters. It shall not assume that the WSP repository or caller's current
directory is the adopting-project root.

**Verification:** Tool inspection and invocation from another working directory.

## WSP-TOOL-0003 — Deterministic Result

A common validation tool shall produce the same verdict for the same input
files, parameters, tool versions, and declared environment.

**Verification:** Repeated execution.

## WSP-TOOL-0004 — Failure Contract

A common validation tool shall return exit code zero only when all required
checks pass and a nonzero exit code when a required check cannot be performed
or fails.

Advisory tools shall identify their advisory status in their documentation and
shall distinguish execution failure from a reported advisory condition.

**Verification:** Positive, negative, and missing-dependency tests.

## WSP-TOOL-0005 — Actionable Diagnostics

A common validation tool shall identify the failed rule and affected artifact.
When applicable, it shall report the line number, identifier, configuration, or
command needed to locate the failure.

**Verification:** Negative test and diagnostic inspection.

## WSP-TOOL-0006 — Project Output Isolation

A common tool shall not write generated output into the WSP submodule. It shall
write only to an explicit project-owned output path or emit data to the caller.

**Verification:** Filesystem inspection after execution.

## WSP-TOOL-0007 — Secret Safety

A common tool shall not print, persist, or incorporate a secret into generated
evidence. Parameters that may contain secrets shall be identified and redacted
from commands and diagnostics.

**Verification:** Tool review and controlled secret-value test.

## WSP-TOOL-0008 — Tool Self-Verification

Each common tool shall have automated positive and negative tests before its
behavior is used as a required release gate by an adopting project.

**Verification:** WSP test inventory and CI evidence.
