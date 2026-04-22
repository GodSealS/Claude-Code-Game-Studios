# Setup Requirements / 设置要求

This template requires a few tools to be installed for full functionality.
All hooks fail gracefully if tools are missing — nothing will break, but
you'll lose validation features.

> **中文翻译**：此模板需要安装一些工具才能获得完整功能。如果缺少工具，所有钩子会优雅地失败 — 不会出问题，但你会失去验证功能。

## Required / 必需

| Tool | Purpose | Install |
| ---- | ---- | ---- |
| **Git** | Version control, branch management | [git-scm.com](https://git-scm.com/) |
| **CodeBuddy IDE** | AI agent IDE plugin | Install from VS Code marketplace or JetBrains plugin repository |

> **中文翻译**：

| 工具 | 用途 | 安装 |
| ---- | ---- | ---- |
| **Git** | 版本控制、分支管理 | [git-scm.com](https://git-scm.com/) |
| **CodeBuddy IDE** | AI代理IDE插件 | 从VS Code市场或JetBrains插件仓库安装 |

## Recommended / 推荐

| Tool | Used By | Purpose | Install |
| ---- | ---- | ---- | ---- |
| **jq** | Hooks (4 of 8) | JSON parsing in commit/push/asset/agent hooks | See below |
| **Python 3** | Hooks (2 of 8) | JSON validation for data files | [python.org](https://www.python.org/) |
| **Bash** | All hooks | Shell script execution | Included with Git for Windows |

> **中文翻译**：

| 工具 | 使用者 | 用途 | 安装 |
| ---- | ---- | ---- | ---- |
| **jq** | 钩子（8个中的4个） | commit/push/asset/agent钩子中的JSON解析 | 见下方 |
| **Python 3** | 钩子（8个中的2个） | 数据文件的JSON验证 | [python.org](https://www.python.org/) |
| **Bash** | 所有钩子 | Shell脚本执行 | Git for Windows自带 |

### Installing jq / 安装 jq

**Windows** (any of these):
```
winget install jqlang.jq
choco install jq
scoop install jq
```

**macOS**:
```
brew install jq
```

**Linux**:
```
sudo apt install jq     # Debian/Ubuntu
sudo dnf install jq     # Fedora
sudo pacman -S jq       # Arch
```

## Platform Notes / 平台说明

### Windows
- Git for Windows includes **Git Bash**, which provides the `bash` command
  used by all hooks in `settings.json`
  > **中文翻译**：Git for Windows 包含 **Git Bash**，提供 `settings.json` 中所有钩子使用的 `bash` 命令
- Ensure Git Bash is on your PATH (default if installed via the Git installer)
  > **中文翻译**：确保Git Bash在你的PATH中（通过Git安装程序安装时默认配置）
- Hooks use `bash .codebuddy/hooks/[name].sh` — this works on Windows because
  CodeBuddy invokes commands through a shell that can find `bash.exe`
  > **中文翻译**：钩子使用 `bash .codebuddy/hooks/[name].sh` — 这在Windows上可行，因为CodeBuddy通过能找到 `bash.exe` 的shell调用命令

### macOS / Linux
- Bash is available natively
  > **中文翻译**：Bash原生可用
- Install `jq` via your package manager for full hook support
  > **中文翻译**：通过包管理器安装 `jq` 以获得完整钩子支持

## Verifying Your Setup / 验证你的设置

Run these commands to check prerequisites:

> **中文翻译**：运行以下命令检查先决条件：

```bash
git --version          # Should show git version / 应显示git版本
bash --version         # Should show bash version / 应显示bash版本
jq --version           # Should show jq version (optional) / 应显示jq版本（可选）
python3 --version      # Should show python version (optional) / 应显示python版本（可选）
```

## What Happens Without Optional Tools / 没有可选工具会发生什么

| Missing Tool | Effect |
| ---- | ---- |
| **jq** | Commit validation, push protection, asset validation, and agent audit hooks silently skip their checks. Commits and pushes still work. |
| **Python 3** | JSON data file validation in commit and asset hooks is skipped. Invalid JSON can be committed without warning. |
| **Both** | All hooks still execute without error (exit 0) but provide no validation. You're flying without safety nets. |

> **中文翻译**：

| 缺少的工具 | 影响 |
| ---- | ---- |
| **jq** | 提交验证、推送保护、资产验证和代理审计钩子静默跳过检查。提交和推送仍然可用。 |
| **Python 3** | 提交和资产钩子中的JSON数据文件验证被跳过。无效的JSON可以在无警告的情况下被提交。 |
| **两者都缺** | 所有钩子仍会无错误执行（exit 0）但不提供任何验证。你是在没有安全网的情况下运行。 |

## Recommended IDE / 推荐IDE

CodeBuddy works with any editor, but the template is optimized for:
- **VS Code** with the CodeBuddy extension
- **Cursor** (CodeBuddy compatible)
- Terminal-based CodeBuddy CLI

> **中文翻译**：CodeBuddy适用于任何编辑器，但此模板针对以下环境优化：
- **VS Code** + CodeBuddy扩展
- **Cursor**（CodeBuddy兼容）
- 基于终端的CodeBuddy CLI
