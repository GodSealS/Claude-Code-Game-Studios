---
name: bug-report
description: "Creates a structured bug report from a description, or analyzes code to identify potential bugs. Ensures every bug report has full reproduction steps, severity assessment, and context. / 从描述创建结构化缺陷报告，或分析代码识别潜在缺陷。确保每个缺陷报告包含完整的复现步骤、严重性评估和上下文。"
argument-hint: "[description] | analyze [path-to-file]"
user-invocable: true
allowed-tools: Read, Glob, Grep, Write
---

## Phase 1: Parse Arguments / 第 1 阶段：解析参数


Determine the mode from the argument:
> **中文翻译**：从参数确定模式：


- No keyword → **Description Mode**: generate a structured bug report from the provided description
  > **中文翻译**：无关键字 → **描述模式**：根据提供的描述生成结构化错误报告
- `analyze [path]` → **Analyze Mode**: read the target file(s) and identify potential bugs
  > **中文翻译**：`analyze [path]` → **分析模式**：读取目标文件并识别潜在的错误
- `verify [BUG-ID]` → **Verify Mode**: confirm a reported fix actually resolved the bug
  > **中文翻译**：`验证 [BUG-ID]` → **验证模式**：确认报告的修复确实解决了错误
- `close [BUG-ID]` → **Close Mode**: mark a verified bug as closed with resolution record
  > **中文翻译**：`关闭 [BUG-ID]` → **关闭模式**：将已验证的错误标记为已关闭并带有解决记录


If no argument is provided, ask the user for a bug description before proceeding.
> **中文翻译**：如果未提供参数，请在继续之前询问用户错误描述。


---

## Phase 2A: Description Mode / 第 2A 阶段：描述模式

1. **Parse the description** for key information: what broke, when, how to reproduce it, and what the expected behavior is.

2. **Search the codebase** for related files using Grep/Glob to add context (affected system, likely files).

3. **Draft the bug report**:

```markdown
# Bug Report

## Summary
**Title**: [Concise, descriptive title]
**ID**: BUG-[NNNN]
**Severity**: [S1-Critical / S2-Major / S3-Minor / S4-Trivial]
**Priority**: [P1-Immediate / P2-Next Sprint / P3-Backlog / P4-Wishlist]
**Status**: Open
**Reported**: [Date]
**Reporter**: [Name]

## Classification
- **Category**: [Gameplay / UI / Audio / Visual / Performance / Crash / Network]
- **System**: [Which game system is affected]
- **Frequency**: [Always / Often (>50%) / Sometimes (10-50%) / Rare (<10%)]
- **Regression**: [Yes/No/Unknown -- was this working before?]

## Environment
- **Build**: [Version or commit hash]
- **Platform**: [OS, hardware if relevant]
- **Scene/Level**: [Where in the game]
- **Game State**: [Relevant state -- inventory, quest progress, etc.]

## Reproduction Steps
**Preconditions**: [Required state before starting]

1. [Exact step 1]
2. [Exact step 2]
3. [Exact step 3]

**Expected Result**: [What should happen]
**Actual Result**: [What actually happens]

## Technical Context
- **Likely affected files**: [List of files based on codebase search]
- **Related systems**: [What other systems might be involved]
- **Possible root cause**: [If identifiable from the description]

## Evidence
- **Logs**: [Relevant log output if available]
- **Visual**: [Description of visual evidence]

## Related Issues
- [Links to related bugs or design documents]

## Notes
[Any additional context or observations]
```

---

## Phase 2B: Analyze Mode / 第 2B 阶段：分析模式


1. **Read the target file(s)** specified in the argument.
  > **中文翻译**：**读取参数中指定的目标文件**。


2. **Identify potential bugs**: null references, off-by-one errors, race conditions, unhandled edge cases, resource leaks, incorrect state transitions.
  > **中文翻译**：**识别潜在的错误**：空引用、相差一错误、竞争条件、未处理的边缘情况、资源泄漏、不正确的状态转换。


3. **For each potential bug**, generate a bug report using the template above, with the likely trigger scenario and recommended fix filled in.
  > **中文翻译**：**对于每个潜在的错误**，使用上面的模板生成错误报告，并填写可能的触发场景和建议的修复。


---

## Phase 2C: Verify Mode / 第 2C 阶段：验证模式

Read `production/qa/bugs/[BUG-ID].md`. Extract the reproduction steps and expected result.
> **中文翻译**：读取 `production/qa/bugs/[BUG-ID].md`。提取复现步骤和预期结果。

1. **Re-run reproduction steps** — use Grep/Glob to check whether the root cause code path still exists as described. If the fix removed or changed it, note the change.
   > **中文翻译**：**重新运行复现步骤** — 使用 Grep/Glob 检查根本原因代码路径是否仍按描述存在。如果修复已删除或更改了它，记录该变更。
2. **Run the related test** — if the bug's system has a test file in `tests/`, run it via Bash and report pass/fail.
   > **中文翻译**：**运行相关测试** — 如果缺陷系统在 `tests/` 中有测试文件，通过 Bash 运行并报告通过/失败。
3. **Check for regression** — grep the codebase for any new occurrence of the pattern that caused the bug.
   > **中文翻译**：**检查回归** — 使用 grep 在代码库中搜索导致缺陷模式的任何新出现。

Produce a verification verdict: / 生成验证裁决：

