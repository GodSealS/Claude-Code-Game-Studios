---
name: hotfix
description: "Emergency fix workflow that bypasses normal sprint processes with a full audit trail. Creates hotfix branch, tracks approvals, and ensures the fix is backported correctly. / 绕过正常冲刺流程的紧急修复工作流，保留完整审计追踪。创建热修分支，跟踪审批，并确保修复正确回移。"
argument-hint: "[bug-id or description]"
user-invocable: true
allowed-tools: Read, Glob, Grep, Write, Edit, Bash, Task
---

> **Explicit invocation only**: This skill should only run when the user explicitly requests it with `/hotfix`. Do not auto-invoke based on context matching.
> **中文翻译**：> **仅限显式调用**：此技能仅在用户通过 `/hotfix` 显式请求时运行。不要基于上下文匹配自动调用。

## Phase 1: Assess Severity / 第 1 阶段：评估严重性

Read the bug description or ID. Determine severity: / 读取缺陷描述或 ID。确定严重性：

- **S1 (Critical)**: Game unplayable, data loss, security vulnerability — hotfix immediately / **S1（关键）**：游戏无法游玩、数据丢失、安全漏洞 — 立即热修
- **S2 (Major)**: Significant feature broken, workaround exists — hotfix within 24 hours / **S2（重大）**：重要功能损坏，有变通方案 — 24 小时内热修
- If severity is S3 or lower, recommend using the normal bug fix workflow instead and stop. / 如果严重性为 S3 或更低，建议改用正常缺陷修复工作流并停止。

---

## Phase 2: Create Hotfix Record / 第 2 阶段：创建热修记录

Draft the hotfix record: / 起草热修记录：

```markdown
## Hotfix: [Short Description] / 热修：[简短描述]
Date: [Date] / 日期：[日期]
Severity: [S1/S2] / 严重性：[S1/S2]
Reporter: [Who found it] / 报告人：[谁发现的]
Status: IN PROGRESS / 状态：进行中

### Problem / 问题
[Clear description of what is broken and the player impact] / [清楚描述什么损坏了以及对玩家的影响]

### Root Cause / 根本原因
[To be filled during investigation] / [在调查期间填写]

### Fix / 修复
[To be filled during implementation] / [在实施期间填写]

### Testing / 测试
[What was tested and how] / [测试了什么以及如何测试]

### Approvals / 审批
- [ ] Fix reviewed by lead-programmer / 修复由首席程序员审查
- [ ] Regression test passed (qa-tester) / 回归测试通过（qa-tester）
- [ ] Release approved (producer) / 发布批准（制作人）

### Rollback Plan / 回滚计划
[How to revert if the fix causes new issues] / [如果修复引起新问题如何回滚]
```

Ask: "May I write this to `production/hotfixes/hotfix-[date]-[short-name].md`?"
> **中文翻译**：询问："我可以将其写入 `production/hotfixes/hotfix-[date]-[short-name].md` 吗？"

If yes, write the file, creating the directory if needed. / 如果是，写入文件，必要时创建目录。

---

## Phase 3: Create Hotfix Branch / 第 3 阶段：创建热修分支

If git is initialized, create the hotfix branch: / 如果已初始化 git，创建热修分支：

```
git checkout -b hotfix/[short-name] [release-tag-or-main]
```

---

## Phase 4: Investigate and Implement / 第 4 阶段：调查和实施

Focus on the minimal change that resolves the issue. Do NOT refactor, clean up, or add features alongside the hotfix.
> **中文翻译**：专注于解决问题的最小更改。不要在热修的同时进行重构、清理或添加功能。

Validate the fix by running targeted tests for the affected system. Check for regressions in adjacent systems.
> **中文翻译**：通过运行受影响系统的针对性测试来验证修复。检查相邻系统的回归。

Update the hotfix record with root cause, fix details, and test results.
> **中文翻译**：用根本原因、修复详情和测试结果更新热修记录。

---

## Phase 5: Collect Approvals / 第 5 阶段：收集审批

Use the Task tool to request sign-off in parallel: / 使用 Task 工具并行请求签核：

- `subagent_type: lead-programmer` — Review the fix for correctness and side effects / 审查修复的正确性和副作用
- `subagent_type: qa-tester` — Run targeted regression tests on the affected system / 对受影响系统运行针对性回归测试
- `subagent_type: producer` — Approve deployment timing and communication plan / 批准部署时间和沟通计划

All three must return APPROVE before proceeding. If any returns CONCERNS or REJECT, do not deploy — surface the issue and resolve it first.
> **中文翻译**：三者都必须返回批准才能继续。如果任何返回关注或拒绝，不要部署 — 呈现问题并先解决它。

---

## Phase 5b: QA Re-Entry Gate / 第 5b 阶段：QA 重入门控

