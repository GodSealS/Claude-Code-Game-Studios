---
name: asset-spec
description: "Generate per-asset visual specifications and AI generation prompts from GDDs, level docs, or character profiles. Produces structured spec files and updates the master asset manifest. Run after art bible and GDD/level design are approved, before production begins. / 从 GDD、关卡文档或角色档案生成每个资产的视觉规格和 AI 生成提示。生成结构化规格文件并更新主资产清单。在美术圣经和 GDD/关卡设计批准后、生产开始前运行。"
argument-hint: "[system:<name> | level:<name> | character:<name>] [--review full|lean|solo]"
user-invocable: true
allowed-tools: Read, Glob, Grep, Write, Edit, Task, AskUserQuestion
---

If no argument is provided, check whether `design/assets/asset-manifest.md` exists:
> **中文翻译**：如果未提供参数，检查 `design/assets/asset-manifest.md` 是否存在：

- If it exists: read it, find the first context (system/level/character) with any asset at status "Needed" but no spec file written yet, and use `AskUserQuestion`: / 如果存在：读取它，找到第一个有任何资产处于 "Needed" 状态但尚未写入规格文件的上下文（系统/关卡/角色），然后使用 `AskUserQuestion`：
  - Prompt: "The next unspecced context is **[target]**. Generate asset specs for it?" / 提示："下一个未规格化的上下文是 **[target]**。为其生成资产规格吗？"
  - Options: `[A] Yes — spec [target]` / `[B] Pick a different target` / `[C] Stop here` / 选项：`[A] 是 — 规格 [target]` / `[B] 选择不同目标` / `[C] 在此停止`
- If no manifest: fail with: / 如果没有清单：失败并显示：

  > "Usage: `/asset-spec system:<name>` — e.g., `/asset-spec system:tower-defense`   > Or: `/asset-spec level:iron-gate-fortress` / `/asset-spec character:frost-warden`   > Run after your art bible and GDDs are approved."
  > **中文翻译**：> "用法：`/asset-spec system:<name>` — 例如，`/asset-spec system:tower-defense` > 或者：`/asset-spec level:iron-gate-fortress` / `/asset-spec character:frost-warden` > 在美术圣经和 GDD 获得批准后运行。"

---

## Phase 0: Parse Arguments / 第 0 阶段：解析参数

Extract:
> **中文翻译**：提取：

- **Target type**: `system`, `level`, or `character` / **目标类型**：`system`、`level` 或 `character`
- **Target name**: the name after the colon (normalize to kebab-case) / **目标名称**：冒号后的名称（标准化为 kebab-case）
- **Review mode**: `--review [full|lean|solo]` if present / **审查模式**：如果提供了 `--review [full|lean|solo]`

**Mode behavior:** / **模式行为：**

- `full` (default): spawn both `art-director` and `technical-artist` in parallel / `full`（默认）：并行生成 `art-director` 和 `technical-artist`
- `lean`: spawn `art-director` only — faster, skips technical constraint pass / `lean`：仅生成 `art-director` — 更快，跳过技术约束检查
- `solo`: no agent spawning — main session writes specs from art bible rules alone. Use for simple asset categories or when speed matters more than depth. / `solo`：无代理生成 — 主会话仅从美术圣经规则编写规格。用于简单资产类别或速度比深度更重要的情况。

---

## Phase 1: Gather Context / 第 1 阶段：收集上下文

Read all source material **before** asking the user anything.
> **中文翻译**：**在向用户询问任何问题之前**读取所有源材料。

### Required reads: / 必读内容：

- **Art bible**: Read `design/art/art-bible.md` — fail if missing: / **美术圣经**：读取 `design/art/art-bible.md` — 如果缺失则失败：

  > "No art bible found. Run `/art-bible` first — asset specs are anchored to the art bible's visual rules and asset standards."   Extract: Visual Identity Statement, Color System (semantic colors), Shape Language, Asset Standards (Section 8 — dimensions, formats, polycount budgets, texture resolution tiers).
  > **中文翻译**：> "未找到美术圣经。请先运行 `/art-bible` — 资产规格锚定于美术圣经的视觉规则和资产标准。"   提取：视觉标识声明、色彩系统（语义色彩）、形状语言、资产标准（第 8 章节 — 尺寸、格式、多边形数预算、纹理分辨率层级）。

