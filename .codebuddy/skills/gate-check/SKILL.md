---
name: gate-check
description: "Validate readiness to advance between development phases. Produces a PASS/CONCERNS/FAIL verdict with specific blockers and required artifacts. Use when user says 'are we ready to move to X', 'can we advance to production', 'check if we can start the next phase', 'pass the gate'. / 验证在开发阶段之间推进的准备度。生成 PASS/CONCERNS/FAIL 裁决及具体阻塞因素和必需工件。当用户说'我们准备好进入X了吗'、'我们可以进入生产吗'、'检查我们能否开始下一阶段'、'通过门控'时使用。"
argument-hint: "[target-phase: systems-design | technical-setup | pre-production | production | polish | release] [--review full|lean|solo]"
user-invocable: true
allowed-tools: Read, Glob, Grep, Bash, Write, Task, AskUserQuestion
model: opus
---

# Phase Gate Validation / 阶段门控验证

This skill validates whether the project is ready to advance to the next development
phase. It checks for required artifacts, quality standards, and blockers.
> **中文翻译**：此技能验证项目是否准备好推进到下一个开发阶段。它检查必需工件、质量标准和阻塞因素。

**Distinct from `/project-stage-detect`**: That skill is diagnostic ("where are we?").
This skill is prescriptive ("are we ready to advance?" with a formal verdict).
> **中文翻译**：**与 `/project-stage-detect` 不同**：那个技能是诊断性的（"我们在哪里？"）。此技能是规范性的（"我们准备好推进了吗？"带有正式裁决）。

## Production Stages (7) / 生产阶段（7个）

The project progresses through these stages: / 项目通过以下阶段推进：

1. **Concept** — Brainstorming, game concept document / **概念** — 头脑风暴，游戏概念文档
2. **Systems Design** — Mapping systems, writing GDDs / **系统设计** — 映射系统，编写 GDD
3. **Technical Setup** — Engine config, architecture decisions / **技术设置** — 引擎配置，架构决策
4. **Pre-Production** — Prototyping, vertical slice validation / **预生产** — 原型制作，垂直切片验证
5. **Production** — Feature development (Epic/Feature/Task tracking active) / **生产** — 功能开发（史诗/功能/任务跟踪活跃）
6. **Polish** — Performance, playtesting, bug fixing / **打磨** — 性能、试玩、缺陷修复
7. **Release** — Launch prep, certification / **发布** — 发布准备，认证

**When a gate passes**, write the new stage name to `production/stage.txt`
(single line, e.g. `Production`). This updates the status line immediately.
> **中文翻译**：**当门控通过时**，将新阶段名称写入 `production/stage.txt`（单行，例如 `Production`）。这会立即更新状态行。

---

## 1. Parse Arguments / 1. 解析参数

**Target phase:** `$ARGUMENTS[0]` (blank = auto-detect current stage, then validate next transition)
> **中文翻译**：**目标阶段：** `$ARGUMENTS[0]`（空白 = 自动检测当前阶段，然后验证下一个转换）

Also resolve the review mode (once, store for all gate spawns this run): / 同时解析审查模式（一次，存储本次运行的所有门控生成）：
1. If `--review [full|lean|solo]` was passed → use that / 如果传递了 `--review [full|lean|solo]` → 使用它
2. Else read `production/review-mode.txt` → use that value / 否则读取 `production/review-mode.txt` → 使用该值
3. Else → default to `lean` / 否则 → 默认为 `lean`

Note: in `solo` mode, director spawns (CD-PHASE-GATE, TD-PHASE-GATE, PR-PHASE-GATE, AD-PHASE-GATE) are skipped — gate-check becomes artifact-existence checks only. In `lean` mode, all four directors still run (phase gates are the purpose of lean mode).
> **中文翻译**：注意：在 `solo` 模式下，总监生成被跳过 — 门控检查仅变为工件存在性检查。在 `lean` 模式下，所有四位总监仍然运行（阶段门控是 lean 模式的目的）。