After approvals, determine the QA scope required before deploying the hotfix. Spawn `qa-lead` via Task with: / 审批后，确定部署热修前所需的 QA 范围。通过 Task 生成 `qa-lead`：
- The hotfix description and affected system / 热修描述和受影响系统
- The regression test results from Phase 5 / 第 5 阶段的回归测试结果
- A list of all systems that touch the changed files (use Grep to find callers) / 所有涉及更改文件的系统列表（使用 Grep 查找调用者）

Ask qa-lead: **Is a full smoke check sufficient, or does this fix require a targeted team-qa pass?**
> **中文翻译**：询问 qa-lead：**完整冒烟检查是否足够，还是此修复需要针对性的 team-qa 通过？**

Apply the verdict: / 应用裁决：
- **Smoke check sufficient** — run `/smoke-check` against the hotfix build. If PASS, proceed to Phase 6. / **冒烟检查足够** — 对热修构建运行 `/smoke-check`。如果通过，继续第 6 阶段。
- **Targeted QA pass required** — run `/team-qa [affected-system]` scoped to the changed system only. If QA returns APPROVED or APPROVED WITH CONDITIONS, proceed to Phase 6. / **需要针对性 QA 通过** — 运行 `/team-qa [affected-system]` 仅限于更改的系统。如果 QA 返回批准或有条件批准，继续第 6 阶段。
- **Full QA required** — S1 fixes that touch core systems may require a full `/team-qa sprint`. This delays deployment but prevents a bad patch. / **需要完整 QA** — 涉及核心系统的 S1 修复可能需要完整的 `/team-qa sprint`。这会延迟部署但防止糟糕的补丁。

Do not skip this gate. A hotfix that breaks something else is worse than the original bug.
> **中文翻译**：不要跳过此门控。破坏其他东西的热修比原始缺陷更糟糕。

---

## Phase 6: Update Bug Status and Deploy / 第 6 阶段：更新缺陷状态并部署

Update the original bug file if one exists: / 如果存在原始缺陷文件，更新它：

```markdown
## Fix Record / 修复记录
**Fixed in**: hotfix/[branch-name] — [commit hash or description] / **修复于**：hotfix/[branch-name] — [提交哈希或描述]
**Fixed date**: [date] / **修复日期**：[日期]
**Status**: Fixed — Pending Verification / **状态**：已修复 — 待验证
```

Set `**Status**: Fixed — Pending Verification` in the bug file header. / 在缺陷文件头中设置 `**Status**: Fixed — Pending Verification`。

Output a deployment summary: / 输出部署摘要：

```
## Hotfix Ready to Deploy: [short-name] / 热修已准备好部署：[short-name]

**Severity**: [S1/S2] / **严重性**：[S1/S2]
**Root cause**: [one line] / **根本原因**：[一行]
**Fix**: [one line] / **修复**：[一行]
**QA gate**: [Smoke check PASS / Team-QA APPROVED] / **QA 门控**：[冒烟检查通过 / Team-QA 批准]
**Approvals**: lead-programmer ✓ / qa-tester ✓ / producer ✓ / **审批**：首席程序员 ✓ / qa-tester ✓ / 制作人 ✓
**Rollback plan**: [from Phase 2 record] / **回滚计划**：[来自第 2 阶段记录]

Merge to: release branch AND development branch / 合并到：发布分支和开发分支
Next: /bug-report verify [BUG-ID] after deploy to confirm resolution / 下一步：部署后运行 /bug-report verify [BUG-ID] 确认解决
```

### Rules / 规则
- Hotfixes must be the MINIMUM change to fix the issue — no cleanup, no refactoring / 热修必须是修复问题的最小更改 — 不进行清理，不进行重构
- Every hotfix must have a rollback plan documented before deployment / 每个热修必须在部署前记录回滚计划
- Hotfix branches merge to BOTH the release branch AND the development branch / 热修分支同时合并到发布分支和开发分支
- All hotfixes require a post-incident review within 48 hours / 所有热修需要在 48 小时内进行事后审查
- If the fix is complex enough to need more than 4 hours, escalate to `technical-director` / 如果修复足够复杂需要超过 4 小时，升级到 `technical-director`

---

## Phase 7: Post-Deploy Verification / 第 7 阶段：部署后验证

After deploying, run `/bug-report verify [BUG-ID]` to confirm the fix resolved the issue in the deployed build.
> **中文翻译**：部署后，运行 `/bug-report verify [BUG-ID]` 确认修复在部署的构建中解决了问题。

If VERIFIED FIXED: run `/bug-report close [BUG-ID]` to formally close it. / 如果已验证修复：运行 `/bug-report close [BUG-ID]` 正式关闭它。
If STILL PRESENT: the hotfix failed — immediately re-open, assess rollback, and escalate. / 如果仍然存在：热修失败 — 立即重新打开，评估回滚，并升级。

Schedule a post-incident review within 48 hours using `/retrospective hotfix`. / 使用 `/retrospective hotfix` 安排 48 小时内的事后审查。
