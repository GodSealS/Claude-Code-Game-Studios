# CCGS Skill Testing Framework 详解与扩展指南

> 本文档详细说明 `CCGS Skill Testing Framework/` 目录下每级目录和文件的功能，以及如何扩展该框架。

---

## 一、框架定位 / Framework Positioning

**CCGS Skill Testing Framework** 是 Claude Code Game Studios (CCGS) 的**质量保证基础设施**。它不是测试用 CCGS 开发出来的游戏，而是测试 **Skills 和 Agents 本身**是否正确运行。

> **独立可选**：该目录完全独立于 `.codebuddy/` 主框架，删除它不会影响 CCGS 的任何功能。

---

## 二、目录结构与功能详解 / Directory Structure & Function

```
CCGS Skill Testing Framework/
├── README.md              ← 框架总览和使用指南
├── CODEBUDDY.md           ← Claude 如何理解和使用本框架的指令
├── catalog.yaml           ← 主注册表：72 Skills + 49 Agents 的测试覆盖追踪
├── quality-rubric.md      ← 按类别划分的 PASS/FAIL 度量标准
├── skills/                ← Skill 行为规格文件（每个 Skill 一个文件）
├── agents/                ← Agent 行为规格文件（每个 Agent 一个文件）
└── templates/             ← 规格文件的编写模板
```

### 2.1 顶层根文件 / Root Files

| 文件 | 功能说明 |
|------|----------|
| **README.md** | 框架的入口文档。描述框架目的、使用方法（`/skill-test`、`/skill-improve` 命令）、Skill 类别和 Agent 层级总览、如何编写新规格、如何删除框架 |
| **CODEBUDDY.md** | 给 AI 助手的指令文件。定义了关键文件路径约定、Skill 类别映射、Agent 层级映射、测试工作流（5 步流程）、改进工作流。确保 AI 正确理解和使用本框架 |
| **catalog.yaml** | **主注册表**——整个框架的数据核心。YAML 格式，包含两个顶级列表：<br/>- `skills:` — 72 条记录，每条含 `name`、`spec`（规格文件路径）、`category`、`priority`（critical/high/medium/low）、6 个追踪字段（`last_static`、`last_spec`、`last_category` 及其 result）<br/>- `agents:` — 49 条记录，每条含 `name`、`spec`、`category`、追踪字段 |
| **quality-rubric.md** | **按类别划分的质量度量标准**。为每个 Skill 类别（gate/review/authoring/readiness/pipeline/analysis/team/sprint/utility）和 Agent 类别（director/lead/specialist/engine/qa/operations）定义了 3-5 条 PASS/FAIL 检查项。由 `/skill-test category` 命令使用 |

### 2.2 skills/ 目录 — Skill 行为规格

每个文件都是一个 Skill 的**行为测试规格**，包含：Skill 摘要、静态断言、5 个测试用例（含 Fixture 和 Expected behaviour）、协议合规检查、覆盖说明。

