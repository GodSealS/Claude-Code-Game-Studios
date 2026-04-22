# settings.local.json Template / settings.local.json 模板

Create `.codebuddy/settings.local.json` for personal overrides that should NOT
be committed to version control. Add it to `.gitignore`.

> **中文翻译**：创建 `.codebuddy/settings.local.json` 用于不应提交到版本控制的个人覆盖。将其添加到 `.gitignore`。

## Example settings.local.json / 示例 settings.local.json

```json
{
  "permissions": {
    "allow": [
      "Bash(git *)",
      "Bash(npm *)",
      "Read",
      "Glob",
      "Grep"
    ],
    "deny": [
      "Bash(rm -rf *)",
      "Bash(git push --force *)"
    ]
  }
}
```

## Permission Modes / 权限模式

CodeBuddy supports different permission modes. Recommended for game dev:

> **中文翻译**：CodeBuddy 支持不同的权限模式。游戏开发推荐：

### During Development (Default) / 开发期间（默认）
Use **normal mode** — Claude asks before running most commands. This is safest
for production code.

> **中文翻译**：使用**普通模式** — Claude 在运行大多数命令前会询问。这对生产代码最安全。

### During Prototyping / 原型期间
Use **auto-accept mode** with limited scope — faster iteration on throwaway code.
Only use this when working in `prototypes/` directory.

> **中文翻译**：使用**自动接受模式**并限定范围 — 一次性代码的更快迭代。仅在 `prototypes/` 目录中工作时使用。

### During Code Review / 代码审查期间
Use **read-only** permissions — Claude can read and search but not modify files.

> **中文翻译**：使用**只读**权限 — Claude 可以读取和搜索但不能修改文件。

## Customizing Hooks Locally / 本地自定义钩子

You can add personal hooks in `settings.local.json` that extend (not override)
the project hooks. For example, adding a notification when builds complete:

> **中文翻译**：你可以在 `settings.local.json` 中添加扩展（而非覆盖）项目钩子的个人钩子。例如，添加构建完成时的通知：

```json
{
  "hooks": {
    "Stop": [
      {
        "matcher": "",
        "hooks": [
          {
            "type": "command",
            "command": "bash -c 'echo Session ended at $(date)'",
            "timeout": 5
          }
        ]
      }
    ]
  }
}
```
