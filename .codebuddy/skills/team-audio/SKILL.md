---
name: team-audio
description: "Orchestrate audio team: audio-director + sound-designer + technical-artist + gameplay-programmer for full audio pipeline from direction to implementation. / 编排音频团队：audio-director + sound-designer + technical-artist + gameplay-programmer 完成从方向到实现的完整音频管线。"
argument-hint: "[feature or area to design audio for]"
user-invocable: true
allowed-tools: Read, Glob, Grep, Write, Edit, Bash, Task, AskUserQuestion, TodoWrite
---

If no argument is provided, output usage guidance and exit without spawning any agents:
> Usage: `/team-audio [feature or area]` — specify the feature or area to design audio for (e.g., `combat`, `main menu`, `forest biome`, `boss encounter`). Do not use `AskUserQuestion` here; output the guidance directly.

> **中文翻译**：如果未提供参数，输出使用指南并退出，不派生任何代理：
> 用法：`/team-audio [功能或区域]` — 指定要设计音频的功能或区域（如 `combat`、`main menu`、`forest biome`、`boss encounter`）。此处不使用 `AskUserQuestion`；直接输出指南。

When this skill is invoked with an argument, orchestrate the audio team through a structured pipeline.

> **中文翻译**：当此技能带参数调用时，通过结构化管线编排音频团队。

**Decision Points:** At each step transition, use `AskUserQuestion` to present
the user with the subagent's proposals as selectable options. Write the agent's
full analysis in conversation, then capture the decision with concise labels.
The user must approve before moving to the next step.

> **中文翻译**：**决策点：** 在每个步骤转换时，使用 `AskUserQuestion` 向用户展示子代理的提案作为可选选项。在对话中写入代理的完整分析，然后用简洁的标签捕获决策。用户必须在进入下一步之前批准。

1. **Read the argument** for the target feature or area (e.g., `combat`, `main menu`, `forest biome`, `boss encounter`). / **读取参数**，获取目标功能或区域（如 `combat`、`main menu`、`forest biome`、`boss encounter`）。

2. **Gather context**: / **收集上下文**：
   - Read relevant design docs in `design/gdd/` for the feature / 读取 `design/gdd/` 中该功能的相关设计文档
   - Read the sound bible at `design/gdd/sound-bible.md` if it exists / 如存在则读取 `design/gdd/sound-bible.md` 中的声音圣经
   - Read existing audio asset lists in `assets/audio/` / 读取 `assets/audio/` 中现有的音频资产列表
   - Read any existing sound design docs for this area / 读取该区域已有的声音设计文档

## How to Delegate / 如何委托

Use the Task tool to spawn each team member as a subagent:

> **中文翻译**：使用 Task 工具将每个团队成员作为子代理派生：

- `subagent_type: audio-director` — Sonic identity, emotional tone, audio palette / 声音标识、情感基调、音频调色板
- `subagent_type: sound-designer` — SFX specifications, audio events, mixing groups / 音效规格、音频事件、混音组
- `subagent_type: technical-artist` — Audio middleware, bus structure, memory budgets / 音频中间件、总线结构、内存预算
- `subagent_type: [primary engine specialist]` — Validate audio integration patterns for the engine / 验证引擎的音频集成模式
- `subagent_type: gameplay-programmer` — Audio manager, gameplay triggers, adaptive music / 音频管理器、游戏玩法触发器、自适应音乐

Always provide full context in each agent's prompt (feature description, existing audio assets, design doc references).

> **中文翻译**：始终在每个代理的提示中提供完整上下文（功能描述、现有音频资产、设计文档引用）。

3. **Orchestrate the audio team** in sequence: / **按顺序编排音频团队**：

### Step 1: Audio Direction (audio-director) / 步骤 1：音频方向（audio-director）
Spawn the `audio-director` agent to: / 派生 `audio-director` 代理以：
- Define the sonic identity for this feature/area / 定义此功能/区域的声音标识
- Specify the emotional tone and audio palette / 指定情感基调和音频调色板
- Set music direction (adaptive layers, stems, transitions) / 设定音乐方向（自适应层、分轨、过渡）
- Define audio priorities and mix targets / 定义音频优先级和混音目标
- Establish any adaptive audio rules (combat intensity, exploration, tension) / 建立任何自适应音频规则（战斗强度、探索、紧张度）

