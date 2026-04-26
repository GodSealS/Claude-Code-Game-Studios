---
name: patch-notes
description: "Generate player-facing patch notes from git history, sprint data, and internal changelogs. Translates developer language into clear, engaging player communication. / 从 git 历史、冲刺数据和内部变更日志生成面向玩家的补丁说明。将开发者语言翻译为清晰、有吸引力的玩家沟通。"
argument-hint: "[version] [--style brief|detailed|full]"
user-invocable: true
allowed-tools: Read, Glob, Grep, Write, Bash
model: haiku
agent: community-manager
---

## Phase 1: Parse Arguments / 阶段 1：解析参数

- `version`: the release version to generate notes for (e.g., `1.2.0`) / `version`：要生成说明的发布版本（例如 `1.2.0`）
- `--style`: output style — `brief` (bullet points), `detailed` (with context), `full` (with developer commentary). Default: `detailed`. / `--style`：输出风格——`brief`（要点）、`detailed`（带上下文）、`full`（带开发者评论）。默认：`detailed`。

If no version is provided, ask the user before proceeding.

> **中文翻译**：如果未提供版本，在继续之前询问用户。

---

## Phase 2: Gather Change Data / 阶段 2：收集变更数据

- Read the internal changelog at `production/releases/[version]/changelog.md` if it exists / 如存在则读取 `production/releases/[version]/changelog.md` 中的内部变更日志
- Also check `docs/CHANGELOG.md` for the relevant version entry / 同时检查 `docs/CHANGELOG.md` 中的相关版本条目
- Run `git log` between the previous release tag and current tag/HEAD as a fallback / 作为后备，在上一个发布标签和当前标签/HEAD 之间运行 `git log`
- Read sprint retrospectives in `production/sprints/` for context / 读取 `production/sprints/` 中的冲刺回顾以获取上下文
- Read any balance change documents in `design/balance/` / 读取 `design/balance/` 中的任何平衡变更文档
- Read bug fix records from QA if available / 如可用则从 QA 读取错误修复记录

**If no changelog data is available** (neither `production/releases/[version]/changelog.md`
nor a `docs/CHANGELOG.md` entry for this version exists, and git log is empty or unavailable):

> **中文翻译**：**如果无变更日志数据可用**（`production/releases/[version]/changelog.md` 和 `docs/CHANGELOG.md` 中的该版本条目都不存在，且 git log 为空或不可用）：

> "No changelog data found for [version]. Run `/changelog [version]` first to generate the
> internal changelog, then re-run `/patch-notes [version]`."
>
> **中文翻译**："未找到 [version] 的变更日志数据。请先运行 `/changelog [version]` 生成内部变更日志，然后重新运行 `/patch-notes [version]`。"

Verdict: **BLOCKED** — stop here without generating notes.

> **中文翻译**：裁决：**BLOCKED** — 在此停止，不生成说明。

---

## Phase 2b: Detect Tone Guide and Template / 阶段 2b：检测语调指南和模板

**Tone guide detection** — before drafting notes, check for writing style guidance:

> **中文翻译**：**语调指南检测** — 在起草说明之前，检查写作风格指南：

1. Check `.codebuddy/docs/technical-preferences.md` for any "tone", "voice", or "style"
   fields or sections. / 检查 `.codebuddy/docs/technical-preferences.md` 中是否有"tone"、"voice"或"style"字段或部分。
2. Check `docs/PATCH-NOTES-STYLE.md` if it exists. / 如存在则检查 `docs/PATCH-NOTES-STYLE.md`。
3. Check `design/community/tone-guide.md` if it exists. / 如存在则检查 `design/community/tone-guide.md`。
4. If any source contains tone/voice/style instructions, extract them and apply
   them to the language and framing of the generated notes. / 如果任何来源包含语调/声音/风格指令，提取并将其应用于生成说明的语言和框架。
5. If no tone guidance is found anywhere, default to:
   player-friendly, non-technical language; enthusiastic but not hyperbolic;
   focus on what the player experiences, not what the developer changed. / 如果在任何地方都未找到语调指南，默认为：对玩家友好的非技术性语言；热情但不过度夸张；关注玩家体验，而非开发者更改。

**Template detection** — check whether a patch notes template exists:

> **中文翻译**：**模板检测** — 检查补丁说明模板是否存在：

1. Glob for `docs/patch-notes-template.md` and `.codebuddy/docs/templates/patch-notes-template.md`. / 搜索 `docs/patch-notes-template.md` 和 `.codebuddy/docs/templates/patch-notes-template.md`。
2. If found at either location, read it and use it as the output structure for Phase 4
   instead of the built-in style templates (Brief / Detailed / Full). Fill in the
   template's sections with the categorized data. / 如果在任一位置找到，读取它并作为阶段 4 的输出结构，替代内置风格模板（Brief / Detailed / Full）。用分类数据填充模板的章节。
3. If not found, use the built-in style templates as defined in Phase 4. / 如果未找到，使用阶段 4 中定义的内置风格模板。

---

## Phase 3: Categorize and Translate / 阶段 3：分类和翻译

