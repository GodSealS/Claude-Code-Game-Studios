---
name: day-one-patch
description: "Prepare a day-one patch for a game launch. Scopes, prioritises, implements, and QA-gates a focused patch addressing known issues discovered after gold master but before or immediately after public launch. Treats the patch as a mini-sprint with its own QA gate and rollback plan. / 为游戏发布准备首日补丁。范围界定、优先排序、实现和 QA 门控一个针对性补丁，解决在金版之后但在公开发布之前或之后发现的已知问题。将补丁视为一个带有自己 QA 门控和回滚计划的迷你冲刺。"
argument-hint: "[scope: known-bugs | cert-feedback | all]"
user-invocable: true
allowed-tools: Read, Glob, Grep, Write, Edit, Bash, Task, AskUserQuestion
---

# Day-One Patch / 首日补丁

Every shipped game has a day-one patch. Planning it before launch day prevents chaos. This skill scopes the patch to only what is safe and necessary, gates it through a lightweight QA pass, and ensures a rollback plan exists before anything ships. It is a mini-sprint — not a hotfix, not a full sprint.
> **中文翻译**：每个发布的游戏都有首日补丁。在发布日之前规划它可以防止混乱。此技能将补丁范围限定在安全和必要的范围内，通过轻量级 QA 通道进行门控，并确保在发布任何内容之前存在回滚计划。这是一个迷你冲刺 — 不是热修复，也不是完整冲刺。

**When to run:** / **何时运行：**
- After the gold master build is locked (cert approved or launch candidate tagged)
  > **中文翻译**：金版构建锁定后（证书已批准或发布候选已标记）
- When known bugs exist that are too risky to address in the gold master
  > **中文翻译**：当存在已知错误且风险太大而无法在金版中解决时
- When cert feedback requires minor fixes post-submission
  > **中文翻译**：当证书反馈需要提交后进行小修复时
- When a pre-launch playtest surfaces must-fix issues after the release gate passed
  > **中文翻译**：当发布前试玩在发布门控通过后出现必须修复的问题时

**Day-one patch scope rules:** / **首日补丁范围规则：**
- Only P1/P2 bugs that are SAFE to fix quickly
  > **中文翻译**：仅限可安全快速修复的 P1/P2 错误
- No new features — this is fix-only
  > **中文翻译**：无新功能 — 仅限修复
- No refactoring — minimum viable change
  > **中文翻译**：无重构 — 最小可行更改
- Any fix that requires more than 4 hours of dev time belongs in patch 1.1, not day-one
  > **中文翻译**：任何需要超过 4 小时开发时间的修复都属于补丁 1.1，而非首日补丁

**Output:** `production/releases/day-one-patch-[version].md`
> **中文翻译**：**输出：** `production/releases/day-one-patch-[version].md`

---

## Phase 1: Load Release Context / 第 1 阶段：加载发布上下文

Read:
> **中文翻译**：读取：

- `production/stage.txt` — confirm project is in Release stage
- The most recent file in `production/gate-checks/` — read the release gate verdict
- `production/qa/bugs/*.md` — load all bugs with Status: Open or Fixed — Pending Verification
- `production/sprints/` most recent — understand what shipped
- `production/security/security-audit-*.md` most recent — check for any open security items

> **中文翻译**：
> - `production/stage.txt` — 确认项目处于发布阶段
> - `production/gate-checks/` 中最近的文件 — 读取发布门控裁决
> - `production/qa/bugs/*.md` — 加载所有状态为开放或已修复 — 待验证的错误
> - `production/sprints/` 最近的 — 了解已发布的内容
> - `production/security/security-audit-*.md` 最近的 — 检查是否有未解决的安全项

If `production/stage.txt` is not `Release` or `Polish`:
> "Day-one patch prep is for Release-stage projects. Current stage: [stage]. This skill is not appropriate until you are approaching launch."
> **中文翻译**：如果 `production/stage.txt` 不是 `Release` 或 `Polish`：
> "首日补丁准备适用于发布阶段的项目。当前阶段：[阶段]。此技能在您接近发布之前不适用。"

