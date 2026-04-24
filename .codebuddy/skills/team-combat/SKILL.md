---
name: team-combat
description: "Orchestrate the combat team: coordinates game-designer, gameplay-programmer, ai-programmer, technical-artist, sound-designer, and qa-tester to design, implement, and validate a combat feature end-to-end. / 编排战斗团队：协调 game-designer、gameplay-programmer、ai-programmer、technical-artist、sound-designer 和 qa-tester 端到端设计、实现和验证战斗功能。"
argument-hint: "[combat feature description]"
user-invocable: true
allowed-tools: Read, Glob, Grep, Write, Edit, Bash, Task, AskUserQuestion, TodoWrite
---
**Argument check:** If no combat feature description is provided, output:
> "Usage: `/team-combat [combat feature description]` — Provide a description of the combat feature to design and implement (e.g., `melee parry system`, `ranged weapon spread`)."
Then stop immediately without spawning any subagents or reading any files.

> **中文翻译**：**参数检查：** 如果未提供战斗功能描述，输出：
> 用法：`/team-combat [战斗功能描述]` — 提供要设计和实现的战斗功能描述（如 `melee parry system`、`ranged weapon spread`）。
> 然后立即停止，不派生任何子代理或读取任何文件。

When this skill is invoked with a valid argument, orchestrate the combat team through a structured pipeline.

> **中文翻译**：当此技能带有效参数调用时，通过结构化管线编排战斗团队。

**Decision Points:** At each phase transition, use `AskUserQuestion` to present
the user with the subagent's proposals as selectable options. Write the agent's
full analysis in conversation, then capture the decision with concise labels.
The user must approve before moving to the next phase.

> **中文翻译**：**决策点：** 在每个阶段转换时，使用 `AskUserQuestion` 向用户展示子代理的提案作为可选选项。在对话中写入代理的完整分析，然后用简洁的标签捕获决策。用户必须在进入下一阶段之前批准。

## Team Composition / 团队组成
- **game-designer** — Design the mechanic, define formulas and edge cases / 设计机制，定义公式和边界情况
- **gameplay-programmer** — Implement the core gameplay code / 实现核心游戏玩法代码
- **ai-programmer** — Implement NPC/enemy AI behavior for the feature / 实现该功能的 NPC/敌人 AI 行为
- **technical-artist** — Create VFX, shader effects, and visual feedback / 创建视觉效果、着色器效果和视觉反馈
- **sound-designer** — Define audio events, impact sounds, and ambient combat audio / 定义音频事件、冲击音效和环境战斗音频
- **engine specialist** (primary) — Validate architecture and implementation patterns are idiomatic for the engine (read from `.codebuddy/docs/technical-preferences.md` Engine Specialists section) / （主要）引擎专家 — 验证架构和实现模式符合引擎惯例（从 `.codebuddy/docs/technical-preferences.md` 引擎专家部分读取）
- **qa-tester** — Write test cases and validate the implementation / 编写测试用例并验证实现

## How to Delegate / 如何委托

Use the Task tool to spawn each team member as a subagent:

> **中文翻译**：使用 Task 工具将每个团队成员作为子代理派生：

- `subagent_type: game-designer` — Design the mechanic, define formulas and edge cases / 设计机制，定义公式和边界情况
- `subagent_type: gameplay-programmer` — Implement the core gameplay code / 实现核心游戏玩法代码
- `subagent_type: ai-programmer` — Implement NPC/enemy AI behavior / 实现 NPC/敌人 AI 行为
- `subagent_type: technical-artist` — Create VFX, shader effects, visual feedback / 创建视觉效果、着色器效果、视觉反馈
- `subagent_type: sound-designer` — Define audio events, impact sounds, ambient audio / 定义音频事件、冲击音效、环境音频
- `subagent_type: [primary engine specialist]` — Engine idiom validation for architecture and implementation / 架构和实现的引擎惯例验证
- `subagent_type: qa-tester` — Write test cases and validate implementation / 编写测试用例并验证实现

Always provide full context in each agent's prompt (design doc path, relevant code files, constraints). Launch independent agents in parallel where the pipeline allows it (e.g., Phase 3 agents can run simultaneously).

> **中文翻译**：始终在每个代理的提示中提供完整上下文（设计文档路径、相关代码文件、约束）。在管线允许的情况下并行启动独立代理（如第 3 阶段代理可同时运行）。

## Pipeline / 管线

### Phase 1: Design / 第 1 阶段：设计
Delegate to **game-designer**: / 委托给 **game-designer**：
- Create or update the design document in `design/gdd/` covering: mechanic overview, player fantasy, detailed rules, formulas with variable definitions, edge cases, dependencies, tuning knobs with safe ranges, and acceptance criteria / 在 `design/gdd/` 中创建或更新设计文档，涵盖：机制概述、玩家幻想、详细规则、带变量定义的公式、边界情况、依赖关系、带安全范围的调优旋钮和验收标准
- Output: completed design document / 输出：完成的设计文档

