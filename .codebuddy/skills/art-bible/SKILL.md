---
name: art-bible
description: "Guided, section-by-section Art Bible authoring. Creates the visual identity specification that gates all asset production. Run after /brainstorm is approved and before /map-systems or any GDD authoring begins. / 引导式逐节美术圣经编写。创建所有资产生产的视觉标识规范。在 /brainstorm 被批准后、/map-systems 或任何 GDD 编写之前运行。"
argument-hint: "[--review full|lean|solo]"
user-invocable: true
allowed-tools: Read, Glob, Grep, Write, Edit, Task, AskUserQuestion
---

## Phase 0: Parse Arguments and Context Check / 第 0 阶段：解析参数和上下文检查

Resolve the review mode (once, store for all gate spawns this run):
> **中文翻译**：解析审查模式（一次性，存储本次运行所有门生成的结果）：

1. If `--review [full|lean|solo]` was passed → use that / 如果传入了 `--review [full|lean|solo]` → 使用该值
2. Else read `production/review-mode.txt` → use that value / 否则读取 `production/review-mode.txt` → 使用该值
3. Else → default to `lean` / 否则 → 默认为 `lean`

See `.codebuddy/docs/director-gates.md` for the full check pattern.
> **中文翻译**：完整检查模式参见 `.codebuddy/docs/director-gates.md`。

Read `design/gdd/game-concept.md`. If it does not exist, fail with:
> **中文翻译**：读取 `design/gdd/game-concept.md`。如果不存在，则失败：

> "No game concept found. Run `/brainstorm` first — the art bible is authored after the game concept is approved."
> **中文翻译**："未找到游戏概念。请先运行 `/brainstorm` — 美术圣经在游戏概念被批准后编写。"

Extract from game-concept.md:
> **中文翻译**：从 game-concept.md 中提取：

- Game title (working title) / 游戏名称（暂定名称）
- Core fantasy and elevator pitch / 核心幻想和电梯推介
- Game pillars (all of them) / 游戏支柱（全部）
- **Visual Identity Anchor** section if present (from brainstorm Phase 4 art-director output) / **视觉标识锚点**部分（如果存在）（来自头脑风暴第 4 阶段美术总监的输出）
- Target platform (if noted) / 目标平台（如果注明）

**Retrofit mode detection**: Glob `design/art/art-bible.md`. If the file exists:
> **中文翻译**：**改造模式检测**：Glob `design/art/art-bible.md`。如果文件存在：

- Read it in full / 完整读取
- For each of the 9 sections, check whether the body contains real content (more than a `[To be designed]` placeholder or similar) vs. is empty/placeholder / 对于 9 个章节中的每一个，检查正文是否包含真实内容（多于 `[To be designed]` 占位符或类似内容）还是空/占位符
- Build a section status table: / 构建章节状态表：

```
Section | Status
--------|--------
1. Visual Identity Statement | [Complete / Empty / Placeholder]
2. Color Palette | ...
3. Lighting & Atmosphere | ...
4. Character Art Direction | ...
5. Environment & Level Art | ...
6. UI Visual Language | ...
7. VFX & Particle Style | ...
8. Asset Standards | ...
9. Style Prohibitions | ...
```

- Present this table to the user: / 将此表呈现给用户：

  > "Found existing art bible at `design/art/art-bible.md`. [N] sections are complete, [M] need content. I'll work on the incomplete sections only — existing content will not be touched."
  > **中文翻译**："在 `design/art/art-bible.md` 找到现有美术圣经。[N] 个章节已完成，[M] 个需要内容。我将仅处理不完整的章节 — 现有内容不会被修改。"

- Only work on sections with Status: Empty or Placeholder. Do not re-author sections that are already complete. / 仅处理状态为 Empty 或 Placeholder 的章节。不要重新创作已完成的章节。

If the file does not exist, this is a fresh authoring session — proceed normally.
> **中文翻译**：如果文件不存在，这是新的创作会话 — 正常进行。

