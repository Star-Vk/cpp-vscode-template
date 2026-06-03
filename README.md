# CppTemplate

A minimal VSCode + CMake + C++20 project template.

## Project Structure

```text
.
├── .github
│   └── workflows
│       └── cmake.yml
├── .vscode
│   ├── extensions.json
│   └── settings.json
├── CMakeLists.txt
├── CMakePresets.json
├── README.md
├── .gitignore
└── src
    ├── main.cpp
    ├── include
    │   └── main.hpp
    └── lib
        └── .gitkeep
```

All source files live under `src/`. Public project headers for this template live under `src/include/`. The `src/lib/` directory is reserved for future source organization and contains `.gitkeep` so Git can track it while empty.

## Requirements

- CMake 3.20+
- A C++20-capable compiler
- Ninja, recommended but not strictly required
- VSCode, optional
- CMake Tools extension, optional but recommended

CMakePresets.json is tracked by the template, while CMakeUserPresets.json is intended for local user-specific settings and is ignored by Git.

## Command Line Build

Debug build:

```bash
cmake --preset debug
cmake --build --preset debug
./build/debug/bin/CppTemplate
```

Release build:

```bash
cmake --preset release
cmake --build --preset release
./build/release/bin/CppTemplate
```

Build outputs stay inside the selected build directory:

```text
build/debug/bin/CppTemplate
build/release/bin/CppTemplate
```

If Ninja is not installed, use a generator selected by your local CMake environment:

```bash
cmake -S . -B build/debug
cmake --build build/debug
./build/debug/bin/CppTemplate
```

## Adding Source Files

- Put new `.cpp` files in `src/` or a subdirectory of `src/`.
- Put new header files in `src/include/`.
- This template automatically collects `src/**/*.cpp` with `file(GLOB_RECURSE ... CONFIGURE_DEPENDS)` to keep the beginner workflow simple.
- For larger projects, consider replacing the glob with explicit `target_sources()` entries for clearer source ownership and build behavior.

## Using VSCode

1. Open this project folder in VSCode.
2. Install the recommended extensions when prompted.
3. Select the `debug` or `release` CMake preset.
4. Use CMake Tools to Configure, Build, and Run.

The included `.vscode/settings.json` tells CMake Tools to use CMake presets and configure when the folder opens.

## Using As A GitHub Template

To make this repository reusable from GitHub:

1. Open the repository on GitHub.
2. Go to Settings.
3. Enable Template repository.
4. Use the Use this template button to create new projects from this template.
