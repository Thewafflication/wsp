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
| TinyCC | Common | `-Wall -Werror` | Enable TinyCC's useful warnings and make them build failures. |
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

## Reproducibility

Build behavior should derive from declared cache variables, presets, source
revision, and toolchain inputs. Avoid relying on an undeclared current working
directory, an ambiguous executable from `PATH`, or mutable machine state when a
path or version can be supplied explicitly.