- **With argument**: `/gate-check production` — validate readiness for that specific phase / **带参数**：验证特定阶段的准备度
- **No argument**: Auto-detect current stage using the same heuristics as
  `/project-stage-detect`, then **confirm with the user before running**: / **无参数**：使用与 `/project-stage-detect` 相同的启发式方法自动检测当前阶段，然后**在运行前与用户确认**：

  Use `AskUserQuestion`: / 使用 `AskUserQuestion`：
  - Prompt: "Detected stage: **[current stage]**. Running gate for [Current] → [Next] transition. Is this correct?" / 提示："检测到阶段：**[当前阶段]**。运行 [当前] → [下一] 转换的门控。这正确吗？"
  - Options: / 选项：
    - `[A] Yes — run this gate` / `[A] 是 — 运行此门控`
    - `[B] No — pick a different gate` (if selected, show a second widget listing all gate options) / `[B] 否 — 选择不同的门控`（如果选择，显示第二个小部件列出所有门控选项）
  
  Do not skip this confirmation step when no argument is provided. / 当未提供参数时，不要跳过此确认步骤。

---

## 2. Phase Gate Definitions / 2. 阶段门控定义

### Gate: Concept → Systems Design / 门控：概念 → 系统设计

**Required Artifacts:** / **必需工件：**
- [ ] `design/gdd/game-concept.md` exists and has content / 存在且有内容
- [ ] Game pillars defined (in concept doc or `design/gdd/game-pillars.md`) / 游戏支柱已定义
- [ ] Visual Identity Anchor section exists in `design/gdd/game-concept.md` / 视觉标识锚点部分存在

**Quality Checks:** / **质量检查：**
- [ ] Game concept has been reviewed (`/design-review` verdict not MAJOR REVISION NEEDED) / 游戏概念已审查
- [ ] Core loop is described and understood / 核心循环已描述和理解
- [ ] Target audience is identified / 目标受众已识别
- [ ] Visual Identity Anchor contains a one-line visual rule and at least 2 supporting visual principles / 视觉标识锚点包含一行视觉规则和至少 2 个支持性视觉原则

---

### Gate: Systems Design → Technical Setup / 门控：系统设计 → 技术设置

**Required Artifacts:** / **必需工件：**
- [ ] Systems index exists at `design/gdd/systems-index.md` with at least MVP systems enumerated / 系统索引存在且至少列出了 MVP 系统
- [ ] All MVP-tier GDDs exist in `design/gdd/` and individually pass `/design-review` / 所有 MVP 层级的 GDD 存在且各自通过设计审查
- [ ] A cross-GDD review report exists in `design/gdd/` (from `/review-all-gdds`) / 跨 GDD 审查报告存在

**Quality Checks:** / **质量检查：**
- [ ] All MVP GDDs pass individual design review (8 required sections, no MAJOR REVISION NEEDED verdict) / 所有 MVP GDD 通过单独的设计审查
- [ ] `/review-all-gdds` verdict is not FAIL / `/review-all-gdds` 裁决不是失败
- [ ] All cross-GDD consistency issues flagged by `/review-all-gdds` are resolved or explicitly accepted / 所有跨 GDD 一致性问题已解决或明确接受
- [ ] System dependencies are mapped in the systems index and are bidirectionally consistent / 系统依赖已在系统索引中映射且双向一致
- [ ] MVP priority tier is defined / MVP 优先级层级已定义
- [ ] No stale GDD references flagged / 未标记过时的 GDD 引用

---

### Gate: Technical Setup → Pre-Production / 门控：技术设置 → 预生产

**Required Artifacts:** / **必需工件：**
- [ ] Engine chosen (CODEBUDDY.md Technology Stack is not `[CHOOSE]`) / 引擎已选择
- [ ] Technical preferences configured / 技术偏好已配置
- [ ] Art bible exists at `design/art/art-bible.md` with at least Sections 1–4 / 美术圣经存在且至少有第 1-4 节
- [ ] At least 3 Architecture Decision Records in `docs/architecture/` covering Foundation-layer systems / 至少 3 个 ADR 覆盖基础层系统
- [ ] Engine reference docs exist in `docs/engine-reference/[engine]/` / 引擎参考文档存在
- [ ] Test framework initialized / 测试框架已初始化
- [ ] CI/CD test workflow exists / CI/CD 测试工作流存在
- [ ] At least one example test file exists to confirm the framework is functional / 至少一个示例测试文件存在
- [ ] Master architecture document exists at `docs/architecture/architecture.md` / 主架构文档存在
- [ ] Architecture traceability index exists / 架构可追溯性索引存在
- [ ] `/architecture-review` has been run / `/architecture-review` 已运行
- [ ] `design/accessibility-requirements.md` exists with accessibility tier committed / 无障碍要求文档存在
- [ ] `design/ux/interaction-patterns.md` exists / 交互模式库存在

