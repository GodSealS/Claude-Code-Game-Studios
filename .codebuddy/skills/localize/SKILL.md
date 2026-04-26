---
name: localize
description: "Full localization pipeline: scan for hardcoded strings, extract and manage string tables, validate translations, generate translator briefings, run cultural/sensitivity review, manage VO localization, test RTL/platform requirements, enforce string freeze, and report coverage. / 完整本地化管线：扫描硬编码字符串、提取和管理字符串表、验证翻译、生成翻译员简报、运行文化/敏感性审查、管理语音本地化、测试 RTL/平台要求、执行字符串冻结并报告覆盖率。"
argument-hint: "[scan|extract|validate|status|brief|cultural-review|vo-pipeline|rtl-check|freeze|qa]"
user-invocable: true
agent: localization-lead
allowed-tools: Read, Glob, Grep, Write, Bash, Task, AskUserQuestion
---

# Localization Pipeline / 本地化管线

Localization is not just translation — it is the full process of making a game
feel native in every language and region. Poor localization breaks immersion,
confuses players, and blocks platform certification. This skill covers the
complete pipeline from string extraction through cultural review, VO recording,
RTL layout testing, and localization QA sign-off.

> **中文翻译**：本地化不仅是翻译——它是让游戏在每种语言和地区都感觉原生的完整过程。糟糕的本地化会破坏沉浸感、困惑玩家，并阻碍平台认证。此技能覆盖从字符串提取到文化审查、语音录制、RTL 布局测试和本地化 QA 签收的完整管线。

**Modes / 模式：**
- `scan` — Find hardcoded strings and localization anti-patterns (read-only) / 查找硬编码字符串和本地化反模式（只读）
- `extract` — Extract strings and generate translation-ready tables / 提取字符串并生成可翻译的表格
- `validate` — Check translations for completeness, placeholders, and length / 检查翻译的完整性、占位符和长度
- `status` — Coverage matrix across all locales / 所有语言区域的覆盖率矩阵
- `brief` — Generate translator context briefing document for an external team / 为外部团队生成翻译员上下文简报文档
- `cultural-review` — Flag culturally sensitive content, symbols, colours, idioms / 标记文化敏感内容、符号、颜色、习语
- `vo-pipeline` — Manage voice-over localization: scripts, recording specs, integration / 管理语音本地化：脚本、录制规格、集成
- `rtl-check` — Validate RTL language layout, mirroring, and font support / 验证 RTL 语言布局、镜像和字体支持
- `freeze` — Enforce string freeze; lock source strings before translation begins / 执行字符串冻结；在翻译开始前锁定源字符串
- `qa` — Run the full localization QA cycle before release / 在发布前运行完整的本地化 QA 周期

If no subcommand is provided, output usage and stop. Verdict: **FAIL** — missing required subcommand.

> **中文翻译**：如果未提供子命令，输出用法并停止。裁决：**FAIL** — 缺少必需的子命令。

---

## Phase 2A: Scan Mode / 阶段 2A：扫描模式

Search `src/` for hardcoded user-facing strings:
/ 在 `src/` 中搜索硬编码的面向用户的字符串：

- String literals in UI code not wrapped in a localization function (`tr()`, `Tr()`, `NSLocalizedString`, `GetText`, etc.) / UI 代码中未包装在本地化函数中的字符串字面量
- Concatenated strings that should be parameterized / 应参数化的拼接字符串
- Strings with positional placeholders (`%s`, `%d`) instead of named ones (`{playerName}`) / 使用位置占位符而非命名占位符的字符串
- Format strings that mix locale-sensitive data (numbers, dates, currencies) without locale-aware formatting / 混合区域敏感数据（数字、日期、货币）但未使用区域感知格式的格式字符串

Search for localization anti-patterns:
/ 搜索本地化反模式：

