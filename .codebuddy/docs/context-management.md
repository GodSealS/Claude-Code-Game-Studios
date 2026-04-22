# Context Management / 上下文管理

Context is the most critical resource in a CodeBuddy session. Manage it actively.

> **中文翻译**：上下文是CodeBuddy会话中最关键的资源。请主动管理它。

## File-Backed State (Primary Strategy) / 文件后备状态（主要策略）

**The file is the memory, not the conversation.** Conversations are ephemeral and
will be compacted or lost. Files on disk persist across compactions and session crashes.

> **中文翻译**：**文件才是记忆，而非对话。** 对话是短暂的，会被压缩或丢失。磁盘上的文件在压缩和会话崩溃后依然存在。

### Session State File / 会话状态文件

Maintain `production/session-state/active.md` as a living checkpoint. Update it
after each significant milestone:

> **中文翻译**：将 `production/session-state/active.md` 维护为一个活跃的检查点。在每次重要里程碑后更新它：

- Design section approved and written to file
  > **中文翻译**：设计章节已批准并写入文件
- Architecture decision made
  > **中文翻译**：架构决策已做出
- Implementation milestone reached
  > **中文翻译**：实现里程碑已达成
- Test results obtained
  > **中文翻译**：测试结果已获得

The state file should contain: current task, progress checklist, key decisions
made, files being worked on, and open questions.

> **中文翻译**：状态文件应包含：当前任务、进度清单、已做出的关键决策、正在处理的文件、以及待解决问题。

### Status Line Block (Production+ only) / 状态行块（仅制作阶段及以后）

When the project is in Production, Polish, or Release stage, include a structured
status block in `active.md` that the status line script can parse:

> **中文翻译**：当项目处于制作、打磨或发布阶段时，在 `active.md` 中包含状态行脚本可解析的结构化状态块：

```markdown
<!-- STATUS -->
Epic: Combat System
Feature: Melee Combat
Task: Implement hitbox detection
<!-- /STATUS -->
```

- All three fields (Epic, Feature, Task) are optional — include only what applies
  > **中文翻译**：所有三个字段（Epic、Feature、Task）都是可选的 — 仅包含适用的
- Update this block when switching focus areas
  > **中文翻译**：切换关注区域时更新此块
- The status line displays it as a breadcrumb: `Combat System > Melee Combat > Hitboxes`
  > **中文翻译**：状态行以面包屑方式显示：`Combat System > Melee Combat > Hitboxes`
- Remove or empty the block when no active work focus exists
  > **中文翻译**：没有活跃工作焦点时删除或清空此块

After any disruption (compaction, crash, `/clear`), read the state file first.

> **中文翻译**：在任何中断（压缩、崩溃、`/clear`）之后，首先读取状态文件。

### Incremental File Writing / 增量文件写入

When creating multi-section documents (design docs, architecture docs, lore entries):

> **中文翻译**：创建多章节文档（设计文档、架构文档、背景条目）时：

1. Create the file immediately with a skeleton (all section headers, empty bodies)
   > **中文翻译**：立即创建带有骨架的文件（所有章节标题、空正文）
2. Discuss and draft one section at a time in conversation
   > **中文翻译**：在对话中逐章讨论和起草
3. Write each section to the file as soon as it's approved
   > **中文翻译**：每章节批准后立即写入文件
4. Update the session state file after each section
   > **中文翻译**：每章节后更新会话状态文件
5. After writing a section, previous discussion about that section can be safely
   compacted — the decisions are in the file
   > **中文翻译**：写入章节后，关于该章节的先前讨论可以安全压缩 — 决策已在文件中

This keeps the context window holding only the *current* section's discussion
(~3-5k tokens) instead of the entire document's conversation history (~30-50k tokens).

> **中文翻译**：这使得上下文窗口仅保存 *当前* 章节的讨论（约3-5k token），而非整个文档的对话历史（约30-50k token）。

## Proactive Compaction / 主动压缩

- **Compact proactively** at ~60-70% context usage, not reactively at the limit
  > **中文翻译**：**主动压缩** — 在约60-70%上下文使用率时压缩，而非被动到极限时