Read `.codebuddy/docs/technical-preferences.md` if it exists — extract performance budgets and engine for asset standard constraints.
> **中文翻译**：读取 `.codebuddy/docs/technical-preferences.md`（如果存在）— 提取性能预算和引擎以用于资产标准约束。

---

## Phase 1: Framing / 第 1 阶段：框架设定

Present the session context and ask two questions before authoring anything:
> **中文翻译**：在创作任何内容之前，呈现会话上下文并询问两个问题：

Use `AskUserQuestion` with two tabs:
> **中文翻译**：使用 `AskUserQuestion` 的两个标签页：

- Tab **"Scope"** — "Which sections need to be authored today?" / 标签 **"范围"** — "今天需要创作哪些章节？"
  Options: `Full bible — all 9 sections` / `Visual identity core (sections 1–4 only)` / `Asset standards only (section 8)` / `Resume — fill in missing sections` / 选项：`完整圣经 — 全部 9 个章节` / `视觉标识核心（仅第 1-4 章节）` / `仅资产标准（第 8 章节）` / `恢复 — 填充缺失章节`
- Tab **"References"** — "Do you have reference games, films, or art that define the visual direction?" / 标签 **"参考资料"** — "您有定义视觉方向的参考游戏、电影或艺术作品吗？"
  (Free text — let the user type specific titles. Do NOT preset options here.) / （自由文本 — 让用户输入具体标题。不要预设选项。）

If the game-concept.md has a Visual Identity Anchor section, note it:
> **中文翻译**：如果 game-concept.md 有视觉标识锚点章节，注明它：

> "Found a visual identity anchor from brainstorm: '[anchor name] — [one-line rule]'. I'll use this as the foundation for the art bible."
> **中文翻译**："从头脑风暴中找到视觉标识锚点：'[锚点名称] — [单行规则]'。我将以此作为美术圣经的基础。"

---

## Phase 2: Visual Identity Foundation (Sections 1–4) / 第 2 阶段：视觉标识基础（第 1-4 章节）

These four sections define the core visual language. **All other sections flow from them.** Author and write each to file before moving to the next.
> **中文翻译**：这四个章节定义了核心视觉语言。**所有其他章节都源于它们。** 在进入下一个之前创作并写入文件。

### Section 1: Visual Identity Statement / 第 1 章节：视觉标识声明

**Goal**: A one-line visual rule plus 2–3 supporting principles that resolve visual ambiguity.
> **中文翻译**：**目标**：一行视觉规则加上 2-3 个解决视觉歧义的支持原则。

If a visual anchor exists from game-concept.md: present it and ask:
> **中文翻译**：如果 game-concept.md 中存在视觉锚点：呈现它并询问：

- "Build directly from this anchor?" / "直接从这个锚点构建？"
- "Revise it before expanding?" / "扩展前先修改？"
- "Start fresh with new options?" / "用新选项重新开始？"

**Agent delegation (MANDATORY)**: Spawn `art-director` via Task:
> **中文翻译**：**代理委派（强制）**：通过 Task 生成 `art-director`：

- Provide: game concept (elevator pitch, core fantasy), full pillar set, platform target, any reference games/art from Phase 1 framing, the visual anchor if it exists / 提供：游戏概念（电梯推介、核心幻想）、完整支柱集、平台目标、第 1 阶段框架中的任何参考游戏/艺术、视觉锚点（如果存在）
- Ask: "Draft a Visual Identity Statement for this game. Provide: (1) a one-line visual rule that could resolve any visual decision ambiguity, (2) 2–3 supporting visual principles, each with a one-sentence design test ('when X is ambiguous, this principle says choose Y'). Anchor all principles directly in the stated pillars — each principle must serve a specific pillar." / 要求："为此游戏起草视觉标识声明。提供：(1) 一行可以解决任何视觉决策歧义的视觉规则，(2) 2-3 个支持性视觉原则，每个原则有一个一句话设计测试（'当 X 不明确时，此原则要求选择 Y'）。将所有原则直接锚定在所述支柱中 — 每个原则必须服务于特定支柱。"

