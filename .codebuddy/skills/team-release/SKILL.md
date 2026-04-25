---
name: team-release
description: "Orchestrate the release team: coordinates release-manager, qa-lead, devops-engineer, and producer to execute a release from candidate to deployment. / 编排发布团队：协调 release-manager、qa-lead、devops-engineer 和 producer 从候选版本到部署执行发布。"
argument-hint: "[version number or 'next']"
user-invocable: true
allowed-tools: Read, Glob, Grep, Write, Edit, Bash, Task, AskUserQuestion, TodoWrite
---
**Argument check:** If no version number is provided:
1. Read `production/session-state/active.md` and the most recent file in `production/milestones/` (if they exist) to infer the target version.
2. If a version is found: report "No version argument provided — inferred [version] from milestone data. Proceeding." Then confirm with `AskUserQuestion`: "Releasing [version]. Is this correct?"
3. If no version is discoverable: use `AskUserQuestion` to ask "What version number should be released? (e.g., v1.0.0)" and wait for user input before proceeding. Do NOT default to a hardcoded version string.

> **中文翻译**：**参数检查**：如果未提供版本号：
> 1. 读取 `production/session-state/active.md` 和 `production/milestones/` 中的最新文件（如果存在）以推断目标版本
> 2. 如果找到版本：报告"未提供版本参数 — 从里程碑数据推断出[版本]。继续。"然后通过 `AskUserQuestion` 确认："正在发布[版本]。这正确吗？"
> 3. 如果无法发现版本：使用 `AskUserQuestion` 询问"应该发布什么版本号？（例如，v1.0.0）"并在继续前等待用户输入。不要默认使用硬编码版本字符串。

When this skill is invoked, orchestrate the release team through a structured pipeline.

> **中文翻译**：当调用此技能时，通过结构化管道编排发布团队。

**Decision Points:** At each phase transition, use `AskUserQuestion` to present
the user with the subagent's proposals as selectable options. Write the agent's
full analysis in conversation, then capture the decision with concise labels.
The user must approve before moving to the next phase.

> **中文翻译**：**决策点**：在每个阶段转换时，使用 `AskUserQuestion` 向用户呈现子代理的提案作为可选选项。在对话中写入代理的完整分析，然后用简洁的标签捕获决策。用户必须在进入下一阶段前批准。

## Team Composition / 团队组成
- **release-manager** — Release branch, versioning, changelog, deployment / 发布分支、版本控制、变更日志、部署
- **qa-lead** — Test sign-off, regression suite, release quality gate / 测试签署、回归测试套件、发布质量门控
- **devops-engineer** — Build pipeline, artifacts, deployment automation / 构建管道、构件、部署自动化
- **security-engineer** — Pre-release security audit (invoke if game has online/multiplayer features or player data) / 发布前安全审计（如果游戏有在线/多人功能或玩家数据则调用）
- **analytics-engineer** — Verify telemetry events fire correctly and dashboards are live / 验证遥测事件正确触发且仪表板正常运行
- **community-manager** — Patch notes, launch announcement, player-facing messaging / 补丁说明、发布公告、面向玩家的消息
- **producer** — Go/no-go decision, stakeholder communication, scheduling / 前进/停止决策、利益相关者沟通、计划安排

## How to Delegate / 如何委派

Use the Task tool to spawn each team member as a subagent:
- `subagent_type: release-manager` — Release branch, versioning, changelog, deployment / 发布分支、版本控制、变更日志、部署
- `subagent_type: qa-lead` — Test sign-off, regression suite, release quality gate / 测试签署、回归测试套件、发布质量门控
- `subagent_type: devops-engineer` — Build pipeline, artifacts, deployment automation / 构建管道、构件、部署自动化
- `subagent_type: security-engineer` — Security audit for online/multiplayer/data features / 在线/多人/数据功能的安全审计
- `subagent_type: analytics-engineer` — Telemetry event verification and dashboard readiness / 遥测事件验证和仪表板准备状态
- `subagent_type: community-manager` — Patch notes and launch communication / 补丁说明和发布沟通
- `subagent_type: producer` — Go/no-go decision, stakeholder communication / 前进/停止决策、利益相关者沟通
- `subagent_type: network-programmer` — Netcode stability sign-off (invoke if game has multiplayer) / 网络代码稳定性签署（如果游戏有多人功能则调用）

Always provide full context in each agent's prompt (version number, milestone status, known issues). Launch independent agents in parallel where the pipeline allows it (e.g., Phase 3 agents can run simultaneously).

> **中文翻译**：始终在每个代理的提示中提供完整上下文（版本号、里程碑状态、已知问题）。在管道允许的情况下并行启动独立代理（例如，第 3 阶段代理可以同时运行）。