- **VERIFIED FIXED** — reproduction steps no longer produce the bug; related tests pass / **已验证修复** — 复现步骤不再产生缺陷；相关测试通过
- **STILL PRESENT** — bug reproduces as described; fix did not resolve the issue / **仍然存在** — 缺陷按描述复现；修复未解决问题
- **CANNOT VERIFY** — automated checks inconclusive; manual playtest required / **无法验证** — 自动化检查不确定；需要手动试玩

Ask: "May I update `production/qa/bugs/[BUG-ID].md` to set Status: Verified Fixed / Still Present / Cannot Verify?"
> **中文翻译**：询问："我可以更新 `production/qa/bugs/[BUG-ID].md` 将状态设置为：已验证修复/仍然存在/无法验证吗？"

If STILL PRESENT: reopen the bug, set Status back to Open, and suggest re-running `/hotfix [BUG-ID]`.
> **中文翻译**：如果仍然存在：重新打开缺陷，将状态设回"开放"，并建议重新运行 `/hotfix [BUG-ID]`。

---

## Phase 2D: Close Mode
> **中文翻译**：## 第 2D 阶段：关闭模式


Read `production/qa/bugs/[BUG-ID].md`. Confirm Status is `Verified Fixed` before closing. If status is anything else, stop: "Bug [ID] must be Verified Fixed before it can be closed. Run `/bug-report verify [BUG-ID]` first."
> **中文翻译**：阅读 `product/qa/bugs/[BUG-ID].md`。关闭前确认状态为“已验证已修复”。如果状态为其他任何内容，请停止：“Bug [ID] 必须经过验证修复才能关闭。首先运行 `/bug-report verify [BUG-ID]`。”


Append a closure record to the bug file:
> **中文翻译**：将关闭记录附加到错误文件中：


```markdown
## Closure Record
**Closed**: [date]
**Resolution**: Fixed — [one-line description of what was changed]
**Fix commit / PR**: [if known]
**Verified by**: qa-tester
**Closed by**: [user]
**Regression test**: [test file path, or "Manual verification"]
**Status**: Closed
```

Update the top-level `**Status**: Open` field to `**Status**: Closed`.
> **中文翻译**：将顶级“**状态**：开放”字段更新为“**状态**：已关闭”。


Ask: "May I update `production/qa/bugs/[BUG-ID].md` to mark it Closed?"
> **中文翻译**：问：“我可以更新`product/qa/bugs/[BUG-ID].md`以将其标记为“已关闭”吗？”


After closing, check `production/qa/bug-triage-*.md` — if the bug appears in an open triage report, note: "Bug [ID] is referenced in the triage report. Run `/bug-triage` to refresh the open bug count."
> **中文翻译**：关闭后，检查“Production/qa/bug-triage-*.md”——如果该错误出现在打开的分类报告中，请注意：“分类报告中引用了错误 [ID]。运行“/bug-triage”以刷新打开的错误计数。”


---

## Phase 3: Save Report / 第 3 阶段：保存报告

Present the completed bug report(s) to the user.
> **中文翻译**：向用户展示完整的缺陷报告。

Ask: "May I write this to `production/qa/bugs/BUG-[NNNN].md`?"
> **中文翻译**：询问："我可以将其写入 `production/qa/bugs/BUG-[NNNN].md` 吗？"

If yes, write the file, creating the directory if needed. Verdict: **COMPLETE** — bug report filed.
> **中文翻译**：如果是，写入文件，必要时创建目录。裁决：**完成** — 缺陷报告已归档。

If no, stop here. Verdict: **BLOCKED** — user declined write.
> **中文翻译**：如果否，在此停止。裁决：**阻塞** — 用户拒绝写入。

---

## Phase 4: Next Steps
> **中文翻译**：## 第 4 阶段：后续步骤


After saving, suggest based on mode:
> **中文翻译**：保存后，根据模式建议：


**After filing (Description/Analyze mode):**
> **中文翻译**：**归档后（描述/分析模式）：**

- Run `/bug-triage` to prioritize alongside existing open bugs
  > **中文翻译**：运行“/bug-triage”以与现有的未解决错误一起确定优先级
- If S1 or S2: run `/hotfix [BUG-ID]` for emergency fix workflow
  > **中文翻译**：如果 S1 或 S2：运行“/hotfix [BUG-ID]”进行紧急修复工作流程


**After fixing the bug (developer confirms fix is in):**
> **中文翻译**：**修复错误后（开发人员确认已修复）：**

- Run `/bug-report verify [BUG-ID]` — confirm the fix actually works before closing
  > **中文翻译**：运行“/bug-report verify [BUG-ID]”——在关闭之前确认修复确实有效
- Never mark a bug closed without verification — a fix that doesn't verify is still Open
  > **中文翻译**：切勿在未经验证的情况下将错误标记为已关闭 - 未验证的修复仍处于打开状态


**After verify returns VERIFIED FIXED:**
> **中文翻译**：**验证返回后已验证已修复：**

- Run `/bug-report close [BUG-ID]` — write the closure record and update status
  > **中文翻译**：运行 `/bug-report close [BUG-ID]` — 写入关闭记录并更新状态
- Run `/bug-triage` to refresh the open bug count and remove it from the active list
  > **中文翻译**：运行“/bug-triage”刷新未解决的错误计数并将其从活动列表中删除

