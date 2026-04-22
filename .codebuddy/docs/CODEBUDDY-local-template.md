# CODEBUDDY.local.md Template / CODEBUDDY.local.md 模板

Copy this file to the project root as `CODEBUDDY.local.md` for personal overrides.
This file is gitignored and will not be committed.

> **中文翻译**：将此文件复制到项目根目录为 `CODEBUDDY.local.md` 用于个人覆盖。此文件已被 gitignore，不会被提交。

```markdown
# Personal Preferences / 个人偏好

## Model Preferences / 模型偏好
- Prefer GLM-5.1 for complex design tasks / 复杂设计任务优先使用 GLM-5.1
- Use Haiku for quick lookups and simple edits / 快速查找和简单编辑使用 Haiku

## Workflow Preferences / 工作流偏好
- Always run tests after code changes / 代码变更后始终运行测试
- Compact context proactively at 60% usage / 在60%使用率时主动压缩上下文
- Use /clear between unrelated tasks / 不相关任务之间使用 /clear

## Local Environment / 本地环境
- Python command: python (or py / python3) / Python命令：python（或 py / python3）
- Shell: Git Bash on Windows / Shell：Windows上的Git Bash
- IDE: VS Code with Claude Code extension / IDE：VS Code + Claude Code扩展

## Communication Style / 沟通风格
- Keep responses concise / 保持回答简洁
- Show file paths in all code references / 所有代码引用中显示文件路径
- Explain architectural decisions briefly / 简要解释架构决策

## Personal Shortcuts / 个人快捷方式
- When I say "review", run /code-review on the last changed files / 当我说"review"时，对最后修改的文件运行 /code-review
- When I say "status", show git status + sprint progress / 当我说"status"时，显示 git status + 冲刺进度
```

## Setup / 设置

1. Copy this template to your project root: `cp .codebuddy/docs/CODEBUDDY-local-template.md CODEBUDDY.local.md`
2. Edit to match your preferences / 编辑以匹配你的偏好
3. Verify `CODEBUDDY.local.md` is in `.gitignore` (Claude Code reads it from the project root) / 验证 `CODEBUDDY.local.md` 在 `.gitignore` 中（Claude Code 从项目根目录读取它）
