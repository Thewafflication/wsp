# CMake Style

**Content type:** Selectable profile

This profile applies to project-owned `CMakeLists.txt`, CMake modules, toolchain
files, and presets.

## General Style

- Use lowercase CMake command names.
- Use two spaces for indentation.
- Quote paths and values that may contain spaces or list separators.
- Give cache variables uppercase project-prefixed names.
- Give local implementation variables lowercase names, optionally beginning
  with an underscore when confined to one file.
- Break long commands into one logical argument per line.
- Explain non-obvious compatibility constraints and policy choices near the
  code they affect.

## Project Configuration

- Declare the minimum CMake version required by features actually used.
- Declare project languages explicitly.
- Validate cache variables and fail during configuration when a combination is
  unsupported.
- Prefer target properties and target-scoped commands over directory-wide
  compiler and linker settings.
- State required language editions explicitly and disable extensions when the
  project requires portable source.
- Mark custom commands `VERBATIM` unless there is a documented reason not to.

## Presets and Output

Projects with repeated build configurations should provide checked-in CMake
presets. Shared base presets should hold common configuration while named
presets identify architecture and configuration clearly, for example:

```text
x86-debug
x64-release
arm64-release
```

Generated builds and packages should remain outside source directories, under
ignored locations such as `out/build/<preset>` and `out/packages`. User-local
settings belong in `CMakeUserPresets.json`, which should normally be ignored.

## Standard C Build Profiles

Projects that compile C shall provide `Debug` and `Release` profiles. The WSP
baseline is toolchain-specific because TinyCC accepts many GCC options only for
command-line compatibility and may silently ignore them.

| Toolchain | Profile | C flags | Purpose |
| --- | --- | --- | --- |
| TinyCC | Common | `-Wall -Wunsupported -Werror` | Enable TinyCC's useful warnings, report ignored GCC-compatible options, and make warnings build failures. |
| TinyCC | Debug | `-gdwarf` | Emit GDB-compatible DWARF debug information. |
| TinyCC | Release | `-O2 -DNDEBUG` | Select Release preprocessing behavior and disable assertions controlled by `NDEBUG`. |
| GCC or Clang | Common | `-Wall -Wextra -Wpedantic` | Enable the portable warning baseline. |
| GCC or Clang | Debug | `-O0 -g3 -fno-omit-frame-pointer` | Preserve source-level debug information and reliable stack frames. |
| GCC or Clang | Release | `-O2 -DNDEBUG` | Enable production optimization and disable assertions controlled by `NDEBUG`. |

TinyCC does not provide GCC-style optimization levels. Its `-O2` option
defines `__OPTIMIZE__` but does not promise the transformations associated
with GCC or Clang `-O2`. Projects shall not claim an optimized TinyCC binary
solely because that option was present.

TinyCC projects shall not pass `-Wextra`, `-Wpedantic`, or
`-fno-omit-frame-pointer`: the supported TinyCC baseline does not implement
those options. GDB is the WSP default debugger, so TinyCC Debug builds shall use
`-gdwarf` rather than the compiler's default `-g` stab format. Windows projects
may additionally produce Microsoft debugger symbols with `-g.pdb`; a PDB is a
secondary artifact and shall not replace the DWARF symbols required by the
normal Debug profile. Projects using both debugger ecosystems shall build or
validate the required symbol variants explicitly.

Debug and Release settings shall be configuration-specific and target-scoped.
They shall not be supplied by mutating the process-wide `CFLAGS` environment
variable in checked-in automation. In CMake, projects should express the
baseline with `target_compile_options()` and configuration generator
expressions so multi-configuration generators receive the same behavior as
single-configuration generators.

