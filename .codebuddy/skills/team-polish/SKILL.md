---
name: team-polish
description: "Orchestrate the polish team: coordinates performance-analyst, technical-artist, sound-designer, and qa-tester to optimize, polish, and harden a feature or area for release quality. / 编排打磨团队：协调 performance-analyst、technical-artist、sound-designer 和 qa-tester 优化、打磨和加固功能或区域至发布质量。"
argument-hint: "[feature or area to polish]"
user-invocable: true
allowed-tools: Read, Glob, Grep, Write, Edit, Bash, Task, AskUserQuestion, TodoWrite
---
If no argument is provided, output usage guidance and exit without spawning any agents:
> Usage: `/team-polish [feature or area]` — specify the feature or area to polish (e.g., `combat`, `main menu`, `inventory system`, `level-1`). Do not use `AskUserQuestion` here; output the guidance directly.
> **中文翻译**：如果未提供参数，输出用法指导并退出，不派生任何代理：
> 用法：`/team-polish [功能或区域]` — 指定要打磨的功能或区域（如 `combat`、`main menu`、`inventory system`、`level-1`）。此处不使用 `AskUserQuestion`；直接输出指导。

When this skill is invoked with an argument, orchestrate the polish team through a structured pipeline.
> **中文翻译**：当此技能带参数调用时，通过结构化管线编排打磨团队。

**Decision Points:** At each phase transition, use `AskUserQuestion` to present
the user with the subagent's proposals as selectable options. Write the agent's
full analysis in conversation, then capture the decision with concise labels.
The user must approve before moving to the next phase.
> **中文翻译**：**决策点：** 在每个阶段转换时，使用 `AskUserQuestion` 向用户展示子代理的提案作为可选选项。在对话中写入代理的完整分析，然后用简洁的标签捕获决策。用户必须在进入下一阶段之前批准。

## Team Composition / 团队组成
- **performance-analyst** — Profiling, optimization, memory analysis, frame budget / 性能分析、优化、内存分析、帧预算
- **engine-programmer** — Engine-level bottlenecks: rendering pipeline, memory, resource loading (invoke when performance-analyst identifies low-level root causes) / 引擎级瓶颈：渲染管线、内存、资源加载（当 performance-analyst 识别出底层根本原因时调用）
- **technical-artist** — VFX polish, shader optimization, visual quality / 视觉效果打磨、着色器优化、视觉质量
- **sound-designer** — Audio polish, mixing, ambient layers, feedback sounds / 音频打磨、混音、环境层、反馈音效
- **tools-programmer** — Content pipeline tool verification, editor tool stability, automation fixes (invoke when content authoring tools are involved in the polished area) / 内容管线工具验证、编辑器工具稳定性、自动化修复（当打磨区域涉及内容创作工具时调用）
- **qa-tester** — Edge case testing, regression testing, soak testing / 边缘情况测试、回归测试、浸泡测试

## How to Delegate / 如何委托

Use the Task tool to spawn each team member as a subagent:
> **中文翻译**：使用 Task 工具将每个团队成员作为子代理派生：

- `subagent_type: performance-analyst` — Profiling, optimization, memory analysis / 性能分析、优化、内存分析
- `subagent_type: engine-programmer` — Engine-level fixes for rendering, memory, resource loading / 渲染、内存、资源加载的引擎级修复
- `subagent_type: technical-artist` — VFX polish, shader optimization, visual quality / 视觉效果打磨、着色器优化、视觉质量
- `subagent_type: sound-designer` — Audio polish, mixing, ambient layers / 音频打磨、混音、环境层
- `subagent_type: tools-programmer` — Content pipeline and editor tool verification / 内容管线和编辑器工具验证
- `subagent_type: qa-tester` — Edge case testing, regression testing, soak testing / 边缘情况测试、回归测试、浸泡测试

Always provide full context in each agent's prompt (target feature/area, performance budgets, known issues). Launch independent agents in parallel where the pipeline allows it (e.g., Phases 3 and 4 can run simultaneously).
> **中文翻译**：始终在每个代理的提示中提供完整上下文（目标功能/区域、性能预算、已知问题）。在管线允许的情况下并行启动独立代理（如第 3 和 4 阶段可同时运行）。

## Pipeline / 管线

### Phase 1: Assessment / 第 1 阶段：评估
Delegate to **performance-analyst**: / 委托给 **performance-analyst**：
- Profile the target feature/area using `/perf-profile` / 使用 `/perf-profile` 分析目标功能/区域
- Identify performance bottlenecks and frame budget violations / 识别性能瓶颈和帧预算违规
- Measure memory usage and check for leaks / 测量内存使用并检查泄漏
- Benchmark against target hardware specs / 对照目标硬件规格进行基准测试
- Output: performance report with prioritized optimization list / 输出：带优先级优化列表的性能报告

