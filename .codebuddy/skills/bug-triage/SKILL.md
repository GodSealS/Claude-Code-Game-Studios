---
name: bug-triage
description: "Read all open bugs in production/qa/bugs/, re-evaluate priority vs. severity, assign to sprints, surface systemic trends, and produce a triage report. Run at sprint start or when the bug count grows enough to need re-prioritization. / 读取 production/qa/bugs/ 中所有开放缺陷，重新评估优先级与严重性，分配到冲刺，发现系统性趋势，生成分诊报告。在冲刺开始时或缺陷数量增长到需要重新排序时运行。"
argument-hint: "[sprint | full | trend]"
user-invocable: true
allowed-tools: Read, Glob, Grep, Write, Edit
---

# Bug Triage / 缺陷分诊

This skill processes the open bug backlog into a prioritised, sprint-assigned action list. It distinguishes between **severity** (how bad is the impact?) and **priority** (how urgently must we fix it?), detects systemic trends, and ensures no critical bug is lost between sprints.
> **中文翻译**：该技能将未解决的缺陷积压处理为按优先级排序、分配到冲刺的行动列表。它区分**严重性**（影响有多严重？）和**优先级**（必须多紧急地修复？），检测系统性趋势，并确保冲刺之间不会丢失关键缺陷。

**Output:** `production/qa/bug-triage-[date].md`
> **中文翻译**：**输出：** `production/qa/bug-triage-[date].md`

**When to run:** / **何时运行：**

- Sprint start — assign open bugs to the new sprint or backlog / 冲刺开始 — 将未解决的缺陷分配到新冲刺或待办列表
- After `/team-qa` completes and new bugs have been filed / 在 `/team-qa` 完成并提交新缺陷后
- When the bug count crosses 10+ open items / 当缺陷数量超过 10 个以上未解决项时

---

## 1. Parse Arguments / 解析参数

**Modes:** / **模式：**
- `/bug-triage sprint` — triage against the current sprint; assign fixable bugs to the sprint backlog; defer the rest / 针对当前冲刺进行分诊；将可修复的缺陷分配到冲刺待办列表；推迟其余的
- `/bug-triage full` — full triage of all bugs regardless of sprint scope / 对所有缺陷进行完整分诊，不论冲刺范围
- `/bug-triage trend` — trend analysis only (no assignment); read-only report / 仅趋势分析（不分配）；只读报告
- No argument — run sprint mode if a current sprint exists, else full mode / 无参数 — 如果存在当前冲刺则运行冲刺模式，否则运行完整模式

---

## 2. Load Bug Backlog / 加载缺陷积压

### Step 2a — Discover bug files / 步骤 2a — 发现缺陷文件

Glob for bug reports in priority order: / 按优先级顺序 Glob 查找缺陷报告：

1. `production/qa/bugs/*.md` — individual bug report files (preferred format) / 单独的缺陷报告文件（首选格式）
2. `production/qa/bugs.md` — single consolidated bug log (fallback) / 单个合并的缺陷日志（后备方案）
3. Any `production/qa/qa-plan-*.md` "Bugs Found" table (last resort) / 任何 `production/qa/qa-plan-*.md` "发现的缺陷"表格（最后手段）

If no bug files found: "No bug files found in `production/qa/bugs/`. If bugs are tracked in a different location, adjust the glob pattern. If no bugs exist yet, there is nothing to triage."
> **中文翻译**：如果未找到缺陷文件："在 `production/qa/bugs/` 中未找到缺陷文件。如果缺陷在其他位置跟踪，请调整 glob 模式。如果尚无缺陷，则无需分诊。"

Stop and report. Do not proceed if no bugs exist.
> **中文翻译**：停止并报告。如果不存在缺陷，请不要继续。

### Step 2b — Load sprint context / 步骤 2b — 加载冲刺上下文

Read the most recently modified file in `production/sprints/` to understand: / 读取 `production/sprints/` 中最近修改的文件以了解：

- Current sprint number / name / 当前冲刺编号/名称
- Stories in scope (for assignment target) / 范围内的故事（用于分配目标）
- Sprint capacity constraints (if noted) / 冲刺容量限制（如有注明）

If no sprint file exists: note "No sprint plan found — assigning to backlog only."
> **中文翻译**：如果不存在冲刺文件：注明"未找到冲刺计划 — 仅分配到待办列表。"

### Step 2c — Load severity reference / 步骤 2c — 加载严重性参考

Read `.codebuddy/docs/coding-standards.md` for severity/priority definitions if they exist. If they do not exist, use the standard definitions in Step 3.
> **中文翻译**：读取 `.codebuddy/docs/coding-standards.md` 中的严重性/优先级定义（如果存在）。如果不存在，使用步骤 3 中的标准定义。

---

## 3. Classify Each Bug / 分类每个缺陷

For each bug, extract or infer: / 对于每个缺陷，提取或推断：

### Severity (impact of the bug) / 严重性（缺陷的影响）

