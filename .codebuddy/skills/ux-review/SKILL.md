---
name: ux-review
description: "Validates a UX spec, HUD design, or interaction pattern library for completeness, accessibility compliance, GDD alignment, and implementation readiness. Produces APPROVED / NEEDS REVISION / MAJOR REVISION NEEDED verdict with specific gaps. / 验证 UX 规格、HUD 设计或交互模式库的完整性、无障碍合规性、GDD 一致性和实现就绪度。生成 APPROVED / NEEDS REVISION / MAJOR REVISION NEEDED 裁决及具体差距。"
argument-hint: "[file-path or 'all' or 'hud' or 'patterns']"
user-invocable: true
allowed-tools: Read, Glob, Grep
agent: ux-designer
---

## Overview / 概述

Validates UX design documents before they enter the implementation pipeline.
Acts as the quality gate between UX Design and Visual Design/Implementation in
the `/team-ui` pipeline.

> **中文翻译**：在 UX 设计文档进入实现管线之前验证它们。在 `/team-ui` 管线中充当 UX 设计与视觉设计/实现之间的质量门控。

**Run this skill:** / **运行此技能：**
- After completing a UX spec with `/ux-design` / 使用 `/ux-design` 完成 UX 规格后
- Before handing off to `ui-programmer` or `art-director` / 在交接给 `ui-programmer` 或 `art-director` 之前
- Before the Pre-Production to Production gate check (which requires key screens
  to have reviewed UX specs) / 在预生产到生产门控检查之前（要求关键屏幕已有审查过的 UX 规格）
- After major revisions to a UX spec / 对 UX 规格进行重大修订后

**Verdict levels:** / **裁决等级：**
- **APPROVED** — spec is complete, consistent, and implementation-ready / 规格完整、一致且可实现就绪
- **NEEDS REVISION** — specific gaps found; fix before handoff but not a full redesign / 发现具体差距；在交接前修复，但不是完全重新设计
- **MAJOR REVISION NEEDED** — fundamental issues with scope, player need, or
  completeness; needs significant rework / 范围、玩家需求或完整性存在根本问题；需要重大返工

---

## Phase 1: Parse Arguments / 阶段 1：解析参数

- **Specific file path** (e.g., `/ux-review design/ux/inventory.md`): validate
  that one document / **特定文件路径**（例如，`/ux-review design/ux/inventory.md`）：验证该文档
- **`all`**: find all files in `design/ux/` and validate each / 查找 `design/ux/` 中的所有文件并逐一验证
- **`hud`**: validate `design/ux/hud.md` specifically / 专门验证 `design/ux/hud.md`
- **`patterns`**: validate `design/ux/interaction-patterns.md` specifically / 专门验证 `design/ux/interaction-patterns.md`
- **No argument**: ask the user which spec to validate / **无参数**：询问用户要验证哪个规格

For `all`, output a summary table first (file | verdict | primary issue) then
full detail for each. / 对于 `all`，首先输出摘要表（文件 | 裁决 | 主要问题），然后详细说明每个。

---

## Phase 2: Load Cross-Reference Context / 阶段 2：加载交叉引用上下文

Before validating any spec, load: / 在验证任何规格之前，加载：

1. **Input & Platform config**: Read `.codebuddy/docs/technical-preferences.md` and
   extract `## Input & Platform`. This is the authoritative source for which input
   methods the game supports — use it to drive the Input Method Coverage checks in
   Phase 3A, not the spec's own header. If unconfigured, fall back to the spec header. / **输入与平台配置**：读取 `.codebuddy/docs/technical-preferences.md` 并提取 `## Input & Platform`。这是游戏支持的输入方法的权威来源——用它来驱动阶段 3A 中的输入方法覆盖检查，而不是规格自己的头部。如果未配置，回退到规格头部。
2. The accessibility tier committed to in `design/accessibility-requirements.md`
   (if it exists) / `design/accessibility-requirements.md` 中承诺的无障碍层级（如果存在）
