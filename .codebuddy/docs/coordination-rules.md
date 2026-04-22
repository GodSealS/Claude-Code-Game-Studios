# Agent Coordination Rules / 代理协调规则

1. **Vertical Delegation**: Leadership agents delegate to department leads, who
   delegate to specialists. Never skip a tier for complex decisions.
   > **中文翻译**：**垂直委派**：领导层代理委派给部门主管，部门主管委派给专家。对于复杂决策，永远不要跳过层级。
2. **Horizontal Consultation**: Agents at the same tier may consult each other
   but must not make binding decisions outside their domain.
   > **中文翻译**：**水平协商**：同层级的代理可以相互协商，但不得在其领域之外做出约束性决策。
3. **Conflict Resolution**: When two agents disagree, escalate to the shared
   parent. If no shared parent, escalate to `creative-director` for design
   conflicts or `technical-director` for technical conflicts.
   > **中文翻译**：**冲突解决**：当两个代理意见不一致时，升级到共同上级。如果没有共同上级，设计冲突升级到 `creative-director`，技术冲突升级到 `technical-director`。
4. **Change Propagation**: When a design change affects multiple domains, the
   `producer` agent coordinates the propagation.
   > **中文翻译**：**变更传播**：当设计变更影响多个领域时，`producer` 代理协调传播。
5. **No Unilateral Cross-Domain Changes**: An agent must never modify files
   outside its designated directories without explicit delegation.
   > **中文翻译**：**禁止单方面跨领域变更**：代理不得在未经明确委派的情况下修改其指定目录之外的文件。

## Model Tier Assignment / 模型层级分配

Skills and agents are assigned to model tiers based on task complexity:

> **中文翻译**：技能和代理根据任务复杂度被分配到模型层级：

| Tier | Model | When to use |
|------|-------|-------------|
| **Haiku** | `MiniMax-M2.7​` | Read-only status checks, formatting, simple lookups — no creative judgment needed |
| **Sonnet** | `DeepSeek-V3.2` | Implementation, design authoring, analysis of individual systems — default for most work |
| **Opus** | `GLM-5.1` | Multi-document synthesis, high-stakes phase gate verdicts, cross-system holistic review |

> **中文翻译**：

| 层级 | 模型 | 何时使用 |
|------|------|----------|
| **Haiku** | `MiniMax-M2.7​` | 只读状态检查、格式化、简单查找 — 不需要创意判断 |
| **Sonnet** | `DeepSeek-V3.2` | 实现、设计编写、单个系统分析 — 大多数工作的默认选择 |
| **Opus** | `GLM-5.1` | 多文档综合、高风险阶段门控裁决、跨系统整体审查 |

Skills with `model: haiku`: `/help`, `/sprint-status`, `/story-readiness`, `/scope-check`,
`/project-stage-detect`, `/changelog`, `/patch-notes`, `/onboard`

> **中文翻译**：使用 `model: haiku` 的技能：`/help`、`/sprint-status`、`/story-readiness`、`/scope-check`、`/project-stage-detect`、`/changelog`、`/patch-notes`、`/onboard`

Skills with `model: opus`: `/review-all-gdds`, `/architecture-review`, `/gate-check`

> **中文翻译**：使用 `model: opus` 的技能：`/review-all-gdds`、`/architecture-review`、`/gate-check`

All other skills default to DeepSeek-V3.2. When creating new skills, assign Haiku if the
skill only reads and formats; assign Opus if it must synthesize 5+ documents with
high-stakes output; otherwise leave unset (DeepSeek-V3.2).

> **中文翻译**：所有其他技能默认为DeepSeek-V3.2。创建新技能时，如果技能仅读取和格式化，分配Haiku；如果需要综合5+文档且输出高风险，分配Opus；否则留空(DeepSeek-V3.2)。

## Subagents vs Agent Teams / 子代理 vs 代理团队

This project uses two distinct multi-agent patterns:

> **中文翻译**：本项目使用两种不同的多代理模式：

### Subagents (current, always active) / 子代理（当前，始终活跃）
Spawned via `Task` within a single Claude Code session. Used by all `team-*` skills
and orchestration skills. Subagents share the session's permission context, run
sequentially or in parallel within the session, and return results to the parent.

> **中文翻译**：通过单个Claude Code会话中的 `Task` 生成。所有 `team-*` 技能和编排技能都使用。子代理共享会话的权限上下文，在会话内顺序或并行运行，并将结果返回给父级。

**When to spawn in parallel**: If two subagents' inputs are independent (neither
needs the other's output to begin), spawn both Task calls simultaneously rather
than waiting. Example: `/review-all-gdds` Phase 1 (consistency) and Phase 2
(design theory) are independent — spawn both at the same time.

> **中文翻译**：**何时并行生成**：如果两个子代理的输入是独立的（都不需要对方的输出才能开始），同时生成两个Task调用而不是等待。例如：`/review-all-gdds` 阶段1（一致性）和阶段2（设计理论）是独立的 — 同时生成两者。

### Agent Teams (experimental — opt-in) / 代理团队（实验性 — 选择启用）
Multiple independent Claude Code *sessions* running simultaneously, coordinated
via a shared task list. Each session has its own context window and token budget.
Requires `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1` environment variable.

> **中文翻译**：多个独立的Claude Code *会话* 同时运行，通过共享任务列表协调。每个会话有自己的上下文窗口和token预算。需要 `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1` 环境变量。

**Use agent teams when**:
- Work spans multiple subsystems that will not touch the same files
- Each workstream would take >30 minutes and benefits from true parallelism
- A senior agent (technical-director, producer) needs to coordinate 3+ specialist
  sessions working on different epics simultaneously

> **中文翻译**：**何时使用代理团队**：
- 工作跨多个子系统且不会触碰相同文件
- 每个工作流需要>30分钟且受益于真正的并行
- 高级代理（technical-director、producer）需要协调3+个专家会话同时处理不同史诗

**Do not use agent teams when**:
- One session's output is required as input for another (use sequential subagents)
- The task fits in a single session's context (use subagents instead)
- Cost is a concern — each team member burns tokens independently

> **中文翻译**：**何时不使用代理团队**：
- 一个会话的输出是另一个的输入（使用顺序子代理）
- 任务适合单个会话的上下文（改用子代理）
- 成本是考虑因素 — 每个团队成员独立消耗token

**Current status**: Not yet used in this project. Document usage here when first adopted.

> **中文翻译**：**当前状态**：尚未在本项目中使用。首次采用时在此记录使用情况。

## Parallel Task Protocol / 并行任务协议

When an orchestration skill spawns multiple independent agents:

> **中文翻译**：当编排技能生成多个独立代理时：

1. Issue all independent Task calls before waiting for any result
   > **中文翻译**：在等待任何结果之前发出所有独立的Task调用
2. Collect all results before proceeding to dependent phases
   > **中文翻译**：在进入依赖阶段之前收集所有结果
3. If any agent is BLOCKED, surface it immediately — do not silently skip
   > **中文翻译**：如果任何代理被阻塞，立即上报 — 不要静默跳过
4. Always produce a partial report if some agents complete and others block
   > **中文翻译**：如果部分代理完成而其他代理阻塞，始终生成部分报告
