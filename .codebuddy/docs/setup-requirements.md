# Setup Requirements / 设置要求

This template requires a few tools to be installed for full functionality. / 此模板需要安装一些工具才能完全运行。
All hooks fail gracefully if tools are missing — nothing will break, but
如果工具缺失，所有钩子会优雅地失败 — 不会破坏任何东西，但
you'll lose validation features. / 您将失去验证功能。

## Required / 必需

| Tool / 工具 | Purpose / 目的 | Install / 安装 |
| ---- | ---- | ---- |
| **Git** | Version control, branch management / 版本控制、分支管理 | [git-scm.com](https://git-scm.com/) |
| **CodeBuddy IDE** | AI agent IDE plugin / AI代理IDE插件 | Install from VS Code marketplace or JetBrains plugin repository / 从 VS Code 市场或 JetBrains 插件库安装 |

## Recommended / 推荐

| Tool / 工具 | Used By / 使用者 | Purpose / 目的 | Install / 安装 |
| ---- | ---- | ---- | ---- |
| **jq** | Hooks (4 of 8) / 钩子（8个中的4个） | JSON parsing in commit/push/asset/agent hooks / 提交/推送/资源/代理钩子中的JSON解析 | See below / 见下方 |
| **Python 3** | Hooks (2 of 8) / 钩子（8个中的2个） | JSON validation for data files / 数据文件的JSON验证 | [python.org](https://www.python.org/) |
| **Bash** | All hooks / 所有钩子 | Shell script execution / Shell脚本执行 | Included with Git for Windows / 随 Windows Git 包含 |

### Installing jq / 安装 jq

**Windows** (any of these / 以下任一方式):
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
  Windows版Git包含 **Git Bash**，提供 `bash` 命令
  used by all hooks in `settings.json`
  `settings.json` 中的所有钩子使用
- Ensure Git Bash is on your PATH (default if installed via the Git installer)
  确保 Git Bash 在 PATH 上（如果通过Git安装程序安装则为默认）
- Hooks use `bash .codebuddy/hooks/[name].sh` — this works on Windows because
  钩子使用 `bash .codebuddy/hooks/[name].sh` — 这在Windows上有效，因为
  CodeBuddy invokes commands through a shell that can find `bash.exe`
  CodeBuddy 通过可以找到 `bash.exe` 的 shell 调用命令

### macOS / Linux
- Bash is available natively / Bash 原生可用
- Install `jq` via your package manager for full hook support / 通过包管理器安装 `jq` 以获得完整的钩子支持

## Verifying Your Setup / 验证您的设置

Run these commands to check prerequisites: / 运行以下命令检查先决条件：

```bash
git --version          # Should show git version / 应显示git版本
bash --version         # Should show bash version / 应显示bash版本
jq --version           # Should show jq version (optional) / 应显示jq版本（可选）
python3 --version      # Should show python version (optional) / 应显示python版本（可选）
```

## What Happens Without Optional Tools / 没有可选工具时会发生什么

| Missing Tool / 缺失工具 | Effect / 效果 |
| ---- | ---- |
| **jq** | Commit validation, push protection, asset validation, and agent audit hooks silently skip their checks. Commits and pushes still work. / 提交验证、推送保护、资源验证和代理审计钩子静默跳过其检查。提交和推送仍然有效。 |
| **Python 3** | JSON data file validation in commit and asset hooks is skipped. Invalid JSON can be committed without warning. / 提交和资源钩子中的JSON数据文件验证被跳过。无效的JSON可以在没有警告的情况下提交。 |
| **Both** | All hooks still execute without error (exit 0) but provide no validation. You're flying without safety nets. / 所有钩子仍然无错误执行（退出0），但不提供验证。您在没有安全网的情况下飞行。 |

## Recommended IDE / 推荐的IDE

CodeBuddy works with any editor, but the template is optimized for: / CodeBuddy 可与任何编辑器配合使用，但此模板针对以下优化：
- **VS Code** with the CodeBuddy extension / 带有 CodeBuddy 扩展
- **Cursor** (CodeBuddy compatible / CodeBuddy 兼容)
- Terminal-based CodeBuddy CLI / 基于终端的 CodeBuddy CLI
