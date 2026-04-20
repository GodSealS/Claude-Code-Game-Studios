# Active Hooks / 活跃钩子

Hooks are configured in `.codebuddy/settings.json` and fire automatically: / 钩子在 `.codebuddy/settings.json` 中配置并自动触发：

| Hook / 钩子 | Event / 事件 | Trigger / 触发器 | Action / 动作 |
| ---- | ----- | ------- | ------ |
| `validate-commit.sh` | PreToolUse (Bash) | `git commit` commands / 命令 | Validates design doc sections, JSON data files, hardcoded values, TODO format / 验证设计文档章节、JSON数据文件、硬编码值、TODO格式 |
| `validate-push.sh` | PreToolUse (Bash) | `git push` commands / 命令 | Warns on pushes to protected branches (develop/main) / 推送到受保护分支时警告 |
| `validate-assets.sh` | PostToolUse (Write/Edit) | Asset file changes / 资源文件更改 | Checks naming conventions and JSON validity for files in `assets/` / 检查 `assets/` 中文件的命名约定和JSON有效性 |
| `session-start.sh` | SessionStart | Session begins / 会话开始 | Loads sprint context, milestone, git activity; detects and previews active session state file for recovery / 加载冲刺上下文、里程碑、git活动；检测并预览活跃会话状态文件以进行恢复 |
| `detect-gaps.sh` | SessionStart | Session begins / 会话开始 | Detects fresh projects (suggests /start) and missing documentation when code/prototypes exist, suggests /reverse-document or /project-stage-detect / 检测新项目（建议 /start）和代码/原型存在时缺失的文档，建议 /reverse-document 或 /project-stage-detect |
| `pre-compact.sh` | PreCompact | Context compression / 上下文压缩 | Dumps session state (active.md, modified files, WIP design docs) into conversation before compaction so it survives summarization / 在压缩前将会话状态（active.md、修改的文件、进行中的设计文档）转储到对话中，使其在摘要中保留 |
| `post-compact.sh` | PostCompact | After compaction / 压缩后 | Reminds Claude to restore session state from `active.md` checkpoint / 提醒Claude从 `active.md` 检查点恢复会话状态 |
| `notify.sh` | Notification | Notification event / 通知事件 | Shows Windows toast notification via PowerShell / 通过 PowerShell 显示 Windows 气泡通知 |
| `session-stop.sh` | Stop | Session ends / 会话结束 | Summarizes accomplishments and updates session log / 总结成就并更新会话日志 |
| `log-agent.sh` | SubagentStart | Agent spawned / 代理生成 | Audit trail start — logs subagent invocation with timestamp / 审计跟踪开始 — 记录带时间戳的子代理调用 |
| `log-agent-stop.sh` | SubagentStop | Agent stops / 代理停止 | Audit trail stop — completes subagent record / 审计跟踪停止 — 完成子代理记录 |
| `validate-skill-change.sh` | PostToolUse (Write/Edit) | Skill file changes / 技能文件更改 | Advises running `/skill-test` after any `.codebuddy/skills/` file is written or edited / 在写入或编辑任何 `.codebuddy/skills/` 文件后建议运行 `/skill-test` |

Hook reference documentation: `.codebuddy/docs/hooks-reference/` / 钩子参考文档：
Hook input schema documentation: `.codebuddy/docs/hooks-reference/hook-input-schemas.md` / 钩子输入模式文档：
