---
name: team-narrative
description: "Orchestrate the narrative team: coordinates narrative-director, writer, world-builder, and level-designer to create cohesive story content, world lore, and narrative-driven level design. / 编排叙事团队：协调 narrative-director、writer、world-builder 和 level-designer 创建连贯的故事内容、世界设定和叙事驱动的关卡设计。"
argument-hint: "[narrative content description]"
user-invocable: true
allowed-tools: Read, Glob, Grep, Write, Edit, Task, AskUserQuestion, TodoWrite
---
If no argument is provided, output usage guidance and exit without spawning any agents:
> Usage: `/team-narrative [narrative content description]` — describe the story content, scene, or narrative area to work on (e.g., `boss encounter cutscene`, `faction intro dialogue`, `tutorial narrative`). Do not use `AskUserQuestion` here; output the guidance directly.
> **中文翻译**：如果未提供参数，输出用法指导并退出，不派生任何代理：
> 用法：`/team-narrative [叙事内容描述]` — 描述要处理的故事内容、场景或叙事区域（如 `boss encounter cutscene`、`faction intro dialogue`、`tutorial narrative`）。此处不使用 `AskUserQuestion`；直接输出指导。

When this skill is invoked with an argument, orchestrate the narrative team through a structured pipeline.
> **中文翻译**：当此技能带参数调用时，通过结构化管线编排叙事团队。

**Decision Points:** At each phase transition, use `AskUserQuestion` to present
the user with the subagent's proposals as selectable options. Write the agent's
full analysis in conversation, then capture the decision with concise labels.
The user must approve before moving to the next phase.
> **中文翻译**：**决策点：** 在每个阶段转换时，使用 `AskUserQuestion` 向用户展示子代理的提案作为可选选项。在对话中写入代理的完整分析，然后用简洁的标签捕获决策。用户必须在进入下一阶段之前批准。

## Team Composition / 团队组成
- **narrative-director** — Story arcs, character design, dialogue strategy, narrative vision / 故事弧线、角色设计、对话策略、叙事愿景
- **writer** — Dialogue writing, lore entries, item descriptions, in-game text / 对话写作、设定条目、物品描述、游戏内文本
- **world-builder** — World rules, faction design, history, geography, environmental storytelling / 世界规则、阵营设计、历史、地理、环境叙事
- **art-director** — Character visual design, environmental visual storytelling, cutscene/cinematic tone / 角色视觉设计、环境视觉叙事、过场动画/电影基调
- **level-designer** — Level layouts that serve the narrative, pacing, environmental storytelling beats / 服务于叙事的关卡布局、节奏、环境叙事节奏

## How to Delegate / 如何委托

Use the Task tool to spawn each team member as a subagent:
> **中文翻译**：使用 Task 工具将每个团队成员作为子代理派生：

- `subagent_type: narrative-director` — Story arcs, character design, narrative vision / 故事弧线、角色设计、叙事愿景
- `subagent_type: writer` — Dialogue writing, lore entries, in-game text / 对话写作、设定条目、游戏内文本
- `subagent_type: world-builder` — World rules, faction design, history, geography / 世界规则、阵营设计、历史、地理
- `subagent_type: art-director` — Character visual profiles, environmental visual storytelling, cinematic tone / 角色视觉概要、环境视觉叙事、电影基调
- `subagent_type: level-designer` — Level layouts that serve the narrative, pacing / 服务于叙事的关卡布局、节奏
- `subagent_type: localization-lead` — i18n validation, string key compliance, translation headroom / i18n 验证、字符串键合规性、翻译余量

Always provide full context in each agent's prompt (narrative brief, lore dependencies, character profiles). Launch independent agents in parallel where the pipeline allows it (e.g., Phase 2 agents can run simultaneously).
> **中文翻译**：始终在每个代理的提示中提供完整上下文（叙事简报、设定依赖、角色概要）。在管线允许的情况下并行启动独立代理（如第 2 阶段代理可同时运行）。

