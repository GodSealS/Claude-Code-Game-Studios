---
name: tech-debt
description: "Track, categorize, and prioritize technical debt across the codebase. Scans for debt indicators, maintains a debt register, and recommends repayment scheduling. / 跟踪、分类和优先排序整个代码库的技术债务。扫描债务指标，维护债务登记册，并推荐偿还计划。"
argument-hint: "[scan|add|prioritize|report]"
user-invocable: true
allowed-tools: Read, Glob, Grep, Write
---

## Phase 1: Parse Subcommand / 第 1 阶段：解析子命令

Determine the mode from the argument:
> **中文翻译**：从参数确定模式：

- `scan` — Scan the codebase for tech debt indicators / 扫描代码库以查找技术债务指标
- `add` — Add a new tech debt entry manually / 手动添加新技术债务条目
- `prioritize` — Re-prioritize the existing debt register / 重新优先排序现有债务登记册
- `report` — Generate a summary report of current debt status / 生成当前债务状态摘要报告

If no subcommand is provided, output usage and stop. Verdict: **FAIL** — missing required subcommand. / 如果未提供子命令，输出用法并停止。裁决：**FAIL** — 缺少必需子命令。

---

## Phase 2A: Scan Mode / 第 2A 阶段：扫描模式

Search the codebase for debt indicators:
> **中文翻译**：搜索代码库中的债务指标：

- `TODO` comments (count and categorize) / `TODO` 注释（计数和分类）
- `FIXME` comments (these are bugs disguised as debt) / `FIXME` 注释（伪装为债务的缺陷）
- `HACK` comments (workarounds that need proper solutions) / `HACK` 注释（需要正式解决方案的权宜之计）
- `@deprecated` markers / `@deprecated` 标记
- Duplicated code blocks (similar patterns in multiple files) / 重复的代码块（多个文件中的相似模式）
- Files over 500 lines (potential god objects) / 超过 500 行的文件（潜在的上帝对象）
- Functions over 50 lines (potential complexity) / 超过 50 行的函数（潜在的复杂性）

Categorize each finding:
> **中文翻译**：对每个发现进行分类：

- **Architecture Debt**: Wrong abstractions, missing patterns, coupling issues / **架构债务**：错误的抽象、缺失的模式、耦合问题
- **Code Quality Debt**: Duplication, complexity, naming, missing types / **代码质量债务**：重复、复杂性、命名、缺失类型
- **Test Debt**: Missing tests, flaky tests, untested edge cases / **测试债务**：缺失测试、不稳定测试、未测试的边界情况
- **Documentation Debt**: Missing docs, outdated docs, undocumented APIs / **文档债务**：缺失文档、过时文档、未文档化的 API
- **Dependency Debt**: Outdated packages, deprecated APIs, version conflicts / **依赖债务**：过时的包、弃用的 API、版本冲突
- **Performance Debt**: Known slow paths, unoptimized queries, memory issues / **性能债务**：已知的慢路径、未优化的查询、内存问题

Present the findings to the user.
> **中文翻译**：将发现呈现给用户。

Ask: "May I write these findings to `docs/tech-debt-register.md`?"
> **中文翻译**：询问："我可以将这些发现写入 `docs/tech-debt-register.md` 吗？"

If yes, update the register (append new entries, do not overwrite existing ones). Verdict: **COMPLETE** — scan findings written to register.
> **中文翻译**：如果是，更新登记册（追加新条目，不覆盖已有条目）。裁决：**COMPLETE** — 扫描发现已写入登记册。

If no, stop here. Verdict: **BLOCKED** — user declined write.
> **中文翻译**：如果否，停止。裁决：**BLOCKED** — 用户拒绝写入。

---

## Phase 2B: Add Mode / 第 2B 阶段：添加模式

Prompt for: description, category, affected files, estimated fix effort, impact if left unfixed.
> **中文翻译**：提示输入：描述、类别、受影响文件、预计修复工作量、不修复的影响。

Present the new entry to the user.
> **中文翻译**：将新条目呈现给用户。

Ask: "May I append this entry to `docs/tech-debt-register.md`?"
> **中文翻译**：询问："我可以将此条目追加到 `docs/tech-debt-register.md` 吗？"

