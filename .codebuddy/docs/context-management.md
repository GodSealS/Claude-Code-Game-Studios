# Context Management / 上下文管理

Context is the most critical resource in a CodeBuddy session. Manage it actively. / 上下文是 CodeBuddy 会话中最关键的资源。主动管理它。

## File-Backed State (Primary Strategy) / 文件支持状态（主要策略）

**The file is the memory, not the conversation.** Conversations are ephemeral and
**文件是记忆，而非对话。** 对话是短暂的，
will be compacted or lost. Files on disk persist across compactions and session crashes.
将被压缩或丢失。磁盘上的文件在压缩和会话崩溃中持续存在。

### Session State File / 会话状态文件

Maintain `production/session-state/active.md` as a living checkpoint. Update it
将 `production/session-state/active.md` 维护为活跃的检查点。在以下重要里程碑后更新它：
after each significant milestone: / 

- Design section approved and written to file / 设计章节已批准并写入文件
- Architecture decision made / 架构决策已做出
- Implementation milestone reached / 实现里程碑已达到
- Test results obtained / 测试结果已获得

The state file should contain: current task, progress checklist, key decisions
状态文件应包含：当前任务、进度清单、关键决策
made, files being worked on, and open questions.
已做出的、正在处理的文件和未解决的问题。

### Status Line Block (Production+ only) / 状态行块（仅Production+）

When the project is in Production, Polish, or Release stage, include a structured
当项目处于 Production、Polish 或 Release 阶段时，在 `active.md` 中包含一个
status block in `active.md` that the status line script can parse:
状态行脚本可以解析的结构化状态块：

```markdown
<!-- STATUS -->
Epic: Combat System
Feature: Melee Combat
Task: Implement hitbox detection
<!-- /STATUS -->
```

- All three fields (Epic, Feature, Task) are optional — include only what applies / 所有三个字段（Epic、Feature、Task）都是可选的 — 仅包含适用的
- Update this block when switching focus areas / 切换焦点区域时更新此块
- The status line displays it as a breadcrumb: `Combat System > Melee Combat > Hitboxes` / 状态行将其显示为面包屑：`Combat System > Melee Combat > Hitboxes`
- Remove or empty the block when no active work focus exists / 没有活跃工作焦点时删除或清空块

After any disruption (compaction, crash, `/clear`), read the state file first. / 在任何中断（压缩、崩溃、`/clear`）后，首先读取状态文件。

### Incremental File Writing / 增量文件写入

When creating multi-section documents (design docs, architecture docs, lore entries): / 创建多章节文档（设计文档、架构文档、背景故事条目）时：

1. Create the file immediately with a skeleton (all section headers, empty bodies) / 立即创建带有骨架的文件（所有章节标题，空正文）
2. Discuss and draft one section at a time in conversation / 在对话中一次讨论和起草一个章节
3. Write each section to the file as soon as it's approved / 一旦批准，立即将每个章节写入文件
4. Update the session state file after each section / 每个章节后更新会话状态文件
5. After writing a section, previous discussion about that section can be safely
   写入章节后，关于该章节的先前讨论可以安全地
   compacted — the decisions are in the file
   压缩 — 决策在文件中

This keeps the context window holding only the *current* section's discussion
这使上下文窗口仅保存*当前*章节的讨论
(~3-5k tokens) instead of the entire document's conversation history (~30-50k tokens).
（~3-5k令牌）而非整个文档的对话历史（~30-50k令牌）。

## Proactive Compaction / 主动压缩

- **Compact proactively** at ~60-70% context usage, not reactively at the limit / 在~60-70%上下文使用率时主动压缩，而非在限制时被动压缩
- **Use `/clear`** between unrelated tasks, or after 2+ failed correction attempts / 在不相关的任务之间，或2+次失败的更正尝试后使用 `/clear`
- **Natural compaction points:** after writing a section to file, after committing,
  **自然压缩点：** 将章节写入文件后、提交后、
  after completing a task, before starting a new topic
  完成任务后、开始新主题前
- **Focused compaction:** `/compact Focus on [current task] — sections 1-3 are
  **聚焦压缩：** `/compact Focus on [current task] — sections 1-3 are
  written to file, working on section 4`
  written to file, working on section 4`

## Context Budgets by Task Type / 按任务类型的上下文预算

- Light (read/review): ~3k tokens startup / 轻量（读取/审查）：~3k令牌启动
- Medium (implement feature): ~8k tokens / 中等（实现功能）：~8k令牌
- Heavy (multi-system refactor): ~15k tokens / 繁重（多系统重构）：~15k令牌

## Subagent Delegation / 子代理委派

Use subagents for research and exploration to keep the main session clean. / 使用子代理进行研究和探索，以保持主会话干净。
Subagents run in their own context window and return only summaries: / 子代理在自己的上下文窗口中运行，仅返回摘要：

- **Use subagents** when investigating across multiple files, exploring unfamiliar code,
  **使用子代理** 在跨多个文件调查、探索不熟悉的代码、
  or doing research that would consume >5k tokens of file reads
  或进行会消耗 >5k 令牌文件读取的研究时
- **Use direct reads** when you know exactly which 1-2 files to check / 当您确切知道要检查哪1-2个文件时使用直接读取
- Subagents do not inherit conversation history — provide full context in the prompt / 子代理不继承对话历史 — 在提示中提供完整上下文

## Compaction Instructions / 压缩说明

When context is compacted, preserve the following in the summary: / 压缩上下文时，在摘要中保留以下内容：

- Reference to `production/session-state/active.md` (read it to recover state) / 引用 `production/session-state/active.md`（读取它以恢复状态）
- List of files modified in this session and their purpose / 本次会话中修改的文件列表及其目的
- Any architectural decisions made and their rationale / 做出的任何架构决策及其理由
- Active sprint tasks and their current status / 活跃冲刺任务及其当前状态
- Agent invocations and their outcomes (success/failure/blocked) / 代理调用及其结果（成功/失败/阻塞）
- Test results (pass/fail counts, specific failures) / 测试结果（通过/失败计数、具体失败）
- Unresolved blockers or questions awaiting user input / 未解决的阻塞或等待用户输入的问题
- The current task and what step we are on / 当前任务及我们所在的步骤
- Which sections of the current document are written to file vs. still in progress / 当前文档的哪些章节已写入文件 vs 仍在进行中

**After compaction:** Read `production/session-state/active.md` and any files being
**压缩后：** 读取 `production/session-state/active.md` 和任何正在
actively worked on to recover full context. The files contain the decisions; the
积极处理的文件以恢复完整上下文。文件包含决策；
conversation history is secondary.
对话历史是次要的。

## Recovery After Session Crash / 会话崩溃后恢复

If CodeBuddy crashes or the session is interrupted: / 如果 CodeBuddy 崩溃或会话被中断：

1. **Read `production/session-state/active.md` first** — this is your checkpoint / **首先读取 `production/session-state/active.md`** — 这是您的检查点
2. Check `production/session-logs/session-log.md` for recent activity / 检查 `production/session-logs/session-log.md` 获取最近活动
3. Review files modified in the last session (shown in git status) / 查看上次会话中修改的文件（显示在git状态中）
4. If you were in the middle of a document, re-read the file to see what's written / 如果您正在处理文档，重新读取文件以查看已写入的内容
5. Resume from the last completed section / 从最后一个完成的章节恢复
