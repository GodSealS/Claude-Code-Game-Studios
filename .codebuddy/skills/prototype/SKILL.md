---
name: prototype
description: "Rapid prototyping workflow. Skips normal standards to quickly validate a game concept or mechanic. Produces throwaway code and a structured prototype report. / 快速原型工作流。跳过正常标准以快速验证游戏概念或机制。生成一次性代码和结构化原型报告。"
argument-hint: "[concept-description] [--review full|lean|solo]"
user-invocable: true
allowed-tools: Read, Glob, Grep, Write, Edit, Bash, Task
agent: prototyper
isolation: worktree
---

## Phase 1: Define the Question / 阶段 1：定义问题

Resolve the review mode (once, store for all gate spawns this run):
> **中文翻译**：解析审查模式（一次解析，本次运行所有门控生成均使用）：

1. If `--review [full|lean|solo]` was passed → use that
2. Else read `production/review-mode.txt` → use that value
3. Else → default to `lean`

> **中文翻译**：
> 1. 如果传入了 `--review [full|lean|solo]` → 使用该值
> 2. 否则读取 `production/review-mode.txt` → 使用该值
> 3. 否则 → 默认为 `lean`

See `.codebuddy/docs/director-gates.md` for the full check pattern.
> **中文翻译**：完整检查模式参见 `.codebuddy/docs/director-gates.md`。

Read the concept description from the argument. Identify the core question this prototype must answer. If the concept is vague, state the question explicitly before proceeding — a prototype without a clear question wastes time.
> **中文翻译**：从参数中读取概念描述。识别此原型必须回答的核心问题。如果概念模糊，在继续之前明确陈述问题 — 没有明确问题的原型浪费时间。

---

## Phase 2: Load Project Context / 阶段 2：加载项目上下文

Read `CODEBUDDY.md` for project context and the current tech stack. Understand what engine, language, and frameworks are in use so the prototype is built with compatible tooling.
> **中文翻译**：读取 `CODEBUDDY.md` 获取项目上下文和当前技术栈。了解正在使用的引擎、语言和框架，以便原型使用兼容的工具构建。

---

## Phase 3: Plan the Prototype / 阶段 3：规划原型

Define in 3-5 bullet points what the minimum viable prototype looks like:
> **中文翻译**：用 3-5 个要点定义最小可行原型的样子：

- What is the core question? / 核心问题是什么？
- What is the absolute minimum code needed to answer it? / 回答它所需的绝对最小代码是什么？
- What can be skipped (error handling, polish, architecture)? / 可以跳过什么（错误处理、打磨、架构）？

Present this plan to the user before building. Ask for confirmation if scope seems unclear.
> **中文翻译**：在构建前向用户展示此计划。如果范围看起来不明确，请求确认。

---

## Phase 4: Implement / 阶段 4：实现

Ask: "May I create the prototype directory at `prototypes/[concept-name]/` and begin implementation?"
> **中文翻译**：询问："我可以在 `prototypes/[concept-name]/` 创建原型目录并开始实现吗？"

If yes, create the directory. Every file must begin with:
> **中文翻译**：如果是，创建目录。每个文件必须以以下内容开头：

```
// PROTOTYPE - NOT FOR PRODUCTION
// Question: [Core question being tested]
// Date: [Current date]
```

Standards are intentionally relaxed:
> **中文翻译**：标准有意放宽：

- Hardcode values freely / 自由硬编码值
- Use placeholder assets / 使用占位符资产
- Skip error handling / 跳过错误处理
- Use the simplest approach that works / 使用最简单的可行方法
- Copy code rather than importing from production / 复制代码而非从生产代码导入

Run the prototype. Observe behavior. Collect any measurable data (frame times, interaction counts, feel assessments).
> **中文翻译**：运行原型。观察行为。收集任何可测量的数据（帧时间、交互次数、手感评估）。

---

## Phase 5: Generate Prototype Report / 阶段 5：生成原型报告

Draft the report:
> **中文翻译**：起草报告：

```markdown
## Prototype Report: [Concept Name]

### Hypothesis
[What we expected to be true -- the question we set out to answer]

### Approach
[What we built, how long it took, what shortcuts we took]

### Result
[What actually happened -- specific observations, not opinions]

### Metrics
[Any measurable data collected during testing]
- Frame time: [if relevant]
- Feel assessment: [subjective but specific -- "response felt sluggish at
  200ms delay" not "felt bad"]
- Player action counts: [if relevant]
- Iteration count: [how many attempts to get it working]

### Recommendation: [PROCEED / PIVOT / KILL]

[One paragraph explaining the recommendation with evidence]

### If Proceeding
[What needs to change for a production-quality implementation]
- Architecture requirements
- Performance targets
- Scope adjustments from the original design
- Estimated production effort

### If Pivoting
[What alternative direction the results suggest]

### If Killing
[Why this concept does not work and what we should do instead]

### Lessons Learned
[Discoveries that affect other systems or future work]
```

Ask: "May I write this report to `prototypes/[concept-name]/REPORT.md`?"
> **中文翻译**：询问："我可以将此报告写入 `prototypes/[concept-name]/REPORT.md` 吗？"