3. The interaction pattern library at `design/ux/interaction-patterns.md` (if
   it exists) / `design/ux/interaction-patterns.md` 中的交互模式库（如果存在）
4. The GDDs referenced in the spec's header (read their UI Requirements sections) / 规格头部引用的 GDD（读取它们的 UI 要求部分）
5. The player journey map at `design/player-journey.md` (if it exists) for
   context-arrival validation / `design/player-journey.md` 中的玩家旅程图（如果存在），用于上下文到达验证

---

## Phase 3A: UX Spec Validation Checklist / 阶段 3A：UX 规格验证清单

Run all checks against a `ux-spec.md`-based document. / 对基于 `ux-spec.md` 的文档运行所有检查。

### Completeness (required sections) / 完整性（必需部分）

- [ ] Document header present with Status, Author, Platform Target / 文档头部包含状态、作者、平台目标
- [ ] Purpose & Player Need — has a player-perspective need statement (not
  developer-perspective) / 目的与玩家需求——有玩家视角的需求声明（而非开发者视角）
- [ ] Player Context on Arrival — describes player's state and prior activity / 到达时玩家上下文——描述玩家的状态和先前的活动
- [ ] Navigation Position — shows where screen sits in hierarchy / 导航位置——显示屏幕在层次结构中的位置
- [ ] Entry & Exit Points — all entry sources and exit destinations documented / 入口与出口点——记录所有入口源和出口目的地
- [ ] Layout Specification — zones defined, component inventory table present / 布局规格——定义区域，存在组件清单表
- [ ] States & Variants — at minimum: loading, empty/populated, and error states
  documented / 状态与变体——至少记录：加载、空/填充和错误状态
- [ ] Interaction Map — covers all target input methods (check platform target
  in header) / 交互映射——涵盖所有目标输入方法（检查头部中的平台目标）
- [ ] Data Requirements — every displayed data element has a source system and owner / 数据要求——每个显示的数据元素都有源系统和所有者
- [ ] Events Fired — every player action has a corresponding event or null
  explanation / 触发的事件——每个玩家操作都有对应的事件或空解释
- [ ] Transitions & Animations — at least enter/exit transitions specified / 过渡与动画——至少指定进入/退出过渡
- [ ] Accessibility Requirements — screen-level requirements present / 无障碍要求——存在屏幕级要求
- [ ] Localization Considerations — max character counts for text elements / 本地化考虑——文本元素的最大字符数
- [ ] Acceptance Criteria — at least 5 specific testable criteria / 验收标准——至少 5 个具体的可测试标准

### Quality Checks / 质量检查