- **Technical preferences**: Read `.codebuddy/docs/technical-preferences.md` — extract performance budgets and naming conventions. / **技术偏好**：读取 `.codebuddy/docs/technical-preferences.md` — 提取性能预算和命名约定。

### Source doc reads (by target type): / 源文档读取（按目标类型）：

- **system**: Read `design/gdd/[target-name].md`. Extract the **Visual/Audio Requirements** section. If it doesn't exist or reads `[To be designed]`: / **system**：读取 `design/gdd/[target-name].md`。提取 **Visual/Audio Requirements** 章节。如果不存在或显示 `[To be designed]`：

  > "The Visual/Audio section of `design/gdd/[target-name].md` is empty. Either run `/design-system [target-name]` to complete the GDD, or describe the visual needs manually."   Use `AskUserQuestion`: `[A] Describe needs manually` / `[B] Stop — complete the GDD first`
  > **中文翻译**：> "`design/gdd/[target-name].md` 的 Visual/Audio 章节为空。请运行 `/design-system [target-name]` 完成 GDD，或手动描述视觉需求。"   使用 `AskUserQuestion`：`[A] 手动描述需求` / `[B] 停止 — 先完成 GDD`

- **level**: Read `design/levels/[target-name].md`. Extract art requirements, asset list, VFX needs, and the art-director's production concept specs from Step 4. / **level**：读取 `design/levels/[target-name].md`。提取美术需求、资产列表、VFX 需求以及第 4 步美术总监的制作概念规格。
- **character**: Read `design/narrative/characters/[target-name].md` or search `design/narrative/` for the character profile. Extract visual description, role, and any specified distinguishing features. / **character**：读取 `design/narrative/characters/[target-name].md` 或搜索 `design/narrative/` 获取角色档案。提取视觉描述、角色和任何指定的区分特征。

### Optional reads: / 可选读取：

- **Existing manifest**: Read `design/assets/asset-manifest.md` if it exists — extract already-specced assets for this target to avoid duplicates. / **现有清单**：读取 `design/assets/asset-manifest.md`（如果存在）— 提取此目标已规格化的资产以避免重复。
- **Related specs**: Glob `design/assets/specs/*.md` — scan for assets that could be shared (e.g., a common UI element specced for one system might apply here too). / **相关规格**：Glob `design/assets/specs/*.md` — 扫描可共享的资产（例如，为一个系统规格化的通用 UI 元素可能也适用于此处）。

### Present context summary: / 呈现上下文摘要：

> **Asset Spec: [Target Type] — [Target Name]**
> - Source doc: [path] — [N] asset types identified / 源文档：[路径] — 识别 [N] 种资产类型
> - Art bible: found — Asset Standards at Section 8 / 美术圣经：已找到 — 第 8 章节的资产标准
> - Existing specs for this target: [N already specced / none] / 此目标的现有规格：[N 已规格化 / 无]
> - Shared assets found in other specs: [list or "none"] / 其他规格中找到的共享资产：[列表或"无"]

---

## Phase 2: Asset Identification / 第 2 阶段：资产识别

From the source doc, extract every asset type mentioned — explicit and implied.
> **中文翻译**：从源文档中提取提到的每种资产类型 — 明确的和隐含的。

**For systems**: look for VFX events, sprite references, UI elements, audio triggers, particle effects, icon needs, and any "visual feedback" language. / **对于系统**：查找 VFX 事件、精灵引用、UI 元素、音频触发器、粒子效果、图标需求以及任何"视觉反馈"语言。