- Date/time formatting not using locale-aware functions / 未使用区域感知函数的日期/时间格式化
- Number formatting without locale awareness (`1,000` vs `1.000`) / 无区域感知的数字格式化
- Text embedded in images or textures (flag asset files in `assets/`) / 嵌入图片或纹理中的文本（标记 `assets/` 中的资产文件）
- Strings that assume left-to-right text direction (positional layout, string assembly order) / 假设从左到右文本方向的字符串（位置布局、字符串组装顺序）
- Gender/plurality assumptions baked into string logic (must use plural forms or gender tokens) / 字符串逻辑中内置的性别/数量假设（必须使用复数形式或性别标记）
- Hardcoded punctuation (e.g. `"You won!"` — exclamation styles vary by locale) / 硬编码标点（例如 `"You won!"` — 感叹号风格因地区而异）

Report all findings with file paths and line numbers. This mode is read-only — no files are written.

> **中文翻译**：报告所有发现，包含文件路径和行号。此模式为只读——不写入任何文件。

---

## Phase 2B: Extract Mode / 阶段 2B：提取模式

- Scan all source files for localized string references / 扫描所有源文件中的本地化字符串引用
- Compare against the existing string table in `assets/data/strings/` / 与 `assets/data/strings/` 中现有的字符串表比较
- Generate new entries for strings not yet keyed / 为尚未设置键的字符串生成新条目
- Suggest key names following the convention: `[category].[subcategory].[description]` / 按照约定建议键名：`[类别].[子类别].[描述]`
  - Example: `ui.hud.health_label`, `dialogue.npc.merchant.greeting`, `menu.main.play_button`
