# CppTemplate

一个最小化的 VSCode + CMake + C++20 项目模板。

## 项目结构

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

所有源码文件都放在 `src/` 目录下。本模板的头文件放在 `src/include/` 目录下。`src/lib/` 是预留目录，目前只包含 `.gitkeep`，用于让 Git 能够追踪这个空目录。

## 环境要求

- CMake 3.20+
- 支持 C++20 的编译器
- Ninja，推荐安装，但不是绝对必须
- VSCode，可选
- CMake Tools 扩展，可选但推荐

`CMakePresets.json` 是模板仓库会提交的通用配置；`CMakeUserPresets.json` 用于用户本地的个性化配置，并已被 Git 忽略。

## 命令行构建

Debug 构建：

```bash
cmake --preset debug
cmake --build --preset debug
./build/debug/bin/CppTemplate
```

Release 构建：

```bash
cmake --preset release
cmake --build --preset release
./build/release/bin/CppTemplate
```

构建产物会保留在当前选择的构建目录内：

```text
build/debug/bin/CppTemplate
build/release/bin/CppTemplate
```

如果没有安装 Ninja，可以使用由本地 CMake 环境选择的默认生成器：

```bash
cmake -S . -B build/debug
cmake --build build/debug
./build/debug/bin/CppTemplate
```

## 添加源码文件

- 新的 `.cpp` 文件放到 `src/` 或 `src/` 的子目录下。
- 新的头文件放到 `src/include/` 下。
- 当前模板会通过 `file(GLOB_RECURSE ... CONFIGURE_DEPENDS)` 自动收集 `src/**/*.cpp`，方便新手快速添加源文件。
- 如果项目规模变大，建议改为使用显式的 `target_sources()` 管理源文件，让源码归属和构建行为更清晰。

## 在 VSCode 中使用

1. 用 VSCode 打开当前项目文件夹。
2. 按提示安装推荐扩展。
3. 选择 `debug` 或 `release` CMake preset。
4. 使用 CMake Tools 执行 Configure、Build 和 Run。

仓库中的 `.vscode/settings.json` 会让 CMake Tools 使用 CMake presets，并在打开文件夹时自动配置项目。

## 作为 GitHub Template 使用

如果想让这个仓库作为 GitHub 模板仓库复用：

1. 在 GitHub 上打开该仓库。
2. 进入 Settings。
3. 启用 Template repository。
4. 之后可以通过 Use this template 按钮创建新项目。
