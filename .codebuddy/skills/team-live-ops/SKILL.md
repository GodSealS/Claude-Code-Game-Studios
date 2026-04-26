---
name: team-live-ops
description: "Orchestrate the live-ops team for post-launch content planning: coordinates live-ops-designer, economy-designer, analytics-engineer, community-manager, writer, and narrative-director to design and plan a season, event, or live content update. / 编排活跃运营团队进行发布后内容规划：协调 live-ops-designer、economy-designer、analytics-engineer、community-manager、writer 和 narrative-director 设计和规划赛季、活动或线上内容更新。"
argument-hint: "[season name or event description]"
user-invocable: true
allowed-tools: Read, Glob, Grep, Write, Edit, Bash, Task, AskUserQuestion, TodoWrite
---
**Argument check:** If no season name or event description is provided, output:
> "Usage: `/team-live-ops [season name or event description]` — Provide the name or description of the season or live event to plan."
Then stop immediately without spawning any subagents or reading any files.

> **中文翻译**：**参数检查：** 如果未提供赛季名称或活动描述，输出：
> 用法：`/team-live-ops [赛季名称或活动描述]` — 提供要规划的赛季或线上活动的名称或描述。
> 然后立即停止，不派生任何子代理或读取任何文件。

When this skill is invoked with a valid argument, orchestrate the live-ops team through a structured planning pipeline.

> **中文翻译**：当此技能带有效参数调用时，通过结构化规划管线编排活跃运营团队。

**Decision Points:** At each phase transition, use `AskUserQuestion` to present
the user with the subagent's proposals as selectable options. Write the agent's
full analysis in conversation, then capture the decision with concise labels.
The user must approve before moving to the next phase.

> **中文翻译**：**决策点：** 在每个阶段转换时，使用 `AskUserQuestion` 向用户展示子代理的提案作为可选选项。在对话中写入代理的完整分析，然后用简洁的标签捕获决策。用户必须在进入下一阶段之前批准。

## Team Composition / 团队组成
- **live-ops-designer** — Season structure, event cadence, retention mechanics, battle pass / 赛季结构、活动节奏、留存机制、战斗通行证
- **economy-designer** — Live economy balance, store rotation, currency pricing, pity timers / 长线经济平衡、商店轮换、货币定价、保底机制
- **analytics-engineer** — Success metrics, A/B test design, event tracking, dashboard specs / 成功指标、A/B 测试设计、事件追踪、仪表板规格
- **community-manager** — Player-facing announcements, event descriptions, seasonal messaging / 面向玩家的公告、活动描述、赛季信息
- **narrative-director** — Seasonal narrative theme, story arc, world event framing / 赛季叙事主题、故事弧线、世界事件框架
- **writer** — Event descriptions, reward item names, seasonal flavor text, announcement copy / 活动描述、奖励物品名称、赛季风味文本、公告文案

## How to Delegate / 如何委派

Use the Task tool to spawn each team member as a subagent:

> **中文翻译**：使用 Task 工具将每个团队成员作为子代理派生：

- `subagent_type: live-ops-designer` — Season/event structure and retention mechanics / 赛季/活动结构和留存机制
- `subagent_type: economy-designer` — Live economy balance and reward pricing / 长线经济平衡和奖励定价
- `subagent_type: analytics-engineer` — Success metrics, A/B tests, event instrumentation / 成功指标、A/B 测试、事件埋点
- `subagent_type: community-manager` — Player-facing communication and messaging / 面向玩家的沟通和信息
- `subagent_type: narrative-director` — Seasonal theme and narrative framing / 赛季主题和叙事框架
- `subagent_type: writer` — All player-facing text: event descriptions, item names, copy / 所有面向玩家的文本：活动描述、物品名称、文案

Always provide full context in each agent's prompt (game concept path, existing season docs, ethics policy path, current economy state). Launch independent agents in parallel where the pipeline allows it (Phases 3 and 4 can run simultaneously).

> **中文翻译**：始终在每个代理的提示中提供完整上下文（游戏概念路径、现有赛季文档、伦理政策路径、当前经济状态）。在管线允许的情况下并行启动独立代理（第 3 和 4 阶段可同时运行）。

## Pipeline / 管线

### Phase 1: Season/Event Scoping / 第 1 阶段：赛季/活动范围界定
Delegate to **live-ops-designer**: / 委托给 **live-ops-designer**：
- Define the season or event: type (seasonal, limited-time event, challenge), duration, theme direction / 定义赛季或活动：类型（赛季、限时活动、挑战）、持续时间、主题方向
- Outline the content list: what's new (modes, items, challenges, story beats) / 概述内容列表：新增内容（模式、物品、挑战、故事节奏）
- Define the retention hook: what brings players back daily/weekly during this season / 定义留存钩子：什么让玩家在赛季期间每日/每周回来
- Identify resource budget: how much new content needs to be created vs. reused / 识别资源预算：需要创建多少新内容 vs 重用
- Output: season brief with scope, content list, and retention mechanic overview / 输出：带范围、内容列表和留存机制概述的赛季简报