Present the art-director's draft to the user. Use `AskUserQuestion`:
> **中文翻译**：将美术总监的草稿呈现给用户。使用 `AskUserQuestion`：

- Options: `[A] Lock this in` / `[B] Revise the one-liner` / `[C] Revise a supporting principle` / `[D] Describe my own direction` / 选项：`[A] 锁定此方案` / `[B] 修改单行规则` / `[C] 修改支持原则` / `[D] 描述我自己的方向`

Write the approved section to file immediately.
> **中文翻译**：批准后立即将章节写入文件。

### Section 2: Mood & Atmosphere / 第 2 章节：情绪与氛围

**Goal**: Emotional targets by game state — specific enough for a lighting artist to work from.
> **中文翻译**：**目标**：按游戏状态划分的情感目标 — 足够具体以供灯光艺术家工作。

For each major game state (e.g., exploration, combat, victory, defeat, menus — adapt to this game's states), define:
> **中文翻译**：对于每个主要游戏状态（例如，探索、战斗、胜利、失败、菜单 — 适应该游戏的状态），定义：

- Primary emotion/mood target / 主要情绪/氛围目标
- Lighting character (time of day, color temperature, contrast level) / 灯光特性（时间段、色温、对比度级别）
- Atmospheric descriptors (3–5 adjectives) / 氛围描述词（3-5 个形容词）
- Energy level (frenetic / measured / contemplative / etc.) / 能量水平（狂热/稳重/沉思/等）

**Agent delegation**: Spawn `art-director` via Task with the Visual Identity Statement and pillar set. Ask: "Define mood and atmosphere targets for each major game state in this game. Be specific — 'dark and foreboding' is not enough. Name the exact emotional target, the lighting character (warm/cool, high/low contrast, time of day direction), and at least one visual element that carries the mood. Each game state must feel visually distinct from the others."
> **中文翻译**：**代理委派**：通过 Task 生成 `art-director`，提供视觉标识声明和支柱集。要求："为此游戏中的每个主要游戏状态定义情绪和氛围目标。要具体 — '黑暗和不祥'是不够的。说出确切的情感目标、灯光特性（暖/冷、高/低对比度、时间段方向），以及至少一个承载情绪的视觉元素。每个游戏状态必须在视觉上与其他状态明显区分。"

Write the approved section to file immediately.
> **中文翻译**：批准后立即将章节写入文件。

### Section 3: Shape Language / 第 3 章节：形状语言

**Goal**: The geometric vocabulary that makes this game's world visually coherent and distinguishable.
> **中文翻译**：**目标**：使游戏世界在视觉上连贯且可区分的几何词汇。

Cover:
> **中文翻译**：覆盖：

- Character silhouette philosophy (how readable at thumbnail size? Distinguishing trait per archetype?) / 角色轮廓理念（缩略图大小时的可读性如何？每个原型的区分特征？）
- Environment geometry (angular/curved/organic/geometric — which dominates and why?) / 环境几何（棱角/曲线/有机/几何 — 哪种占主导及原因？）
- UI shape grammar (does UI echo the world aesthetic, or is it a distinct HUD language?) / UI 形状语法（UI 是呼应世界美学，还是独特的 HUD 语言？）
- Hero shapes vs. supporting shapes (what draws the eye, what recedes?) / 主角形状与辅助形状（什么吸引视线，什么退居背景？）

**Agent delegation**: Spawn `art-director` via Task with Visual Identity Statement and mood targets. Ask: "Define the shape language for this game. Connect each shape principle back to the visual identity statement and a specific game pillar. Explain what these shape choices communicate to the player emotionally."
> **中文翻译**：**代理委派**：通过 Task 生成 `art-director`，提供视觉标识声明和情绪目标。要求："为此游戏定义形状语言。将每个形状原则与视觉标识声明和特定游戏支柱联系起来。解释这些形状选择在情感上向玩家传达了什么。"

Write the approved section to file immediately.
> **中文翻译**：批准后立即将章节写入文件。

### Section 4: Color System / 第 4 章节：色彩系统

**Goal**: A complete, producible palette system that serves both aesthetic and communication needs.
> **中文翻译**：**目标**：一个完整的、可生产的调色板系统，同时服务于美学和沟通需求。

Cover:
> **中文翻译**：覆盖：

- Primary palette (5–7 colors with roles — not just hex codes, but what each color means in this world) / 主调色板（5-7 种颜色及其角色 — 不仅是十六进制代码，而是每种颜色在这个世界中的含义）
- Semantic color usage (what does red communicate? Gold? Blue? White? Establish the color vocabulary) / 语义色彩用法（红色传达什么？金色？蓝色？白色？建立色彩词汇）
- Per-biome or per-area color temperature rules (if the game has distinct areas) / 按生物群落或区域的色温规则（如果游戏有不同区域）
- UI palette (may differ from world palette — define the divergence explicitly) / UI 调色板（可能与世界调色板不同 — 明确定义差异）
- Colorblind safety: which semantic colors need shape/icon/sound backup / 色盲安全：哪些语义颜色需要形状/图标/声音备份

**Agent delegation**: Spawn `art-director` via Task with Visual Identity Statement and mood targets. Ask: "Design the color system for this game. Every semantic color assignment must be explained — why does this color mean danger/safety/reward in this world? Identify which color pairs might fail colorblind players and specify what backup cues are needed."
> **中文翻译**：**代理委派**：通过 Task 生成 `art-director`，提供视觉标识声明和情绪目标。要求："为此游戏设计色彩系统。每个语义色彩分配都必须解释 — 为什么这种颜色在这个世界中意味着危险/安全/奖励？识别哪些颜色对可能让色盲玩家失败，并指定需要什么备用提示。"

Write the approved section to file immediately.
> **中文翻译**：批准后立即将章节写入文件。

---

## Phase 3: Production Guides (Sections 5–8) / 第 3 阶段：生产指南（第 5-8 章节）

These sections translate the visual identity into concrete production rules. They should be specific enough that an outsourcing team can follow them without additional briefing.
> **中文翻译**：这些章节将视觉标识转化为具体的生产规则。它们应足够具体，使外包团队无需额外简报即可遵循。

### Section 5: Character Design Direction / 第 5 章节：角色设计方向

**Agent delegation**: Spawn `art-director` via Task with sections 1–4. Ask: "Define character design direction for this game. Cover: visual archetype for the player character (if any), distinguishing feature rules per character type (how do players tell enemies/NPCs/allies apart at a glance?), expression/pose style targets (stiff/expressive/realistic/exaggerated), and LOD philosophy (how much detail is preserved at game camera distance?)."
> **中文翻译**：**代理委派**：通过 Task 生成 `art-director`，提供第 1-4 章节。要求："为此游戏定义角色设计方向。覆盖：玩家角色的视觉原型（如有）、每种角色类型的区分特征规则（玩家如何一眼区分敌人/NPC/盟友？）、表情/姿势风格目标（僵硬/富有表现力/写实/夸张）以及 LOD 理念（游戏摄像机距离保留多少细节？）。"

Write the approved section to file.
> **中文翻译**：批准后将章节写入文件。

### Section 6: Environment Design Language / 第 6 章节：环境设计语言

**Agent delegation**: Spawn `art-director` via Task with sections 1–4. Ask: "Define the environment design language for this game. Cover: architectural style and its relationship to the world's culture/history, texture philosophy (painted vs. PBR vs. stylized — why this choice for this game?), prop density rules (sparse/dense — what drives the choice per area type?), and environmental storytelling guidelines (what visual details should tell the story without text?)."
> **中文翻译**：**代理委派**：通过 Task 生成 `art-director`，提供第 1-4 章节。要求："为此游戏定义环境设计语言。覆盖：建筑风格及其与世界文化/历史的关系、纹理理念（手绘 vs. PBR vs. 风格化 — 为什么为此游戏选择这种方式？）、道具密度规则（稀疏/密集 — 每种区域类型的驱动因素是什么？）以及环境叙事指南（哪些视觉细节应该不用文字就讲述故事？）。"

Write the approved section to file.
> **中文翻译**：批准后将章节写入文件。

### Section 7: UI/HUD Visual Direction / 第 7 章节：UI/HUD 视觉方向

**Agent delegation**: Spawn in parallel:
> **中文翻译**：**代理委派**：并行生成：

- **`art-director`**: Visual style for UI — diegetic vs. screen-space HUD, typography direction (font personality, weight, size hierarchy), iconography style (flat/outlined/illustrated/photorealistic), animation feel for UI elements / **`art-director`**：UI 视觉风格 — 沉浸式 vs. 屏幕空间 HUD、排版方向（字体个性、粗细、大小层级）、图标风格（扁平/轮廓/插画/照片级真实感）、UI 元素动画感觉
- **`ux-designer`**: UX alignment check — does the visual direction support the interaction patterns this game requires? Flag any conflicts between art direction and readability/accessibility needs. / **`ux-designer`**：UX 对齐检查 — 视觉方向是否支持此游戏所需的交互模式？标记美术方向与可读性/无障碍需求之间的任何冲突。

Collect both. If they conflict (e.g., art-director wants elaborate diegetic UI but ux-designer flags it would reduce combat readability), surface the conflict explicitly with both positions. Do NOT silently resolve — use `AskUserQuestion` to let the user decide.
> **中文翻译**：收集两者。如果它们冲突（例如，美术总监想要精致的沉浸式 UI 但 UX 设计师标记它会降低战斗可读性），明确呈现冲突及双方立场。不要静默解决 — 使用 `AskUserQuestion` 让用户决定。

Write the approved section to file.
> **中文翻译**：批准后将章节写入文件。

### Section 8: Asset Standards / 第 8 章节：资产标准

**Agent delegation**: Spawn in parallel:
> **中文翻译**：**代理委派**：并行生成：

- **`art-director`**: File format preferences, naming convention direction, texture resolution tiers, LOD level expectations, export settings philosophy / **`art-director`**：文件格式偏好、命名约定方向、纹理分辨率层级、LOD 级别期望、导出设置理念
- **`technical-artist`**: Engine-specific hard constraints — poly count budgets per asset category, texture memory limits, material slot counts, importer constraints, anything from the performance budgets in `.codebuddy/docs/technical-preferences.md` / **`technical-artist`**：引擎特定的硬约束 — 每种资产类别的多边形数量预算、纹理内存限制、材质槽计数、导入器约束、`.codebuddy/docs/technical-preferences.md` 中性能预算的任何内容

If any art preference conflicts with a technical constraint (e.g., art-director wants 4K textures but performance budget requires 2K for mobile), resolve the conflict explicitly — note both the ideal and the constrained standard, and explain the tradeoff. Ambiguity in asset standards is where production costs are born.
> **中文翻译**：如果任何美术偏好与技术约束冲突（例如，美术总监想要 4K 纹理但性能预算要求移动端 2K），明确解决冲突 — 注明理想标准和受约束标准，并解释权衡。资产标准中的模糊是生产成本产生的地方。

Write the approved section to file.
> **中文翻译**：批准后将章节写入文件。

---

## Phase 4: Reference Direction (Section 9) / 第 4 阶段：参考方向（第 9 章节）

**Goal**: A curated reference set that is specific about what to take and what to avoid from each source.
> **中文翻译**：**目标**：精选的参考集，具体说明从每个来源应采用什么和应避免什么。

**Agent delegation**: Spawn `art-director` via Task with the completed sections 1–8. Ask: "Compile a reference direction for this game. Provide 3–5 reference sources (games, films, art styles, or specific artists). For each: name it, specify exactly what visual element to draw from it (not 'the general aesthetic' — a specific technique, color choice, or compositional rule), and specify what to explicitly avoid or diverge from (to prevent the 'trying to copy X' reading). References should be additive — no two references should be pointing in exactly the same direction."
> **中文翻译**：**代理委派**：通过 Task 生成 `art-director`，提供已完成的第 1-8 章节。要求："为此游戏编制参考方向。提供 3-5 个参考来源（游戏、电影、艺术风格或特定艺术家）。对于每个：命名它，准确指定从中借鉴什么视觉元素（不是'一般美学' — 特定技术、颜色选择或构图规则），并指定要明确避免或偏离的内容（以防止'试图复制 X'的印象）。参考应该是增补性的 — 任何两个参考不应指向完全相同的方向。"

Write the approved section to file.
> **中文翻译**：批准后将章节写入文件。

---

## Phase 5: Art Director Sign-Off / 第 5 阶段：美术总监签署

**Review mode check** — apply before spawning AD-ART-BIBLE:
> **中文翻译**：**审查模式检查** — 在生成 AD-ART-BIBLE 之前应用：

- `solo` → skip. Note: "AD-ART-BIBLE skipped — Solo mode." Proceed to Phase 6. / `solo` → 跳过。注意："AD-ART-BIBLE 已跳过 — Solo 模式。" 继续第 6 阶段。
- `lean` → skip (not a PHASE-GATE). Note: "AD-ART-BIBLE skipped — Lean mode." Proceed to Phase 6. / `lean` → 跳过（不是阶段门控）。注意："AD-ART-BIBLE 已跳过 — Lean 模式。" 继续第 6 阶段。
- `full` → spawn as normal. / `full` → 正常生成。

After all sections are complete (or the scoped set from Phase 1 is complete), spawn `creative-director` via Task using gate **AD-ART-BIBLE** (`.codebuddy/docs/director-gates.md`).
> **中文翻译**：所有章节完成后（或第 1 阶段的范围集完成），通过 Task 使用门控 **AD-ART-BIBLE**（`.codebuddy/docs/director-gates.md`）生成 `creative-director`。

Pass: art bible file path, game pillars, visual identity anchor.
> **中文翻译**：传递：美术圣经文件路径、游戏支柱、视觉标识锚点。

Handle verdict per standard rules in `director-gates.md`. Record the verdict in the art bible's status header:
`> **Art Director Sign-Off (AD-ART-BIBLE)**: APPROVED [date] / CONCERNS (accepted) [date] / REVISED [date]`
> **中文翻译**：按照 `director-gates.md` 中的标准规则处理裁决。在美术圣经的状态标题中记录裁决：
`> **美术总监签署 (AD-ART-BIBLE)**: APPROVED [日期] / CONCERNS (accepted) [日期] / REVISED [日期]`

---

## Phase 6: Close / 第 6 阶段：收尾

Before presenting next steps, check project state:
> **中文翻译**：在呈现后续步骤之前，检查项目状态：

- Does `design/gdd/systems-index.md` exist? → map-systems is done, skip that option / `design/gdd/systems-index.md` 是否存在？→ map-systems 已完成，跳过该选项
- Does `.codebuddy/docs/technical-preferences.md` contain a configured engine (not `[TO BE CONFIGURED]`)? → setup-engine is done, skip that option / `.codebuddy/docs/technical-preferences.md` 是否包含已配置的引擎（非 `[TO BE CONFIGURED]`）？→ setup-engine 已完成，跳过该选项
- Does `design/gdd/` contain any `*.md` files? → design-system has been run, skip that option / `design/gdd/` 是否包含任何 `*.md` 文件？→ design-system 已运行，跳过该选项
- Does `design/gdd/gdd-cross-review-*.md` exist? → review-all-gdds is done / `design/gdd/gdd-cross-review-*.md` 是否存在？→ review-all-gdds 已完成
- Do GDDs exist (check above)? → include /consistency-check option / GDD 是否存在（检查上述）？→ 包含 /consistency-check 选项

Use `AskUserQuestion` for next steps. Only include options that are genuinely next based on the state check above:
> **中文翻译**：使用 `AskUserQuestion` 进行后续步骤。仅包含基于上述状态检查真正是下一步的选项：

**Option pool — include only if not already done:** / **选项池 — 仅在尚未完成时包含：**

- `[_] Run /map-systems — decompose the concept into systems before writing GDDs` (skip if systems-index.md exists) / `[_] 运行 /map-systems — 在编写 GDD 之前将概念分解为系统`（如果 systems-index.md 存在则跳过）
- `[_] Run /setup-engine — configure the engine (asset standards may need revisiting after engine is set)` (skip if engine configured) / `[_] 运行 /setup-engine — 配置引擎（设置引擎后可能需要重新审视资产标准）`（如果引擎已配置则跳过）
- `[_] Run /design-system — start the first GDD` (skip if any GDDs exist) / `[_] 运行 /design-system — 开始第一个 GDD`（如果存在任何 GDD 则跳过）
- `[_] Run /review-all-gdds — cross-GDD consistency check (required before Technical Setup gate)` (skip if gdd-cross-review-*.md exists) / `[_] 运行 /review-all-gdds — 跨 GDD 一致性检查（技术设置门控之前需要）`（如果 gdd-cross-review-*.md 存在则跳过）
- `[_] Run /asset-spec — generate per-asset visual specs and AI generation prompts from approved GDDs` (include if GDDs exist) / `[_] 运行 /asset-spec — 从已批准的 GDD 生成每个资产的视觉规格和 AI 生成提示`（如果 GDD 存在则包含）
- `[_] Run /consistency-check — scan existing GDDs against the art bible for visual direction conflicts` (include if GDDs exist) / `[_] 运行 /consistency-check — 对照美术圣经扫描现有 GDD 的视觉方向冲突`（如果 GDD 存在则包含）
- `[_] Run /create-architecture — author the master architecture document (next Technical Setup step)` / `[_] 运行 /create-architecture — 编写主架构文档（下一个技术设置步骤）`
- `[_] Stop here` / `[_] 在此停止`

Assign letters A, B, C… only to the options actually included. Mark the most logical pipeline-advancing option as `(recommended)`.
> **中文翻译**：仅将字母 A、B、C…分配给实际包含的选项。将最合逻辑的管线推进选项标记为 `(recommended)`。

> **Always include** `/create-architecture` and Stop here as options — these are always valid next steps once the art bible is complete.
> **中文翻译**：> **始终包含** `/create-architecture` 和 Stop here 作为选项 — 一旦美术圣经完成，这些始终是有效的后续步骤。

---

## Collaborative Protocol / 协作协议

Every section follows: **Question → Options → Decision → Draft (from art-director agent) → Approval → Write to file**
> **中文翻译**：每个章节遵循：**提问 → 选项 → 决策 → 草稿（来自 art-director 代理）→ 批准 → 写入文件**

- Never draft a section without first spawning the relevant agent(s) / 永远不要在没有先生成相关代理的情况下起草章节
- Write each section to file immediately after approval — do not batch / 批准后立即将章节写入文件 — 不要批量处理
- Surface all agent disagreements to the user — never silently resolve conflicts between art-director and technical-artist / 向用户呈现所有代理分歧 — 永远不要静默解决 art-director 和 technical-artist 之间的冲突
- The art bible is a constraint document: it restricts future decisions in exchange for visual coherence. Every section should feel like it narrows the solution space productively. / 美术圣经是约束文档：它限制未来决策以换取视觉一致性。每个章节应该感觉它在有效地缩小解决方案空间。

---

## Recommended Next Steps / 建议的后续步骤

After the art bible is approved:
> **中文翻译**：美术圣经获批后：

- Run `/map-systems` to decompose the concept into game systems before authoring GDDs / 运行 `/map-systems` 在编写 GDD 之前将概念分解为游戏系统
- Run `/setup-engine` if the engine is not yet configured (asset standards may need revisiting after engine selection) / 如果引擎尚未配置，运行 `/setup-engine`（选择引擎后可能需要重新审视资产标准）
- Run `/design-system [first-system]` to start authoring per-system GDDs / 运行 `/design-system [first-system]` 开始编写每个系统的 GDD
- Run `/consistency-check` once GDDs exist to validate them against the art bible's visual rules / 一旦 GDD 存在，运行 `/consistency-check` 对照美术圣经的视觉规则验证它们
- Run `/create-architecture` to produce the master architecture document / 运行 `/create-architecture` 生成主架构文档