---

## Phase 2: Scope the Patch / 第 2 阶段：确定补丁范围

### Step 2a — Classify open bugs for patch inclusion / 步骤 2a — 对未解决错误进行分类以纳入补丁

For each open bug, evaluate:
> **中文翻译**：对于每个未解决的错误，评估：

| Criterion | Include in day-one? |
|-----------|-------------------|
| S1 or S2 severity | Yes — must include if safe to fix |
| P1 priority | Yes |
| Fix estimated < 4 hours | Yes |
| Fix requires architecture change | No — defer to 1.1 |
| Fix introduces new code paths | No — too risky |
| Fix is data/config only (no code change) | Yes — very low risk |
| Cert feedback requirement | Yes — required for platform approval |
| S3/S4 severity | Only if trivial config fix; otherwise defer |

> **中文翻译**：
> | 标准 | 纳入首日补丁？ |
> |-----------|-------------------|
> | S1 或 S2 严重性 | 是 — 如可安全修复则必须纳入 |
> | P1 优先级 | 是 |
> | 预计修复 < 4 小时 | 是 |
> | 修复需要架构更改 | 否 — 延至 1.1 |
> | 修复引入新代码路径 | 否 — 风险太大 |
> | 修复仅涉及数据/配置（无代码更改） | 是 — 风险极低 |
> | 证书反馈要求 | 是 — 平台批准所需 |
> | S3/S4 严重性 | 仅当简单配置修复时；否则延后 |

### Step 2b — Present patch scope to user / 步骤 2b — 向用户展示补丁范围

Use `AskUserQuestion`:
> **中文翻译**：使用 `AskUserQuestion`：

- Prompt: "Based on open bugs and cert feedback, here is the proposed day-one patch scope. Does this look right?"
  > **中文翻译**：提示："根据未解决的错误和证书反馈，这是建议的首日补丁范围。这看起来正确吗？"
- Show: table of included bugs (ID, severity, description, estimated effort)
  > **中文翻译**：显示：纳入的错误表（ID、严重性、描述、预计工作量）
- Show: table of deferred bugs (ID, severity, reason deferred)
  > **中文翻译**：显示：延后的错误表（ID、严重性、延后原因）
- Options: `[A] Approve this scope` / `[B] Adjust — I want to add or remove items` / `[C] No day-one patch needed`
  > **中文翻译**：选项：`[A] 批准此范围` / `[B] 调整 — 我想添加或删除项目` / `[C] 不需要首日补丁`

If [C]: output "No day-one patch required. Proceed to `/launch-checklist`." Stop.
> **中文翻译**：如果 [C]：输出"不需要首日补丁。继续执行 `/launch-checklist`。"停止。

### Step 2c — Check total scope / 步骤 2c — 检查总范围

Sum estimated effort. If total exceeds 1 day of work: > "⚠️ Patch scope is [N hours] — this exceeds a safe day-one window. Consider deferring lower-priority items to patch 1.1. A bloated day-one patch introduces more risk than it removes."
> **中文翻译**：合计预计工作量。如果总计超过 1 天的工作量：> "⚠️ 补丁范围为 [N 小时] — 这超出了安全的首日窗口。考虑将较低优先级的项目延至补丁 1.1。臃肿的首日补丁引入的风险大于它消除的风险。"

Use `AskUserQuestion` to confirm proceeding or reduce scope.
> **中文翻译**：使用 `AskUserQuestion` 确认继续或缩小范围。

---

## Phase 3: Rollback Plan / 第 3 阶段：回滚计划

Before any code is written, define the rollback procedure. This is non-negotiable.
> **中文翻译**：在编写任何代码之前，定义回滚程序。这是不可协商的。

Spawn `release-manager` via Task. Ask them to produce a rollback plan covering:
> **中文翻译**：通过 Task 生成 `release-manager`。要求他们制作涵盖以下内容的回滚计划：