### Phase 2: Narrative Theme / 第 2 阶段：叙事主题
Delegate to **narrative-director**: / 委托给 **narrative-director**：
- Read the season brief from Phase 1 / 读取第 1 阶段的赛季简报
- Design the seasonal narrative theme: how does this event connect to the game world? / 设计赛季叙事主题：此活动如何与游戏世界连接？
- Define the central story hook players will discover during the event / 定义玩家在活动中将发现的中心故事钩子
- Identify which existing lore threads this season can advance / 识别此赛季可以推进哪些现有设定线索
- Output: narrative framing document (theme, story hook, lore connections) / 输出：叙事框架文档（主题、故事钩子、设定连接）

### Phase 3: Economy Design (parallel with Phase 2 if theme is clear) / 第 3 阶段：经济设计（如主题明确则与第 2 阶段并行）
Delegate to **economy-designer**: / 委托给 **economy-designer**：
- Read the season brief and existing economy rules from `design/live-ops/economy-rules.md` / 读取赛季简报和 `design/live-ops/economy-rules.md` 中现有的经济规则
- Design the reward track: free tier progression, premium tier value proposition / 设计奖励轨道：免费层进度、高级层价值主张
- Plan the in-season economy: seasonal currency, store rotation, pricing / 规划赛季内经济：赛季货币、商店轮换、定价
- Define pity timer mechanics and bad-luck protection for any random elements / 为任何随机元素定义保底机制和坏运气保护
- Verify no pay-to-win items in premium track / 验证高级层无付费获胜物品
- Output: economy design doc with reward tables, pricing, and currency flow / 输出：带奖励表、定价和货币流的经济设计文档

### Phase 4: Analytics and Success Metrics (parallel with Phase 3) / 第 4 阶段：分析和成功指标（与第 3 阶段并行）
Delegate to **analytics-engineer**: / 委托给 **analytics-engineer**：
- Read the season brief / 读取赛季简报
- Define success metrics: participation rate target, retention lift target, battle pass completion rate / 定义成功指标：参与率目标、留存提升目标、战斗通行证完成率
- Design any A/B tests to run during the season (e.g., different reward cadences) / 设计赛季期间运行的任何 A/B 测试（如不同奖励节奏）
- Specify new telemetry events needed for this season's content / 指定此赛季内容所需的新遥测事件
- Output: analytics plan with success criteria and instrumentation requirements / 输出：带成功标准和埋点要求的分析计划

### Phase 5: Content Writing (parallel) / 第 5 阶段：内容写作（并行）
Delegate in parallel: / 并行委托：
- **narrative-director** (if needed): Write any in-game narrative text (cutscene scripts, NPC dialogue, world event descriptions) for the season / **narrative-director**（如需要）：为赛季编写任何游戏内叙事文本（过场动画脚本、NPC 对话、世界事件描述）
- **writer**: Write all player-facing text — event names, reward item descriptions, challenge objective text, seasonal flavor text / **writer**：编写所有面向玩家的文本 — 活动名称、奖励物品描述、挑战目标文本、赛季风味文本
- Both should read the narrative framing doc from Phase 2 / 两者都应读取第 2 阶段的叙事框架文档

### Phase 6: Player Communication Plan / 第 6 阶段：玩家沟通计划
Delegate to **community-manager**: / 委托给 **community-manager**：
- Read the season brief, economy design, and narrative framing / 读取赛季简报、经济设计和叙事框架
- Draft the season launch announcement (tone, key highlights, platform-specific versions) / 起草赛季发布公告（基调、关键亮点、平台特定版本）
- Plan the communication cadence: pre-launch teaser, launch day post, mid-season reminder, final week FOMO push / 规划沟通节奏：发布前预告、发布日帖子、赛季中提醒、最后一周推送
- Draft known-issues section placeholder for day-1 patch notes / 起草首日补丁说明的已知问题部分占位符
- Output: communication calendar with draft copy for each touchpoint / 输出：带每个触点草稿文案的沟通日历

### Phase 7: Review and Sign-off / 第 7 阶段：审查和签署
Collect outputs from all phases and present a consolidated season plan: / 收集所有阶段的输出并展示综合赛季计划：
- Season brief (Phase 1) / 赛季简报（第 1 阶段）
- Narrative framing (Phase 2) / 叙事框架（第 2 阶段）
- Economy design and reward tables (Phase 3) / 经济设计和奖励表（第 3 阶段）
- Analytics plan and success metrics (Phase 4) / 分析计划和成功指标（第 4 阶段）
- Written content inventory (Phase 5) / 书面内容清单（第 5 阶段）
- Communication calendar (Phase 6) / 沟通日历（第 6 阶段）

