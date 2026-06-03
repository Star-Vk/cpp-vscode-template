# CppTemplate

一个干净、通用、可扩展的 C++20 CMake 项目模板，适合 VSCode、CMake Tools 和命令行使用。

## 项目结构

```text
.
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

所有源码都放在 `src/` 目录下，头文件放在 `src/include/` 目录下。`src/lib/` 是预留目录，当前仅保留 `.gitkeep` 方便 Git 追踪空目录。

## 配置和构建

推荐使用 CMake preset：

```bash
cmake --preset debug
cmake --build --preset debug
```

Release 构建：

```bash
cmake --preset release
cmake --build --preset release
```

构建产物会输出到 `build/` 目录内部，不会写到源码目录。Debug 可执行文件位于：

```text
build/debug/bin/CppTemplate
```

Release 可执行文件位于：

```text
build/release/bin/CppTemplate
```

运行示例：

```bash
./build/debug/bin/CppTemplate
```

如果环境没有安装 Ninja，可以使用备用方式：

```bash
cmake -S . -B build/debug
cmake --build build/debug
./build/debug/bin/CppTemplate
```

## 源文件管理

当前模板为了方便新手开发，使用 `GLOB_RECURSE CONFIGURE_DEPENDS` 自动收集 `src/` 下的 `.cpp` 文件。这样以后新增 `.cpp` 文件时，通常不需要手动修改 `CMakeLists.txt`。

高级用户或大型工程可以改成手动 `target_sources()` 管理源文件，以获得更明确的构建配置和更稳定的工程维护方式。