If yes, append the entry. Verdict: **COMPLETE** — entry added to register.
> **中文翻译**：如果是，追加条目。裁决：**COMPLETE** — 条目已添加到登记册。

If no, stop here. Verdict: **BLOCKED** — user declined write.
> **中文翻译**：如果否，停止。裁决：**BLOCKED** — 用户拒绝写入。

---

## Phase 2C: Prioritize Mode / 第 2C 阶段：优先排序模式

Read the debt register at `docs/tech-debt-register.md`.
> **中文翻译**：读取 `docs/tech-debt-register.md` 中的债务登记册。

Score each item by: `(impact_if_unfixed × frequency_of_encounter) / fix_effort`
> **中文翻译**：按以下公式对每项评分：`(不修复影响 × 遇到频率) / 修复工作量`

Re-sort the register by priority score and recommend which items to include in the next sprint.
> **中文翻译**：按优先级分数重新排序登记册，并推荐哪些条目应纳入下一个冲刺。

Present the re-prioritized register to the user.
> **中文翻译**：将重新排序的登记册呈现给用户。

Ask: "May I write the re-prioritized register back to `docs/tech-debt-register.md`?"
> **中文翻译**：询问："我可以将重新排序的登记册写回 `docs/tech-debt-register.md` 吗？"

If yes, write the updated file. Verdict: **COMPLETE** — register re-prioritized and saved.
> **中文翻译**：如果是，写入更新后的文件。裁决：**COMPLETE** — 登记册已重新排序并保存。

If no, stop here. Verdict: **BLOCKED** — user declined write.
> **中文翻译**：如果否，停止。裁决：**BLOCKED** — 用户拒绝写入。

---

## Phase 2D: Report Mode / 第 2D 阶段：报告模式

Read the debt register. Generate summary statistics:
> **中文翻译**：读取债务登记册。生成摘要统计：

- Total items by category / 按类别统计的总条目数
- Total estimated fix effort / 预计总修复工作量
- Items added vs resolved since last report / 自上次报告以来新增与已解决的条目数
- Trending direction (growing / stable / shrinking) / 趋势方向（增长 / 稳定 / 缩减）

Flag any items that have been in the register for more than 3 sprints.
> **中文翻译**：标记登记册中超过 3 个冲刺的任何条目。

Output the report to the user. This mode is read-only — no files are written. Verdict: **COMPLETE** — debt report generated.
> **中文翻译**：将报告输出给用户。此模式为只读 — 不写入任何文件。裁决：**COMPLETE** — 债务报告已生成。

---

## Phase 3: Next Steps / 第 3 阶段：后续步骤

- Run `/sprint-plan` to schedule high-priority debt items into the next sprint. / 运行 `/sprint-plan` 将高优先级债务条目安排到下一个冲刺。
- Run `/tech-debt report` at the start of each sprint to track debt trends over time. / 在每个冲刺开始时运行 `/tech-debt report` 以跟踪债务趋势。

<!-- 中文翻译 -->
### Debt Register Format

```markdown
## Technical Debt Register
Last updated: [Date]
Total items: [N] | Estimated total effort: [T-shirt sizes summed]

| ID | Category | Description | Files | Effort | Impact | Priority | Added | Sprint |
|----|----------|-------------|-------|--------|--------|----------|-------|--------|
| TD-001 | [Cat] | [Description] | [files] | [S/M/L/XL] | [Low/Med/High/Critical] | [Score] | [Date] | [Sprint to fix or "Backlog"] |
```

### Rules / 规则
- Tech debt is not inherently bad — it is a tool. The register tracks conscious decisions. / 技术债务本身不是坏事 — 它是一种工具。登记册跟踪有意识的决策。
- Every debt entry must explain WHY it was accepted (deadline, prototype, missing info) / 每个债务条目必须解释为什么被接受（截止日期、原型、信息缺失）
- "Scan" should run at least once per sprint to catch new debt / "Scan" 应在每个冲刺至少运行一次以捕获新债务
- Items older than 3 sprints without action should either be fixed or consciously accepted with a documented reason / 超过 3 个冲刺未处理的条目应被修复或有文档记录的理由下有意识地接受