- How to revert to the gold master build on each target platform
- Platform-specific rollback constraints (some platforms cannot roll back cert builds)
- Who is responsible for triggering the rollback
- What player communication is required if a rollback occurs

> **中文翻译**：
> - 如何在每个目标平台上恢复到金版构建
> - 平台特定的回滚约束（某些平台无法回滚证书构建）
> - 谁负责触发回滚
> - 如果发生回滚需要什么玩家沟通

Present the rollback plan. Ask: "May I write this rollback plan to `production/releases/rollback-plan-[version].md`?"
> **中文翻译**：呈现回滚计划。问："我可以将此回滚计划写入 `production/releases/rollback-plan-[version].md` 吗？"

Do not proceed to Phase 4 until the rollback plan is written.
> **中文翻译**：在回滚计划写入之前不要继续第 4 阶段。

---

## Phase 4: Implement Fixes / 第 4 阶段：实施修复

For each bug in the approved scope, spawn a focused implementation loop:
> **中文翻译**：对于批准范围内的每个错误，生成一个集中的实施循环：

1. Spawn `lead-programmer` via Task with:
  > **中文翻译**：通过 Task 生成 `lead-programmer`：
   - The bug report (exact reproduction steps and root cause if known)
  > **中文翻译**：错误报告（确切的重现步骤和根本原因（如已知））
   - The constraint: minimum viable fix only, no cleanup
  > **中文翻译**：约束：仅最小可行修复，不进行清理
   - The affected files (from bug report Technical Context section)
  > **中文翻译**：受影响的文件（来自错误报告技术上下文部分）

2. The lead-programmer implements and runs targeted tests.
  > **中文翻译**：首席程序员实施并运行针对性测试。

3. Spawn `qa-tester` via Task to verify: does the bug reproduce after the fix?
  > **中文翻译**：通过 Task 生成 `qa-tester` 验证：修复后错误是否仍可重现？

For config/data-only fixes: make the change directly (no programmer agent needed). Confirm the value changed and re-run any relevant smoke test.
> **中文翻译**：对于仅配置/数据的修复：直接进行更改（不需要程序员代理）。确认更改的值并重新运行任何相关的冒烟测试。

---

## Phase 5: Patch QA Gate / 第 5 阶段：补丁 QA 门控

This is a lightweight QA pass — not a full `/team-qa`. The patch is already QA-approved from the release gate; we are only re-verifying the changed areas.
> **中文翻译**：这是一个轻量级 QA 检查 — 不是完整的 `/team-qa`。补丁已通过发布门控的 QA 批准；我们只是重新验证更改的区域。

Spawn `qa-lead` via Task with:
> **中文翻译**：通过 Task 生成 `qa-lead`：

- List of all changed files
- List of bugs fixed (with verification status from Phase 4)
- The smoke check scope for the affected systems

> **中文翻译**：
> - 所有更改文件的列表
> - 已修复错误列表（附第 4 阶段的验证状态）
> - 受影响系统的冒烟检查范围

Ask qa-lead to determine: **Is a targeted smoke check sufficient, or do any fixes touch systems that require a broader regression?**
> **中文翻译**：要求 qa-lead 确定：**针对性冒烟检查是否足够，还是有任何修复触及需要更广泛回归测试的系统？**

Run the required QA scope:
> **中文翻译**：运行所需的 QA 范围：

- **Targeted smoke check** — run `/smoke-check [affected-systems]`
- **Broader regression** — run targeted tests in `tests/unit/` and `tests/integration/` for affected systems

> **中文翻译**：
> - **针对性冒烟检查** — 运行 `/smoke-check [affected-systems]`
> - **更广泛的回归测试** — 对受影响系统运行 `tests/unit/` 和 `tests/integration/` 中的针对性测试

QA verdict must be PASS or PASS WITH WARNINGS before proceeding. If FAIL: scope the failing fix out of the day-one patch and defer to 1.1.
> **中文翻译**：继续之前 QA 裁决必须是通过或带警告通过。如果失败：将失败的修复从首日补丁范围中移除并延至 1.1。

