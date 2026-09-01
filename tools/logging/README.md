# WSP Logging

**Content type:** Reusable tool and guidance

WSP Logging provides consistent diagnostic output for C programs, PowerShell
scripts, and CMake configuration. Each implementation uses the same severity
order and fixed-width tags:

| Level | Tag | Console color | Purpose |
| --- | --- | --- | --- |
| Debug | `[DEBUG]` | Amber | Diagnostic detail |
| Info | `[INFO ]` | Blue | Normal progress |
| Pass | `[PASS ]` | Green | Successful completion |
| Warn | `[WARN ]` | Bright amber | Recoverable concern |
| Error | `[ERROR]` | Red | Failure |

Tags remain present when color is unavailable. Automatic color mode emits ANSI
colors only when the implementation detects a suitable interactive terminal.
Every implementation honors a nonempty [`NO_COLOR`][no-color] environment
variable. File records are always plain UTF-8-compatible text with UTC ISO 8601
timestamps.

Logging calls do not change control flow. In particular, an error record does
not terminate the process or throw an exception. Callers remain responsible
for returning, throwing, or setting an appropriate exit status. CMake provides
`wsp_log_fatal()` as an explicit log-and-stop convenience.

## C

Add the library from a pinned WSP checkout:

```cmake
add_subdirectory(wsp/tools/logging wsp-logging)
target_link_libraries(my_target PRIVATE wsp::logging)
```

Create a logger for each independently configured consumer:

```c
#include "wsp_log.h"

wsp_logger logger;
wsp_log_init(&logger);
wsp_log_set_console_level(&logger, WSP_LOG_INFO);
wsp_log_set_file_level(&logger, WSP_LOG_DEBUG);
if (wsp_log_open_file(&logger, "output/build.log", 1) != 0) {
    /* Report or handle the file error according to the application. */
}
wsp_log_write(&logger, WSP_LOG_PASS, "All %d tests passed", count);
wsp_log_close(&logger);
```

The C implementation is C99, process-local, and not thread-safe. The caller
must create the parent directory before opening a file sink. Append mode is
recommended for an existing build log; truncate mode begins a new log.

Consumers that cannot safely share a CRT `FILE *` with WSP may install a byte
sink instead:

```c
int write_record(void *context, const char *bytes, size_t length);
void close_sink(void *context);

wsp_log_set_sink(&logger, write_record, close_sink, context);
wsp_log_write(&logger, WSP_LOG_INFO, "Native sink active");
if (wsp_log_sink_status(&logger) != 0) {
    /* Surface the consumer-defined write failure. */
}
```

The write callback receives one complete timestamped, uncolored record and
shall synchronously consume or copy all bytes before returning. Message encoding
is the encoding supplied by the caller; WSP adds only ASCII record framing. Zero
reports success; a nonzero consumer-defined status is retained by the logger.
Replacing or closing the sink invokes its optional close callback exactly once.
The consumer owns the context and all native handles or runtime objects behind
it; WSP never casts, closes, frees, or otherwise interprets them.

Targets without `<unistd.h>` or Microsoft `_isatty` support may configure with
`-DWSP_LOG_NO_TTY=ON`, or define `WSP_LOG_NO_TTY` when compiling `wsp_log.c`
directly. Automatic color detection then conservatively disables color;
explicit `WSP_LOG_COLOR_ALWAYS` mode remains available.

The C logger uses `va_copy` when the standard library provides it, falls back
to compiler `__va_copy`, and otherwise supports assignment-compatible legacy
`va_list` implementations. A toolchain with a different representation may
define `WSP_VA_COPY(destination, source)` to its supported copy primitive.

## PowerShell

Import the module through the pinned WSP checkout:

```powershell
Import-Module "$PSScriptRoot/wsp/tools/logging/Wsp.Logging.psm1"
Set-WspLogConfiguration -ConsoleLevel Info -FileLevel Debug -Color Auto
Set-WspLogFile -Path 'output/build.log' -Truncate

Write-WspDebug 'Compiler diagnostics enabled'
Write-WspInfo 'Building application'
Write-WspPass 'All tests passed'
Write-WspWarning 'Using fallback configuration'
Write-WspError 'Build failed'

Close-WspLog
```

`Set-WspLogFile` creates missing parent directories. The module opens the file
for each record so independently launched PowerShell processes do not retain a
long-lived handle. Concurrent writers should use separate files unless their
filesystem guarantees suitable append behavior.

## CMake

Include the module before using its functions:

```cmake
include("${CMAKE_SOURCE_DIR}/wsp/tools/logging/WspLogging.cmake")

set(WSP_LOG_FILE "${CMAKE_BINARY_DIR}/configure.log")
set(WSP_LOG_CONSOLE_LEVEL INFO)
set(WSP_LOG_FILE_LEVEL DEBUG)

wsp_log(DEBUG "Compiler: ${CMAKE_C_COMPILER}")
wsp_log(PASS "Configuration complete")
```

The cache variables may also be supplied with `cmake -D`. CMake logging covers
configuration-time events; build-time tools should use the C or PowerShell
implementation. Do not direct concurrent configure and build processes to the
same file.

## Operational Guidance

- Avoid logging secrets, complete environment dumps, and sensitive command
  arguments.
- Use separate console and file thresholds when detailed diagnostics are
  valuable in evidence but noisy on screen.
- Let the calling project or CI system manage rotation and retention.
- Treat failure to initialize the requested file sink as a visible diagnostic;
  do not silently claim that evidence was recorded.

## Adoption Verification

Before using a logging implementation as project or release evidence, execute
the common-tool tests and verify on every supported platform:

- all five severity tags and their ordering;
- colored output to a suitable interactive terminal;
- uncolored output when redirected and when `NO_COLOR` is nonempty;
- plain UTF-8-compatible file records with UTC ISO 8601 timestamps;
- independent console and file thresholds;
- visible handling of a requested file sink that cannot be initialized;
- append, truncate, close, and repeated-write behavior; and
- ABI-safe byte-sink record boundaries, status propagation, replacement, and
  close-callback behavior; and
- caller-controlled return, exception, and exit status after an error record.

The adopting project records log rotation, retention, and sensitive-data rules
outside the adapter and verifies those project controls separately.

[no-color]: https://no-color.org/