### Phase 2: Optimization / 第 2 阶段：优化
Delegate to **performance-analyst** (with relevant programmers as needed): / 委托给 **performance-analyst**（根据需要加上相关程序员）：
- Fix performance hotspots identified in Phase 1 / 修复第 1 阶段识别的性能热点
- Optimize draw calls, reduce overdraw / 优化绘制调用，减少过度绘制
- Fix memory leaks and reduce allocation pressure / 修复内存泄漏并减少分配压力
- Verify optimizations don't change gameplay behavior / 验证优化不改变游戏玩法行为
- Output: optimized code with before/after metrics / 输出：带前后指标的优化代码

If Phase 1 identified engine-level root causes (rendering pipeline, resource loading, memory allocator), delegate those fixes to **engine-programmer** in parallel: / 如果第 1 阶段识别出引擎级根本原因（渲染管线、资源加载、内存分配器），并行委托这些修复给 **engine-programmer**：
- Optimize hot paths in engine systems / 优化引擎系统中的热路径
- Fix allocation pressure in core loops / 修复核心循环中的分配压力
- Output: engine-level fixes with profiler validation / 输出：带分析器验证的引擎级修复

### Phase 3: Visual Polish (parallel with Phase 2) / 第 3 阶段：视觉打磨（与第 2 阶段并行）
Delegate to **technical-artist**: / 委托给 **technical-artist**：
- Review VFX for quality and consistency with art bible / 审查视觉效果的质量和与美术圣经的一致性
- Optimize particle systems and shader effects / 优化粒子系统和着色器效果
- Add screen shake, camera effects, and visual juice where appropriate / 在适当时添加屏幕抖动、相机效果和视觉表现力
- Ensure effects degrade gracefully on lower settings / 确保效果在较低设置下优雅降级
- Output: polished visual effects / 输出：打磨后的视觉效果

### Phase 4: Audio Polish (parallel with Phase 2) / 第 4 阶段：音频打磨（与第 2 阶段并行）
Delegate to **sound-designer**: / 委托给 **sound-designer**：
- Review audio events for completeness (are any actions missing sound feedback?) / 审查音频事件的完整性（是否有任何动作缺少声音反馈？）
- Check audio mix levels — nothing too loud or too quiet relative to the mix / 检查音频混音级别 — 相对于混音没有过响或过静
- Add ambient audio layers for atmosphere / 为氛围添加环境音频层
- Verify audio plays correctly with spatial positioning / 验证音频在空间定位下正确播放
- Output: audio polish list and mixing notes / 输出：音频打磨列表和混音说明

### Phase 5: Hardening / 第 5 阶段：加固
Delegate to **qa-tester**: / 委托给 **qa-tester**：
- Test all edge cases: boundary conditions, rapid inputs, unusual sequences / 测试所有边缘情况：边界条件、快速输入、异常序列
- Soak test: run the feature for extended periods checking for degradation / 浸泡测试：长时间运行功能检查降级
- Stress test: maximum entities, worst-case scenarios / 压力测试：最大实体数、最坏情况场景
- Regression test: verify polish changes haven't broken existing functionality / 回归测试：验证打磨更改未破坏现有功能
- Test on minimum spec hardware (if available) / 在最低规格硬件上测试（如可用）
- Output: test results with any remaining issues / 输出：带任何剩余问题的测试结果

### Phase 6: Sign-off / 第 6 阶段：签署
- Collect results from all team members / 收集所有团队成员的结果
- Compare performance metrics against budgets / 对照预算比较性能指标
- Report: READY FOR RELEASE / NEEDS MORE WORK / 报告：准备发布 / 需要更多工作
- List any remaining issues with severity and recommendations / 列出任何剩余问题及其严重性和建议

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

All file writes (performance reports, test results, evidence docs) are delegated to
sub-agents spawned via Task. Each sub-agent enforces the "May I write to [path]?"
protocol. This orchestrator does not write files directly.
> **中文翻译**：所有文件写入委托给通过 Task 派生的子代理。每个子代理执行"我可以写入到 [路径] 吗？"协议。此编排器不直接写入文件。

## Output / 输出

A summary report covering: performance before/after metrics, visual polish changes, audio polish changes, test results, and release readiness assessment.
> **中文翻译**：摘要报告涵盖：前后性能指标、视觉打磨更改、音频打磨更改、测试结果和发布就绪度评估。

## Next Steps / 后续步骤

- If READY FOR RELEASE: run `/release-checklist` for the final pre-release validation. / 如果准备发布：运行 `/release-checklist` 进行最终发布前验证。
- If NEEDS MORE WORK: schedule remaining issues in `/sprint-plan update` and re-run `/team-polish` after fixes. / 如果需要更多工作：在 `/sprint-plan update` 中安排剩余问题，修复后重新运行 `/team-polish`。
- Run `/gate-check` for a formal phase gate verdict before handing off to release. / 在移交发布前运行 `/gate-check` 进行正式阶段门裁决。