## Pipeline / 管线

### Phase 1: Narrative Direction / 第 1 阶段：叙事方向
Delegate to **narrative-director**: / 委托给 **narrative-director**：
- Define the narrative purpose of this content: what story beat does it serve? / 定义此内容的叙事目的：它服务于什么故事节奏？
- Identify characters involved, their motivations, and how this fits the overall arc / 识别涉及的角色、他们的动机，以及这与整体弧线的契合方式
- Set the emotional tone and pacing targets / 设置情感基调和节奏目标
- Specify any lore dependencies or new lore this introduces / 指定任何设定依赖或此内容引入的新设定
- Output: narrative brief with story requirements / 输出：带故事要求的叙事简报

### Phase 2: World Foundation (parallel) / 第 2 阶段：世界基础（并行）
Delegate in parallel — issue all three Task calls simultaneously before waiting for any result: / 并行委托 — 在等待任何结果之前同时发出所有三个 Task 调用：
- **world-builder**: Create or update lore entries for factions, locations, and history relevant to this content. Cross-reference against existing lore for contradictions. Set canon level for new entries. / **world-builder**：创建或更新与此内容相关的阵营、位置和历史的设定条目。对照现有设定检查矛盾。为新条目设置规范级别。
- **writer**: Draft character dialogue using voice profiles. Ensure all lines are under 120 characters, use named placeholders for variables, and are localization-ready. / **writer**：使用声音概要起草角色对话。确保所有行数不超过 120 字符，使用命名占位符用于变量，并本地化就绪。
- **art-director**: Define character visual design direction for key characters appearing in this content (silhouette, visual archetype, distinguishing features). Specify environmental visual storytelling elements for each key space (prop composition, lighting notes, spatial arrangement). Define tone palette and cinematic direction for any cutscenes or scripted sequences. / **art-director**：为此内容中出现的关键角色定义视觉设计方向（剪影、视觉原型、显著特征）。指定每个关键空间的环境视觉叙事元素（道具构成、灯光说明、空间布置）。为任何过场动画或脚本序列定义基调调色板和电影方向。

### Phase 3: Level Narrative Integration / 第 3 阶段：关卡叙事集成
Delegate to **level-designer**: / 委托给 **level-designer**：
- Review the narrative brief and lore foundation / 审查叙事简报和设定基础
- Design environmental storytelling elements in the level / 在关卡中设计环境叙事元素
- Place narrative triggers, dialogue zones, and discovery points / 放置叙事触发器、对话区域和发现点
- Ensure pacing serves both gameplay and story / 确保节奏既服务游戏玩法又服务故事

### Phase 4: Review and Consistency / 第 4 阶段：审查和一致性
Delegate to **narrative-director**: / 委托给 **narrative-director**：
- Review all dialogue against character voice profiles / 对照角色声音概要审查所有对话
- Verify lore consistency across new and existing entries / 验证新旧条目的设定一致性
- Confirm narrative pacing aligns with level design / 确认叙事节奏与关卡设计一致
- Check that所有谜题都有记录的"真实答案" / Check that all mysteries have documented "true answers"

### Phase 5: Polish (parallel) / 第 5 阶段：润色（并行）
Delegate in parallel: / 并行委托：
- **writer**: Final self-review — verify no line exceeds dialogue box constraints, all text uses string keys (not raw strings), placeholder variable names are consistent / **writer**：最终自我审查 — 验证没有行超过对话框限制，所有文本使用字符串键（非原始字符串），占位符变量名一致
- **localization-lead**: Validate i18n compliance — check string key naming conventions, flag any strings with hardcoded formatting that won't survive translation, verify character limit headroom for languages that expand (German/Finnish typically +30%), confirm no cultural assumptions in text that would need locale-specific variants / **localization-lead**：验证 i18n 合规性 — 检查字符串键命名约定，标记任何带有硬编码格式且在翻译中无法存活的字符串，验证扩展语言（德语/芬兰语通常 +30%）的字符限制余量，确认文本中无需要特定区域变体的文化假设
- **world-builder**: Finalize canon levels for all new lore entries / **world-builder**：最终确定所有新设定条目的规范级别