### Phase 2: Architecture / 第 2 阶段：架构
Delegate to **gameplay-programmer** (with **ai-programmer** if AI is involved): / 委托给 **gameplay-programmer**（如涉及 AI 则加上 **ai-programmer**）：
- Review the design document / 审查设计文档
- Design the code architecture: class structure, interfaces, data flow / 设计代码架构：类结构、接口、数据流
- Identify integration points with existing systems / 识别与现有系统的集成点
- Output: architecture sketch with file list and interface definitions / 输出：带文件列表和接口定义的架构草图

Then spawn the **primary engine specialist** to validate the proposed architecture: / 然后派生**主要引擎专家**验证提议的架构：
- Is the class/node/component structure idiomatic for the pinned engine? (e.g., Godot node hierarchy, Unity MonoBehaviour vs DOTS, Unreal Actor/Component design) / 类/节点/组件结构是否符合固定引擎的惯例？（如 Godot 节点层次、Unity MonoBehaviour vs DOTS、Unreal Actor/Component 设计）
- Are there engine-native systems that should be used instead of custom implementations? / 是否有应使用的引擎原生系统而非自定义实现？
- Any proposed APIs that are deprecated or changed in the pinned engine version? / 固定引擎版本中是否有提议的 API 已弃用或更改？
- Output: engine architecture notes — incorporate into the architecture before Phase 3 begins / 输出：引擎架构说明 — 在第 3 阶段开始前纳入架构

### Phase 3: Implementation (parallel where possible) / 第 3 阶段：实现（尽可能并行）
Delegate in parallel: / 并行委托：
- **gameplay-programmer**: Implement core combat mechanic code / 实现核心战斗机制代码
- **ai-programmer**: Implement AI behaviors (if the feature involves NPC reactions) / 实现 AI 行为（如果功能涉及 NPC 反应）
- **technical-artist**: Create VFX and shader effects / 创建视觉效果和着色器效果
- **sound-designer**: Define audio event list and mixing notes / 定义音频事件列表和混音说明

### Phase 4: Integration / 第 4 阶段：集成
- Wire together gameplay code, AI, VFX, and audio / 将游戏玩法代码、AI、视觉效果和音频连接在一起
- Ensure all tuning knobs are exposed and data-driven / 确保所有调优旋钮都暴露且数据驱动
- Verify the feature works with existing combat systems / 验证功能与现有战斗系统协同工作

### Phase 5: Validation / 第 5 阶段：验证
Delegate to **qa-tester**: / 委托给 **qa-tester**：
- Write test cases from the acceptance criteria / 根据验收标准编写测试用例
- Test all edge cases documented in the design / 测试设计中记录的所有边界情况
- Verify performance impact is within budget / 验证性能影响在预算范围内
- File bug reports for any issues found / 为发现的任何问题提交缺陷报告

### Phase 6: Sign-off / 第 6 阶段：签署
- Collect results from all team members / 收集所有团队成员的结果
- Report feature status: COMPLETE / NEEDS WORK / BLOCKED / 报告功能状态：COMPLETE / NEEDS WORK / BLOCKED
- List any outstanding issues and their assigned owners / 列出任何未解决的问题及其分配的负责人

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

Common blockers: / 常见阻塞：
- Input file missing (story not found, GDD absent) → redirect to the skill that creates it / 输入文件缺失 → 重定向到创建它的技能
- ADR status is Proposed → do not implement; run `/architecture-decision` first / ADR 状态为 Proposed → 先运行 `/architecture-decision`
- Scope too large → split into two stories via `/create-stories` / 范围太大 → 通过 `/create-stories` 拆分
- Conflicting instructions between ADR and story → surface the conflict, do not guess / ADR 和故事之间指令冲突 → 展示冲突

## File Write Protocol / 文件写入协议

All file writes (design documents, implementation files, test cases) are
delegated to sub-agents spawned via Task. Each sub-agent enforces the
"May I write to [path]?" protocol. This orchestrator does not write files directly.

> **中文翻译**：所有文件写入委托给通过 Task 派生的子代理。每个子代理执行"我可以写入到 [路径] 吗？"协议。此编排器不直接写入文件。

## Output / 输出

A summary report covering: design completion status, implementation status per team member, test results, and any open issues.

> **中文翻译**：摘要报告涵盖：设计完成状态、每个团队成员的实现状态、测试结果和任何开放问题。

Verdict: **COMPLETE** — combat feature designed, implemented, and validated.
Verdict: **BLOCKED** — one or more phases could not complete; partial report produced with unresolved items listed.

> **中文翻译**：裁决：**COMPLETE** — 战斗功能已设计、实现和验证。裁决：**BLOCKED** — 一个或多个阶段无法完成；生成了包含未解决项目的部分报告。

## Next Steps / 后续步骤

- Run `/code-review` on the implemented combat code before closing stories. / 在关闭故事前对已实现的战斗代码运行 `/code-review`。
- Run `/balance-check` to validate combat formulas and tuning values. / 运行 `/balance-check` 验证战斗公式和调优值。
- Run `/team-polish` if VFX, audio, or performance polish is needed. / 如需视觉效果、音频或性能打磨，运行 `/team-polish`。