**For levels**: look for unique environment props, atmospheric VFX, lighting setups, ambient audio, skybox/background, and any area-specific materials. / **对于关卡**：查找独特的环境道具、氛围 VFX、灯光设置、环境音频、天空盒/背景以及任何区域特定材质。

**For characters**: look for sprite sheets (idle, walk, attack, death), portrait/avatar, VFX attached to abilities, UI representation (icon, health bar skin). / **对于角色**：查找精灵表（待机、行走、攻击、死亡）、头像/头像框、附加到技能的 VFX、UI 表示（图标、血条外观）。

Group assets into categories: / 将资产分组为类别：

- **Sprite / 2D Art** — character sprites, UI icons, tile sheets / **精灵 / 2D 美术** — 角色精灵、UI 图标、瓦片表
- **VFX / Particles** — hit effects, ambient particles, screen effects / **VFX / 粒子** — 命中效果、环境粒子、屏幕效果
- **Environment** — props, tiles, backgrounds, skyboxes / **环境** — 道具、瓦片、背景、天空盒
- **UI** — HUD elements, menu art, fonts (if custom) / **UI** — HUD 元素、菜单美术、字体（如果自定义）
- **Audio** — SFX, music tracks, ambient loops *(note: audio specs are descriptions only — no generation prompts)* / **音频** — SFX、音乐曲目、环境循环 *（注意：音频规格仅是描述 — 无生成提示）*
- **3D Assets** — meshes, materials (if applicable per engine) / **3D 资产** — 网格、材质（如果适用于引擎）

Present the full identified list to the user. Use `AskUserQuestion`:
> **中文翻译**：将完整识别列表呈现给用户。使用 `AskUserQuestion`：

- Prompt: "I identified [N] assets across [N] categories for **[target]**. Review before speccing:" / 提示："我为 **[target]** 识别了 [N] 个资产，跨 [N] 个类别。规格化之前审查："
- Show the grouped list in conversation text first / 先在对话文本中显示分组列表
- Options: `[A] Proceed — spec all of these` / `[B] Remove some assets` / `[C] Add assets I didn't catch` / `[D] Adjust categories` / 选项：`[A] 继续 — 规格化所有这些` / `[B] 移除一些资产` / `[C] 添加我遗漏的资产` / `[D] 调整类别`

Do NOT proceed to Phase 3 without user confirmation of the asset list.
> **中文翻译**：在用户确认资产列表之前不要进入第 3 阶段。

---

## Phase 3: Spec Generation / 第 3 阶段：规格生成

Spawn specialist agents based on review mode. **Issue all Task calls simultaneously — do not wait for one before starting the next.**
> **中文翻译**：基于审查模式生成专业代理。**同时发出所有 Task 调用 — 不要等待一个完成后再开始下一个。**

### Full mode — spawn in parallel: / 完整模式 — 并行生成：

**`art-director`** via Task:
> **中文翻译**：**`art-director`** 通过 Task：

- Provide: full asset list from Phase 2, art bible Visual Identity Statement, Color System, Shape Language, the source doc's visual requirements, and any reference games/art mentioned in the art bible Section 9 / 提供：第 2 阶段的完整资产列表、美术圣经视觉标识声明、色彩系统、形状语言、源文档的视觉需求以及美术圣经第 9 章节中提到的任何参考游戏/艺术
- Ask: "For each asset in this list, produce: (1) a 2–3 sentence visual description anchored to the art bible's shape language and color system — be specific enough that two different artists would produce consistent results; (2) a generation prompt ready for use with AI image tools (Midjourney/Stable Diffusion style — include style keywords, composition, color palette anchors, negative prompts); (3) which art bible rules directly govern this asset (cite by section). For audio assets, describe the sonic character instead of a generation prompt." / 要求："对于此列表中的每个资产，生成：(1) 一段 2-3 句话的视觉描述，锚定于美术圣经的形状语言和色彩系统 — 足够具体使两个不同的艺术家能产生一致结果；(2) 一个可用的 AI 图像工具生成提示（Midjourney/Stable Diffusion 风格 — 包含风格关键词、构图、调色板锚点、负面提示）；(3) 哪些美术圣经规则直接管理此资产（按章节引用）。对于音频资产，描述声音特性而非生成提示。"