## Error Recovery Protocol / 错误恢复协议

If any spawned agent (via Task) returns BLOCKED, errors, or cannot complete:
> **中文翻译**：如果任何派生的代理返回 BLOCKED、错误或无法完成：

1. **Surface immediately**: Report "[AgentName]: BLOCKED — [reason]" to the user before continuing to dependent phases / **立即报告**：在继续依赖阶段之前向用户报告"[代理名称]: BLOCKED — [原因]"
2. **Assess dependencies**: Check whether the blocked agent's output is required by subsequent phases. If yes, do not proceed past that dependency point without user input. / **评估依赖**：检查被阻塞代理的输出是否是后续阶段所需的。如果是，在没有用户输入的情况下不要越过该依赖点。
3. **Offer options** via AskUserQuestion with choices: / 通过 AskUserQuestion **提供选项**：
   - Skip this agent and note the gap in the final report / 跳过此代理并在最终报告中注明差距
   - Retry with narrower scope / 以更窄的范围重试
   - Stop here and resolve the blocker first / 先停在这里解决阻塞问题
4. **Always produce a partial report** — output whatever was completed. Never discard work because one agent blocked. / **始终生成部分报告** — 输出已完成的任何内容。绝不因为一个代理被阻塞而丢弃工作。

Common blockers: / 常见阻塞：
- Input file missing (story not found, GDD absent) → redirect to the skill that creates it / 输入文件缺失 → 重定向到创建它的技能
- ADR status is Proposed → do not implement; run `/architecture-decision` first / ADR 状态为 Proposed → 先运行 `/architecture-decision`
- Scope too large → split into two stories via `/create-stories` / 范围太大 → 通过 `/create-stories` 拆分
- Conflicting instructions between ADR and story → surface the conflict, do not guess / ADR 和故事之间指令冲突 → 展示冲突

## File Write Protocol / 文件写入协议

All file writes (narrative docs, dialogue files, lore entries) are delegated to
sub-agents spawned via Task. Each sub-agent enforces the "May I write to [path]?"
protocol. This orchestrator does not write files directly.
> **中文翻译**：所有文件写入委托给通过 Task 派生的子代理。每个子代理执行"我可以写入到 [路径] 吗？"协议。此编排器不直接写入文件。

## Output / 输出

A summary report covering: narrative brief status, lore entries created/updated, dialogue lines written, level narrative integration points, consistency review results, and any unresolved contradictions.
> **中文翻译**：摘要报告涵盖：叙事简报状态、创建/更新的设定条目、编写的对话行数、关卡叙事集成点、一致性审查结果和任何未解决的矛盾。

Verdict: **COMPLETE** — narrative content delivered.
> **中文翻译**：裁决：**COMPLETE** — 叙事内容已交付。

If the pipeline stops because a dependency is unresolved (e.g., lore contradiction or missing prerequisite not resolved by the user):
> **中文翻译**：如果管线因为依赖未解决而停止（如设定矛盾或用户未解决的缺失先决条件）：

Verdict: **BLOCKED** — [reason]
> **中文翻译**：裁决：**BLOCKED** — [原因]

## Next Steps / 后续步骤

- Run `/design-review` on the narrative documents for consistency validation. / 对叙事文档运行 `/design-review` 进行一致性验证。
- Run `/localize extract` to extract new strings for translation after dialogue is finalized. / 对话最终确定后运行 `/localize extract` 提取新字符串用于翻译。
- Run `/dev-story` to implement dialogue triggers and narrative events in-engine. / 运行 `/dev-story` 在引擎中实现对话触发器和叙事事件。