**Quality Checks:** / **质量检查：**
- [ ] Architecture decisions cover core systems / 架构决策覆盖核心系统
- [ ] Technical preferences have naming conventions and performance budgets set / 技术偏好已设置命名约定和性能预算
- [ ] Accessibility tier is defined and documented / 无障碍层级已定义和记录
- [ ] At least one screen's UX spec started / 至少一个屏幕的 UX 规格已开始
- [ ] All ADRs have an **Engine Compatibility section** with engine version stamped / 所有 ADR 有引擎兼容性部分并标注引擎版本
- [ ] All ADRs have a **GDD Requirements Addressed section** with explicit GDD linkage / 所有 ADR 有 GDD 需求已解决部分并明确 GDD 链接
- [ ] No ADR references APIs listed in deprecated-apis.md / 没有 ADR 引用已弃用的 API
- [ ] All HIGH RISK engine domains have been explicitly addressed / 所有高风险引擎域已明确处理
- [ ] Architecture traceability matrix has **zero Foundation layer gaps** / 架构可追溯性矩阵基础层零差距

**ADR Circular Dependency Check** / **ADR 循环依赖检查**: For all ADRs in `docs/architecture/`, read each ADR's
"ADR Dependencies" / "Depends On" section. Build a dependency graph. If any cycle is detected:
- Flag as **FAIL**: "Circular ADR dependency: [ADR-X] → [ADR-Y] → [ADR-X]. / 标记为 **失败**："循环 ADR 依赖：[ADR-X] → [ADR-Y] → [ADR-X]。
  Neither can reach Accepted while the cycle exists." / 循环存在时两者都无法达到已接受状态。"

**Engine Validation** / **引擎验证** (read `docs/engine-reference/[engine]/VERSION.md` first):
- [ ] ADRs that touch post-cutoff engine APIs are flagged with Knowledge Risk: HIGH/MEDIUM / 涉及截止后引擎 API 的 ADR 已标记知识风险
- [ ] `/architecture-review` engine audit shows no deprecated API usage / `/architecture-review` 引擎审计未显示已弃用 API 使用
- [ ] All ADRs agree on the same engine version / 所有 ADR 同意相同的引擎版本

---

### Gate: Pre-Production → Production / 门控：预生产 → 生产

**Required Artifacts:** / **必需工件：**
- [ ] At least 1 prototype in `prototypes/` with a README / 至少 1 个原型及 README
- [ ] First sprint plan exists in `production/sprints/` / 第一个冲刺计划存在
- [ ] Art bible is complete (all 9 sections) and AD-ART-BIBLE sign-off verdict is recorded / 美术圣经完成（全部 9 节）且签核裁决已记录
- [ ] Character visual profiles exist for key characters / 关键角色的视觉档案存在
- [ ] All MVP-tier GDDs from systems index are complete / 系统索引中所有 MVP 层级 GDD 已完成
- [ ] Master architecture document exists / 主架构文档存在
- [ ] At least 3 ADRs covering Foundation-layer decisions exist / 至少 3 个覆盖基础层决策的 ADR 存在
- [ ] Control manifest exists at `docs/architecture/control-manifest.md` / 控制清单存在
- [ ] Epics defined in `production/epics/` with at least Foundation and Core layer epics present / 史诗已定义且至少基础层和核心层史诗存在
- [ ] Vertical Slice build exists and is playable / 垂直切片构建存在且可游玩
- [ ] Vertical Slice has been playtested with at least 3 sessions / 垂直切片已试玩至少 3 次
- [ ] Vertical Slice playtest report exists / 垂直切片试玩报告存在
- [ ] UX specs exist for key screens / 关键屏幕的 UX 规格存在
- [ ] HUD design document exists (if game has in-game HUD) / HUD 设计文档存在
- [ ] All key screen UX specs have passed `/ux-review` / 所有关键屏幕 UX 规格已通过审查