**`technical-artist`** via Task:
> **中文翻译**：**`technical-artist`** 通过 Task：

- Provide: full asset list, art bible Asset Standards (Section 8), technical-preferences.md performance budgets, engine name and version / 提供：完整资产列表、美术圣经资产标准（第 8 章节）、technical-preferences.md 性能预算、引擎名称和版本
- Ask: "For each asset in this list, specify: (1) exact dimensions or polycount (match the art bible Asset Standards tiers — do not invent new sizes); (2) file format and export settings; (3) naming convention (from technical-preferences.md); (4) any engine-specific constraints this asset type must respect; (5) LOD requirements if applicable. Flag any asset type where the art bible's preferred standard conflicts with the engine's constraints." / 要求："对于此列表中的每个资产，指定：(1) 确切尺寸或多边形数（匹配美术圣经资产标准层级 — 不要发明新尺寸）；(2) 文件格式和导出设置；(3) 命名约定（来自 technical-preferences.md）；(4) 此资产类型必须遵守的任何引擎特定约束；(5) LOD 要求（如适用）。标记美术圣经首选标准与引擎约束冲突的任何资产类型。"

### Lean mode — spawn art-director only (skip technical-artist). / Lean 模式 — 仅生成 art-director（跳过 technical-artist）。

### Solo mode — skip both. Derive specs from art bible rules alone, noting that technical constraints were not validated. / Solo 模式 — 两者都跳过。仅从美术圣经规则推导规格，注明技术约束未经验证。

**Collect both responses before Phase 4.** If any conflict exists between art-director and technical-artist (e.g., art-director specifies 4K textures but technical-artist flags the engine budget requires 512px), surface it explicitly — do NOT silently resolve.
> **中文翻译**：**在第 4 阶段之前收集两个响应。** 如果 art-director 和 technical-artist 之间存在任何冲突（例如，art-director 指定 4K 纹理但 technical-artist 标记引擎预算要求 512px），明确呈现 — 不要静默解决。

---

## Phase 4: Compile and Review / 第 4 阶段：编译和审查

Combine the agent outputs into a draft spec per asset. Present all specs in conversation text using this format:
> **中文翻译**：将代理输出组合为每个资产的草稿规格。使用以下格式在对话文本中呈现所有规格：

```
## ASSET-[NNN] — [Asset Name]

| Field | Value |
|-------|-------|
| Category | [Sprite / VFX / Environment / UI / Audio / 3D] |
| Dimensions | [e.g. 256×256px, 4-frame sprite sheet] |
| Format | [PNG / SVG / WAV / etc.] |
| Naming | [e.g. vfx_frost_hit_01.png] |
| Polycount | [if 3D — e.g. <800 tris] |
| Texture Res | [e.g. 512px — matches Art Bible §8 Tier 2] |

**Visual Description:** / **视觉描述：**
[2–3 sentences. Specific enough for two artists to produce consistent results.]

**Art Bible Anchors:** / **美术圣经锚点：**
- §3 Shape Language: [relevant rule applied] / §3 形状语言：[应用的相关规则]
- §4 Color System: [color role — e.g. "uses Threat Blue per semantic color rules"] / §4 色彩系统：[颜色角色 — 例如"按语义色彩规则使用威胁蓝"]

**Generation Prompt:** / **生成提示：**
[Ready-to-use prompt. Include: style keywords, composition notes, color palette anchors, lighting direction, negative prompts.]
[即用提示。包含：风格关键词、构图说明、调色板锚点、灯光方向、负面提示。]

**Status:** Needed / **状态：** 需要创建
```

After presenting all specs, use `AskUserQuestion`:
> **中文翻译**：呈现所有规格后，使用 `AskUserQuestion`：

