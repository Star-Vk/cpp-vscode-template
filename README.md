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
│   ├── settings.json
│   └── tasks.json
├── CMakeLists.txt
├── CMakePresets.json
├── README.md
├── .gitignore
├── scripts
│   ├── run.ps1
│   └── run.sh
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

## 一键构建并运行

本模板提供辅助脚本，可以一条命令完成 configure、build 和 run。

Linux/macOS：

```bash
./scripts/run.sh
./scripts/run.sh debug
./scripts/run.sh release
```

Windows PowerShell：

```powershell
.\scripts\run.ps1
.\scripts\run.ps1 debug
.\scripts\run.ps1 release
```

脚本会自动从 `CMakeLists.txt` 读取 CMake 项目名。所以如果你把项目名从 `CppTemplate` 改成自己的名字，运行脚本仍然应该可以继续找到对应的可执行文件。

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

## VSCode Tasks

本模板包含 `.vscode/tasks.json`，可以在 VSCode 中快速执行一键构建运行脚本。

- 按 `Ctrl + Shift + B` 会默认执行 `Project: Run Debug`，完成 Debug 的 configure、build 和 run。
- 使用 `Ctrl + Shift + P` -> `Tasks: Run Task` -> `Project: Run Release` 可以构建并运行 Release 可执行文件。

如果想绑定自定义快捷键，可以打开 `Preferences: Open Keyboard Shortcuts (JSON)`，添加用户级快捷键配置：

```json
{
  "key": "ctrl+alt+r",
  "command": "workbench.action.tasks.runTask",
  "args": "Project: Run Debug"
}
```

如果你把 CMake 项目名从 `CppTemplate` 改成自己的项目名，脚本会自动读取新项目名；如果你手动修改 `.vscode/tasks.json` 去直接运行可执行文件，也要同步更新里面的可执行文件路径。

例如项目名改成：

```cmake
project(study_demo03
    VERSION 0.1.0
    LANGUAGES CXX
)
```

运行脚本会自动查找 `study_demo03` 对应的可执行文件。

## 作为 GitHub Template 使用

如果想让这个仓库作为 GitHub 模板仓库复用：

1. 在 GitHub 上打开该仓库。
2. 进入 Settings。
3. 启用 Template repository。
4. 之后可以通过 Use this template 按钮创建新项目。