## Pipeline / 管道

### Phase 1: Release Planning / 第 1 阶段：发布计划
Delegate to **producer**:
- Confirm all milestone acceptance criteria are met / 确认所有里程碑验收标准都已满足
- Identify any scope items deferred from this release / 识别从此版本中推迟的任何范围项
- Set the target release date and communicate to team / 设置目标发布日期并与团队沟通
- Output: release authorization with scope confirmation / 输出：带范围确认的发布授权

### Phase 2: Release Candidate / 第 2 阶段：发布候选版本
Delegate to **release-manager**:
- Cut release branch from the agreed commit / 从商定的提交创建发布分支
- Bump version numbers in all relevant files / 增加所有相关文件中的版本号
- Generate the release checklist using `/release-checklist` / 使用 `/release-checklist` 生成发布检查清单
- Freeze the branch — no feature changes, bug fixes only / 冻结分支 — 无功能更改，仅错误修复
- Output: release branch name and checklist / 输出：发布分支名称和检查清单

### Phase 3: Quality Gate (parallel) / 第 3 阶段：质量门控（并行）
Delegate in parallel:
- **qa-lead**: Execute full regression test suite. Test all critical paths. Verify no S1/S2 bugs. Sign off on quality. / 执行完整回归测试套件。测试所有关键路径。验证没有 S1/S2 错误。签署质量。
- **devops-engineer**: Build release artifacts for all target platforms. Verify builds are clean and reproducible. Run automated tests in CI. / 为所有目标平台构建发布构件。验证构建干净且可重现。在 CI 中运行自动化测试。
- **security-engineer** *(if game has online features, multiplayer, or player data)*: Conduct pre-release security audit. Review authentication, anti-cheat, data privacy compliance. Sign off on security posture. / 进行发布前安全审计。审查身份验证、反作弊、数据隐私合规性。签署安全态势。
- **network-programmer** *(if game has multiplayer)*: Sign off on netcode stability. Verify lag compensation, reconnect handling, and bandwidth usage under load. / 签署网络代码稳定性。验证延迟补偿、重新连接处理和高负载下的带宽使用。

### Phase 4: Localization, Performance, and Analytics / 第 4 阶段：本地化、性能和分析
Delegate (can run in parallel with Phase 3 if resources available):
- Verify all strings are translated (delegate to **localization-lead** if available) / 验证所有字符串已翻译（如果可用，委派给 **localization-lead**）
- Run performance benchmarks against targets (delegate to **performance-analyst** if available) / 针对目标运行性能基准测试（如果可用，委派给 **performance-analyst**）
- **analytics-engineer**: Verify all telemetry events fire correctly on release build. Confirm dashboards are receiving data. Check that critical funnels (onboarding, progression, monetization if applicable) are instrumented. / 验证所有遥测事件在发布构建上正确触发。确认仪表板正在接收数据。检查关键漏斗（入门、进度、如果适用的货币化）是否已插装。
- Output: localization, performance, and analytics sign-off / 输出：本地化、性能和分析签署

### Phase 5: Go/No-Go / 第 5 阶段：前进/停止
Delegate to **producer**:
- Collect sign-off from: qa-lead, release-manager, devops-engineer, security-engineer (if spawned in Phase 3), network-programmer (if spawned in Phase 3), and technical-director / 收集以下人员的签署：qa-lead、release-manager、devops-engineer、security-engineer（如果在第 3 阶段生成）、network-programmer（如果在第 3 阶段生成）和 technical-director
- Evaluate any open issues — are they blocking or can they ship? / 评估任何未解决的问题 — 它们是阻碍还是可以发布？
- Make the go/no-go call / 做出前进/停止决定
- Output: release decision with rationale / 输出：带理由的发布决策

> **中文翻译**：**如果 producer 宣布 NO-GO（停止）：**
> - 立即呈现决策："PRODUCER: NO-GO — [理由，例如，在第 3 阶段发现的 S1 错误]。"
> - 使用带选项的 `AskUserQuestion`：
>   - 修复阻碍并重新运行受影响阶段
>   - 将发布推迟到稍后日期
>   - 用记录的理由覆盖 NO-GO（用户必须提供书面理由）
> - **完全跳过第 6 阶段** — 不要标记、部署到暂存、部署到生产或生成 community-manager。
> - 生成部分报告，总结第 1-5 阶段以及跳过的内容（第 6 阶段）及原因。
> - 裁决：**BLOCKED** — 发布未部署。