- **Use `/clear`** between unrelated tasks, or after 2+ failed correction attempts
  > **中文翻译**：**使用 `/clear`** — 在不相关任务之间，或在2+次修正失败后
- **Natural compaction points:** after writing a section to file, after committing,
  after completing a task, before starting a new topic
  > **中文翻译**：**自然压缩点**：写入章节到文件后、提交后、完成任务后、开始新主题前
- **Focused compaction:** `/compact Focus on [current task] — sections 1-3 are
  written to file, working on section 4`
  > **中文翻译**：**聚焦压缩**：`/compact Focus on [当前任务] — 章节1-3已写入文件，正在处理章节4`

## Context Budgets by Task Type / 按任务类型的上下文预算

- Light (read/review): ~3k tokens startup
  > **中文翻译**：轻量（阅读/审查）：约3k token启动
- Medium (implement feature): ~8k tokens
  > **中文翻译**：中等（实现功能）：约8k token
- Heavy (multi-system refactor): ~15k tokens
  > **中文翻译**：重型（多系统重构）：约15k token

## Subagent Delegation / 子代理委派

Use subagents for research and exploration to keep the main session clean.
Subagents run in their own context window and return only summaries:

> **中文翻译**：使用子代理进行研究和探索以保持主会话干净。子代理在自有上下文窗口中运行，仅返回摘要：

- **Use subagents** when investigating across multiple files, exploring unfamiliar code,
  or doing research that would consume >5k tokens of file reads
  > **中文翻译**：**使用子代理** — 当跨多文件调查、探索不熟悉的代码、或进行会消耗>5k token文件读取的研究时
- **Use direct reads** when you know exactly which 1-2 files to check
  > **中文翻译**：**使用直接读取** — 当你确切知道要检查哪1-2个文件时
- Subagents do not inherit conversation history — provide full context in the prompt
  > **中文翻译**：子代理不继承对话历史 — 在提示中提供完整上下文

## Compaction Instructions / 压缩指令

When context is compacted, preserve the following in the summary:

> **中文翻译**：上下文被压缩时，在摘要中保留以下内容：

- Reference to `production/session-state/active.md` (read it to recover state)
  > **中文翻译**：对 `production/session-state/active.md` 的引用（读取它以恢复状态）
- List of files modified in this session and their purpose
  > **中文翻译**：本会话修改的文件列表及其用途
- Any architectural decisions made and their rationale
  > **中文翻译**：已做出的任何架构决策及其理由
- Active sprint tasks and their current status
  > **中文翻译**：活跃冲刺任务及其当前状态
- Agent invocations and their outcomes (success/failure/blocked)
  > **中文翻译**：代理调用及其结果（成功/失败/阻塞）
- Test results (pass/fail counts, specific failures)
  > **中文翻译**：测试结果（通过/失败计数、具体失败项）
- Unresolved blockers or questions awaiting user input
  > **中文翻译**：未解决的阻塞或等待用户输入的问题
- The current task and what step we are on
  > **中文翻译**：当前任务及所在步骤
- Which sections of the current document are written to file vs. still in progress
  > **中文翻译**：当前文档中哪些章节已写入文件 vs 仍在进行中

**After compaction:** Read `production/session-state/active.md` and any files being
actively worked on to recover full context. The files contain the decisions; the
conversation history is secondary.

> **中文翻译**：**压缩后**：读取 `production/session-state/active.md` 和任何正在处理的文件以恢复完整上下文。文件包含决策；对话历史是次要的。

## Recovery After Session Crash / 会话崩溃后的恢复

If a session dies ("prompt too long") or you start a new session to continue work:

> **中文翻译**：如果会话终止（"prompt too long"）或你开始新会话继续工作：

1. The `session-start.sh` hook will detect and preview `active.md` automatically
   > **中文翻译**：`session-start.sh` 钩子将自动检测并预览 `active.md`
2. Read the full state file for context
   > **中文翻译**：读取完整的状态文件获取上下文
3. Read the partially-completed file(s) listed in the state
   > **中文翻译**：读取状态中列出的未完成文件
4. Continue from the next incomplete section or task
   > **中文翻译**：从下一个未完成的章节或任务继续