- Prompt: "Asset specs for **[target]** — [N] assets. Review complete?" / 提示："**[target]** 的资产规格 — [N] 个资产。审查完成？"
- Options: `[A] Approve all — write to file` / `[B] Revise a specific asset` / `[C] Regenerate with different direction` / 选项：`[A] 全部批准 — 写入文件` / `[B] 修改特定资产` / `[C] 用不同方向重新生成`

If [B]: ask which asset and what to change. Revise inline and re-present. Do NOT re-spawn agents for minor text revisions — only re-spawn if the visual direction itself needs to change.
> **中文翻译**：如果是 [B]：询问哪个资产以及要更改什么。内联修改并重新呈现。不要为小文本修改重新生成代理 — 仅在视觉方向本身需要更改时重新生成。

If [C]: ask what direction to change. Re-spawn the relevant agent with the updated brief.
> **中文翻译**：如果是 [C]：询问要更改什么方向。用更新的简报重新生成相关代理。

---

## Phase 5: Write Spec File / 第 5 阶段：写入规格文件

After approval, ask: "May I write the spec to `design/assets/specs/[target-name]-assets.md`?"
> **中文翻译**：批准后，询问："我可以将规格写入 `design/assets/specs/[target-name]-assets.md` 吗？"

Write the file with:
> **中文翻译**：写入文件，包含：

```markdown
# Asset Specs — [Target Type]: [Target Name]

> **Source**: [path to source GDD/level/character doc] / **源文档**：[源 GDD/关卡/角色文档路径]
> **Art Bible**: design/art/art-bible.md / **美术圣经**
> **Generated**: [date] / **生成日期**
> **Status**: [N] assets specced / [N] approved / [N] in production / [N] done / **状态**：[N] 已规格化 / [N] 已批准 / [N] 生产中 / [N] 已完成

[all asset specs in ASSET-NNN format]
```

Then update `design/assets/asset-manifest.md`. If it doesn't exist, create it:
> **中文翻译**：然后更新 `design/assets/asset-manifest.md`。如果不存在则创建：

```markdown
# Asset Manifest

> Last updated: [date]

## Progress Summary / 进度摘要

| Total | Needed | In Progress | Done | Approved |
|-------|--------|-------------|------|----------|
| [N] | [N] | [N] | [N] | [N] |

## Assets by Context / 按上下文组织的资产

### [Target Type]: [Target Name]
| Asset ID | Name | Category | Status | Spec File |
|----------|------|----------|--------|-----------|
| ASSET-001 | [name] | [category] | Needed | design/assets/specs/[target]-assets.md |
```

If the manifest already exists, append the new context block and update the Progress Summary counts.
> **中文翻译**：如果清单已存在，追加新的上下文块并更新进度摘要计数。

Ask: "May I update `design/assets/asset-manifest.md`?"
> **中文翻译**：询问："我可以更新 `design/assets/asset-manifest.md` 吗？"

---

## Phase 6: Close / 第 6 阶段：收尾

Use `AskUserQuestion`:
> **中文翻译**：使用 `AskUserQuestion`：

- Prompt: "Asset specs complete for **[target]**. What's next?" / 提示："**[target]** 的资产规格已完成。下一步？"
- Options: / 选项：
  - `[A] Spec another system — /asset-spec system:[next-system]` / `[A] 规格化另一个系统`
  - `[B] Spec a level — /asset-spec level:[level-name]` / `[B] 规格化一个关卡`
  - `[C] Spec a character — /asset-spec character:[character-name]` / `[C] 规格化一个角色`
  - `[D] Run /asset-audit — validate delivered assets against specs` / `[D] 运行 /asset-audit — 对照规格验证已交付资产`
  - `[E] Stop here` / `[E] 在此停止`

---

## Asset ID Assignment / 资产 ID 分配

Asset IDs are assigned sequentially across the entire project — not per-context. Read the manifest before assigning IDs to find the current highest number:
> **中文翻译**：资产 ID 在整个项目中按顺序分配 — 不是按上下文分配。在分配 ID 之前读取清单以找到当前最大编号：