Debug binaries shall contain debugger-usable symbols. A build or packaging
step may separate symbols from the runtime binary, but a successful Debug CI
build shall retain both pieces together as described by
[WSP-TEST-0016](../testing/test-strategy.md#wsp-test-0016--debug-build-evidence).

Release builds shall not inherit Debug optimization or diagnostic defines.
Conversely, a build identified as Debug shall not silently use Release
optimization or strip the only retained debug symbols.

Other compilers shall provide documented semantic equivalents. For example,
MSVC projects normally use `/W4`, `/Od`, and `/Zi` for the common warning and
Debug behavior, and `/O2` plus `NDEBUG` for Release behavior.

## Static Analysis

C and C++ projects shall apply the [static-analysis profile](static-analysis.md)
through a dedicated build preset or equivalent controlled CI configuration.
Static analysis supplements, but does not replace, compilation and testing with
the project's supported compilers. In particular, TinyCC remains the default
WSP compiler even when clang-tidy parses its source and compile arguments.

The analysis configuration shall fail when clang-tidy is missing or reports a
finding. It shall use CMake's Ninja or Makefile generators, which execute the
target clang-tidy property; IDE generators that merely retain the property do
not satisfy the build-time gate. Analysis shall be target-scoped so
project-owned targets can be distinguished from generated and third-party code.
Projects shall not set a directory-wide analyzer property that unintentionally
analyzes vendored dependencies.

## Native Build Hardening

Projects selecting the Security/DFS profile shall apply
[WSP-SEC-0015](../security/security-requirements.md#wsp-sec-0015--native-build-hardening)
and verify the result under WSP-SEC-0016. The standard CMake implementation
uses these controls:

| Compiler and target | Compile controls | Final-link controls |
| --- | --- | --- |
| TinyCC on Windows | Unsupported-option diagnostics; optional Debug `-b` bounds checks | `-Wl,-dynamicbase -Wl,-nxcompat` and `-Wl,-high-entropy-va` on 64-bit targets |
| TinyCC on Linux | Unsupported-option diagnostics; optional Debug `-b` bounds checks | Verify TinyCC's emitted PIE, GNU RELRO, and immediate binding; TinyCC has no WSP switch for stack canaries or executable-stack metadata |
| GCC or Clang on Linux | `-fstack-protector-strong`; `_FORTIFY_SOURCE=2` in optimized profiles; `-fPIE` for executables | `-pie` and `-z relro`, `-z now`, and `-z noexecstack` |
| GCC or Clang on Windows | `-fstack-protector-strong` | PE dynamic-base, NX-compatible, and 64-bit high-entropy-VA flags |
| MSVC-compatible on Windows | `/GS /guard:cf`; `/sdl` for MSVC | `/DYNAMICBASE /NXCOMPAT /guard:cf` and `/HIGHENTROPYVA` on 64-bit targets |

TinyCC does not implement compiler-inserted stack canaries. `-b` performs
different and more intrusive runtime bounds checks and shall not be reported as
a stack-canary equivalent. A project requiring stack protection shall use a
GCC, Clang, or MSVC hardened-release configuration for the applicable release
artifact, while retaining TinyCC as its default compiler, or shall approve and
record a tailoring decision with compensating controls.

Build scripts shall not pass GCC security options to TinyCC and assume they
worked. TinyCC builds shall enable `-Wunsupported` with `-Werror` so ignored
compatibility options fail visibly. Security switches shall be applied to every
first-party compiled target and to each final executable or shared library;
hardening a static library alone cannot set final-image linker properties.

The reusable [`WspBuild.cmake`](../tools/cmake/README.md) module implements this
baseline with target properties. `WSP_ENABLE_HARDENING` is enabled by default,
while a hardened secondary preset can set
`WSP_REQUIRE_STACK_PROTECTION=ON` to reject TinyCC for the final artifact.

## Reproducibility

Build behavior should derive from declared cache variables, presets, source
revision, and toolchain inputs. Avoid relying on an undeclared current working
directory, an ambiguous executable from `PATH`, or mutable machine state when a
path or version can be supplied explicitly.