| 子目录 | 包含的 Skill 规格 | 数量 | 类别说明 |
|--------|-------------------|------|----------|
| **gate/** | `gate-check.md` | 1 | **门控**：控制阶段转换的最核心 Skill，验证是否可以进入下一开发阶段 |
| **review/** | `design-review.md`、`architecture-review.md`、`review-all-gdds.md` | 3 | **审查**：只读分析文档，生成结构化裁决报告（PASS/CONCERNS/FAIL） |
| **authoring/** | `design-system.md`、`quick-design.md`、`architecture-decision.md`、`ux-design.md`、`ux-review.md`、`art-bible.md`、`create-architecture.md` | 7 | **创作**：逐节创建/更新设计文档，遵循"先问再写"协作协议 |
| **readiness/** | `story-readiness.md`、`story-done.md` | 2 | **就绪**：验证 Story 在开发前/后的准备状态，生成多维度裁决 |
| **pipeline/** | `create-epics.md`、`create-stories.md`、`dev-story.md`、`create-control-manifest.md`、`propagate-design-change.md`、`map-systems.md` | 6 | **管线**：产生供下游 Skill 消费的工件（Epic/Story/Manifest），遵循正确 schema |
| **analysis/** | `consistency-check.md`、`balance-check.md`、`content-audit.md`、`code-review.md`、`tech-debt.md`、`scope-check.md`、`estimate.md`、`perf-profile.md`、`asset-audit.md`、`security-audit.md`、`test-evidence-review.md`、`test-flakiness.md` | 12 | **分析**：只读扫描项目，生成结构化发现报告，不自动修改文件 |
| **team/** | `team-combat.md`、`team-narrative.md`、`team-audio.md`、`team-level.md`、`team-ui.md`、`team-qa.md`、`team-release.md`、`team-polish.md`、`team-live-ops.md` | 9 | **团队**：编排多个专家 Agent 协同工作，并行启动独立任务，收集所有裁决 |
| **sprint/** | `sprint-plan.md`、`sprint-status.md`、`milestone-review.md`、`retrospective.md`、`changelog.md`、`patch-notes.md` | 6 | **冲刺**：读取生产状态，产生规划/报告制品，包含 Producer 门控 |
| **utility/** | `start.md`、`help.md`、`brainstorm.md`、`adopt.md`、`hotfix.md`、`localize.md`、`skill-test.md`、`skill-improve.md`、`bug-report.md`、`bug-triage.md` 等 | 26 | **实用**：所有不属于上述类别的 Skill，通过 7 项静态检查即为合格 |

### 2.3 agents/ 目录 — Agent 行为规格

每个文件都是一个 Agent 的**行为测试规格**，包含：Agent 摘要（领域、升级路径、委托对象）、静态断言、5 个测试用例（域内请求、域外重定向、门控裁决、冲突升级、上下文传递）、协议合规检查、覆盖说明。

| 子目录 | 包含的 Agent 规格 | 数量 | 层级说明 |
|--------|-------------------|------|----------|
| **directors/** | `creative-director.md`、`technical-director.md`、`producer.md`、`art-director.md` | 4 | **总监级 (Tier 1)**：拥有最高决策权。负责创意愿景、技术架构、制作进度、美术风格的最终审批 |
| **leads/** | `lead-programmer.md`、`qa-lead.md`、`narrative-director.md`、`audio-director.md`、`game-designer.md`、`systems-designer.md`、`level-designer.md` | 7 | **主管级 (Tier 2)**：部门主管，拥有领域内决策权，跨域冲突上升至总监 |
| **specialists/** | `gameplay-programmer.md`、`ai-programmer.md`、`technical-artist.md`、`sound-designer.md`、`engine-programmer.md`、`tools-programmer.md`、`network-programmer.md`、`ux-designer.md`、`ui-programmer.md`、`performance-analyst.md`、`prototyper.md`、`writer.md`、`world-builder.md` | 13 | **专家级 (Tier 3)**：专注单一领域实现，不做出跨域决策 |
| **engine/** | 按引擎分 5 个子目录： | 29 | **引擎专家**：各引擎的专项专家 |
| ├─ **godot/** | 5 个规格 | 5 | Godot 引擎专家（通用、GDScript、C#、Shader、GDExtension） |
| ├─ **unity/** | 5 个规格 | 5 | Unity 引擎专家（通用、UI、Shader、DOTS、Addressables） |
| ├─ **unreal/** | 5 个规格 | 5 | Unreal 引擎专家（通用、Blueprint、GAS、UMG、Replication） |
| ├─ **wechat/** | 5 个规格 | 5 | 微信小游戏专家（通用、小游戏、Shader、UI、CloudBase） |
| └─ **cocos/** | 9 个规格 | 9 | Cocos Creator 引擎专家（通用、2D、3D、Core、GFX、Physics、Physics-2D、Animation、Rendering） |
| **operations/** | `devops-engineer.md`、`release-manager.md`、`live-ops-designer.md`、`community-manager.md`、`analytics-engineer.md`、`economy-designer.md`、`localization-lead.md` | 7 | **运维级**：负责 CI/CD、发布管理、数据运营、经济平衡、本地化 |
| **qa/** | `qa-tester.md`、`security-engineer.md`、`accessibility-specialist.md` | 3 | **QA 级**：产出测试用例、缺陷报告、安全审计、无障碍检查，不写实现代码 |

### 2.4 templates/ 目录 — 规格编写模板

| 文件 | 功能说明 |
|------|----------|
| **skill-test-spec.md** | Skill 规格文件的标准模板。定义了 Skill 规格的完整结构：<br/>- 头部（name、category、priority、spec written）<br/>- Skill 摘要<br/>- 静态断言（5 项 frontmatter 检查）<br/>- 总监门控检查表（full/lean/solo 三种模式下的行为）<br/>- 5 个测试用例模板（Happy Path、Failure/Blocked、Mode Variant、Edge Case、Director Gate）<br/>- 协议合规检查<br/>- 覆盖说明 |
| **agent-test-spec.md** | Agent 规格文件的标准模板。定义了 Agent 规格的完整结构：<br/>- 头部（Tier、Category、Spec written）<br/>- Agent 摘要（Domain、Escalates to、Delegates to）<br/>- 静态断言<br/>- 5 个测试用例模板（In-Domain Request、Out-of-Domain Redirect、Gate Verdict、Conflict Escalation、Context Pass-Through）<br/>- 协议合规检查<br/>- 覆盖说明 |

---

## 三、如何扩展 CCGS Skill Testing Framework / How to Extend

扩展框架的核心流程是：**新增 Skill/Agent → 编写行为规格 → 注册到 catalog → 运行测试验证**。

### 3.1 为新 Skill 添加测试规格

**步骤 1**：确认 Skill 已在 `.codebuddy/skills/[name]/SKILL.md` 中存在。

**步骤 2**：确定 Skill 所属类别（参考 `quality-rubric.md` 中的类别定义）：
```
gate, review, authoring, readiness, pipeline, analysis, team, sprint, utility
```

**步骤 3**：复制模板创建规格文件：
```bash
cp "CCGS Skill Testing Framework/templates/skill-test-spec.md" \
   "CCGS Skill Testing Framework/skills/[category]/[skill-name].md"
```

**步骤 4**：填写规格文件，需完成：
- 头部信息（name、category、priority、spec written 日期）
- Skill 摘要（一句话描述功能）
- 静态断言（5 项结构检查，参考 `templates/skill-test-spec.md` 模板）
- 总监门控检查（说明 full/lean/solo 模式下的行为，或标为 N/A）
- 5 个测试用例：
  1. **Happy Path** — 正常成功路径
  2. **Failure/Blocked** — 失败/阻塞路径
  3. **Mode Variant** — 不同模式下的行为差异
  4. **Edge Case** — 边界条件
  5. **Director Gate** — 门控行为验证
- 协议合规检查
- 覆盖说明

**步骤 5**：在 `catalog.yaml` 中注册：
```yaml
- name: [skill-name]
  spec: CCGS Skill Testing Framework/skills/[category]/[skill-name].md
  last_static: ""
  last_static_result: ""
  last_spec: ""
  last_spec_result: ""
  last_category: ""
  last_category_result: ""
  priority: [critical|high|medium|low]
  category: [gate|review|authoring|...]
```

**步骤 6**：运行测试验证：
```
/skill-test static [skill-name]    # 静态结构检查
/skill-test spec [skill-name]      # 行为规格测试
/skill-test category [skill-name]  # 类别度量测试
```

### 3.2 为新 Agent 添加测试规格

**步骤 1**：确认 Agent 已在 `.codebuddy/agents/[name].md` 中存在。

**步骤 2**：确定 Agent 所属层级和类别：
```
directors / leads / specialists / engine / operations / qa
```

**步骤 3**：复制模板创建规格文件：
```bash
cp "CCGS Skill Testing Framework/templates/agent-test-spec.md" \
   "CCGS Skill Testing Framework/agents/[tier]/[agent-name].md"
```

**步骤 4**：填写规格文件，需完成：
- 头部信息（Tier、Category、Spec written 日期）
- Agent 摘要（领域、升级路径、委托对象）
- 静态断言（domain、frontmatter、escalation path）
- 5 个测试用例：
  1. **In-Domain Request** — 域内请求处理
  2. **Out-of-Domain Redirect** — 域外重定向
  3. **Gate Verdict** — 门控裁决格式
  4. **Conflict Escalation** — 冲突升级路径
  5. **Context Pass-Through** — 上下文正确使用
- 协议合规检查
- 覆盖说明

**步骤 5**：在 `catalog.yaml` 的 `agents:` 列表中注册：
```yaml
- name: [agent-name]
  spec: CCGS Skill Testing Framework/agents/[tier]/[agent-name].md
  last_spec: ""
  last_spec_result: ""
  category: [director|lead|specialist|engine|operations|qa]
```

### 3.3 添加新的 Skill 类别 / Agent 类别

**场景**：需要新增一个不匹配现有类别的 Skill 类型。

**步骤 1**：在 `quality-rubric.md` 中新增一个 `###` 类别节：
```markdown
### `[new-category]`

**Skills**: [skill-names]

| Metric | PASS criteria |
|---|---|
| **XX1 — ...** | ... |
| **XX2 — ...** | ... |
| ...
```

**步骤 2**：在 `skills/` 下创建新的类别子目录：
```bash
mkdir "CCGS Skill Testing Framework/skills/[new-category]"
```

**步骤 3**：为属于该类别的每个 Skill 编写规格文件。

**步骤 4**：在 `catalog.yaml` 的 `skills:` 中，使用新的 `category:` 值。
- 同时更新 CODEBUDDY.md 中的类别映射表以确保 AI 助手能正确识别。

### 3.4 添加新的测试维度

**场景**：除了 static、spec、category 测试外，想添加新的测试类型。

**步骤 1**：在 `catalog.yaml` 中为 skills/agents 条目添加新的追踪字段：
```yaml
- name: [skill-name]
  ...
  last_integration: ""
  last_integration_result: ""
```

**步骤 2**：在 `quality-rubric.md` 中为新测试维度定义度量标准。

**步骤 3**：更新 `CODEBUDDY.md` 和 `README.md` 中的测试工作流说明。

**步骤 4**：如果新的测试维度需要新的 Skill 命令驱动（如 `/skill-test integration`），需更新 `skill-test` 的 Skill 定义。

### 3.5 添加新的引擎专家 Agent 组

**场景**：项目使用了新引擎（如 Stride、Bevy），需要添加对应的引擎专家 Agent。

**步骤 1**：在 `.codebuddy/agents/` 中创建 Agent 定义文件。

**步骤 2**：在 `CCGS Skill Testing Framework/agents/engine/` 下创建子目录和规格文件：
```bash
mkdir "CCGS Skill Testing Framework/agents/engine/[new-engine]"
# 然后为每个引擎专家创建 .md 规格文件
```

**步骤 3**：在 `catalog.yaml` 的 `agents:` 中注册。

**步骤 4**：在 `quality-rubric.md` 中，引擎类别的度量标准（E1 版本感知、E2 文件路由、E3 引擎模式）通常已足够，无需扩展。

---

## 四、扩展示例 / Extension Examples

### 示例 1：为新 Skill `/battle-test` 添加测试规格

假设你在 `.codebuddy/skills/battle-test/SKILL.md` 中创建了一个战斗测试 Skill。

1. 判定类别为 `utility`（不属于其他 8 类）
2. 创建规格文件：
```bash
cp templates/skill-test-spec.md skills/utility/battle-test.md
```
3. 填写测试用例（列出 5 个场景的 fixture 和预期行为）
4. 在 `catalog.yaml` 注册：
```yaml
- name: battle-test
  spec: CCGS Skill Testing Framework/skills/utility/battle-test.md
  last_static: ""
  ...
  priority: low
  category: utility
```
5. 运行验证：
```
/skill-test static battle-test
/skill-test spec battle-test
```

### 示例 2：为自定义 Agent `physics-engineer` 添加测试规格

1. 判定层级为 `specialists`
2. 拷贝模板：
```bash
cp templates/agent-test-spec.md agents/specialists/physics-engineer.md
```
3. 填写：domain = "物理模拟与碰撞系统"，escalates to = "lead-programmer"
4. 编写 5 个测试用例，特别是 Case 3（Gate Verdict）如果参与门控
5. 在 `catalog.yaml` 注册
6. 可运行 `/skill-test spec` 进行行为验证

---

## 五、框架与主项目的关系 / Integration with Main Project

```
.codebuddy/                          ← 主项目：Skills 和 Agents 的定义和执行
├── skills/                          ← Skill 的 SKILL.md 定义（实际执行逻辑）
├── agents/                          ← Agent 的 .md 定义（角色指令）
└── ...

CCGS Skill Testing Framework/        ← 测试层：验证 Skills/Agents 是否正确
├── skills/                          ← Skill 的行为规格（期望行为描述）
├── agents/                          ← Agent 的行为规格
├── catalog.yaml                     ← 追踪每个 Skill/Agent 是否已测试
└── quality-rubric.md                ← 判定 PASS/FAIL 的标准
```

**关键区别**：
- `.codebuddy/skills/` 中的文件告诉 AI **如何执行**一个 Skill
- `CCGS Skill Testing Framework/skills/` 中的文件描述 **测试该 Skill 时要验证什么**

**数据流**：
1. 用户调用 `/skill-test spec gate-check`
2. AI 读取 `catalog.yaml` → 找到 spec 路径 → 读取规格文件
3. AI 读取 `.codebuddy/skills/gate-check/SKILL.md`（被测试对象）
4. AI 逐一对照规格文件中的测试用例，判定 PASS/FAIL
5. AI 更新 `catalog.yaml` 中的追踪字段（`last_spec`、`last_spec_result`）

---

## 六、最佳实践 / Best Practices

1. **规格描述当前行为，而非理想行为**。规格是从现有 Skill/Agent 中读取后写出的，可能编码了 bug。如果 Skill 在实践中行为异常，先修复 Skill，再更新规格。

2. **优先覆盖 critical 和 high 优先级的 Skill**。门控和审查类 Skill 对开发流程影响最大。

3. **每个测试用例必须有明确的 Fixture（前置条件）和 Expected behaviour（预期行为）**。模糊的用例无法可靠执行。

4. **覆盖率不完整的 Skill/Agent 应在 Coverage Notes 中记录**。说明哪些边界情况未覆盖，以及原因。

5. **新增 Skill/Agent 后立即添加规格文件**。避免产生未追踪的"测试债务"。

6. **规格文件遵循模板结构**。便于 AI 解析和人类阅读。

---

> **相关文档**：
> - [Skills 参考手册](./05-Skills-Reference.md) — 72 个 Skill 的完整参考
> - [Agents 参考手册](./04-Agents-Reference.md) — 49 个 Agent 的完整参考
> - [Templates 模板指南](./13-Templates-Guide.md) — 38 个模板的使用说明

# CCGS Skill Testing Framework 详解
The user is asking three questions about the CCGS Skill Testing Framework:
1. Under what conditions does it trigger?
2. What are the execution results?
3. How does it work?

Let me read the key files to answer this comprehensively.
Now let me also read the skill-test and skill-improve spec files to understand the actual testing mechanism better.
Now I have a complete picture of the framework. Let me answer the user's three questions comprehensively:

1. **触发条件**: When does it trigger?
2. **执行结果**: What are the results?
3. **工作原理**: How does it work?

Let me organize a clear, complete response.
## CCGS Skill Testing Framework 详解

---

### 一、触发条件

该框架**不会自动触发**——它是完全**手动的、由用户命令驱动**的。触发方式是调用以下两个 Skill 命令：

| 命令 | 触发场景举例 |
|------|-------------|
| `/skill-test static [name]` | 检查某个 Skill 的 SKILL.md 文件结构是否规范 |
| `/skill-test static all` | 批量检查全部 72 个 Skill |
| `/skill-test spec [name]` | 用预写的行为规格脚本验证某 Skill 的行为 |
| `/skill-test category [name]` | 按类别度量标准（如 gate/review/authoring）评估 Skill |
| `/skill-test category all` | 对所有已分类 Skill 运行类别度量检查 |
| `/skill-test audit` | 查看所有 Skills + Agents 的测试覆盖率全景 |
| `/skill-improve [name]` | 测试 → 诊断 → 修 → 复测的改进循环 |

**典型触发时机**：
- 新增或修改了一个 Skill 的 `SKILL.md` 后 → 运行 `/skill-test static` 检查结构
- 为某个 Skill 编写了新的行为规格文件后 → 运行 `/skill-test spec` 验证
- 想评估某个 Skill 是否满足其类别的质量标准 → 运行 `/skill-test category`
- 发现某个 Skill 测试不通过 → 运行 `/skill-improve` 尝试自动修复

---

### 二、执行结果

每种模式产生不同格式的输出：

#### 1. `static` 模式 — 结构合规性

输出 7 项检查的 PASS/FAIL 表格：

```
Check 1: frontmatter 字段完整 ........ PASS
Check 2: ≥2 个阶段标题 ............... PASS
Check 3: 裁决关键词存在 .............. PASS
Check 4: "May I write" 语言存在 ....... FAIL  (有 Write 工具但缺少协作协议)
Check 5: 下一步引导存在 ............... PASS
Check 6: 总监门控已记录 ............... PASS
Check 7: 门控模式行为已记录 ........... PASS

结果：6/7 PASS — NON-COMPLIANT
```

#### 2. `spec` 模式 — 行为规格测试

输出逐用例的裁决表：

```
Case 1: Happy Path — All artifacts present ............ PASS
Case 2: Failure Path — Missing artifacts .............. PASS
Case 3: No Argument — Auto-detect stage ............... PASS
Case 4: Edge Case — Manual check items ................ PASS
Case 5: Director Gate — lean vs full vs solo .......... PASS

结果：5/5 PASS — PASS（全部通过）
```

#### 3. `category` 模式 — 类别度量

按 `quality-rubric.md` 中的标准逐项打分：

```
Gate Skills 度量 (G1-G5):
G1 — Review mode read ........... PASS
G2 — Full mode: 4 directors ...... PASS
G3 — Lean mode: phase gate only . PARTIAL
G4 — Solo mode: no directors .... PASS
G5 — No auto-advance ............ PASS

类别得分：4.5/5 — WARNINGS
```

#### 4. `audit` 模式 — 覆盖率报告

```
Skills: 60 / 72 有规格文件
Agents: 32 / 49 有规格文件
总计覆盖率: 76%
结果: COMPLETE
```

#### 5. `skill-improve` — 改进循环

```
基线: 5/7 static checks pass
诊断: Check 4 (缺少 "May I write") 和 Check 5 (缺少 handoff)
修复: 添加协作协议 + 下一步引导段
复测: 7/7 pass

裁决: IMPROVED (5 → 7)
```

**可能的最终裁决**：
- `IMPROVED` — 分数提升
- `NO CHANGE` — 已完美，无需修改
- `REVERTED` — 修复导致退步，已回滚

---

### 三、工作原理

整个框架是一个 **"规格驱动测试 + 注册表追踪"** 的闭环系统：

```
┌─────────────────────────────────────────────────────┐
│                    用户触发测试                        │
│         /skill-test static|spec|category|audit        │
└──────────────────────┬──────────────────────────────┘
                       │
                       ▼
┌──────────────────────────────────────────────────────┐
│              Step 1: 读取 catalog.yaml                 │
│  获取被测试 Skill/Agent 的 spec: 路径 和 category:      │
└──────────────────────┬───────────────────────────────┘
                       │
                       ▼
┌──────────────────────────────────────────────────────┐
│           Step 2: 读取被测试对象（实际代码）              │
│  .codebuddy/skills/[name]/SKILL.md   ← Skill 定义     │
│  .codebuddy/agents/[name].md         ← Agent 定义     │
└──────────────────────┬───────────────────────────────┘
                       │
                       ▼
┌──────────────────────────────────────────────────────┐
│          Step 3: 读取测试标准（期望行为）                │
│  ┌─ static 模式: 硬编码的 7 项结构检查                   │
│  ├─ spec 模式: skills/[category]/[name].md 规格文件     │
│  ├─ category 模式: quality-rubric.md 度量标准           │
│  └─ audit 模式: 扫描 .codebuddy/ 下所有文件             │
└──────────────────────┬───────────────────────────────┘
                       │
                       ▼
┌──────────────────────────────────────────────────────┐
│           Step 4: AI 逐条对照评估                        │
│  对被测试文件的每一行/段，检查是否满足断言条件              │
│  返回: PASS / FAIL / PARTIAL                          │
└──────────────────────┬───────────────────────────────┘
                       │
                       ▼
┌──────────────────────────────────────────────────────┐
│         Step 5: 生成报告 + 更新 catalog.yaml            │
│  AI 询问: "May I update last_spec_result?"             │
│  用户确认后写入追踪字段                                  │
└──────────────────────────────────────────────────────┘
```

**核心机制三点**：

#### A) 三层测试模型

```
Level 1: 静态检查 (static)
       → 文件结构对不对？frontmatter 字段齐不齐？
       → 无需 Fixture，7 个固定检查项

Level 2: 行为规格 (spec)
       → 功能行为对不对？用户给输入 A，输出是不是 B？
       → 需要 Fixture（前置条件），5 个测试用例

Level 3: 类别度量 (category)
       → 是否符合该类 Skill 的设计哲学？
       → 例如 gate 类必须读 review-mode、不自动推进阶段
```

#### B) 规格与实现分离

```
.codebuddy/skills/gate-check/SKILL.md     ← 实际 Skill（如何执行）
CCGS Skill Testing Framework/skills/gate/  ← 测试规格（期望什么行为）
     gate-check.md
```

规格描述的是从 Skill 文件**读出来的当前行为**，而不是理想行为。如果 Skill 有 bug，规格也会编码这个 bug。所以流程是：**先修 Skill，再更新规格**。

#### C) `skill-improve` 闭环

```
测试(取得基线分数)
    ↓
诊断(识别 FAIL 的检查项)
    ↓  
提出修复(生成修改方案)
    ↓
用户批准("May I write?")
    ↓
应用修复(修改 SKILL.md)
    ↓
复测(重新打分)
    ↓
比对分数 ── 提升 → IMPROVED
           ── 下降 → 询问"是否回滚？" → REVERTED
           ── 不变 → NO CHANGE
```

**总结**：该框架本质上是一个**手动的、AI 驱动的 Skill/Agent 质量监控系统**。它不修改游戏代码，只验证 CCGS 框架自身（72 Skills + 49 Agents）的正确性和合规性。用户在任何时候都可以用 `/skill-test` 或 `/skill-improve` 触发检查，AI 读取规格文件→对照实现→生成判决→更新追踪数据。

# CCGS Agent 检查详解
The user is asking how to check if a newly added agent violates the rules. This is about using the CCGS Skill Testing Framework to validate a new agent. Let me answer based on my comprehensive knowledge of the framework.

The steps would be:
1. Write a behavioral spec for the new agent
2. Register it in catalog.yaml
3. Run tests against it

Let me give a clear, actionable answer.
## 检查新加 Agent 是否违规的步骤

核心思路：**先写"应该怎么做"的规格 → 再用规格去量"实际怎么做"**。

---

### 第一步：编写 Agent 行为规格

复制模板，填写该 Agent 的"合格标准"：

```bash
# 模板路径
CCGS Skill Testing Framework/templates/agent-test-spec.md
```

放到对应层级目录：

```bash
CCGS Skill Testing Framework/agents/[tier]/[agent-name].md
```

**规格中必须包含的 5 个测试用例**（每项都是"违规检测器"）：

| 用例 | 测什么 | 典型违规信号 |
|------|--------|-------------|
| Case 1：域内请求 | 处理自己领域的事能否正确输出 | 格式不对、缺少裁决关键词 |
| Case 2：域外重定向 | 收到不该管的请求时是否拒绝并**说出**该找谁 | 沉默、自己硬接、不知道重定向给谁 |
| Case 3：门控裁决 | 参与 Gate 时输出格式对不对 | 没说 `APPROVE/CONCERNS/REJECT`、用口语代替 |
| Case 4：冲突升级 | 和其他 Agent 意见冲突时是否升级到上级 | 自作主张裁决、不说该升级给谁 |
| Case 5：上下文传递 | 拿到父 Agent 上下文后是否**复用**而非**重问** | 忽略上下文让用户重来、输出超出委托范围 |

---

### 第二步：注册到 catalog.yaml

在 `catalog.yaml` 的 `agents:` 列表末尾添加：

```yaml
- name: [新agent名]
  spec: CCGS Skill Testing Framework/agents/[tier]/[agent-name].md
  last_spec: ""
  last_spec_result: ""
  category: [director|lead|specialist|engine|operations|qa]
```

---

### 第三步：运行三层检查

```
/skill-test spec [agent名]       → 逐用例评估 5 个场景，直接检测违规行为
/skill-test category [agent名]   → 按层级度量标准检查（director/lead/specialist...）
/skill-test static [agent名]     → 检查 Agent 的 .codebuddy/agents/ 定义文件结构
```

---

### 第四步：按层级对照违规检查清单

根据 `quality-rubric.md`，不同层级的 Agent 有不同的"违规红线"：

**Director 级（创意/技术/美术总监、制作人）**：
| 检查项 | 违规表现 |
|--------|---------|
| D1 — 裁决词汇 | 输出"我觉得行"而非 APPROVE/CONCERNS/REJECT |
| D2 — 域边界 | 创意总监点评技术架构可行性，技术总监拍板美术风格 |
| D3 — 冲突升级 | 两个部门冲突时自己裁了，没上报 creative-director |
| D4 — 模型层级 | 未按 coordination-rules 分配对应模型 |

**Lead 级（首席程序员、QA 主管等）**：
| 检查项 | 违规表现 |
|--------|---------|
| L1 — 领域裁决 | 没输出 FEASIBLE/INFEASIBLE 格式 |
| L2 — 升级路径 | 出界冲突时不升级到 creative-director 或 technical-director |

**Specialist 级（AI/Gameplay/Engine 程序员等）**：
| 检查项 | 违规表现 |
|--------|---------|
| S1 — 守住领域 | ai-programmer 评论 shader 代码，"帮忙"改了渲染管线 |
| S2 — 不擅做跨域决策 | engine-programmer 说"内存分配方案我定了，不用通知 lead" |
| S3 — 正确重定向 | 收到域外请求时拒绝但**不说该找谁** |

**Engine 级（引擎专家）**：
| 检查项 | 违规表现 |
|--------|---------|
| E1 — 版本感知 | 推荐 API 前没读引擎版本文件，用了不存在的 API |
| E2 — 文件路由 | `.gdshader` 文件交给 godot-specialist 而非 godot-shader-specialist |
| E3 — 引擎模式 | Godot 里写了 C# 属性导出语法，但当前用 GDScript |

**Operations 级**：
| 检查项 | 违规表现 |
|--------|---------|
| O2 — 不写实现代码 | devops-engineer 写了战斗系统的核心逻辑 |

**QA 级**：
| 检查项 | 违规表现 |
|--------|---------|
| Q1 — 产出测试而非代码 | QA 直接改了游戏源码 |
| Q3 — 不提议新功能 | 测试报告里夹带"建议加个宠物系统" |

---

### 简化流程总结

```
新增 Agent 定义 (.codebuddy/agents/xxx.md)
        │
        ▼
编写行为规格 (CCGS Skill Testing Framework/agents/[tier]/xxx.md)
        │
        ▼
注册到 catalog.yaml
        │
        ▼
/skill-test spec xxx       ← 跑 5 个用例，检测越权、否决、格式违规
        │
        ▼
/skill-test category xxx   ← 按层级跑度量标准，检测域边界、升级路径违规
        │
        ▼
有 FAIL？
   ├─ 是 → 修改 Agent 定义 → 更新规格 → 复测
   └─ 否 → Agent 合规 ✔
```

**最关键的一句**：Agent 违规最常见的形式是 **"管了不该管的事"**（域越界）和 **"没按标准格式输出裁决"**（格式违规）。这两个是 Case 2 和 Case 3 直接覆盖的，新增 Agent 时最先检查这两项。