**Quality Checks:** / **质量检查：**
- [ ] **Core loop fun is validated** — playtest data confirms the central mechanic is enjoyable / **核心循环趣味已验证** — 试玩数据确认核心机制有趣
- [ ] UX specs cover all UI Requirements sections from MVP-tier GDDs / UX 规格覆盖 MVP 层级 GDD 的所有 UI 需求部分
- [ ] Interaction pattern library documents patterns used in key screens / 交互模式库记录了关键屏幕使用的模式
- [ ] Accessibility tier is addressed in all key screen UX specs / 无障碍层级在所有关键屏幕 UX 规格中已处理
- [ ] Sprint plan references real story file paths / 冲刺计划引用真实的故事文件路径
- [ ] **Vertical Slice is COMPLETE**, not just scoped / **垂直切片已完成**，不仅仅是范围界定
- [ ] Architecture document has no unresolved open questions in Foundation or Core layers / 架构文档在基础层或核心层没有未解决的开放问题
- [ ] All ADRs have Engine Compatibility sections stamped with the engine version / 所有 ADR 有标注引擎版本的引擎兼容性部分
- [ ] **Core fantasy is delivered** — at least one playtester independently described an experience matching the Player Fantasy / **核心幻想已交付** — 至少一位试玩者独立描述了与玩家幻想匹配的体验

**Vertical Slice Validation** / **垂直切片验证** (FAIL if any item is NO / 任何项目为否则失败):
- [ ] A human has played through the core loop without developer guidance / 一个人在没有开发者指导的情况下游玩了核心循环
- [ ] The game communicates what to do within the first 2 minutes of play / 游戏在游玩前 2 分钟内传达了该做什么
- [ ] No critical "fun blocker" bugs exist in the Vertical Slice build / 垂直切片构建中不存在关键的"趣味阻塞"缺陷
- [ ] The core mechanic feels good to interact with / 核心机制交互感觉良好

> **Note**: If any Vertical Slice Validation item is FAIL, the verdict is automatically FAIL
> regardless of other checks. Advancing without a validated Vertical Slice is the #1 cause of
> production failure in game development.
> **中文翻译**：> **注意**：如果任何垂直切片验证项目失败，裁决自动为失败，无论其他检查如何。在未验证垂直切片的情况下推进是游戏开发中生产失败的头号原因。

---

### Gate: Production → Polish / 门控：生产 → 打磨

**Required Artifacts:** / **必需工件：**
- [ ] `src/` has active code organized into subsystems / `src/` 有按子系统组织的活跃代码
- [ ] All core mechanics from GDD are implemented / GDD 中的所有核心机制已实现
- [ ] Main gameplay path is playable end-to-end / 主要游戏路径可端到端游玩
- [ ] Test files exist covering Logic and Integration stories / 测试文件存在且覆盖逻辑和集成故事
- [ ] Smoke check has been run with a PASS or PASS WITH WARNINGS verdict / 冒烟检查已运行且裁决为通过或带警告通过
- [ ] QA plan exists / QA 计划存在
- [ ] QA sign-off report exists with verdict APPROVED or APPROVED WITH CONDITIONS / QA 签核报告存在且裁决为批准或有条件批准
- [ ] At least 3 distinct playtest sessions documented / 至少 3 次不同的试玩会话已记录
- [ ] Fun hypothesis from Game Concept has been explicitly validated or revised / 游戏概念的趣味假设已明确验证或修订

**Quality Checks:** / **质量检查：**
- [ ] Tests are passing / 测试通过
- [ ] No critical/blocker bugs / 无关键/阻塞缺陷
- [ ] Core loop plays as designed / 核心循环按设计游玩
- [ ] Performance is within budget / 性能在预算内
- [ ] Playtest findings have been reviewed and critical fun issues addressed / 试玩发现已审查且关键趣味问题已处理
- [ ] No "confusion loops" identified / 未识别到"困惑循环"
- [ ] All implemented screens have corresponding UX specs / 所有已实现的屏幕有对应的 UX 规格
- [ ] Accessibility compliance verified / 无障碍合规已验证

---

### Gate: Polish → Release / 门控：打磨 → 发布