| Severity | Definition |
|----------|-----------|
| **S1 — Critical** | Game crashes, data loss, or complete feature failure. Cannot proceed past this point. |
| **S2 — High** | Major feature broken but game is still playable. Significant wrong behaviour. |
| **S3 — Medium** | Feature degraded but a workaround exists. Minor wrong behaviour. |
| **S4 — Low** | Visual glitch, cosmetic issue, typo. No gameplay impact. |

> **中文翻译**：
> | 严重性 | 定义 |
> |----------|-----------|
> | **S1 — 关键** | 游戏崩溃、数据丢失或完全功能失效。无法继续进行。 |
> | **S2 — 高** | 主要功能损坏但游戏仍可游玩。行为明显异常。 |
> | **S3 — 中** | 功能降级但有变通方案。行为轻微异常。 |
> | **S4 — 低** | 视觉故障、外观问题、错字。不影响游戏玩法。 |

### Priority (urgency of the fix) / 优先级（修复的紧迫性）

| Priority | Definition |
|----------|-----------|
| **P1 — Fix this sprint** | Blocks QA, blocks release, or is regression from last sprint |
| **P2 — Fix soon** | Should be resolved before the next major milestone |
| **P3 — Backlog** | Would be good to fix, but no active blocking impact |
| **P4 — Won't fix / Deferred** | Accepted risk or out of scope for current product scope |

> **中文翻译**：
> | 优先级 | 定义 |
> |----------|-----------|
> | **P1 — 本冲刺修复** | 阻塞 QA、阻塞发布，或是上个冲刺的回归 |
> | **P2 — 尽快修复** | 应在下一个主要里程碑之前解决 |
> | **P3 — 待办列表** | 最好修复，但没有活跃的阻塞影响 |
> | **P4 — 不修复/推迟** | 已接受的风险或超出当前产品范围 |

### Assignment / 分配

For each P1/P2 bug in `sprint` mode: / 在 `sprint` 模式下对每个 P1/P2 缺陷：
- Identify which story or epic the fix belongs to / 识别修复属于哪个故事或史诗
- Check whether the current sprint has remaining capacity / 检查当前冲刺是否还有剩余容量
- If capacity exists: assign to sprint (`Sprint: [current]`) / 如果有容量：分配到冲刺（`Sprint: [当前]`）
- If capacity is full: flag as `Priority overflow — consider pulling from sprint` / 如果容量已满：标记为 `优先级溢出 — 考虑从冲刺中拉取`

For `full` mode: assign all P1 to current sprint, P2 to next sprint estimate, P3+ to backlog.
> **中文翻译**：对于 `full` 模式：将所有 P1 分配到当前冲刺，P2 分配到下个冲刺预估，P3+ 分配到待办列表。

### Deviation check / 偏差检查

Flag bugs that suggest **systematic problems**: / 标记暗示**系统性问题**的缺陷：
- 3+ bugs from the same system in the same sprint → "Potential design or implementation quality issue in [system]" / 同一冲刺中同一系统 3+ 个缺陷 → "[系统] 可能存在设计或实现质量问题"
- 2+ S1/S2 bugs in the same story → "Story may need to be reopened and re-reviewed before shipping" / 同一故事中 2+ 个 S1/S2 缺陷 → "故事可能需要重新开放并在发布前重新审查"
- Bug filed against a story marked Complete → "Regression in completed story — story should be re-opened in sprint tracking" / 对标记为已完成的故事提交缺陷 → "已完成故事中的回归 — 故事应在冲刺跟踪中重新开放"

---

## 4. Trend Analysis / 趋势分析

After classifying all bugs, generate trend metrics: / 对所有缺陷分类后，生成趋势指标：

### Volume trends / 数量趋势

- Total open bugs: [N] / 未解决缺陷总数：[N]
- Opened this sprint: [N] / 本冲刺新增：[N]
- Closed this sprint: [N] / 本冲刺关闭：[N]
- Net change: [+N / -N] / 净变化：[+N / -N]

### System hot spots / 系统热点

- Which system has the most open bugs? / 哪个系统有最多的未解决缺陷？
- Which system has the highest S1/S2 ratio? / 哪个系统的 S1/S2 比率最高？

### Age analysis / 老化分析

- How many bugs are older than 2 sprints? / 有多少缺陷超过 2 个冲刺未解决？
- Are any S1/S2 bugs un-assigned (sprint = none)? / 是否有 S1/S2 缺陷未分配（冲刺 = 无）？

### Regression indicator / 回归指标

- Any bugs filed against previously-completed stories? / 是否有针对先前已完成故事提交的缺陷？
- Count: [N] regression bugs (story reopened implied) / 计数：[N] 个回归缺陷（暗示故事重新开放）

---

## 5. Generate Triage Report / 生成分诊报告