**Player Need Clarity** / **玩家需求清晰度**
- [ ] Purpose is written from player perspective, not system/developer perspective / 目的从玩家角度而非系统/开发者角度撰写
- [ ] Player goal on arrival is unambiguous ("The player arrives wanting to ___") / 到达时的玩家目标明确（"玩家到达时想要___"）
- [ ] The player context on arrival is specific (not just "they opened the
  inventory") / 到达时玩家上下文具体（不仅仅是"他们打开了背包"）

**Completeness of States** / **状态完整性**
- [ ] Error state is documented (not just happy path) / 错误状态已记录（不仅仅是正常流程）
- [ ] Empty state is documented (no data scenario) / 空状态已记录（无数据场景）
- [ ] Loading state is documented if the screen fetches async data / 如果屏幕获取异步数据，则加载状态已记录
- [ ] Any state with a timer or auto-dismiss is documented with duration / 任何带计时器或自动关闭的状态都已记录持续时间

**Input Method Coverage** / **输入方法覆盖**
- [ ] If platform includes PC: keyboard-only navigation is fully specified / 如果平台包括 PC：完全指定仅键盘导航
- [ ] If platform includes console/gamepad: d-pad navigation and face button
  mapping documented / 如果平台包括游戏机/手柄：记录方向键导航和面键映射
- [ ] No interaction requires mouse-like precision on gamepad / 游戏手柄上无交互需要类似鼠标的精度
- [ ] Focus order is defined (Tab order for keyboard, d-pad order for gamepad) / 焦点顺序已定义（键盘的 Tab 顺序，手柄的方向键顺序）

**Data Architecture** / **数据架构**
- [ ] No data element has "UI" listed as the owner (UI must not own game state) / 无数据元素将"UI"列为所有者（UI 不得拥有游戏状态）
- [ ] Update frequency is specified for all real-time data (not just "realtime" —
  what triggers update?) / 为所有实时数据指定更新频率（不仅仅是"实时"——什么触发更新？）
- [ ] Null handling is specified for all data elements (what shows when data is
  unavailable?) / 为所有数据元素指定空值处理（数据不可用时显示什么？）

**Accessibility** / **无障碍**
- [ ] Accessibility tier from `accessibility-requirements.md` is matched or exceeded / 满足或超过 `accessibility-requirements.md` 中的无障碍层级
- [ ] If Basic tier: no color-only information indicators / 如果是基础层级：无仅颜色信息指示器
- [ ] If Standard tier+: focus order documented, text contrast ratios specified / 如果是标准层级及以上：记录焦点顺序，指定文本对比度
- [ ] If Comprehensive tier+: screen reader announcements for key state changes / 如果是全面层级及以上：关键状态变化的屏幕阅读器播报
- [ ] Colorblind check: any color-coded elements have non-color alternatives / 色盲检查：任何颜色编码元素都有非颜色替代方案

**GDD Alignment** / **GDD 一致性**
- [ ] Every GDD UI Requirement referenced in the header is addressed in this spec / 头部引用的每个 GDD UI 要求在此规格中都有处理
- [ ] No UI element displays or modifies game state without a corresponding GDD
  requirement / 无 UI 元素显示或修改游戏状态而无对应的 GDD 要求
- [ ] No GDD UI Requirement is missing from this spec (cross-check the referenced
  GDD sections) / 此规格中无缺失的 GDD UI 要求（交叉检查引用的 GDD 部分）

**Pattern Library Consistency** / **模式库一致性**
- [ ] All interactive components reference the pattern library (or note they are
  new patterns) / 所有交互组件引用模式库（或注明它们是新模式）
- [ ] No pattern behavior is re-specified from scratch if it already exists in
  the pattern library / 如果模式库中已存在，则不再从头重新指定模式行为
- [ ] Any new patterns invented in this spec are flagged for addition to the
  pattern library / 此规格中发明的任何新模式都已标记添加到模式库

**Localization** / **本地化**
- [ ] Character limit warnings present for all text-heavy elements / 所有文本繁多的元素都有字符限制警告
- [ ] Any layout-critical text has been flagged for 40% expansion accommodation / 任何布局关键文本都已标记以适应 40% 扩展

**Acceptance Criteria Quality** / **验收标准质量**
- [ ] Criteria are specific enough for a QA tester who hasn't seen the design docs / 标准足够具体，供未看过设计文档的 QA 测试人员使用
- [ ] Performance criterion present (screen opens within Xms) / 存在性能标准（屏幕在 Xms 内打开）
- [ ] Resolution criterion present / 存在分辨率标准
- [ ] No criterion requires reading another document to evaluate / 无标准需要阅读其他文档来评估

---

## Phase 3B: HUD Validation Checklist / 阶段 3B：HUD 验证清单

Run all checks against a `hud-design.md`-based document. / 对基于 `hud-design.md` 的文档运行所有检查。

### Completeness / 完整性

- [ ] HUD Philosophy defined / 定义 HUD 理念
- [ ] Information Architecture table covers ALL systems with UI Requirements in GDDs / 信息架构表涵盖 GDD 中所有有 UI 要求的系统
- [ ] Layout Zones defined with safe zone margins for all target platforms / 为所有目标平台定义带安全区域边距的布局区域
- [ ] Every HUD element has a full specification (zone, visibility trigger, data
  source, priority) / 每个 HUD 元素都有完整的规格（区域、可见性触发器、数据源、优先级）
- [ ] HUD States by Gameplay Context covers at minimum: exploration, combat,
  dialogue/cutscene, paused / 按游戏上下文划分的 HUD 状态至少包括：探索、战斗、对话/过场动画、暂停
- [ ] Visual Budget defined (max simultaneous elements, max screen %) / 定义视觉预算（最大同时显示元素数，最大屏幕占比%）
- [ ] Platform Adaptation covers all target platforms / 平台适配涵盖所有目标平台
- [ ] Tuning Knobs present for player-adjustable elements / 存在玩家可调整元素的调校旋钮

### Quality Checks / 质量检查

- [ ] No HUD element covers the center play area without a visibility rule to
  hide it / 无 HUD 元素覆盖中心游戏区域而无可隐藏的可见性规则
- [ ] Every information item that exists in any GDD is either in the HUD or
  explicitly categorized as "hidden/demand" / GDD 中存在的每个信息项要么在 HUD 中，要么明确归类为"隐藏/按需"
- [ ] All color-coded HUD elements have colorblind variants / 所有颜色编码的 HUD 元素都有色盲变体
- [ ] HUD elements in the Feedback & Notification section have queue/priority
  behavior defined / 反馈与通知部分的 HUD 元素定义了队列/优先级行为
- [ ] Visual Budget compliance: total simultaneous elements is within budget / 视觉预算合规性：总同时显示元素数在预算内

### GDD Alignment / GDD 一致性

- [ ] All systems in `design/gdd/systems-index.md` with UI category have
  representation in HUD (or justified absence) / `design/gdd/systems-index.md` 中所有带 UI 类别的系统在 HUD 中都有表示（或有合理缺失）

---

## Phase 3C: Pattern Library Validation Checklist / 阶段 3C：模式库验证清单

- [ ] Pattern catalog index is current (matches actual patterns in document) / 模式目录索引是最新的（匹配文档中的实际模式）
- [ ] All standard control patterns are specified: button variants, toggle,
  slider, dropdown, list, grid, modal, dialog, toast, tooltip, progress bar,
  input field, tab bar, scroll / 指定所有标准控件模式：按钮变体、切换开关、滑块、下拉菜单、列表、网格、模态框、对话框、消息提示、工具提示、进度条、输入字段、标签栏、滚动条
- [ ] All game-specific patterns needed by current UX specs are present / 当前 UX 规格所需的所有游戏特定模式都存在
- [ ] Each pattern has: When to Use, When NOT to Use, full state specification,
  accessibility spec, implementation notes / 每个模式都有：何时使用、何时不使用、完整状态规格、无障碍规格、实现说明
- [ ] Animation Standards table present / 存在动画标准表
- [ ] Sound Standards table present / 存在声音标准表
- [ ] No conflicting behaviors between patterns (e.g., "Back" behavior consistent
  across all navigation patterns) / 模式之间无冲突行为（例如，所有导航模式中的"返回"行为一致）

---

## Phase 4: Output the Verdict / 阶段 4：输出裁决

```markdown
## UX Review: [Document Name] / ## UX 审查：[文档名称]
**Date**: [date] / **日期**：[日期]
**Reviewer**: ux-review skill / **审查者**：ux-review 技能
**Document**: [file path] / **文档**：[文件路径]
**Platform Target**: [from header] / **平台目标**：[来自头部]
**Accessibility Tier**: [from header or accessibility-requirements.md] / **无障碍层级**：[来自头部或 accessibility-requirements.md]

### Completeness: [X/Y sections present] / ### 完整性：[X/Y 部分存在]
- [x] Purpose & Player Need / 目的与玩家需求
- [ ] States & Variants — MISSING: error state not documented / 状态与变体 — 缺失：错误状态未记录

### Quality Issues: [N found] / ### 质量问题：[发现 N 个]
1. **[Issue title]** [BLOCKING / ADVISORY] / **[问题标题]** [阻碍性/建议性]
   - What's wrong: [specific description] / - 问题所在：[具体描述]
   - Where: [section name] / - 位置：[部分名称]
   - Fix: [specific action to take] / - 修复：[要采取的具体行动]

### GDD Alignment: [ALIGNED / GAPS FOUND] / ### GDD 一致性：[一致/发现差距]
- GDD [name] UI Requirements — [X/Y requirements covered] / - GDD [名称] UI 要求 — [覆盖了 X/Y 个要求]
- Missing: [list any uncovered GDD requirements] / - 缺失：[列出任何未覆盖的 GDD 要求]

### Accessibility: [COMPLIANT / GAPS / NON-COMPLIANT] / ### 无障碍：[合规/有差距/不合规]
- Target tier: [tier] / - 目标层级：[层级]
- [list specific accessibility findings] / - [列出具体的无障碍发现]

### Pattern Library: [CONSISTENT / INCONSISTENCIES FOUND] / ### 模式库：[一致/发现不一致]
- [findings] / - [发现]

### Verdict: APPROVED / NEEDS REVISION / MAJOR REVISION NEEDED / ### 裁决：APPROVED / NEEDS REVISION / MAJOR REVISION NEEDED
**Blocking issues**: [N] — must be resolved before implementation / **阻碍性问题**：[N] — 必须在实现前解决
**Advisory issues**: [N] — recommended but not blocking / **建议性问题**：[N] — 建议但不阻碍

[For APPROVED]: This spec is ready for handoff to `/team-ui` Phase 2
(Visual Design). / [对于 APPROVED]：此规格已准备好交接给 `/team-ui` 阶段 2（视觉设计）。

[For NEEDS REVISION]: Address the [N] blocking issues above, then re-run
`/ux-review`. / [对于 NEEDS REVISION]：解决上述 [N] 个阻碍性问题，然后重新运行 `/ux-review`。

[For MAJOR REVISION NEEDED]: The spec has fundamental gaps in [areas].
Recommend returning to `/ux-design` to rework [sections]. / [对于 MAJOR REVISION NEEDED]：规格在 [领域] 存在根本性差距。建议返回 `/ux-design` 重新处理 [部分]。
```

---

## Phase 5: Collaborative Protocol / 阶段 5：协作协议

This skill is READ-ONLY — it never edits or writes files. It reports findings only. / 此技能是只读的——它从不编辑或写入文件。它只报告发现。

After delivering the verdict: / 交付裁决后：
- For **APPROVED**: suggest running `/team-ui` to begin implementation coordination / 对于 **APPROVED**：建议运行 `/team-ui` 开始实现协调
- For **NEEDS REVISION**: offer to help fix specific gaps ("Would you like me to
  help draft the missing error state?") — but do not auto-fix; wait for user
  instruction / 对于 **NEEDS REVISION**：提供帮助修复具体差距（"你希望我帮忙起草缺失的错误状态吗？"）——但不自动修复；等待用户指示
- For **MAJOR REVISION NEEDED**: suggest returning to `/ux-design` with the
  specific sections to rework / 对于 **MAJOR REVISION NEEDED**：建议返回 `/ux-design` 重新处理特定部分

Never block the user from proceeding — the verdict is advisory. Document risks,
present findings, let the user decide whether to proceed despite concerns. A user
who chooses to proceed with a NEEDS REVISION spec takes on the documented risk. / 绝不阻止用户继续——裁决是建议性的。记录风险，呈现发现，让用户决定是否继续，尽管有关切。选择继续 NEEDS REVISION 规格的用户承担记录的风险。