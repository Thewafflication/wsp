# Annex B — Native Standard-Input Testing

**Content type:** Interim testing guidance and adoption feedback

## B.1 Purpose and Status

This annex records a generally reusable lesson reported by WPM after WSP
1.0.0 and before the next WSP release. It supplements `WSP-TEST-0001`,
`WSP-TEST-0003`, `WSP-TEST-0005`, and `WSP-TEST-0015` for native programs
whose behavior depends on standard input, console input, or a C runtime stream.

The originating WPM defect occurred in an interactive `upgrade --all`
confirmation. A rejection-only test piped `n` through a shell and observed the
safe cancellation result. The same result also occurred when the C runtime
input path returned end-of-file without consuming the supplied byte. The test
therefore passed without proving the intended interface behavior. A real
affirmative response exposed the defect.

## B.2 General Lesson

An observed safe default does not prove that a native program consumed its
standard input. Tests shall distinguish the supplied value from end-of-file,
input failure, an unopened or inherited handle, and an implementation that
bypasses the prompt.

For a consequential interactive decision, verification should:

1. exercise at least one accepting and one rejecting value;
2. create the child with a genuine redirected standard-input handle;
3. write the exact bytes, including the intended line ending, and close the
   writer so that end-of-input is deterministic;
4. assert an externally observable effect of each branch, not only prompt text
   or process status;
5. test unattended bypass options separately because they do not exercise the
   input path; and
6. test a real console-input path when redirected and console behavior may
   differ.

Shell object pipelines are not sufficient evidence unless the test also proves
that the native child received and consumed the intended bytes.

## B.3 Native Runtime Regression Matrix

A C runtime or compatibility runtime should test `stdin`, `fgets`, and related
stream operations through the operating-system handle arrangements used by
real child processes. Cover, as applicable:

- accepting and rejecting values;
- CRLF and LF line endings;
- data followed by EOF and EOF before any data;
- partial reads and input longer than the destination buffer;
- redirected pipe input and redirected file input;
- genuine console input;
- `feof`, `ferror`, return value, buffer contents, and consumed-byte behavior;
- x86, x64, and ARM64 runtime builds; and
- repeated reads from the same stream.

An integration test should launch a representative native child using the
platform process API with redirected standard handles. Unit tests that replace
the stream or call an internal parser directly do not cover handle inheritance,
runtime initialization, buffering, or console-versus-pipe behavior.

## B.4 Test Review Questions

Reviewers should ask:

- Could EOF or an input error produce the same result as the supplied value?
- Does the test prove that the child consumed the intended bytes?
- Is each meaningful decision branch verified through an observable effect?
- Does the harness reproduce the handle type used in production?
- Are runtime, architecture, and console-versus-redirection differences in the
  test matrix or explicitly dispositioned?

## B.5 Origin and Feedback Target

This lesson originated in WPM after version 1.0.13. The immediate project
correction used explicitly redirected process streams, tested both `y` and
`n`, and asserted whether the planned upgrade executed. The reusable runtime
feedback is directed to WCRT and other native runtime implementations so the
stream and handle behavior is verified below the application layer.
