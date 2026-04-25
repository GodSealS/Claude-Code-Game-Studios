# Skill Test Spec: /[skill-name] / 技能测试规格：/[技能名称]

## Skill Summary / 技能概述

[One paragraph: what this skill does, when to use it, what it produces. Include
the primary output artifact, the verdict format it uses, and which pipeline stage
it belongs to. / 一段话：这个技能做什么，何时使用它，它产生什么。包括主要输出产物、它使用的裁决格式以及它所属的流水线阶段。]

---

## Static Assertions (Structural) / 静态断言（结构性）

Verified automatically by `/skill-test static` — no fixture needed. / 通过 `/skill-test static` 自动验证——无需固定装置。

- [ ] Has required frontmatter fields: `name`, `description`, `argument-hint`, `user-invocable`, `allowed-tools` / 具有必需的前置字段：`name`、`description`、`argument-hint`、`user-invocable`、`allowed-tools`
- [ ] Has ≥2 phase headings (## Phase N or numbered ## sections) / 有≥2个阶段标题（## Phase N 或编号的 ## 部分）
- [ ] Contains verdict keywords: [list the ones expected, e.g., PASS, FAIL, CONCERNS] / 包含裁决关键词：[列出预期的关键词，例如：PASS、FAIL、CONCERNS]
- [ ] Contains "May I write" collaborative protocol language (if skill writes files) / 包含 "May I write" 协作协议语言（如果技能写入文件）
- [ ] Has a next-step handoff at the end / 在末尾有下一步交接

---

## Test Cases / 测试用例

### Case 1: Happy Path — [short description] / 用例1：成功路径 — [简短描述]

**Fixture:** [Describe the assumed project state. Which files exist? What do they
contain? E.g., "game-concept.md exists with all 8 required sections complete.
systems-index.md exists. All MVP GDDs are present and individually reviewed."] / **固定装置：**[描述假设的项目状态。哪些文件存在？它们包含什么？例如："game-concept.md 存在且所有8个必需部分都已完成。
systems-index.md 存在。所有MVP GDD都完整且经过单独审查。"]

**Input:** `/[skill-name] [args]` / **输入：** `/[skill-name] [args]`

**Expected behavior:** / **预期行为：**
1. [Phase 1 action — what the skill should read or check / 第1阶段行动 — 技能应该读取或检查什么]
2. [Phase 2 action — what the skill should evaluate / 第2阶段行动 — 技能应该评估什么]
3. [Phase N action — what the skill should output / 第N阶段行动 — 技能应该输出什么]

**Assertions:** / **断言：**
- [ ] Skill reads [specific file] before producing output / 技能在产生输出前读取[特定文件]
- [ ] Output includes verdict keyword [PASS/FAIL/etc.] / 输出包含裁决关键词[PASS/FAIL等]
- [ ] Output lists [specific content] from the fixture / 输出列出固定装置中的[特定内容]
- [ ] Skill asks for approval before writing any file / 技能在写入任何文件前请求批准

---

### Case 2: Failure Path — [short description, e.g., "Missing required artifact"] / 用例2：失败路径 — [简短描述，例如："缺少必需构件"]

**Fixture:** [Describe the failure state. E.g., "game-concept.md is missing.
No files exist in design/gdd/."] / **固定装置：**[描述失败状态。例如："game-concept.md 缺失。
design/gdd/ 中没有任何文件。"]

**Input:** `/[skill-name] [args]` / **输入：** `/[skill-name] [args]`

**Expected behavior:** / **预期行为：**
1. [Phase 1: skill detects missing file / 第1阶段：技能检测到缺失文件]
2. [Phase 2: skill surfaces the gap rather than assuming OK / 第2阶段：技能暴露缺口而不是假设没问题]
3. [Output: FAIL or BLOCKED verdict with specific blocker named / 输出：FAIL 或 BLOCKED 裁决，并指名具体的阻碍物]

**Assertions:** / **断言：**
- [ ] Skill does NOT output PASS when the fixture is incomplete / 当固定装置不完整时，技能不输出PASS
- [ ] Skill names the specific missing artifact / 技能指名具体的缺失构件
- [ ] Skill suggests a remediation action (e.g., "Run /[other-skill]") / 技能建议修复行动（例如："运行 /[other-skill]"）
- [ ] Skill does not create files to fill in the gap without asking / 技能不在未经询问的情况下创建文件来填补缺口

---

### Case 3: Edge Case — [short description, e.g., "No argument provided"] / 用例3：边缘情况 — [简短描述，例如："未提供参数"]

**Fixture:** [State of project files for this case] / **固定装置：**[此用例的项目文件状态]

**Input:** `/[skill-name]` (no argument) / **输入：** `/[skill-name]`（无参数）

**Expected behavior:** / **预期行为：**
1. [What the skill should do when invoked without arguments / 当调用技能而没有参数时，它应该做什么]

**Assertions:** / **断言：**
- [ ] [assertion / 断言]

---

## Protocol Compliance / 协议合规性

- [ ] Uses "May I write" before all file writes / 在所有文件写入前使用 "May I write"
- [ ] Presents findings or report before asking for write approval / 在请求写入批准前展示发现或报告
- [ ] Ends with a recommended next step or follow-up skill / 以推荐的下一步或后续技能结束
- [ ] Never auto-creates files without explicit user approval / 从未在没有明确用户批准的情况下自动创建文件
- [ ] Does not skip phases or jump straight to a verdict without checking / 不跳过阶段或不检查就直接跳转到裁决

---

## Coverage Notes / 覆盖范围说明

[Document what is intentionally NOT tested in this spec and why. Examples:
- "Case 3 (all-mode) is not covered because it runs too many checks to evaluate
  in a single spec — test each sub-mode individually."
- "The database integration path is not covered as it requires a live environment."
- "Edge cases involving corrupted YAML files are deferred to a future spec."] / [记录在此规格中故意未测试的内容及其原因。示例：
- "用例3（all-mode）未覆盖，因为它在单个规格中运行太多检查无法评估 — 单独测试每个子模式。"
- "数据库集成路径未覆盖，因为它需要实时环境。"
- "涉及损坏的YAML文件的边缘情况推迟到未来规格中处理。"]
