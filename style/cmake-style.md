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

## Reproducibility

Build behavior should derive from declared cache variables, presets, source
revision, and toolchain inputs. Avoid relying on an undeclared current working
directory, an ambiguous executable from `PATH`, or mutable machine state when a
path or version can be supplied explicitly.
