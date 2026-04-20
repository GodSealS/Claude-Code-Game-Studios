# Test Evidence: [Story Title / 故事标题]

> **Story / 故事**: `[path to story file / 故事文件路径]`
> **Story Type / 故事类型**: [Visual/Feel | UI / 视觉/感觉 | UI]
> **Date / 日期**: [date / 日期]
> **Tester / 测试者**: [who performed the test / 执行测试的人]
> **Build / Commit / 构建/提交**: [version or git hash / 版本或git哈希]

---

## What Was Tested / 测试内容

[One paragraph describing the feature or behaviour that was validated. Include
the acceptance criteria numbers from the story that this evidence covers.
一段话描述验证的特性或行为。包括此证据涵盖的故事中的验收标准编号。]

**Acceptance criteria covered / 涵盖的验收标准**: [AC-1, AC-2, AC-3]

---

## Acceptance Criteria Results / 验收标准结果

| # | Criterion (from story) / 标准（来自故事） | Result / 结果 | Notes / 备注 |
|---|----------------------|--------|-------|
| AC-1 | [exact criterion text / 精确标准文本] | PASS / FAIL / 通过 / 失败 | [any observations / 任何观察] |
| AC-2 | [exact criterion text / 精确标准文本] | PASS / FAIL / 通过 / 失败 | |
| AC-3 | [exact criterion text / 精确标准文本] | PASS / FAIL / 通过 / 失败 | |

---

## Screenshots / Video / 截图/视频

List all captured evidence below. Store files in the same directory as this
document or in `production/qa/evidence/[story-slug]/`.
在下面列出所有捕获的证据。将文件存储在此文档的同一目录中或`production/qa/evidence/[story-slug]/`中。

| # | Filename / 文件名 | What It Shows / 显示内容 | Acceptance Criterion / 验收标准 |
|---|----------|--------------|----------------------|
| 1 | `[filename.png]` | [brief description of what is visible / 可见内容的简要描述] | AC-1 |
| 2 | `[filename.png]` | | AC-2 |

*If video / 如果是视频: note the timestamp and what it demonstrates. / 记录时间戳和它演示的内容。*

---

## Test Conditions / 测试条件

- **Game state at start / 开始时的游戏状态**: [e.g., "fresh save, player at level 1, no items" / 例如，"新存档，玩家等级1，无物品"]
- **Platform / hardware / 平台/硬件**: [e.g., "Windows 11, GTX 1080, 1080p" / 例如，"Windows 11, GTX 1080, 1080p"]
- **Framerate during test / 测试期间帧率**: [e.g., "stable 60fps" or "~45fps — within budget" / 例如，"稳定60fps"或"~45fps — 在预算内"]
- **Any special setup required / 需要的任何特殊设置**: [e.g., "dev menu used to trigger specific state" / 例如，"使用开发菜单触发特定状态"]

---

## Observations / 观察

[Anything noteworthy that didn't cause a FAIL but should be recorded. Examples:
minor visual jitter, frame dip under load, behaviour that technically passes
but felt slightly off. These become candidates for polish work.
任何值得注意但未导致失败但应记录的内容。示例：轻微视觉抖动、负载下帧率下降、技术上通过但感觉稍有不妥的行为。这些成为打磨工作的候选。]

- [Observation 1 / 观察1]
- [Observation 2 / 观察2]
