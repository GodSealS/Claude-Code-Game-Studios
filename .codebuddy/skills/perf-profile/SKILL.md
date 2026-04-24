---
name: perf-profile
description: "Structured performance profiling workflow. Identifies bottlenecks, measures against budgets, and generates optimization recommendations with priority rankings. / 结构化性能分析工作流。识别瓶颈，对照预算测量，并生成带优先级排序的优化建议。"
argument-hint: "[system-name or 'full']"
user-invocable: true
agent: performance-analyst
allowed-tools: Read, Glob, Grep, Bash
---

## Phase 1: Determine Scope / 第 1 阶段：确定范围

Read the argument:
> **中文翻译**：读取参数：

- System name → focus profiling on that specific system / 系统名称 → 专注于该特定系统的性能分析
- `full` → run a comprehensive profile across all systems / `full` → 跨所有系统运行全面分析

---

## Phase 2: Load Performance Budgets / 第 2 阶段：加载性能预算

Check for existing performance targets in design docs or CODEBUDDY.md:
> **中文翻译**：在设计文档或 CODEBUDDY.md 中检查现有的性能目标：

- Target FPS (e.g., 60fps = 16.67ms frame budget) / 目标 FPS（例如 60fps = 16.67ms 帧预算）
- Memory budget (total and per-system) / 内存预算（总量和每系统）
- Load time targets / 加载时间目标
- Draw call budgets / 绘制调用预算
- Network bandwidth limits (if multiplayer) / 网络带宽限制（如为多人游戏）

---

## Phase 3: Analyze Codebase / 第 3 阶段：分析代码库

**CPU Profiling Targets:** / **CPU 分析目标：**
- `_process()` / `Update()` / `Tick()` functions — list all and estimate cost / `_process()` / `Update()` / `Tick()` 函数 — 列出所有并估算成本
- Nested loops over large collections / 大型集合上的嵌套循环
- String operations in hot paths / 热路径中的字符串操作
- Allocation patterns in per-frame code / 每帧代码中的分配模式
- Unoptimized search/sort over game entities / 游戏实体上未优化的搜索/排序
- Expensive physics queries (raycasts, overlaps) every frame / 每帧的昂贵物理查询（射线投射、重叠检测）

**Memory Profiling Targets:** / **内存分析目标：**
- Large data structures and their growth patterns / 大型数据结构及其增长模式
- Texture/asset memory footprint estimates / 纹理/资产内存占用估算
- Object pool vs instantiate/destroy patterns / 对象池 vs 实例化/销毁模式
- Leaked references (objects that should be freed but aren't) / 泄漏的引用（应释放但未释放的对象）
- Cache sizes and eviction policies / 缓存大小和驱逐策略

**Rendering Targets (if applicable):** / **渲染目标（如适用）：**
- Draw call estimates / 绘制调用估算
- Overdraw from overlapping transparent objects / 重叠透明对象的过度绘制
- Shader complexity / 着色器复杂度
- Unoptimized particle systems / 未优化的粒子系统
- Missing LODs or occlusion culling / 缺失的 LOD 或遮挡剔除

**I/O Targets:** / **I/O 目标：**
- Save/load performance / 存档/读档性能
- Asset loading patterns (sync vs async) / 资产加载模式（同步 vs 异步）
- Network message frequency and size / 网络消息频率和大小

---

## Phase 4: Generate Profiling Report / 第 4 阶段：生成分析报告

```markdown
## Performance Profile: [System or Full] / 性能分析：[系统或全面]
Generated: [Date] / 生成时间：[日期]

### Performance Budgets / 性能预算
| Metric | Budget | Estimated Current | Status |
|--------|--------|-------------------|--------|
<!-- 翻译: 指标 | 预算 | 估算当前值 | 状态 -->
| Frame time | [16.67ms] | [estimate] | [OK/WARNING/OVER] |
| Memory | [target] | [estimate] | [OK/WARNING/OVER] |
| Load time | [target] | [estimate] | [OK/WARNING/OVER] |
| Draw calls | [target] | [estimate] | [OK/WARNING/OVER] |

### Hotspots Identified / 已识别的热点
| # | Location | Issue | Estimated Impact | Fix Effort |
|---|----------|-------|------------------|------------|
<!-- 翻译: # | 位置 | 问题 | 估算影响 | 修复工作量 -->

### Optimization Recommendations (Priority Order) / 优化建议（优先级排序）
1. **[Title]** — [Description]
   - Location: [file:line] / 位置：[文件:行]
   - Expected gain: [estimate] / 预期收益：[估算]
   - Risk: [Low/Med/High] / 风险：[低/中/高]
   - Approach: [How to implement] / 方法：[如何实现]

### Quick Wins (< 1 hour each) / 快速收益（每项 < 1 小时）
- [Simple optimization 1] / [简单优化 1]

### Requires Investigation / 需要调查
- [Area that needs actual runtime profiling to confirm impact] / [需要实际运行时分析以确认影响的区域]
```

Output the report with a summary: top 3 hotspots, estimated headroom vs budget, and recommended next action.
> **中文翻译**：输出报告并附带摘要：前 3 个热点、估算的预算余量和推荐下一步行动。

---

## Phase 5: Scope and Timeline Decision / 第 5 阶段：范围和时间线决策

Activate this phase only if any hotspot has Fix Effort rated M or L.
> **中文翻译**：仅当任何热点的修复工作量评级为 M 或 L 时激活此阶段。

Present significant-effort items and ask the user to choose for each:
> **中文翻译**：展示重大工作量项目并让用户为每个选择：

- **A) Implement the optimization** (proceed with fix now or schedule it) / **A) 实施优化**（现在修复或排期）
- **B) Reduce feature scope** (run `/scope-check [feature]` to analyze trade-offs) / **B) 缩减功能范围**（运行 `/scope-check [feature]` 分析权衡）
- **C) Accept the performance hit and defer to Polish phase** (log as known issue) / **C) 接受性能损失并推迟到打磨阶段**（记录为已知问题）
- **D) Escalate to technical-director for an architectural decision** (run `/architecture-decision`) / **D) 上报技术总监进行架构决策**（运行 `/architecture-decision`）

If multiple items are deferred to Polish (choice C), record them under `### Deferred to Polish`.
> **中文翻译**：如果多个项目被推迟到打磨阶段（选择 C），在 `### Deferred to Polish` 下记录。

This skill is read-only — no files are written. Verdict: **COMPLETE** — performance profile generated.
> **中文翻译**：此技能为只读——不写入任何文件。裁决：**COMPLETE** — 性能分析已生成。

---

## Phase 6: Next Steps / 第 6 阶段：后续步骤

- If bottlenecks require architectural change: run `/architecture-decision`. / 如果瓶颈需要架构变更：运行 `/architecture-decision`。
- If scope reduction is needed: run `/scope-check [feature]`. / 如果需要缩减范围：运行 `/scope-check [feature]`。
- To schedule optimizations: run `/sprint-plan update`. / 要排期优化：运行 `/sprint-plan update`。

### Rules / 规则
- Never optimize without measuring first — gut feelings about performance are unreliable / 切勿在未先测量的情况下优化——对性能的直觉不可靠
- Recommendations must include estimated impact — "make it faster" is not actionable / 建议必须包含估算影响——"让它更快"不可操作
- Profile on target hardware, not just development machines / 在目标硬件上分析，而非仅开发机
- Static analysis (this skill) identifies candidates; runtime profiling confirms / 静态分析（此技能）识别候选项；运行时分析确认
