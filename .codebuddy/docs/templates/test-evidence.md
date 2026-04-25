# Test Evidence: [Story Title] / 测试证据：[故事标题]

> **Story**: `[path to story file]` / **故事：** `[路径到故事文件]`
> **Story Type**: [Visual/Feel | UI] / **故事类型：** [视觉/感觉 | UI]
> **Date**: [date] / **日期：** [日期]
> **Tester**: [who performed the test] / **测试者：** [执行测试的人员]
> **Build / Commit**: [version or git hash] / **构建/提交：** [版本或git哈希]

---

## What Was Tested / 测试内容

[One paragraph describing the feature or behaviour that was validated. Include
the acceptance criteria numbers from the story that this evidence covers.] / [一段话描述已验证的功能或行为。包括此证据覆盖的故事的验收标准编号。]

**Acceptance criteria covered**: [AC-1, AC-2, AC-3] / **覆盖的验收标准：** [AC-1, AC-2, AC-3]

---

## Acceptance Criteria Results / 验收标准结果

| # | Criterion (from story) / 标准（来自故事） | Result / 结果 | Notes / 备注 |
|---|----------------------|--------|-------|
| AC-1 | [exact criterion text] | PASS / FAIL | [any observations] |
| AC-2 | [exact criterion text] | PASS / FAIL | |
| AC-3 | [exact criterion text] | PASS / FAIL | |

---

## Screenshots / Video / 截图/视频

List all captured evidence below. Store files in the same directory as this
document or in `production/qa/evidence/[story-slug]/`. / 下面列出所有捕获的证据。将文件存储在此文档的同一目录中或存储在 `production/qa/evidence/[story-slug]/` 中。

| # | Filename / 文件名 | What It Shows / 展示内容 | Acceptance Criterion / 验收标准 |
|---|----------|--------------|----------------------|
| 1 | `[filename.png]` | [brief description of what is visible / 可见内容的简要描述] | AC-1 |
| 2 | `[filename.png]` | | AC-2 |

*If video: note the timestamp and what it demonstrates.* / *如果是视频：记录时间戳及其展示的内容。*

---

## Test Conditions / 测试条件

- **Game state at start**: [e.g., "fresh save, player at level 1, no items"] / **开始时游戏状态：** [例如："新存档，玩家等级1，无物品"]
- **Platform / hardware**: [e.g., "Windows 11, GTX 1080, 1080p"] / **平台/硬件：** [例如："Windows 11，GTX 1080，1080p"]
- **Framerate during test**: [e.g., "stable 60fps" or "~45fps — within budget"] / **测试期间帧率：** [例如："稳定60fps"或"~45fps — 在预算内"]
- **Any special setup required**: [e.g., "dev menu used to trigger specific state"] / **所需特殊设置：** [例如："使用开发者菜单触发特定状态"]

---

## Observations / 观察结果

[Anything noteworthy that didn't cause a FAIL but should be recorded. Examples:
minor visual jitter, frame dip under load, behaviour that technically passes
but felt slightly off. These become candidates for polish work.] / [任何值得注意但未导致FAIL的内容都应记录。示例：
轻微的视觉抖动、负载下的帧率下降、技术上通过但感觉略有问题的行为。这些成为优化工作的候选。]

- [Observation 1 / 观察结果1]
- [Observation 2 / 观察结果2]

If nothing notable: *No significant observations.* / 如果没有值得注意的：*无显著观察结果。*

---

## Sign-Off / 签字批准

All three sign-offs are required before the story can be marked COMPLETE via
`/story-done`. Visual/Feel stories require the designer or art-lead sign-off.
UI stories require the UX lead or designer sign-off. / 在故事可以通过 `/story-done` 标记为完成之前，需要所有三个签字批准。视觉/感觉故事需要设计师或艺术主管签字。UI故事需要UX主管或设计师签字。

| Role / 角色 | Name / 姓名 | Date / 日期 | Signature / 签字 |
|------|------|------|-----------|
| Developer (implemented) / 开发人员（实现者） | | | [ ] Approved / [ ] 批准 |
| Designer / Art Lead / UX Lead / 设计师/艺术主管/UX主管 | | | [ ] Approved / [ ] 批准 |
| QA Lead / QA主管 | | | [ ] Approved / [ ] 批准 |

**Any sign-off can be marked "Deferred — [reason]"** if the person is
unavailable. Deferred sign-offs must be resolved before the story advances
past the sprint review. / **任何签字都可以标记为"延期 — [原因]"，** 如果相关人员不可用。延期签字必须在故事通过sprint评审之前解决。

---

*Template: `.codebuddy/docs/templates/test-evidence.md`* / *模板：`.codebuddy/docs/templates/test-evidence.md`*
*Used for: Visual/Feel and UI story type evidence records* / *用于：视觉/感觉和UI故事类型的证据记录*
*Location: `production/qa/evidence/[story-slug]-evidence.md`* / *位置：`production/qa/evidence/[story-slug]-evidence.md`*
