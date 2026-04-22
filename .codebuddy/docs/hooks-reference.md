# Active Hooks / 活跃钩子

Hooks are configured in `.codebuddy/settings.json` and fire automatically:

> **中文翻译**：钩子在 `.codebuddy/settings.json` 中配置并自动触发：

| Hook | Event | Trigger | Action |
| ---- | ----- | ------- | ------ |
| `validate-commit.sh` | PreToolUse (Bash) | `git commit` commands | Validates design doc sections, JSON data files, hardcoded values, TODO format |
| `validate-push.sh` | PreToolUse (Bash) | `git push` commands | Warns on pushes to protected branches (develop/main) |
| `validate-assets.sh` | PostToolUse (Write/Edit) | Asset file changes | Checks naming conventions and JSON validity for files in `assets/` |
| `session-start.sh` | SessionStart | Session begins | Loads sprint context, milestone, git activity; detects and previews active session state file for recovery |
| `detect-gaps.sh` | SessionStart | Session begins | Detects fresh projects (suggests /start) and missing documentation when code/prototypes exist, suggests /reverse-document or /project-stage-detect |
| `pre-compact.sh` | PreCompact | Context compression | Dumps session state (active.md, modified files, WIP design docs) into conversation before compaction so it survives summarization |
| `post-compact.sh` | PostCompact | After compaction | Reminds Claude to restore session state from `active.md` checkpoint |
| `notify.sh` | Notification | Notification event | Shows Windows toast notification via PowerShell |
| `session-stop.sh` | Stop | Session ends | Summarizes accomplishments and updates session log |
| `log-agent.sh` | SubagentStart | Agent spawned | Audit trail start — logs subagent invocation with timestamp |
| `log-agent-stop.sh` | SubagentStop | Agent stops | Audit trail stop — completes subagent record |
| `validate-skill-change.sh` | PostToolUse (Write/Edit) | Skill file changes | Advises running `/skill-test` after any `.codebuddy/skills/` file is written or edited |

> **中文翻译**：

| 钩子 | 事件 | 触发条件 | 动作 |
| ---- | ---- | -------- | ---- |
| `validate-commit.sh` | PreToolUse (Bash) | `git commit` 命令 | 验证设计文档章节、JSON数据文件、硬编码值、TODO格式 |
| `validate-push.sh` | PreToolUse (Bash) | `git push` 命令 | 推送到受保护分支(develop/main)时警告 |
| `validate-assets.sh` | PostToolUse (Write/Edit) | 资产文件变更 | 检查 `assets/` 中文件的命名约定和JSON有效性 |
| `session-start.sh` | SessionStart | 会话开始 | 加载冲刺上下文、里程碑、git活动；检测并预览活跃会话状态文件以便恢复 |
| `detect-gaps.sh` | SessionStart | 会话开始 | 检测新项目（建议 /start）和代码/原型存在时缺失的文档，建议 /reverse-document 或 /project-stage-detect |
| `pre-compact.sh` | PreCompact | 上下文压缩 | 在压缩前将会话状态（active.md、修改的文件、进行中的设计文档）转储到对话中，使其在摘要后存活 |
| `post-compact.sh` | PostCompact | 压缩后 | 提醒Claude从 `active.md` 检查点恢复会话状态 |
| `notify.sh` | Notification | 通知事件 | 通过PowerShell显示Windows通知 |
| `session-stop.sh` | Stop | 会话结束 | 总结成果并更新会话日志 |
| `log-agent.sh` | SubagentStart | 代理生成 | 审计追踪开始 — 记录子代理调用及时间戳 |
| `log-agent-stop.sh` | SubagentStop | 代理停止 | 审计追踪结束 — 完成子代理记录 |
| `validate-skill-change.sh` | PostToolUse (Write/Edit) | 技能文件变更 | 在 `.codebuddy/skills/` 文件被写入或编辑后建议运行 `/skill-test` |

Hook reference documentation: `.codebuddy/docs/hooks-reference/`
Hook input schema documentation: `.codebuddy/docs/hooks-reference/hook-input-schemas.md`

> **中文翻译**：钩子参考文档：`.codebuddy/docs/hooks-reference/`
> **中文翻译**：钩子输入模式文档：`.codebuddy/docs/hooks-reference/hook-input-schemas.md`