### Step 2: Sound Design and Audio Accessibility (parallel) / 步骤 2：声音设计与音频无障碍（并行）
Spawn the `sound-designer` agent to: / 派生 `sound-designer` 代理以：
- Create detailed SFX specifications for every audio event / 为每个音频事件创建详细的音效规格
- Define sound categories (ambient, UI, gameplay, music, dialogue) / 定义声音类别（环境、UI、游戏玩法、音乐、对话）
- Specify per-sound parameters (volume range, pitch variation, attenuation) / 指定每个声音的参数（音量范围、音高变化、衰减）
- Plan audio event list with trigger conditions / 规划带触发条件的音频事件列表
- Define mixing groups and ducking rules / 定义混音组和闪避规则

Spawn the `accessibility-specialist` agent in parallel to: / 同时派生 `accessibility-specialist` 代理以：
- Identify which audio events carry critical gameplay information (damage received, enemy nearby, objective complete) and require visual alternatives for hearing-impaired players / 识别哪些音频事件承载关键游戏玩法信息（受到伤害、敌人附近、目标完成）并为听障玩家提供视觉替代方案
- Specify subtitle requirements: which audio events need captions, what text format, on-screen duration / 指定字幕要求：哪些音频事件需要字幕、什么文本格式、屏幕显示时长
- Check that no gameplay state is communicated by audio alone (all must have a visual fallback) / 检查是否没有仅通过音频传达的游戏状态（所有状态必须有视觉后备）
- Review the audio event list for any that could cause issues for players with auditory sensitivities (high-frequency alerts, sudden loud events) / 审查音频事件列表中可能对听觉敏感玩家造成问题的项目（高频警报、突然的响亮事件）
- Output: audio accessibility requirements list integrated into the audio event spec / 输出：集成到音频事件规格中的音频无障碍需求列表

### Step 3: Technical Implementation (parallel) / 步骤 3：技术实现（并行）
Spawn the `technical-artist` agent to: / 派生 `technical-artist` 代理以：
- Design the audio middleware integration (Wwise/FMOD/native) / 设计音频中间件集成（Wwise/FMOD/原生）
- Define audio bus structure and routing / 定义音频总线结构和路由
- Specify memory budgets for audio assets per platform / 指定每个平台的音频资产内存预算
- Plan streaming vs preloaded asset strategy / 规划流式加载与预加载资产策略
- Design any audio-reactive visual effects / 设计任何音频响应式视觉效果

