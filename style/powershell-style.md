# PowerShell Style

**Content type:** Selectable profile

This profile applies to project-owned PowerShell automation, build utilities,
and test runners.

## Script Structure

- Begin reusable scripts with `[CmdletBinding()]` and a `param` block.
- Set `$ErrorActionPreference = 'Stop'` when partial execution would produce an
  invalid result.
- Put configuration in parameters rather than editing script constants.
- Resolve repository-relative locations from `$PSScriptRoot`.
- Use approved verbs and descriptive `Verb-Noun` names for functions.
- Keep the main execution flow readable; move repeated or detailed behavior
  into narrowly scoped functions or a shared library.

## Paths and Files

- Use `Join-Path`, `Split-Path`, and `[IO.Path]` rather than assembling paths
  with hard-coded separators.
- Prefer `-LiteralPath` when operating on an already resolved path.
- Do not assume that the caller's current directory is the repository root.
- Write generated files only beneath documented output locations.
- Specify text encoding when interoperability or reproducibility depends on it.

## Errors and External Programs

- Use terminating errors for conditions that make the result invalid.
- Include the failed artifact, target, or operation in error messages.
- Check `$LASTEXITCODE` after an external program when PowerShell would
  otherwise continue after failure.
- Preserve the external program's exit code when it is meaningful to callers.
- Clean up temporary or sensitive material in `finally` blocks or equivalent
  unconditional CI steps.

## Output and Testability

- Emit structured objects for data that another script consumes.
- Reserve host-oriented output for concise progress and summaries.
- Avoid success messages before all required validation has completed.
- Make build and test scripts deterministic from their declared inputs.
- A verification script should return zero only when every required check
  passes and nonzero when any required check fails.

Shared script libraries should avoid hidden global state and clearly document
parameters, returned values, side effects, and required external tools.