**Required Artifacts:** / **必需工件：**
- [ ] All features from milestone plan are implemented / 里程碑计划中的所有功能已实现
- [ ] Content is complete / 内容完整
- [ ] Localization strings are externalized / 本地化字符串已外部化
- [ ] QA test plan exists / QA 测试计划存在
- [ ] QA sign-off report exists / QA 签核报告存在
- [ ] All Must Have story test evidence is present / 所有必须有的故事测试证据存在
- [ ] Smoke check passes cleanly / 冒烟检查干净通过
- [ ] No test regressions / 无测试回归
- [ ] Balance data has been reviewed / 平衡数据已审查
- [ ] Release checklist completed / 发布清单已完成
- [ ] Changelog / patch notes drafted / 变更日志/补丁说明已起草

**Quality Checks:** / **质量检查：**
- [ ] Full QA pass signed off by `qa-lead` / 完整 QA 通过并由 `qa-lead` 签核
- [ ] All tests passing / 所有测试通过
- [ ] Performance targets met across all target platforms / 所有目标平台满足性能目标
- [ ] No known critical, high, or medium-severity bugs / 无已知的关键、高或中等严重性缺陷
- [ ] Accessibility basics covered / 无障碍基础已覆盖
- [ ] Localization verified for all target languages / 所有目标语言的本地化已验证
- [ ] Build compiles and packages cleanly / 构建干净地编译和打包

---

## 3. Run the Gate Check / 3. 运行门控检查

**Before running artifact checks**, read `docs/consistency-failures.md` if it exists.
Extract entries whose Domain matches the target phase. Carry these as context —
recurring conflict patterns in the target domain warrant increased scrutiny.
> **中文翻译**：**在运行工件检查之前**，如果存在则读取 `docs/consistency-failures.md`。提取域与目标阶段匹配的条目。将这些作为上下文携带 — 目标域中的重复冲突模式需要加强审查。

For each item in the target gate: / 对于目标门控中的每个项目：

### Artifact Checks / 工件检查
- Use `Glob` and `Read` to verify files exist and have meaningful content / 使用 `Glob` 和 `Read` 验证文件存在且有有意义的内容
- Don't just check existence — verify the file has real content (not just a template header) / 不要只检查存在性 — 验证文件有真实内容（不只是模板头）
- For code checks, verify directory structure and file counts / 对于代码检查，验证目录结构和文件数量

### Quality Checks / 质量检查
- For test checks: Run the test suite via `Bash` if a test runner is configured / 对于测试检查：如果配置了测试运行器，通过 `Bash` 运行测试套件
- For design review checks: `Read` the GDD and check for the 8 required sections / 对于设计审查检查：`Read` GDD 并检查 8 个必需部分
- For performance checks: compare against profiling data / 对于性能检查：与性能分析数据比较
- For localization checks: `Grep` for hardcoded strings in `src/` / 对于本地化检查：在 `src/` 中 `Grep` 查找硬编码字符串

### Cross-Reference Checks / 交叉引用检查
- Compare `design/gdd/` documents against `src/` implementations / 将 `design/gdd/` 文档与 `src/` 实现比较
- Check that every system referenced in architecture docs has corresponding code / 检查架构文档中引用的每个系统都有对应代码
- Verify sprint plans reference real work items / 验证冲刺计划引用真实的工作项

---

## 4. Collaborative Assessment / 4. 协作评估

For items that can't be automatically verified, **ask the user**: / 对于无法自动验证的项目，**询问用户**：

- "I can't automatically verify that the core loop plays well. Has it been playtested?" / "我无法自动验证核心循环是否游玩良好。它已被试玩了吗？"
- "No playtest report found. Has informal testing been done?" / "未找到试玩报告。是否进行了非正式测试？"
- "Performance profiling data isn't available. Would you like to run `/perf-profile`?" / "性能分析数据不可用。您想运行 `/perf-profile` 吗？"

**Never assume PASS for unverifiable items.** Mark them as MANUAL CHECK NEEDED.
> **中文翻译**：**永远不要对无法验证的项目假设通过。** 将它们标记为需要手动检查。

---

## 4b. Director Panel Assessment / 4b. 总监小组评估

Before generating the final verdict, spawn all four directors as **parallel subagents** via Task. / 在生成最终裁决之前，通过 Task 将所有四位总监作为**并行子代理**生成。

**Spawn in parallel:** / **并行生成：**