Spawn the **primary engine specialist** in parallel (from `.codebuddy/docs/technical-preferences.md` Engine Specialists) to validate the integration approach: / 同时派生**主要引擎专家**（来自 `.codebuddy/docs/technical-preferences.md` 引擎专家部分）以验证集成方案：
- Is the proposed audio middleware integration idiomatic for the engine? (e.g., Godot's built-in AudioStreamPlayer vs FMOD, Unity's Audio Mixer vs Wwise, Unreal's MetaSounds vs FMOD) / 提议的音频中间件集成是否符合引擎惯例？（如 Godot 内置 AudioStreamPlayer vs FMOD、Unity Audio Mixer vs Wwise、Unreal MetaSounds vs FMOD）
- Any engine-specific audio node/component patterns that should be used? / 是否有应使用的引擎特定音频节点/组件模式？
- Known audio system changes in the pinned engine version that affect the integration plan? / 固定引擎版本中影响集成计划的已知音频系统变更？
- Output: engine audio integration notes to merge with the technical-artist's plan / 输出：引擎音频集成说明，与技术美术的计划合并

If no engine is configured, skip the specialist spawn. / 如果未配置引擎，跳过专家派生。

### Step 4: Code Integration (gameplay-programmer) / 步骤 4：代码集成（gameplay-programmer）
Spawn the `gameplay-programmer` agent to: / 派生 `gameplay-programmer` 代理以：
- Implement audio manager system or review existing / 实现音频管理器系统或审查现有系统
- Wire up audio events to gameplay triggers / 将音频事件连接到游戏玩法触发器
- Implement adaptive music system (if specified) / 实现自适应音乐系统（如已指定）
- Set up audio occlusion/reverb zones / 设置音频遮挡/混响区域
- Write unit tests for audio event triggers / 为音频事件触发器编写单元测试

4. **Compile the audio design document** combining all team outputs. / **编译音频设计文档**，合并所有团队输出。

5. **Save to** `design/gdd/audio-[feature].md`. / **保存到** `design/gdd/audio-[feature].md`。

6. **Output a summary** with: audio event count, estimated asset count, implementation tasks, and any open questions between team members. / **输出摘要**，包含：音频事件数、估算资产数、实现任务和团队成员之间的任何开放问题。

Verdict: **COMPLETE** — audio design document produced and team pipeline finished.

> **中文翻译**：裁决：**COMPLETE** — 音频设计文档已生成，团队管线完成。

If the pipeline stops because a dependency is unresolved (e.g., critical accessibility gap or missing GDD not resolved by the user):

> **中文翻译**：如果管线因依赖未解决而停止（如关键无障碍差距或缺失 GDD 未被用户解决）：

Verdict: **BLOCKED** — [reason]

> **中文翻译**：裁决：**BLOCKED** — [原因]

## File Write Protocol / 文件写入协议

All file writes (audio design docs, SFX specs, implementation files) are delegated
to sub-agents spawned via Task. Each sub-agent enforces the "May I write to [path]?"
protocol. This orchestrator does not write files directly.

> **中文翻译**：所有文件写入（音频设计文档、音效规格、实现文件）委托给通过 Task 派生的子代理。每个子代理执行"我可以写入到 [路径] 吗？"协议。此编排器不直接写入文件。

## Next Steps / 后续步骤

- Review the audio design doc with the audio-director before implementation begins. / 在实现开始前与 audio-director 一起审查音频设计文档。
- Use `/dev-story` to implement the audio manager and event system once the design is approved. / 设计批准后使用 `/dev-story` 实现音频管理器和事件系统。
- Run `/asset-audit` after audio assets are created to verify naming and format compliance. / 音频资产创建后运行 `/asset-audit` 验证命名和格式合规性。

## Error Recovery Protocol / 错误恢复协议

If any spawned agent (via Task) returns BLOCKED, errors, or cannot complete:

> **中文翻译**：如果任何派生的代理（通过 Task）返回 BLOCKED、错误或无法完成：

1. **Surface immediately**: Report "[AgentName]: BLOCKED — [reason]" to the user before continuing to dependent phases / **立即报告**：在继续依赖阶段之前向用户报告"[代理名]：BLOCKED — [原因]"
2. **Assess dependencies**: Check whether the blocked agent's output is required by subsequent phases. If yes, do not proceed past that dependency point without user input. / **评估依赖**：检查被阻塞代理的输出是否为后续阶段所需。如果是，未经用户输入不要超过该依赖点。
3. **Offer options** via AskUserQuestion with choices: / 通过 AskUserQuestion **提供选项**：
   - Skip this agent and note the gap in the final report / 跳过此代理并在最终报告中记录差距
   - Retry with narrower scope / 以更窄的范围重试
   - Stop here and resolve the blocker first / 在此停止并先解决阻塞问题
4. **Always produce a partial report** — output whatever was completed. Never discard work because one agent blocked. / **始终生成部分报告** — 输出已完成的内容。绝不因一个代理阻塞而丢弃工作。

Common blockers: / 常见阻塞：
- Input file missing (story not found, GDD absent) → redirect to the skill that creates it / 输入文件缺失（故事未找到、GDD 缺失）→ 重定向到创建它的技能
- ADR status is Proposed → do not implement; run `/architecture-decision` first / ADR 状态为 Proposed → 不要实现；先运行 `/architecture-decision`
- Scope too large → split into two stories via `/create-stories` / 范围太大 → 通过 `/create-stories` 拆分为两个故事
- Conflicting instructions between ADR and story → surface the conflict, do not guess / ADR 和故事之间指令冲突 → 展示冲突，不要猜测