```
Grep pattern="ASSET-" path="design/assets/asset-manifest.md"
```

Start new assets from `ASSET-[highest + 1]`. This ensures IDs are stable and unique across the whole project.
> **中文翻译**：从 `ASSET-[最高 + 1]` 开始新资产。这确保 ID 在整个项目中稳定且唯一。

If no manifest exists yet, start from `ASSET-001`.
> **中文翻译**：如果尚无清单，从 `ASSET-001` 开始。

---

## Shared Asset Protocol / 共享资产协议

Before speccing an asset, check if an equivalent already exists in another context's spec:
> **中文翻译**：在规格化资产之前，检查其他上下文规格中是否已存在等效资产：

- Common UI elements (health bars, score displays) are often shared across systems / 通用 UI 元素（血条、分数显示）通常跨系统共享
- Generic environment props may appear in multiple levels / 通用环境道具可能出现在多个关卡中
- Character VFX (hit sparks, death effects) may reuse a base spec with color variants / 角色 VFX（命中火花、死亡效果）可能复用基础规格加颜色变体

If a match is found: reference the existing ASSET-ID rather than creating a duplicate. Note the shared usage in the manifest's referenced-by column.
> **中文翻译**：如果找到匹配：引用现有 ASSET-ID 而非创建重复。在清单的 referenced-by 列中注明共享使用。

> "ASSET-012 (Generic Hit Spark) already specced for Combat system. Reusing for Tower Defense — adding tower-defense to referenced-by."
> **中文翻译**："ASSET-012（通用命中火花）已为战斗系统规格化。为塔防复用 — 将 tower-defense 添加到 referenced-by。"

---

## Error Recovery Protocol / 错误恢复协议

If any spawned agent returns BLOCKED or cannot complete:
> **中文翻译**：如果任何生成的代理返回 BLOCKED 或无法完成：

1. Surface immediately: "[AgentName]: BLOCKED — [reason]" / 立即呈现："[代理名称]：BLOCKED — [原因]"
2. In `lean` mode or if `technical-artist` blocks: proceed with art-director output only — note that technical constraints were not validated / 在 `lean` 模式下或如果 `technical-artist` 阻塞：仅使用 art-director 输出继续 — 注明技术约束未经验证
3. In `solo` mode or if `art-director` blocks: derive descriptions from art bible rules — flag as "Art director not consulted — verify against art bible before production" / 在 `solo` 模式下或如果 `art-director` 阻塞：从美术圣经规则推导描述 — 标记为"未咨询美术总监 — 生产前对照美术圣经验证"
4. Always produce a partial spec — never discard work because one agent blocked / 始终生成部分规格 — 永远不要因为一个代理阻塞而丢弃工作

---

## Collaborative Protocol / 协作协议

Every phase follows: **Identify → Confirm → Generate → Review → Approve → Write**
> **中文翻译**：每个阶段遵循：**识别 → 确认 → 生成 → 审查 → 批准 → 写入**

- Never spec assets without first confirming the asset list with the user / 永远不要在没有先与用户确认资产列表的情况下规格化资产
- Always anchor specs to the art bible — a spec that contradicts the art bible is wrong / 始终将规格锚定于美术圣经 — 与美术圣经矛盾的规格是错误的
- Surface all agent disagreements — do not silently pick one / 呈现所有代理分歧 — 不要静默选择一方
- Write the spec file only after explicit approval / 仅在明确批准后写入规格文件
- Update the manifest immediately after writing the spec / 写入规格后立即更新清单

---

## Recommended Next Steps / 建议的后续步骤

- Run `/asset-spec [next-context]` to continue speccing remaining systems, levels, or characters / 运行 `/asset-spec [next-context]` 继续规格化剩余系统、关卡或角色
- Run `/asset-audit` to validate delivered assets against the written specs and identify gaps or mismatches / 运行 `/asset-audit` 对照书面规格验证已交付资产并识别差距或不匹配