1. **`creative-director`** — gate **CD-PHASE-GATE** / 门控 **CD-PHASE-GATE**
2. **`technical-director`** — gate **TD-PHASE-GATE** / 门控 **TD-PHASE-GATE**
3. **`producer`** — gate **PR-PHASE-GATE** / 门控 **PR-PHASE-GATE**
4. **`art-director`** — gate **AD-PHASE-GATE** / 门控 **AD-PHASE-GATE**

Pass to each: target phase name, list of artifacts present, and the context fields listed in that gate's definition. / 传递给每位：目标阶段名称、现有工件列表和该门控定义中列出的上下文字段。

**Collect all four responses, then present the Director Panel summary:** / **收集所有四个响应，然后呈现总监小组摘要：**

```
## Director Panel Assessment / 总监小组评估

Creative Director:  [READY / CONCERNS / NOT READY] / 创意总监：[就绪/关注/未就绪]
  [feedback] / [反馈]

Technical Director: [READY / CONCERNS / NOT READY] / 技术总监：[就绪/关注/未就绪]
  [feedback] / [反馈]

Producer:           [READY / CONCERNS / NOT READY] / 制作人：[就绪/关注/未就绪]
  [feedback] / [反馈]

Art Director:       [READY / CONCERNS / NOT READY] / 美术总监：[就绪/关注/未就绪]
  [feedback] / [反馈]
```

**Apply to the verdict:** / **应用于裁决：**
- Any director returns NOT READY → verdict is minimum FAIL / 任何总监返回未就绪 → 裁决最低为失败
- Any director returns CONCERNS → verdict is minimum CONCERNS / 任何总监返回关注 → 裁决最低为关注
- All four READY → eligible for PASS / 所有四位就绪 → 有资格通过

---

## 5. Output the Verdict / 5. 输出裁决

```
## Gate Check: [Current Phase] → [Target Phase] / 门控检查：[当前阶段] → [目标阶段]

**Date**: [date] / **日期**：[日期]
**Checked by**: gate-check skill / **检查者**：gate-check 技能

### Required Artifacts: [X/Y present] / 必需工件：[X/Y 存在]
- [x] design/gdd/game-concept.md — exists, 2.4KB
- [ ] docs/architecture/ — MISSING / 缺失
- [x] production/sprints/ — exists, 1 sprint plan / 存在，1 个冲刺计划

### Quality Checks: [X/Y passing] / 质量检查：[X/Y 通过]
- [x] GDD has 8/8 required sections / GDD 有 8/8 个必需部分
- [ ] Tests — FAILED / 测试 — 失败
- [?] Core loop playtested — MANUAL CHECK NEEDED / 核心循环已试玩 — 需要手动检查

### Blockers / 阻塞因素
1. **No Architecture Decision Records** — Run `/architecture-decision` / **无架构决策记录** — 运行 `/architecture-decision`
2. **3 test failures** — Fix failing tests before advancing. / **3 个测试失败** — 在推进之前修复失败的测试。

### Recommendations / 建议
- [Priority actions to resolve blockers] / [解决阻塞因素的优先行动]
- [Optional improvements that aren't blocking] / [不阻塞的可选改进]

### Verdict: [PASS / CONCERNS / FAIL] / 裁决：[通过/关注/失败]
- **PASS**: All required artifacts present, all quality checks passing / **通过**：所有必需工件存在，所有质量检查通过
- **CONCERNS**: Minor gaps exist but can be addressed during the next phase / **关注**：存在小差距但可在下一阶段处理
- **FAIL**: Critical blockers must be resolved before advancing / **失败**：必须先解决关键阻塞因素才能推进
```

---

## 5a. Chain-of-Verification / 5a. 验证链

After drafting the verdict in Phase 5, challenge it before finalising. / 在第 5 阶段起草裁决后，在最终确定之前挑战它。

**Step 1 — Generate 5 challenge questions** designed to disprove the verdict: / **步骤 1 — 生成 5 个旨在反驳裁决的挑战问题：**