Categorize all changes into player-facing categories:

> **中文翻译**：将所有变更分类为面向玩家的类别：

- **New Content**: new features, maps, characters, items, modes / **新内容**：新功能、地图、角色、物品、模式
- **Gameplay Changes**: balance adjustments, mechanic changes, progression changes / **游戏玩法变更**：平衡调整、机制变更、进度变更
- **Quality of Life**: UI improvements, convenience features, accessibility / **生活质量**：UI 改进、便利功能、无障碍
- **Bug Fixes**: grouped by system (combat, UI, networking, etc.) / **错误修复**：按系统分组（战斗、UI、网络等）
- **Performance**: optimization improvements players might notice / **性能**：玩家可能注意到的优化改进
- **Known Issues**: transparency about unresolved problems / **已知问题**：关于未解决问题的透明度

Translate developer language to player language:

> **中文翻译**：将开发者语言翻译为玩家语言：

- "Refactored damage calculation pipeline" → "Improved hit detection accuracy" / "重构伤害计算管线" → "改善了命中检测准确性"
- "Fixed null reference in inventory manager" → "Fixed a crash when opening inventory" / "修复背包管理器中的空引用" → "修复了打开背包时的崩溃"
- "Reduced GC allocations in combat loop" → "Improved combat performance" / "减少战斗循环中的 GC 分配" → "改善了战斗性能"
- Remove purely internal changes that don't affect players / 移除不影响玩家的纯内部变更
- Preserve specific numbers for balance changes (damage: 50 → 45) / 保留平衡变更的具体数值

---

## Phase 4: Generate Patch Notes / 阶段 4：生成补丁说明

### Brief Style / 简要风格
```markdown
# Patch [Version] — [Title]

**New**
- [Feature 1]
- [Feature 2]

**Changes**
- [Balance/mechanic change with before → after values]

**Fixes**
- [Bug fix 1]
- [Bug fix 2]

**Known Issues**
- [Issue 1]
```

### Detailed Style / 详细风格
```markdown
# Patch [Version] — [Title]
*[Date]*

## Highlights
[1-2 sentence summary of the most exciting changes]

## New Content
### [Feature Name]
[2-3 sentences describing the feature and why players should be excited]

## Gameplay Changes
### Balance
| Change | Before | After | Reason |
| ---- | ---- | ---- | ---- |
| [Item/ability] | [old value] | [new value] | [brief rationale] |

### Mechanics
- **[Change]**: [explanation of what changed and why]

## Quality of Life
- [Improvement with context]

## Bug Fixes
### Combat
- Fixed [description of what players experienced]

### UI
- Fixed [description]

### Networking
- Fixed [description]

## Performance
- [Improvement players will notice]

## Known Issues
- [Issue and workaround if available]
```

### Full Style / 完整风格
Includes everything from Detailed, plus: / 包含详细风格的所有内容，另外：
```markdown
## Developer Commentary
### [Topic]
> [Developer insight into a major change — why it was made, what was considered,
> what the team learned. Written in first-person team voice.]
```

---

## Phase 5: Review Output / 阶段 5：审查输出

Check the generated notes for:

> **中文翻译**：检查生成的说明：

- No internal jargon (replace technical terms with player-friendly language) / 无内部行话（用对玩家友好的语言替换技术术语）
- No references to internal systems, tickets, or sprint numbers / 无内部系统、工单或冲刺编号的引用
- Balance changes include before/after values / 平衡变更包含前/后数值
- Bug fixes describe the player experience, not the technical cause / 错误修复描述玩家体验，而非技术原因
- Tone matches the game's voice (adjust formality based on game style) / 语调匹配游戏的声音（根据游戏风格调整正式程度）

---

## Phase 6: Save Patch Notes / 阶段 6：保存补丁说明

Present the completed patch notes to the user along with: a count of changes by category, and any internal changes that were excluded (for review).

> **中文翻译**：将完成的补丁说明呈现给用户，同时提供：按类别的变更计数，以及任何被排除的内部变更（供审查）。

Ask: "May I write these patch notes to `docs/patch-notes/[version].md`?"

> **中文翻译**：询问："我可以将这些补丁说明写入 `docs/patch-notes/[version].md` 吗？"

If yes, write the file to `docs/patch-notes/[version].md`, creating the directory
if needed. Also write to `production/releases/[version]/patch-notes.md` as the
internal archive copy.

> **中文翻译**：如果同意，将文件写入 `docs/patch-notes/[version].md`，如需要则创建目录。同时写入 `production/releases/[version]/patch-notes.md` 作为内部存档副本。

---

## Phase 7: Next Steps / 阶段 7：后续步骤

Verdict: **COMPLETE** — patch notes generated and saved.

> **中文翻译**：裁决：**COMPLETE** — 补丁说明已生成并保存。

- Run `/release-checklist` to verify all other release gates are met before publishing. / 运行 `/release-checklist` 在发布前验证所有其他发布门控已满足。
- Share the patch notes draft with the community-manager for tone review before posting publicly. / 在公开发布前与社区经理分享补丁说明草稿以进行语调审查。