### Phase 6: Deployment (if GO) / 第 6 阶段：部署（如果前进）
Delegate to **release-manager** + **devops-engineer**:
- Tag the release in version control / 在版本控制中标记发布
- Generate changelog using `/changelog` / 使用 `/changelog` 生成变更日志
- Deploy to staging for final smoke test / 部署到暂存进行最终冒烟测试
- Deploy to production / 部署到生产环境
- Monitor for 48 hours post-release / 发布后监控 48 小时

Delegate to **community-manager** (in parallel with deployment):
- Finalize patch notes using `/patch-notes [version]` / 使用 `/patch-notes [version]` 完成补丁说明
- Prepare launch announcement (store page updates, social media, community post) / 准备发布公告（商店页面更新、社交媒体、社区帖子）
- Draft known issues post if any S3+ issues shipped / 如果有任何 S3+ 问题发布，起草已知问题帖子
- Output: all player-facing release communication, ready to publish on deploy confirmation / 输出：所有面向玩家的发布沟通，准备在部署确认后发布

### Phase 7: Post-Release / 第 7 阶段：发布后
- **release-manager**: Generate release report (what shipped, what was deferred, metrics) / 生成发布报告（发布了什么、推迟了什么、指标）
- **producer**: Update milestone tracking, communicate to stakeholders / 更新里程碑跟踪，与利益相关者沟通
- **qa-lead**: Monitor incoming bug reports for regressions / 监控传入的错误报告以发现回归
- **community-manager**: Publish all player-facing communication, monitor community sentiment / 发布所有面向玩家的沟通，监控社区情绪
- **analytics-engineer**: Confirm live dashboards are healthy; alert if any critical events are missing / 确认实时仪表板健康；如果缺少任何关键事件则发出警报
- Schedule post-release retrospective if issues occurred / 如果出现问题，安排发布后回顾

## Error Recovery Protocol / 错误恢复协议

If any spawned agent (via Task) returns BLOCKED, errors, or cannot complete:

> **中文翻译**：如果任何生成的代理（通过 Task）返回 BLOCKED、错误或无法完成：

1. **Surface immediately**: Report "[AgentName]: BLOCKED — [reason]" to the user before continuing to dependent phases / 立即呈现：在继续依赖阶段之前向用户报告"[AgentName]: BLOCKED — [原因]"
2. **Assess dependencies**: Check whether the blocked agent's output is required by subsequent phases. If yes, do not proceed past that dependency point without user input. / 评估依赖项：检查被阻止代理的输出是否被后续阶段需要。如果是，在没有用户输入的情况下不要继续超过该依赖点。
3. **Offer options** via AskUserQuestion with choices:
   - Skip this agent and note the gap in the final report / 跳过此代理并在最终报告中注明差距
   - Retry with narrower scope / 使用更窄的范围重试
   - Stop here and resolve the blocker first / 停止此处并首先解决阻碍
4. **Always produce a partial report** — output whatever was completed. Never discard work because one agent blocked. / 始终生成部分报告 — 输出已完成的内容。不要因为一个代理被阻止而丢弃工作。

> **中文翻译**：**常见阻碍**：
> - 输入文件缺失（未找到故事，GDD 缺失） → 重定向到创建它的技能
> - ADR 状态为 Proposed → 不要实现；先运行 `/architecture-decision`
> - 范围太大 → 通过 `/create-stories` 拆分为两个故事
> - ADR 和故事之间的冲突指令 → 呈现冲突，不要猜测

## File Write Protocol / 文件写入协议

All file writes (release checklists, changelogs, patch notes, deployment scripts) are
delegated to sub-agents and sub-skills. Each enforces the "May I write to [path]?"
protocol. This orchestrator does not write files directly.

> **中文翻译**：所有文件写入（发布检查清单、变更日志、补丁说明、部署脚本）都委派给子代理和子技能。每个都强制执行"我可以写入[路径]吗？"协议。此编排器不直接写入文件。

## Output / 输出

A summary report covering: release version, scope, quality gate results, go/no-go decision, deployment status, and monitoring plan.

> **中文翻译**：涵盖以下内容的摘要报告：发布版本、范围、质量门控结果、前进/停止决策、部署状态和监控计划。

Verdict: **COMPLETE** — release executed and deployed. / 裁决：**COMPLETE** — 发布已执行并部署。
Verdict: **BLOCKED** — release halted; go/no-go was NO or a hard blocker is unresolved. / 裁决：**BLOCKED** — 发布已停止；前进/停止为 NO 或硬阻碍未解决。

## Next Steps / 下一步

- Monitor post-release dashboards for 48 hours. / 监控发布后仪表板 48 小时。
- Run `/retrospective` if significant issues occurred during the release. / 如果发布期间出现重大问题，运行 `/retrospective`。
- Update `production/stage.txt` to `Live` after successful deployment. / 成功部署后更新 `production/stage.txt` 为 `Live`。