For a **PASS** draft: / 对于**通过**草稿：
- "Which quality checks did I verify by actually reading a file, vs. inferring they passed?" / "哪些质量检查我是通过实际读取文件验证的，vs 推断它们通过了？"
- "Are there MANUAL CHECK NEEDED items I marked PASS without user confirmation?" / "有没有我未经用户确认就标记为通过的需要手动检查的项目？"
- "Did I confirm all listed artifacts have real content, not just empty headers?" / "我确认了所有列出的工件有真实内容，而不只是空头吗？"
- "Could any blocker I dismissed as minor actually prevent the phase from succeeding?" / "我作为轻微问题忽略的任何阻塞因素实际上可能阻止阶段成功吗？"
- "Which single check am I least confident in, and why?" / "我对哪个单一检查最不自信，为什么？"

For a **CONCERNS** draft: / 对于**关注**草稿：
- "Could any listed CONCERN be elevated to a blocker given the project's current state?" / "考虑到项目当前状态，任何列出的关注可以被提升为阻塞因素吗？"
- "Is the concern resolvable within the next phase, or does it compound over time?" / "关注是否可在下一阶段解决，还是会随时间复合？"
- "Did I soften any FAIL condition into a CONCERN to avoid a harder verdict?" / "我是否将任何失败条件软化为关注以避免更严厉的裁决？"
- "Are there artifacts I didn't check that could reveal additional blockers?" / "有没有我未检查的工件可能揭示额外的阻塞因素？"
- "Do all the CONCERNS together create a blocking problem even if each is minor alone?" / "即使每个关注单独来看是轻微的，所有关注一起是否构成了阻塞问题？"

For a **FAIL** draft: / 对于**失败**草稿：
- "Have I accurately separated hard blockers from strong recommendations?" / "我是否准确区分了硬阻塞因素和强建议？"
- "Are there any PASS items I was too lenient about?" / "有没有我对哪些通过项目过于宽松？"
- "Am I missing any additional blockers the user should know about?" / "我是否遗漏了用户应该知道的额外阻塞因素？"
- "Can I provide a minimal path to PASS — the specific 3 things that must change?" / "我能提供通往通过的最小路径 — 必须改变的 3 件具体事情吗？"
- "Is the fail condition resolvable, or does it indicate a deeper design problem?" / "失败条件是可解决的，还是表明更深层的设计问题？"

**Step 2 — Answer each question** independently. / **步骤 2 — 独立回答每个问题。**

**Step 3 — Revise if needed:** / **步骤 3 — 如需则修订：**
- If any answer reveals a missed blocker → upgrade verdict / 如果任何答案揭示了遗漏的阻塞因素 → 升级裁决
- If any answer reveals an over-stated blocker → downgrade only if citing specific evidence / 如果任何答案揭示了过度陈述的阻塞因素 → 仅在引用具体证据时降级
- If answers are consistent → confirm verdict unchanged / 如果答案一致 → 确认裁决不变

**Step 4 — Note the verification** in the final report output: / **步骤 4 — 在最终报告输出中注明验证：**
`Chain-of-Verification: [N] questions checked — verdict [unchanged | revised from X to Y]` / `验证链：[N] 个问题已检查 — 裁决[不变 | 从 X 修订为 Y]`

---

## 6. Update Stage on PASS / 6. 通过时更新阶段

When the verdict is **PASS** and the user confirms they want to advance: / 当裁决为**通过**且用户确认他们想要推进时：

1. Write the new stage name to `production/stage.txt` (single line, no trailing newline) / 将新阶段名称写入 `production/stage.txt`（单行，无尾部换行）
2. This immediately updates the status line for all future sessions / 这会立即更新所有未来会话的状态行

**Always ask before writing**: "Gate passed. May I update `production/stage.txt` to 'Production'?" / **写入前始终询问**："门控通过。我可以将 `production/stage.txt` 更新为 'Production' 吗？"

---

## 7. Closing Next-Step Widget / 7. 结束时下一步小部件

After the verdict is presented and any stage.txt update is complete, close with a structured next-step prompt using `AskUserQuestion`. / 在裁决呈现且任何 stage.txt 更新完成后，使用 `AskUserQuestion` 以结构化的下一步提示结束。

**Tailor the options to the gate that just ran:** / **根据刚运行的门控定制选项：**

For **systems-design PASS**: / 对于**系统设计通过**：
- `[A] Run /create-architecture — produce your master architecture blueprint` / 运行 /create-architecture — 生成主架构蓝图
- `[B] Design more GDDs first` / 先设计更多 GDD
- `[C] Stop here for this session` / 此会话到此结束

