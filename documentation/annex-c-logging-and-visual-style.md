# Annex C — Logging and Visual Style

**Content type:** Interim tool and style adoption guidance

## C.1 Purpose and Status

This annex records reusable logging tools and visual-style guidance developed
after WSP 1.0.0. It makes the additions visible in the controlled document
while preserving the released 1.0 baseline.

The material is planned for incorporation into the applicable Tools and Style
chapters in WSP 1.1. At that time, this annex should be removed or marked as
superseded. Until then, adopting projects may select either or both additions
and record the selection in their WSP adoption record.

## C.2 Shared Logging Tools

WSP provides compatible logging implementations for C, PowerShell, and CMake.
They use a common severity order and fixed-width text tags:

| Level | Tag | Console color | Purpose |
| --- | --- | --- | --- |
| Debug | `[DEBUG]` | Amber | Diagnostic detail |
| Info | `[INFO ]` | Blue | Normal progress |
| Pass | `[PASS ]` | Green | Successful completion |
| Warn | `[WARN ]` | Bright amber | Recoverable concern |
| Error | `[ERROR]` | Red | Failure |

Console color is optional presentation. Tags remain present when color is
unavailable, automatic mode emits ANSI colors only for a suitable interactive
terminal, and a nonempty `NO_COLOR` environment variable disables color. File
records remain plain text and include UTC ISO 8601 timestamps.

Logging does not change control flow. Callers remain responsible for returning,
throwing, or setting an appropriate exit status after recording an error. An
adopting project should also:

- avoid logging secrets, complete environment dumps, and sensitive arguments;
- select separate console and file thresholds when detailed evidence would be
  too noisy for interactive output;
- treat failure to initialize a requested file sink as a visible diagnostic;
  and
- manage log rotation and retention outside the logging adapter.

The implementation and language-specific usage are maintained in
`tools/logging/README.md`, `tools/logging/wsp_log.h`,
`tools/logging/Wsp.Logging.psm1`, and `tools/logging/WspLogging.cmake`.

## C.3 Visual Color and Typography Guidance

WSP's preferred visual foundation uses semantic tokens rather than repeated
literal values. The baseline uses deep-green backgrounds and surfaces, light
text, green primary and success accents, and amber, violet, pink, blue, and red
secondary or status accents.

Adopting interfaces should preserve the semantic role of each selected color,
must not communicate state through color alone, and should verify text and
interactive-control contrast in the context where the colors are used. Text,
an icon, or another visible cue should accompany status color.

The preferred typography is Space Grotesk or Sora for headings, Inter for body
and interface text, and JetBrains Mono for code and technical data. Projects
should specify system fallbacks and may use the fallbacks exclusively when web
fonts would create an unsuitable external dependency.

The complete palette, semantic CSS custom properties, font stacks, and usage
guidance are maintained in `style/visual-style.md`.

## C.4 Verification and WSP 1.1 Disposition

Before adopting the logging tools, a project should run the common-tool tests
and verify colored interactive output, uncolored redirected output, plain file
records, thresholds, timestamps, and error-path behavior on its supported
platforms.

Before adopting the visual profile, a project should review representative
rendered pages or interfaces at supported sizes and verify contrast, focus and
status cues, font fallback behavior, and readability without color.

For WSP 1.1, maintainers should:

1. place the logging guidance in the main Tools chapter;
2. place the visual palette and typography guidance in the main Style chapter;
3. retain stable links from the corresponding chapter indexes;
4. confirm that requirements and tests cover any behavior made normative; and
5. remove or supersede this interim annex.