```markdown
# Bug Triage Report

> **Date**: [date]
> **Mode**: [sprint | full | trend]
> **Generated by**: /bug-triage
> **Open bugs processed**: [N]
> **Sprint in scope**: [sprint name, or "N/A"]

---

## Triage Summary / 分诊摘要

| Priority | Count | Notes |
|----------|-------|-------|
| P1 — Fix this sprint | [N] | [N] assigned to sprint, [N] overflow |
| P2 — Fix soon | [N] | Scheduled for next sprint |
| P3 — Backlog | [N] | Deferred |
| P4 — Won't fix | [N] | Accepted risk |

> **中文翻译**：
> | 优先级 | 数量 | 备注 |
> |----------|-------|-------|
> | P1 — 本冲刺修复 | [N] | [N] 分配到冲刺，[N] 溢出 |
> | P2 — 尽快修复 | [N] | 计划下个冲刺 |
> | P3 — 待办列表 | [N] | 已推迟 |
> | P4 — 不修复 | [N] | 已接受风险 |

**Critical (S1/S2) unfixed count**: [N]
> **中文翻译**：**关键（S1/S2）未修复计数**：[N]

---

## P1 Bugs — Fix This Sprint / P1 缺陷 — 本冲刺修复

| ID | System | Severity | Summary | Assigned to | Story |
|----|--------|----------|---------|-------------|-------|
| BUG-NNN | [system] | S[1-4] | [one-line description] | [sprint] | [story path] |

---

## P2 Bugs — Fix Soon / P2 缺陷 — 尽快修复

| ID | System | Severity | Summary | Target Sprint |
|----|--------|----------|---------|---------------|
| BUG-NNN | [system] | S[1-4] | [one-line description] | Sprint [N+1] |

---

## P3/P4 Bugs — Backlog / Won't Fix / P3/P4 缺陷 — 待办列表/不修复

| ID | System | Severity | Summary | Disposition |
|----|--------|----------|---------|-------------|
| BUG-NNN | [system] | S4 | [one-line description] | Backlog |

---

## Systemic Issues Flagged / 标记的系统性问题

[List any patterns from Step 3 deviation check, or "None identified."] / [列出步骤 3 偏差检查中的任何模式，或"未识别出任何模式。"]

---

## Trend Analysis / 趋势分析

**Volume**: [N] open / [+N] net change this sprint
**Hot spot**: [system with most bugs]
**Regressions**: [N] bugs against completed stories
**Aged bugs (>2 sprints old)**: [N]

[If N aged S1/S2 bugs > 0:]
> ⚠️ [N] high-severity bugs have been open for more than 2 sprints without
> assignment. These represent accepted risk that should be explicitly reviewed.

> **中文翻译**：> ⚠️ [N] 个高严重性缺陷已开放超过 2 个冲刺且未分配。这些代表应明确审查的已接受风险。

---

## Recommended Actions / 建议措施

1. [Most urgent action — usually "fix P1 bugs before QA hand-off"] / [最紧急的行动 — 通常是"在 QA 移交之前修复 P1 缺陷"]
2. [Second action — usually "investigate [hot spot system] quality"] / [第二个行动 — 通常是"调查[热点系统]质量"]
3. [Third action — optional improvement] / [第三个行动 — 可选改进]

```

---

## 6. Write and Gate / 写入与门控

Present the report in conversation, then ask: / 在对话中展示报告，然后询问：

"May I write this triage report to `production/qa/bug-triage-[date].md`?"
> **中文翻译**："我可以将此分诊报告写入 `production/qa/bug-triage-[date].md` 吗？"

Write only after approval. / 仅在批准后写入。

After writing: / 写入后：
- If any S1 bugs are unassigned: "S1 bugs must be assigned before the sprint can be considered healthy. Run `/sprint-status` to see current capacity." / 如果有任何 S1 缺陷未分配："S1 缺陷必须在冲刺被视为健康之前分配。运行 `/sprint-status` 查看当前容量。"
- If regression bugs exist: "Regressions found — consider re-opening the affected stories in sprint tracking and running `/smoke-check` to re-gate." / 如果存在回归缺陷："发现回归 — 考虑在冲刺跟踪中重新开放受影响的故事并运行 `/smoke-check` 重新门控。"
- If no P1 bugs exist: "No P1 bugs — build is in good shape for QA hand-off." Verdict: **COMPLETE** — triage report written. / 如果没有 P1 缺陷："无 P1 缺陷 — 构建状态良好，可移交 QA。" 结论：**完成** — 分诊报告已写入。

If user declined write: Verdict: **BLOCKED** — user declined write.
> **中文翻译**：如果用户拒绝写入：结论：**已阻塞** — 用户拒绝写入。

---

## Collaborative Protocol / 协作协议

- **Never close or mark bugs Won't Fix without user approval** — surface them as P4 candidates and ask: "Are these acceptable as Won't Fix?" / **未经用户批准不得关闭或将缺陷标记为不修复** — 将其作为 P4 候选项展示并询问："这些可以作为不修复接受吗？"
- **Never auto-assign to a sprint at capacity** — flag overflow and let the sprint owner decide what to pull / **不得自动分配到已满容量的冲刺** — 标记溢出并让冲刺负责人决定拉取什么
- **Severity is objective; priority is a team decision** — present severity classifications as recommendations, not mandates / **严重性是客观的；优先级是团队决策** — 将严重性分类作为建议呈现，而非命令
- **Trend data is informational** — do not block work on trend findings alone; surface them as observations / **趋势数据仅供参考** — 不要仅凭趋势发现阻塞工作；将其作为观察呈现