- Each new entry must include a `context` field — a translator comment explaining: / 每个新条目必须包含 `context` 字段——一个翻译员注释，说明：
  - Where it appears (which screen, which scene) / 出现位置（哪个屏幕、哪个场景）
  - Maximum character length / 最大字符长度
  - Any placeholder meaning (`{playerName}` = the player's chosen display name) / 任何占位符含义
  - Gender/plurality context if applicable / 如适用的性别/数量上下文

Output a diff of new strings to add to the string table.

> **中文翻译**：输出要添加到字符串表的新字符串差异。

Present the diff to the user. Ask: "May I write these new entries to `assets/data/strings/strings-en.json`?"

> **中文翻译**：将差异展示给用户。询问："我可以将这些新条目写入 `assets/data/strings/strings-en.json` 吗？"

If yes, write only the diff (new entries), not a full replacement. Verdict: **COMPLETE** — strings extracted and written.

> **中文翻译**：如果同意，仅写入差异（新条目），而非完整替换。裁决：**COMPLETE** — 字符串已提取并写入。

---

## Phase 2C: Validate Mode / 阶段 2C：验证模式

Read all string table files in `assets/data/strings/`. For each locale, check:
/ 读取 `assets/data/strings/` 中的所有字符串表文件。对每个语言区域检查：

- **Completeness** — key exists in source (en) but no translation for this locale / **完整性** — 键存在于源（en）但此语言区域无翻译
- **Placeholder mismatches** — source has `{name}` but translation omits it or adds extras / **占位符不匹配** — 源有 `{name}` 但翻译遗漏或添加了额外的
- **String length violations** — translation exceeds the character limit recorded in the source `context` field / **字符串长度违规** — 翻译超出源 `context` 字段记录的字符限制
- **Plural form count** — locale requires N plural forms; translation provides fewer / **复数形式数量** — 语言区域需要 N 种复数形式；翻译提供了较少的
- **Orphaned keys** — translation exists but nothing in `src/` references the key / **孤立键** — 翻译存在但 `src/` 中无任何内容引用该键
- **Stale translations** — source string changed after translation was written (flag for re-translation) / **过时翻译** — 源字符串在翻译写入后已更改（标记需重新翻译）
- **Encoding** — non-ASCII characters present and font atlas supports them (flag if uncertain) / **编码** — 存在非 ASCII 字符且字体图集支持它们（如不确定则标记）

Report validation results grouped by locale and severity. This mode is read-only — no files are written.

> **中文翻译**：按语言区域和严重程度分组报告验证结果。此模式为只读——不写入任何文件。

---

## Phase 2D: Status Mode / 阶段 2D：状态模式

- Count total localizable strings in the source table / 计算源表中的可本地化字符串总数
- Per locale: count translated, untranslated, stale (source changed since translation) / 每个语言区域：统计已翻译、未翻译、过时（翻译后源已更改）的数量
- Generate a coverage matrix: / 生成覆盖率矩阵：

```markdown
## Localization Status
Generated: [Date]
String freeze: [Active / Not yet called / Lifted]

| Locale | Total | Translated | Missing | Stale | Coverage |
|--------|-------|-----------|---------|-------|----------|
| en (source) | [N] | [N] | 0 | 0 | 100% |
| [locale] | [N] | [N] | [N] | [N] | [X]% |

### Issues
- [N] hardcoded strings found in source code (run /localize scan)
- [N] strings exceeding character limits
- [N] placeholder mismatches
- [N] orphaned keys
- [N] strings added after freeze was called (freeze violations)
```

This mode is read-only — no files are written.

> **中文翻译**：此模式为只读——不写入任何文件。

---

## Phase 2E: Brief Mode / 阶段 2E：简报模式

Generate a translator context briefing document. This document is sent to the
external translation team or localisation vendor alongside the string table export.

> **中文翻译**：生成翻译员上下文简报文档。此文档与字符串表导出一起发送给外部翻译团队或本地化供应商。

Read:
- `design/gdd/` — extract game genre, tone, setting, character names / 提取游戏类型、基调、设定、角色名称
- `assets/data/strings/strings-en.json` — the source string table / 源字符串表
- Any existing lore or narrative documents in `design/narrative/` / `design/narrative/` 中现有的世界观或叙事文档

Generate `production/localization/translator-brief-[locale]-[date].md`:

```markdown
# Translator Brief — [Game Name] — [Locale]

## Game Overview
[2-3 paragraph summary of the game, genre, tone, and audience]
/ [2-3段游戏摘要，包括类型、基调和受众]

## Tone and Voice
- **Overall tone**: [e.g., "Darkly comic, not slapstick — think Terry Pratchett, not Looney Tunes"] / **整体基调**
- **Player address**: [e.g., "Second person, informal. Never formal 'vous' — always 'tu' for French"] / **对玩家的称呼**
- **Profanity policy**: [e.g., "Mild — PG-13 equivalent. Match intensity to source, do not soften or escalate"] / **脏话策略**
- **Humour**: [e.g., "Wordplay exists — if a pun cannot translate, invent an equivalent local joke; do not translate literally"] / **幽默**

## Character Glossary
| Name | Role | Personality | Notes |
|------|------|-------------|-------|
| [Name] | [Role] | [Personality] | [Do not translate / transliterate as X] / [不翻译 / 音译为 X] |

## World Glossary
| Term | Meaning | Notes |
|------|---------|-------|
| [Term] | [What it means] | [Keep in English / translate as X] / [保持英文 / 翻译为 X] |

## Do Not Translate List
The following must appear verbatim in all locales:
/ 以下内容必须在所有语言区域中原样显示：
- [Game name]
- [UI terms that match in-engine labels] / [匹配引擎内标签的 UI 术语]
- [Brand or trademark names] / [品牌或商标名称]

## Placeholder Reference
| Placeholder | What it represents | Example |
|-------------|-------------------|---------|
| `{playerName}` | Player's chosen display name | "Shadowblade" |
| `{count}` | Integer quantity | "3" |

## Character Limits
Tight UI fields with hard limits are marked in the string table `context` field.
Where no limit is stated, target ±30% of the English length as a guideline.

> **中文翻译**：有硬性限制的紧凑 UI 字段在字符串表的 `context` 字段中标记。如未说明限制，以英文长度的 ±30% 为指导目标。

## Contact
Direct questions to: [placeholder for user/team contact] / 直接联系：[用户/团队联系方式占位符]
Delivery format: JSON, same schema as strings-en.json / 交付格式：JSON，与 strings-en.json 相同的架构
```

Ask: "May I write this translator brief to `production/localization/translator-brief-[locale]-[date].md`?"

> **中文翻译**：询问："我可以将此翻译员简报写入 `production/localization/translator-brief-[locale]-[date].md` 吗？"

---

## Phase 2F: Cultural Review Mode / 阶段 2F：文化审查模式

Spawn `localization-lead` via Task. Ask them to audit the following for cultural sensitivity across the target locales (read from `assets/data/strings/` and `assets/`):
/ 通过 Task 启动 `localization-lead`。要求他们审核目标语言区域的文化敏感性（从 `assets/data/strings/` 和 `assets/` 读取）：

### Content Areas to Review / 审查内容领域

**Symbols and gestures / 符号与手势**
- Thumbs up, OK hand, peace sign — meanings vary by region / 竖大拇指、OK 手势、和平手势——含义因地区而异
- Religious or spiritual symbols in art, UI, or audio / 美术、UI 或音频中的宗教或精神符号
- National flags, map representations, disputed territories / 国旗、地图表示、争议领土

**Colours / 颜色**
- White (mourning in some Asian cultures), green (political associations in some regions), red (luck vs danger) / 白色（某些亚洲文化中的丧色）、绿色（某些地区的政治关联）、红色（好运 vs 危险）
- Alert/warning colours that conflict with cultural associations / 与文化关联冲突的警报/警告颜色

**Numbers / 数字**
- 4 (death in Japanese/Chinese), 13, 666 — flag use in UI (room numbers, item counts, prices) / 4（日语/中文中的死亡）、13、666——标记 UI 中的使用（房间号、物品数量、价格）

**Humour and idioms / 幽默与习语**
- Idioms that translate as offensive in other locales / 在其他语言区域翻译为冒犯性内容的习语
- Toilet/bodily humour that is inappropriate in some markets (notably Japan, Germany, Middle East) / 在某些市场不适当的厕所/身体幽默（尤其是日本、德国、中东）
- Dark humour around topics that are culturally sensitive in specific regions / 围绕特定地区文化敏感话题的黑色幽默

**Violence and content ratings / 暴力与内容分级**
- Content that would require ratings changes in DE (Germany), AU (Australia), CN (China), or AE (UAE) / 在 DE（德国）、AU（澳大利亚）、CN（中国）或 AE（阿联酋）需要更改分级的内容
- Blood colour, gore level, drug references — flag all for region-specific asset variants if needed / 血液颜色、血腥程度、药物引用——如需要，为特定地区的资产变体标记所有内容

**Names and representations / 名称与表现**
- Character names that are offensive, profane, or carry negative meaning in target locales / 在目标语言区域中具有冒犯性、亵渎性或负面含义的角色名称
- Stereotyped representation of nationalities, religions, or ethnic groups / 对国籍、宗教或族裔群体的刻板表现

Present findings as a table:
/ 以表格形式呈现发现：

| Finding | Locale(s) Affected | Severity | Recommended Action |
|---------|--------------------|----------|--------------------|
| [Description] | [Locale] | [BLOCKING / ADVISORY / NOTE] | [Change / Flag for review / Accept] |

BLOCKING = must fix before shipping that locale. ADVISORY = recommend change. NOTE = informational only.

> **中文翻译**：BLOCKING = 该语言区域发布前必须修复。ADVISORY = 建议更改。NOTE = 仅供参考。

Ask: "May I write this cultural review report to `production/localization/cultural-review-[date].md`?"

> **中文翻译**：询问："我可以将此文化审查报告写入 `production/localization/cultural-review-[date].md` 吗？"

---

## Phase 2G: VO Pipeline Mode / 阶段 2G：语音管线模式

Manage the voice-over localization process. Determine the sub-task from the argument:
/ 管理语音本地化流程。从参数确定子任务：

- `vo-pipeline scan` — identify all dialogue lines that require VO recording / 识别所有需要语音录制的对话行
- `vo-pipeline script` — generate recording scripts with director notes / 生成带导演注释的录制脚本
- `vo-pipeline validate` — check that all recorded VO files are present and correctly named / 检查所有录制的语音文件是否存在且命名正确
- `vo-pipeline integrate` — verify VO files are correctly referenced in code/assets / 验证语音文件在代码/资产中被正确引用

### VO Pipeline: Scan / 语音管线：扫描

Read `assets/data/strings/` and `design/narrative/`. Identify:
- All dialogue lines (keys matching `dialogue.*`) with source text / 所有对话行（键匹配 `dialogue.*`）及其源文本
- Lines already recorded (audio file exists in `assets/audio/vo/`) / 已录制的行（`assets/audio/vo/` 中存在音频文件）
- Lines not yet recorded / 尚未录制的行

Output a recording manifest:
/ 输出录制清单：

```
## VO Recording Manifest — [Date]

| Key | Character | Source Line | Status |
|-----|-----------|-------------|--------|
| dialogue.npc.merchant.greeting | Merchant | "Welcome, traveller." | Recorded |
| dialogue.npc.merchant.haggle | Merchant | "That's my final offer." | Needs recording |
```

### VO Pipeline: Script / 语音管线：脚本

Generate a recording script document for each character, grouped by scene. Include:
/ 为每个角色生成录制脚本文档，按场景分组。包括：

- Character name and brief personality note / 角色名称和简短性格说明
- Full dialogue line with pronunciation guide for unusual proper nouns / 完整对话行及不常见专有名词的发音指南
- Emotion/direction note for each line (`[Warm, welcoming]`, `[Annoyed, clipped]`) / 每行的情感/方向注释
- Any lines that are responses in a conversation (provide context: "Player just said X") / 对话中的回应行（提供上下文："玩家刚说了 X"）

Ask: "May I write the VO recording scripts to `production/localization/vo-scripts-[locale]-[date].md`?"

> **中文翻译**：询问："我可以将语音录制脚本写入 `production/localization/vo-scripts-[locale]-[date].md` 吗？"

### VO Pipeline: Validate / 语音管线：验证

Glob `assets/audio/vo/[locale]/` for all `.wav`/`.ogg` files. Cross-reference against the VO manifest. Report:
- Missing files (line in script, no audio file) / 缺失文件（脚本中有行但无音频文件）
- Extra files (audio file exists, no matching string key) / 多余文件（音频文件存在但无匹配的字符串键）
- Naming convention violations / 命名约定违规

### VO Pipeline: Integrate / 语音管线：集成

Grep `src/` for VO audio references. Verify each referenced path exists in `assets/audio/vo/[locale]/`. Report broken references.

> **中文翻译**：在 `src/` 中搜索语音音频引用。验证每个引用路径在 `assets/audio/vo/[locale]/` 中存在。报告断裂的引用。

---

## Phase 2H: RTL Check Mode / 阶段 2H：RTL 检查模式

Right-to-left languages (Arabic, Hebrew, Persian, Urdu) require layout mirroring beyond
just translating text. This mode validates the implementation.

> **中文翻译**：从右到左的语言（阿拉伯语、希伯来语、波斯语、乌尔都语）需要超越文本翻译的布局镜像。此模式验证实现。

Read `.codebuddy/docs/technical-preferences.md` to determine the engine. Then check:
/ 读取 `.codebuddy/docs/technical-preferences.md` 确定引擎。然后检查：

**Layout mirroring / 布局镜像**
- Is RTL layout enabled in the engine? (Godot: `Control.layout_direction`, Unity: `RTL Support` package, Unreal: text direction flags) / 引擎中是否启用了 RTL 布局？
- Are all UI containers set to auto-mirror, or are positions hardcoded? / 所有 UI 容器是否设置为自动镜像，还是位置是硬编码的？
- Do progress bars, health bars, and directional indicators mirror correctly? / 进度条、血条和方向指示器是否正确镜像？

**Text rendering / 文本渲染**
- Are fonts loaded that support Arabic/Hebrew character sets? / 是否加载了支持阿拉伯语/希伯来语字符集的字体？
- Is Arabic text rendered with correct ligatures (connected script)? / 阿拉伯语文本是否以正确的连字（连接脚本）渲染？
- Are numbers displayed as Eastern Arabic numerals where required? / 数字是否在需要时显示为东阿拉伯数字？

**String assembly / 字符串组装**
- Are there any string concatenations that assume left-to-right reading order? / 是否有假设从左到右阅读顺序的字符串拼接？
- Do `{placeholder}` positions in sentences work correctly when sentence structure is reversed? / 句子结构反转时，`{placeholder}` 位置是否正确工作？

**Asset review / 资产审查**
- Are there UI icons with directional arrows or asymmetric designs that need mirrored variants? / 是否有带方向箭头或非对称设计的 UI 图标需要镜像变体？
- Do any text-in-image assets exist that require RTL versions? / 是否存在需要 RTL 版本的图文资产？

Grep patterns to check:
/ 要检查的 Grep 模式：
- Engine-specific RTL flags in scene/prefab files / 场景/预制件文件中引擎特定的 RTL 标志
- Any `HBoxContainer`, `LinearLayout`, `HorizontalBox` nodes — verify layout_direction settings / 任何 `HBoxContainer`、`LinearLayout`、`HorizontalBox` 节点——验证 layout_direction 设置
- String concatenation with `+` near dialogue or UI code / 对话或 UI 代码附近使用 `+` 的字符串拼接

Report findings. Flag BLOCKING issues (content unreadable without fix) vs ADVISORY (cosmetic improvements).

> **中文翻译**：报告发现。标记 BLOCKING 问题（不修复则内容不可读）vs ADVISORY（外观改进）。

Ask: "May I write this RTL check report to `production/localization/rtl-check-[date].md`?"

> **中文翻译**：询问："我可以将此 RTL 检查报告写入 `production/localization/rtl-check-[date].md` 吗？"

---

## Phase 2I: Freeze Mode / 阶段 2I：冻结模式

String freeze locks the source (English) string table so that translations can proceed
without the source changing under the translators.

> **中文翻译**：字符串冻结锁定源（英文）字符串表，以便翻译可以在源不在翻译人员手中更改的情况下进行。

### freeze call / 冻结调用

Check current freeze status in `production/localization/freeze-status.md` (if it exists).

> **中文翻译**：在 `production/localization/freeze-status.md`（如存在）中检查当前冻结状态。

If already frozen:
> "String freeze is currently ACTIVE (called [date]). [N] strings have been added or modified since freeze. These are freeze violations — they require re-translation or an approved freeze lift."

> **中文翻译**："字符串冻结当前处于活动状态（于 [date] 调用）。自冻结以来已有 [N] 个字符串被添加或修改。这些是冻结违规——它们需要重新翻译或批准的冻结解除。"

If not frozen, present the pre-freeze checklist:
/ 如果未冻结，呈现冻结前检查清单：

```
Pre-Freeze Checklist
[ ] All planned UI screens are implemented / 所有计划的 UI 屏幕已实现
[ ] All dialogue lines are final (no further narrative revisions planned) / 所有对话行已定稿（不再计划叙事修订）
[ ] All system strings (error messages, tutorial text) are complete / 所有系统字符串（错误消息、教程文本）已完成
[ ] /localize scan shows zero hardcoded strings / /localize scan 显示零硬编码字符串
[ ] /localize validate shows no placeholder mismatches in source (en) / /localize validate 显示源（en）中无占位符不匹配
[ ] Marketing strings (store description, achievements) are final / 营销字符串（商店描述、成就）已定稿
```

Use `AskUserQuestion`:
- Prompt: "Are all items above confirmed? Calling string freeze locks the source table." / 提示："以上所有项目是否已确认？调用字符串冻结将锁定源表。"
- Options: `[A] Yes — call string freeze now` / `[A] 是——现在调用字符串冻结` `[B] No — I still have strings to add` / `[B] 否——我还有字符串要添加`

If [A]: Write `production/localization/freeze-status.md`:

```markdown
# String Freeze Status

**Status**: ACTIVE
**Called**: [date]
**Called by**: [user]
**Total strings at freeze**: [N]

## Post-Freeze Changes
[Any strings added or modified after freeze are listed here automatically by /localize extract]
/ [冻结后添加或修改的任何字符串由 /localize extract 自动在此列出]
```

### freeze lift / 冻结解除

If argument includes `lift`: update `freeze-status.md` Status to `LIFTED`, record the reason and date. Warn: "Lifting the freeze requires re-translation of all modified strings. Notify the translation team."

> **中文翻译**：如果参数包含 `lift`：将 `freeze-status.md` 的状态更新为 `LIFTED`，记录原因和日期。警告："解除冻结需要重新翻译所有修改的字符串。请通知翻译团队。"

### freeze check (auto-integrated into extract) / 冻结检查（自动集成到提取中）

When `extract` mode finds new or modified strings and `freeze-status.md` shows Status: ACTIVE — append the new keys to `## Post-Freeze Changes` and warn:
> "⚠️ String freeze is active. [N] new/modified strings have been added. These are freeze violations. Notify your localization vendor before proceeding."

> **中文翻译**："⚠️ 字符串冻结处于活动状态。已添加 [N] 个新/修改的字符串。这些是冻结违规。在继续之前通知您的本地化供应商。"

---

## Phase 2J: QA Mode / 阶段 2J：QA 模式

Localization QA is a dedicated pass that runs after translations are delivered but
before any locale ships. This is not the same as `/validate` (which checks completeness)
— this is a structured playthrough-based quality check.

> **中文翻译**：本地化 QA 是在翻译交付后但任何语言区域发布前运行的专用测试阶段。这与 `/validate`（检查完整性）不同——这是基于结构化游戏流程的质量检查。

Spawn `localization-lead` via Task with:
/ 通过 Task 启动 `localization-lead`，附带：
- The target locale(s) to QA / 要 QA 的目标语言区域
- The list of all screens/flows in the game (from `design/gdd/` or `/content-audit` output) / 游戏中所有屏幕/流程的列表
- The current `/localize validate` report / 当前的 `/localize validate` 报告
- The cultural review report (if it exists) / 文化审查报告（如存在）

Ask the localization-lead to produce a QA plan covering:
/ 要求 localization-lead 生成 QA 计划，涵盖：

1. **Functional string check** — every string displays in-game without truncation, placeholder errors, or encoding corruption / **功能字符串检查** — 每个字符串在游戏中正确显示，无截断、占位符错误或编码损坏
2. **UI overflow check** — translated strings that exceed UI bounds (even if within character limits, some languages expand) / **UI 溢出检查** — 超出 UI 边界的翻译字符串（即使在字符限制内，某些语言也会扩展）
3. **Contextual accuracy** — a sample of 10% of strings reviewed in-game for translation accuracy and natural phrasing / **上下文准确性** — 10% 的字符串样本在游戏中审查翻译准确性和自然表达
4. **Cultural review items** — verify all BLOCKING items from the cultural review are resolved / **文化审查项目** — 验证文化审查中的所有 BLOCKING 项目已解决
5. **VO sync check** — if VO exists, verify lip sync or subtitle timing is acceptable after translation / **语音同步检查** — 如有语音，验证翻译后口型同步或字幕时序是否可接受
6. **Platform cert requirements** — check platform-specific localization requirements (age ratings text, legal notices, ESRB/PEGI/CERO text) / **平台认证要求** — 检查平台特定的本地化要求

Output a QA verdict per locale:
/ 每个语言区域输出 QA 裁决：

```
## Localization QA Verdict — [Locale]

**Status**: PASS / PASS WITH CONDITIONS / FAIL
**Reviewed by**: localization-lead
**Date**: [date]

### Findings
| ID | Area | Description | Severity | Status |
|----|------|-------------|----------|--------|
| LOC-001 | UI Overflow | "Settings" button text overflows on [Screen] | BLOCKING | Open |
| LOC-002 | Translation | [Key] translation is literal — sounds unnatural | ADVISORY | Open |

### Conditions (if PASS WITH CONDITIONS) / 条件（如果为 PASS WITH CONDITIONS）
- [Condition 1 — must resolve before ship] / [条件1——发布前必须解决]

### Sign-Off
[ ] All BLOCKING findings resolved / 所有 BLOCKING 发现已解决
[ ] Producer approves shipping [Locale] / 制作人批准发布 [语言区域]
```

Ask: "May I write this localization QA report to `production/localization/loc-qa-[locale]-[date].md`?"

> **中文翻译**：询问："我可以将此本地化 QA 报告写入 `production/localization/loc-qa-[locale]-[date].md` 吗？"

**Gate integration**: The Polish → Release gate requires a PASS or PASS WITH CONDITIONS verdict for every locale being shipped. A FAIL blocks release for that locale only — other locales may still proceed if their QA passes.

> **中文翻译**：**门控集成**：Polish → Release 门控要求每个发布语言区域获得 PASS 或 PASS WITH CONDITIONS 裁决。FAIL 仅阻止该语言区域的发布——其他语言区域如果 QA 通过仍可继续。

---

## Phase 3: Rules and Next Steps / 阶段 3：规则与后续步骤

### Rules / 规则
- English (en) is always the source locale / 英语（en）始终是源语言区域
- Every string table entry must include a `context` field with translator notes, character limits, and placeholder meaning / 每个字符串表条目必须包含带有翻译员注释、字符限制和占位符含义的 `context` 字段
- Never modify translation files directly — generate diffs for review / 切勿直接修改翻译文件——生成差异供审查
- Character limits must be defined per-UI-element and enforced in validate mode / 字符限制必须按 UI 元素定义并在验证模式下强制执行
- String freeze must be called before sending strings to translators — never translate a moving target / 在向翻译员发送字符串之前必须调用字符串冻结——切勿翻译移动目标
- RTL support must be designed in from the start — retrofitting RTL layout is expensive / RTL 支持必须从一开始就设计——后期加装 RTL 布局代价高昂
- Cultural review is required for any locale where the game will be sold commercially / 游戏将商业销售的任何语言区域都需要文化审查
- VO scripts must include director notes — raw dialogue lines produce flat recordings / 语音脚本必须包含导演注释——原始对话行会产生平淡的录制

### Recommended Workflow / 推荐工作流

```
/localize scan            → find hardcoded strings / 查找硬编码字符串
/localize extract         → build string table / 构建字符串表
/localize freeze          → lock source before sending to translators / 在发送给翻译员前锁定源
/localize brief           → generate translator briefing document / 生成翻译员简报文档
[Send to translators]     / [发送给翻译员]
/localize validate        → check returned translations / 检查返回的翻译
/localize cultural-review → flag culturally sensitive content / 标记文化敏感内容
/localize rtl-check       → if shipping Arabic / Hebrew / Persian / 如果发布阿拉伯语/希伯来语/波斯语
/localize vo-pipeline     → if shipping dubbed VO / 如果发布配音语音
/localize qa              → full localization QA pass / 完整本地化 QA 通过
```

After `qa` returns PASS for all shipping locales, include the QA report path when running `/gate-check release`.

> **中文翻译**：在 `qa` 对所有发布语言区域返回 PASS 后，运行 `/gate-check release` 时包含 QA 报告路径。
