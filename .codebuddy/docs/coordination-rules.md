# Agent Coordination Rules / 代理协调规则

1. **Vertical Delegation / 垂直委派**: Leadership agents delegate to department leads, who
   领导代理委派给部门负责人，部门负责人
   delegate to specialists. Never skip a tier for complex decisions.
   委派给专家。对于复杂决策，切勿跳过层级。
2. **Horizontal Consultation / 横向咨询**: Agents at the same tier may consult each other
   同一层级的代理可以相互咨询
   but must not make binding decisions outside their domain.
   但不得在其领域之外做出具有约束力的决策。
3. **Conflict Resolution / 冲突解决**: When two agents disagree, escalate to the shared
   当两个代理意见不合时，上报给共同的
   parent. If no shared parent, escalate to `creative-director` for design
   父级。如果没有共同父级，设计冲突上报给 `creative-director`，
   conflicts or `technical-director` for technical conflicts.
   技术冲突上报给 `technical-director`。
4. **Change Propagation / 变更传播**: When a design change affects multiple domains, the
   当设计变更影响多个领域时，
   `producer` agent coordinates the propagation.
   `producer` 代理协调传播。
5. **No Unilateral Cross-Domain Changes / 禁止单方面跨领域变更**: An agent must never modify files
   代理绝不能修改
   outside its designated directories without explicit delegation.
   其指定目录之外的文件，除非有明确委派。

## Model Tier Assignment / 模型层级分配

Skills and agents are assigned to model tiers based on task complexity: / 技能和代理根据任务复杂性分配到模型层级：

| Tier / 层级 | Model / 模型 | When to use / 何时使用 |
|------|-------|-------------|
| **Haiku** | `MiniMax-M2.7​` | Read-only status checks, formatting, simple lookups — no creative judgment needed / 只读状态检查、格式化、简单查找 — 无需创意判断 |
| **Sonnet** | `DeepSeek-V3.2` | Implementation, design authoring, analysis of individual systems — default for most work / 实现、设计编写、单个系统分析 — 大多数工作的默认选择 |
| **Opus** | `GLM-5.1` | Multi-document synthesis, high-stakes phase gate verdicts, cross-system holistic review / 多文档综合、高风险阶段关卡裁决、跨系统整体审查 |

Skills with `model: haiku`: `/help`, `/sprint-status`, `/story-readiness`, `/scope-check`,
带有 `model: haiku` 的技能：`/help`, `/sprint-status`, `/story-readiness`, `/scope-check`,
`/project-stage-detect`, `/changelog`, `/patch-notes`, `/onboard`

Skills with `model: opus`: `/review-all-gdds`, `/architecture-review`, `/gate-check`
带有 `model: opus` 的技能：`/review-all-gdds`, `/architecture-review`, `/gate-check`

All other skills default to DeepSeek-V3.2. When creating new skills, assign Haiku if the
所有其他技能默认为 DeepSeek-V3.2。创建新技能时，如果
skill only reads and formats; assign Opus if it must synthesize 5+ documents with
技能只读取和格式化，则分配 Haiku；如果必须综合 5+ 个文档并
high-stakes output; otherwise leave unset (DeepSeek-V3.2).
产生高风险输出，则分配 Opus；否则保持未设置（DeepSeek-V3.2）。

## Subagents vs Agent Teams / 子代理与代理团队

This project uses two distinct multi-agent patterns: / 本项目使用两种不同的多代理模式：

### Subagents (current, always active) / 子代理（当前，始终激活）
Spawned via `Task` within a single Claude Code session. Used by all `team-*` skills
通过 `Task` 在单个 Claude Code 会话中生成。所有 `team-*` 技能
and orchestration skills. Subagents share the session's permission context, run
和编排技能使用。子代理共享会话的权限上下文，
sequentially or in parallel within the session, and return results to the parent.
在会话中顺序或并行运行，并将结果返回给父级。

**When to spawn in parallel / 何时并行生成**: If two subagents' inputs are independent (neither
如果两个子代理的输入是独立的（两者都不
needs the other's output to begin), spawn both Task calls simultaneously rather
需要对方的输出才能开始），则同时生成两个 Task 调用，而非
than waiting. Example: `/review-all-gdds` Phase 1 (consistency) and Phase 2
等待。示例：`/review-all-gdds` 阶段 1（一致性）和阶段 2
(design theory) are independent — spawn both at the same time.
（设计理论）是独立的 — 同时生成两者。

### Agent Teams (experimental — opt-in) / 代理团队（实验性 — 选择性加入）
Multiple independent Claude Code *sessions* running simultaneously, coordinated
多个独立的 Claude Code *会话* 同时运行，通过
via a shared task list. Each session has its own context window and token budget.
共享任务列表协调。每个会话有自己的上下文窗口和令牌预算。
Requires `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1` environment variable.
需要 `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1` 环境变量。

**Use agent teams when / 何时使用代理团队**:
- Work spans multiple subsystems that will not touch the same files / 工作跨越不会触及相同文件的多个子系统
- Each workstream would take >30 minutes and benefits from true parallelism / 每个工作流需要 >30 分钟，并从真正的并行性中受益
- A senior agent (technical-director, producer) needs to coordinate 3+ specialist
  高级代理（technical-director、producer）需要协调 3+ 个专家
  sessions working on different epics simultaneously
  同时处理不同史诗的会话

**Do not use agent teams when / 何时不使用代理团队**:
- One session's output is required as input for another (use sequential subagents) / 一个会话的输出需要作为另一个的输入（使用顺序子代理）
- The task fits in a single session's context (use subagents instead) / 任务适合单个会话的上下文（改用子代理）
- Cost is a concern — each team member burns tokens independently / 成本是考虑因素 — 每个团队成员独立消耗令牌

**Current status**: Not yet used in this project. Document usage here when first adopted.
**当前状态**: 尚未在本项目中使用。首次采用时在此记录使用情况。

## Parallel Task Protocol / 并行任务协议

When an orchestration skill spawns multiple independent agents: / 当编排技能生成多个独立代理时：

1. Issue all independent Task calls before waiting for any result / 在等待任何结果之前发出所有独立的 Task 调用
2. Collect all results before proceeding to dependent phases / 收集所有结果后再进入依赖阶段
3. If any agent is BLOCKED, surface it immediately — do not silently skip / 如果任何代理被阻塞，立即显示 — 不要静默跳过
4. Always produce a partial report if some agents complete and others block / 如果某些代理完成而其他代理阻塞，始终生成部分报告