For **technical-setup PASS**: / 对于**技术设置通过**：
- `[A] Start Pre-Production — begin prototyping the Vertical Slice` / 开始预生产 — 开始原型制作垂直切片
- `[B] Write more ADRs first` / 先写更多 ADR
- `[C] Stop here for this session` / 此会话到此结束

For all other gates, offer the two most logical next steps for that phase plus "Stop here". / 对于所有其他门控，提供该阶段最合理的两个下一步加"到此结束"。

---

## 8. Follow-Up Actions / 8. 后续行动

Based on the verdict, suggest specific next steps: / 根据裁决，建议具体的下一步：

- **No art bible?** → `/art-bible` / **无美术圣经？** → `/art-bible`
- **Art bible exists but no asset specs?** → `/asset-spec system:[name]` / **美术圣经存在但无资产规格？** → `/asset-spec system:[name]`
- **No game concept?** → `/brainstorm` / **无游戏概念？** → `/brainstorm`
- **No systems index?** → `/map-systems` / **无系统索引？** → `/map-systems`
- **Missing design docs?** → `/reverse-document` / **缺少设计文档？** → `/reverse-document`
- **Small design change needed?** → `/quick-design` / **需要小的设计更改？** → `/quick-design`
- **No UX specs?** → `/ux-design [screen name]` / **无 UX 规格？** → `/ux-design [screen name]`
- **UX specs not reviewed?** → `/ux-review [file]` / **UX 规格未审查？** → `/ux-review [file]`
- **No accessibility requirements doc?** → offer to create it now / **无无障碍要求文档？** → 现在提供创建
- **No interaction pattern library?** → `/ux-design patterns` / **无交互模式库？** → `/ux-design patterns`
- **GDDs not cross-reviewed?** → `/review-all-gdds` / **GDD 未跨审查？** → `/review-all-gdds`
- **No test framework?** → `/test-setup` / **无测试框架？** → `/test-setup`
- **No QA plan?** → `/qa-plan sprint` / **无 QA 计划？** → `/qa-plan sprint`
- **Missing ADRs?** → `/architecture-decision` / **缺少 ADR？** → `/architecture-decision`
- **No master architecture doc?** → `/create-architecture` / **无主架构文档？** → `/create-architecture`
- **Missing control manifest?** → `/create-control-manifest` / **缺少控制清单？** → `/create-control-manifest`
- **Missing epics?** → `/create-epics layer: foundation` / **缺少史诗？** → `/create-epics layer: foundation`
- **Missing stories?** → `/create-stories [epic-slug]` / **缺少故事？** → `/create-stories [epic-slug]`
- **Tests failing?** → delegate to `lead-programmer` or `qa-tester` / **测试失败？** → 委托给 `lead-programmer` 或 `qa-tester`
- **No playtest data?** → `/playtest-report` / **无试玩数据？** → `/playtest-report`
- **Performance unknown?** → `/perf-profile` / **性能未知？** → `/perf-profile`
- **Not localized?** → `/localize` / **未本地化？** → `/localize`
- **Ready for release?** → `/launch-checklist` / **准备好发布？** → `/launch-checklist`

---

## Collaborative Protocol / 协作协议

This skill follows the collaborative design principle: / 此技能遵循协作设计原则：

1. **Scan first**: Check all artifacts and quality gates / **先扫描**：检查所有工件和质量门控
2. **Ask about unknowns**: Don't assume PASS for things you can't verify / **询问未知项**：不要对无法验证的项目假设通过
3. **Present findings**: Show the full checklist with status / **呈现发现**：显示完整的检查清单及状态
4. **User decides**: The verdict is a recommendation — the user makes the final call / **用户决定**：裁决是建议 — 用户做最终决定
5. **Get approval**: "May I write this gate check report to production/gate-checks/?" / **获得批准**："我可以将此门控检查报告写入 production/gate-checks/ 吗？"

**Never** block a user from advancing — the verdict is advisory. Document the risks
and let the user decide whether to proceed despite concerns.
> **中文翻译**：**永远不要**阻止用户推进 — 裁决是咨询性的。记录风险并让用户决定是否在有关注的情况下继续。
