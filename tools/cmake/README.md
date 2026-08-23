# WSP CMake Build Baseline

**Content type:** Reusable tool and guidance

`WspBuild.cmake` applies the WSP compiler-warning, native hardening, and
clang-tidy baselines to project-owned C and C++ targets. Include the module
through the pinned WSP submodule and apply it to every first-party compiled
target, including each final executable and shared library:

```cmake
include("${CMAKE_SOURCE_DIR}/wsp/tools/cmake/WspBuild.cmake")

add_executable(example src/main.c)
wsp_apply_build_baseline(example)
```

The module is target-scoped and assumes TinyCC is the default WSP compiler. It
also supports MSVC-compatible compilers, GCC, Clang, AppleClang, and IntelLLVM.
Hardening is fail-closed for unknown compiler/platform combinations. TinyCC
receives the protections it implements directly; its inability to emit stack
canaries is reported and controlled separately rather than hidden behind an
ignored GCC option.

## Options

| Cache variable | Default | Effect |
| --- | --- | --- |
| `WSP_ENABLE_BUILD_WARNINGS` | `ON` | Apply the warning flags in the WSP CMake profile. |
| `WSP_ENABLE_HARDENING` | `ON` | Apply compiler and linker security controls. |
| `WSP_ENABLE_STATIC_ANALYSIS` | `OFF` | Run clang-tidy as part of compilation. |
| `WSP_REQUIRE_STACK_PROTECTION` | `OFF` | Reject compilers, including TinyCC, that cannot emit stack canaries. |
| `WSP_TINYCC_BOUNDS_CHECKING` | `OFF` | Enable TinyCC `-b` checks in Debug builds. |
| `WSP_CLANG_TIDY_EXECUTABLE` | Discovered from `PATH` | Select an exact clang-tidy executable. |
| `WSP_CLANG_TIDY_CONFIG` | WSP configuration | Select a controlled clang-tidy configuration. |

Static analysis is disabled in ordinary local builds so that including the
module does not introduce an undeclared host dependency. A required CI analysis
configuration shall use Ninja or a Makefile generator and enable it explicitly:

```powershell
cmake --preset x64-analysis -DWSP_ENABLE_STATIC_ANALYSIS=ON `
  -DWSP_CLANG_TIDY_EXECUTABLE=C:/LLVM/bin/clang-tidy.exe
cmake --build --preset x64-analysis
```

Configuration fails when analysis is enabled but clang-tidy or its controlled
configuration is missing, or when the selected CMake generator does not execute
the target's clang-tidy property. Findings are treated as errors. Projects may
point `WSP_CLANG_TIDY_CONFIG` to a reviewed project configuration that is a
documented superset or approved tailoring of the WSP configuration.

## TinyCC Default

TinyCC builds use `-Wall -Wunsupported -Werror`, so a GCC-compatible option
that TinyCC ignores becomes a build failure instead of a false hardening claim.
On Windows, final binaries explicitly receive `dynamicbase`, `nxcompat`, and
the 64-bit `high-entropy-va` PE flags. Current TinyCC ELF output supplies PIE,
RELRO, and immediate binding itself; release evidence shall still verify the
resulting binary because those are linker behaviors rather than accepted WSP
command-line switches.

TinyCC does not implement compiler-inserted stack canaries. A project that
requires them shall provide a GCC, Clang, or MSVC hardened-release
configuration and set `WSP_REQUIRE_STACK_PROTECTION=ON` in that preset. TinyCC
`-b` bounds checking is available for Debug security testing, but is not
described as a stack-canary substitute and is opt-in because it changes runtime
behavior and has documented signal-handler and shared-library limitations.

The module applies flags, but the adopting project remains responsible for
recording tool versions and commands, exercising every supported target, and
inspecting release binaries as required by the static-analysis and security
profiles.