---

## Phase 6: Generate Patch Record / 第 6 阶段：生成补丁记录

```markdown
# Day-One Patch: [Game Name] v[version]

**Date prepared**: [date]
**Target release**: [launch date or "day of launch"]
**Base build**: [gold master tag or commit]
**Patch build**: [patch tag or commit]

---

## Patch Notes (Internal)

### Bugs Fixed
| BUG-ID | Severity | Description | Fix summary |
|--------|----------|-------------|-------------|
| BUG-NNN | S[1-4] | [description] | [one-line fix] |

### Deferred to 1.1
| BUG-ID | Severity | Description | Reason deferred |
|--------|----------|-------------|-----------------|
| BUG-NNN | S[1-4] | [description] | [reason] |

---

## QA Sign-Off

**QA scope**: [Targeted smoke / Broader regression]
**Verdict**: [PASS / PASS WITH WARNINGS]
**QA lead**: qa-lead agent
**Date**: [date]
**Warnings (if any)**: [list or "None"]

---

## Rollback Plan

See: `production/releases/rollback-plan-[version].md`

**Trigger condition**: If [N] or more S1 bugs are reported within [X] hours of launch, execute rollback.
**Rollback owner**: [user / producer]

---

## Approvals Required Before Deploy

- [ ] lead-programmer: all fixes reviewed
- [ ] qa-lead: QA gate PASS confirmed
- [ ] producer: deployment timing approved
- [ ] release-manager: platform submission confirmed

---

## Player-Facing Patch Notes

[Draft for community-manager to review before publishing]

[list player-facing changes in plain language]
```

Ask: "May I write this patch record to `production/releases/day-one-patch-[version].md`?"
> **中文翻译**：问："我可以将此补丁记录写入 `production/releases/day-one-patch-[version].md` 吗？"

---

## Phase 7: Next Steps / 第 7 阶段：后续步骤

After the patch record is written:
> **中文翻译**：补丁记录写入后：

1. Run `/patch-notes` to generate the player-facing version of the patch notes
2. Run `/bug-report verify [BUG-ID]` for each fixed bug after the patch is live
3. Run `/bug-report close [BUG-ID]` for each verified fix
4. Schedule a post-launch review 48–72 hours after launch using `/retrospective launch`

> **中文翻译**：
> 1. 运行 `/patch-notes` 生成面向玩家的补丁说明版本
> 2. 补丁上线后对每个修复的错误运行 `/bug-report verify [BUG-ID]`
> 3. 对每个验证通过的修复运行 `/bug-report close [BUG-ID]`
> 4. 使用 `/retrospective launch` 安排发布后 48-72 小时的回顾

**If any S1 bugs remain open after the patch:**
> "⚠️ S1 bugs remain open and were not patched. These are accepted risks. Document them in the rollback plan trigger conditions — if they occur at scale, rollback may be preferable to a follow-up patch."
> **中文翻译**：**如果补丁后仍有 S1 错误未解决：**
> "⚠️ S1 错误仍然未解决且未被修补。这些是已接受的风险。将它们记录在回滚计划触发条件中 — 如果大规模发生，回滚可能比后续补丁更可取。"

---

## Collaborative Protocol / 协作协议

- **Scope discipline is everything** — resist scope creep; every addition increases risk
- **Rollback plan first, always** — a patch without a rollback plan is irresponsible
- **Deferred is not forgotten** — every deferred bug gets a 1.1 ticket automatically
- **Player communication is part of the patch** — `/patch-notes` is a required output, not optional

> **中文翻译**：
> - **范围纪律至关重要** — 抵制范围蔓延；每次添加都会增加风险
> - **回滚计划优先，始终如此** — 没有回滚计划的补丁是不负责任的
> - **延后不等于遗忘** — 每个延后的错误都会自动获得 1.1 工单
> - **玩家沟通是补丁的一部分** — `/patch-notes` 是必需的输出，不是可选的