Present a summary to the user with: / 向用户展示摘要，包含：
- **Content scope**: what is being created / **内容范围**：正在创建什么
- **Economy health check**: does the reward track feel fair and non-predatory? / **经济健康检查**：奖励轨道是否公平且非掠夺性？
- **Analytics readiness**: are success criteria defined and instrumented? / **分析就绪度**：成功标准是否已定义和埋点？
- **Ethics review**: check the Phase 3 economy design against `design/live-ops/ethics-policy.md` / **伦理审查**：将第 3 阶段经济设计对照 `design/live-ops/ethics-policy.md` 检查
  - If the file does not exist: flag "ETHICS REVIEW SKIPPED: `design/live-ops/ethics-policy.md` not found. Economy design was not reviewed against an ethics policy. Recommend creating one before production begins." Include this flag in the season design output document. Add to next steps: create `design/live-ops/ethics-policy.md`. / 如果文件不存在：标记"伦理审查已跳过：未找到 `design/live-ops/ethics-policy.md`。经济设计未经伦理政策审查。建议在生产开始前创建。"将此标记包含在赛季设计输出文档中。添加到后续步骤：创建 `design/live-ops/ethics-policy.md`。
  - If the file exists and a violation is found: flag "ETHICS FLAG: [element] in Phase 3 economy design violates [policy rule]. Approval is blocked until this is resolved." Do NOT issue a COMPLETE verdict or write output documents. Use `AskUserQuestion` with options: revise economy design / override with documented rationale / cancel. If user chooses to revise: re-spawn economy-designer to produce a corrected design, then return to Phase 7 review. / 如果文件存在且发现违规：标记"伦理标记：第 3 阶段经济设计中的 [元素] 违反了 [政策规则]。在解决之前阻止批准。"不要发布 COMPLETE 裁决或写入输出文档。使用 `AskUserQuestion` 提供选项：修改经济设计/以文档化理由覆盖/取消。如果用户选择修改：重新派生 economy-designer 生成修正设计，然后返回第 7 阶段审查。
- **Open questions**: decisions still needed before production begins / **开放问题**：生产开始前仍需做出的决策

Ask the user to approve the season plan before delegating to production teams. Issue the COMPLETE verdict only after the user approves and no unresolved ethics violations remain. If an ethics violation is unresolved, end with Verdict: **BLOCKED**.

> **中文翻译**：在委托给生产团队之前，请用户批准赛季计划。仅在用户批准且无未解决的伦理违规后发布 COMPLETE 裁决。如果伦理违规未解决，以裁决：**BLOCKED** 结束。

## Output Documents / 输出文档

All documents save to `design/live-ops/`: / 所有文档保存到 `design/live-ops/`：
- `seasons/S[N]_[name].md` — Season design document (from Phase 1-3) / 赛季设计文档（来自第 1-3 阶段）
- `seasons/S[N]_[name]_analytics.md` — Analytics plan (from Phase 4) / 分析计划（来自第 4 阶段）
- `seasons/S[N]_[name]_comms.md` — Communication calendar (from Phase 6) / 沟通日历（来自第 6 阶段）

## Error Recovery Protocol / 错误恢复协议

If any spawned agent (via Task) returns BLOCKED, errors, or cannot complete:

1. **Surface immediately**: Report "[AgentName]: BLOCKED — [reason]" to the user before continuing to dependent phases
2. **Assess dependencies**: Check whether the blocked agent's output is required by subsequent phases. If yes, do not proceed past that dependency point without user input.
3. **Offer options** via AskUserQuestion with choices:
   - Skip this agent and note the gap in the final report
   - Retry with narrower scope
   - Stop here and resolve the blocker first
4. **Always produce a partial report** — output whatever was completed. Never discard work because one agent blocked.

> **中文翻译**：如果任何派生的代理返回 BLOCKED、错误或无法完成：1. **立即报告**；2. **评估依赖**；3. 通过 AskUserQuestion **提供选项**（跳过/缩小范围/先解决阻塞）；4. **始终生成部分报告**。

If a BLOCKED state is unresolvable, end with Verdict: **BLOCKED** instead of COMPLETE.

> **中文翻译**：如果 BLOCKED 状态无法解决，以裁决：**BLOCKED** 而非 COMPLETE 结束。

## File Write Protocol / 文件写入协议

All file writes (season design docs, analytics plans, communication calendars) are
delegated to sub-agents spawned via Task. Each sub-agent enforces the
"May I write to [path]?" protocol. This orchestrator does not write files directly.

> **中文翻译**：所有文件写入委托给通过 Task 派生的子代理。每个子代理执行"我可以写入到 [路径] 吗？"协议。此编排器不直接写入文件。

## Output / 输出

A summary covering: season theme and scope, economy design highlights, success metrics, content list, communication plan, and any open decisions needing user input before production.

> **中文翻译**：摘要涵盖：赛季主题和范围、经济设计亮点、成功指标、内容列表、沟通计划和生产前需要用户输入的任何开放决策。

Verdict: **COMPLETE** — season plan produced and handed off for production.

> **中文翻译**：裁决：**COMPLETE** — 赛季计划已生成并移交生产。

## Next Steps / 后续步骤

- Run `/design-review` on the season design document for consistency validation. / 对赛季设计文档运行 `/design-review` 进行一致性验证。
- Run `/sprint-plan` to schedule content creation work for the season. / 运行 `/sprint-plan` 安排赛季内容创建工作。
- Run `/team-release` when the season content is ready to deploy. / 当赛季内容准备好部署时运行 `/team-release`。