If yes, write the file.
> **中文翻译**：如果是，写入文件。

---

## Phase 6: Creative Director Review / 阶段 6：创意总监审查

**Review mode check** — apply before spawning CD-PLAYTEST:
> **中文翻译**：**审查模式检查** — 在生成 CD-PLAYTEST 之前应用：

- `solo` → skip. Note: "CD-PLAYTEST skipped — Solo mode." Proceed to Phase 7 summary with the prototyper's recommendation as the final verdict. / `solo` → 跳过。备注："CD-PLAYTEST 已跳过 — Solo 模式。" 以原型师的推荐作为最终裁决进入阶段 7 摘要。
- `lean` → skip (not a PHASE-GATE). Note: "CD-PLAYTEST skipped — Lean mode." Proceed to Phase 7 summary with the prototyper's recommendation as the final verdict. / `lean` → 跳过（非阶段门控）。备注："CD-PLAYTEST 已跳过 — Lean 模式。" 以原型师的推荐作为最终裁决进入阶段 7 摘要。
- `full` → spawn as normal. / `full` → 正常生成。

Spawn `creative-director` via Task using gate **CD-PLAYTEST** (`.codebuddy/docs/director-gates.md`).
> **中文翻译**：通过 Task 使用门控 **CD-PLAYTEST** 生成 `creative-director`（`.codebuddy/docs/director-gates.md`）。

Pass: the full REPORT.md content, the original design question, game pillars and core fantasy from `design/gdd/game-concept.md` (if it exists).
> **中文翻译**：传递：完整的 REPORT.md 内容、原始设计问题、来自 `design/gdd/game-concept.md` 的游戏支柱和核心幻想（如果存在）。

The creative director evaluates the prototype result against the game's creative vision and pillars, then confirms, modifies, or overrides the prototyper's PROCEED / PIVOT / KILL recommendation. Their verdict is final. Update the REPORT.md `Recommendation` section if the creative director's verdict differs from the prototyper's.
> **中文翻译**：创意总监根据游戏的创意愿景和支柱评估原型结果，然后确认、修改或覆盖原型师的继续/转向/终止推荐。其裁决为最终决定。如果创意总监的裁决与原型师的不同，更新 REPORT.md 的 `Recommendation` 部分。

---

## Phase 7: Summary and Next Steps / 阶段 7：摘要和下一步

Output a summary to the user: the core question, the result, the prototyper's initial recommendation, and the creative-director's final decision. Link to the full report at `prototypes/[concept-name]/REPORT.md`.
> **中文翻译**：向用户输出摘要：核心问题、结果、原型师的初始推荐和创意总监的最终决定。链接到完整报告 `prototypes/[concept-name]/REPORT.md`。

If **PROCEED**: run `/design-system` to begin the production GDD for this mechanic, or `/architecture-decision` to record key technical decisions before implementation.
> **中文翻译**：如果是 **PROCEED**：运行 `/design-system` 开始此机制的生产 GDD，或 `/architecture-decision` 在实现前记录关键技术决策。

If **PIVOT** or **KILL**: no further action needed — the prototype report is the deliverable.
> **中文翻译**：如果是 **PIVOT** 或 **KILL**：无需进一步操作 — 原型报告即为交付物。

Verdict: **COMPLETE** — prototype finished. Recommendation is PROCEED, PIVOT, or KILL based on findings above.
> **中文翻译**：裁决：**完成** — 原型完成。推荐为 PROCEED、PIVOT 或 KILL，基于上述发现。

### Important Constraints / 重要约束

- Prototype code must NEVER import from production source files / 原型代码绝不能从生产源文件导入
- Production code must NEVER import from prototype directories / 生产代码绝不能从原型目录导入
- If the recommendation is PROCEED, the production implementation must be written from scratch — prototype code is not refactored into production / 如果推荐为 PROCEED，生产实现必须从头编写 — 原型代码不被重构到生产代码中
- Total prototype effort should be timeboxed to 1-3 days equivalent of work / 原型总工作量应限时为 1-3 天等量工作
- If the prototype scope starts growing, stop and reassess whether the question can be simplified / 如果原型范围开始增长，停止并重新评估问题是否可以简化

---

## Recommended Next Steps / 推荐的下一步

- **If PROCEED**: Run `/design-system [mechanic]` to author the production GDD, or `/architecture-decision` to record key technical decisions before implementation / **如果 PROCEED**：运行 `/design-system [机制]` 编写生产 GDD，或 `/architecture-decision` 在实现前记录关键技术决策
- **If PIVOT**: Run `/prototype [revised-concept]` to test the adjusted direction / **如果 PIVOT**：运行 `/prototype [修订概念]` 测试调整后的方向
- **If KILL**: No further action required — the prototype report is the deliverable / **如果 KILL**：无需进一步操作 — 原型报告即为交付物
- Run `/playtest-report` to formally document any playtest sessions conducted during prototyping / 运行 `/playtest-report` 正式记录原型制作期间进行的任何试玩会话
