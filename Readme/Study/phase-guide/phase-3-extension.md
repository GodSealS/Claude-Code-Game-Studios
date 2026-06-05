# 阶段三：扩展新建

目标：独立创建新的 Skill、Agent、Rule 文件，并使其无缝融入现有提示词工程体系。

---

## 1. 创建新 Skill

### 1.1 目录与文件结构

每个 Skill 必须是一个独立子目录，内部至少包含 `SKILL.md`：

```
.codebuddy/skills/<skill-name>/
└── SKILL.md
```

**命名规范**：
- 使用小写字母和连字符（kebab-case）
- 名称应简洁描述功能，如 `bug-report`、`sprint-plan`、`custom-audit`
- 避免与现有 Skill 重名

### 1.2 Frontmatter 规范

```yaml
---
name: skill-name
description: "简明描述该 Skill 的功能，50-150 字。"
argument-hint: "[参数格式说明]"
user-invocable: true
allowed-tools: Read, Glob, Grep, Write, Edit, Bash, Task, AskUserQuestion
model: sonnet
---
```

| 字段 | 必填 | 说明 |
|------|------|------|
| `name` | 是 | 必须与目录名一致 |
| `description` | 是 | 用于 `/help` 和路由决策 |
| `argument-hint` | 否 | 参数提示，帮助用户正确使用 |
| `user-invocable` | 是 | `true` 允许用户直接调用；`false` 仅供内部调用 |
| `allowed-tools` | 是 | 该 Skill 可调用的工具白名单 |
| `model` | 否 | `haiku` / `sonnet` / `opus`，留空则默认 `sonnet` |

### 1.3 内容结构设计

一个良好的 SKILL.md 应包含以下章节：

```markdown
# 标题

## Phase 1: [阶段名称]

1. 步骤一
2. 步骤二

## Phase 2: [阶段名称]

...

## Phase N: 保存/输出

Ask: "May I write this to [filepath]?"

## Edge Cases

- 边界情况 1
- 边界情况 2

## Collaborative Protocol

1. 询问优先
2. 提供选项
3. 用户决定
...
```

**设计原则**：
- **阶段清晰**：每个 Phase 有明确的输入、处理和输出
- **模板具体**：输出模板应包含足够的占位符和示例
- **工具克制**：只在 `allowed-tools` 中声明实际需要的工具
- **用户确认**：涉及写文件的操作前必须询问用户
- **下一步建议**：完成后推荐相关的后续 Skill

### 1.4 使用模板

参考 `.codebuddy/docs/templates/` 中的 38 个模板，选择与你要创建的 Skill 类型最接近的模板作为基础。

### 1.5 验证新 Skill

创建后，运行 `/skill-test` 验证：

```bash
/skill-test <skill-name>
```

检查项：
- Frontmatter 完整性（必填字段是否齐全）
- 阶段逻辑连贯性
- 工具权限合理性
- 与现有 Skill 的命名冲突

---

## 2. 创建新 Agent

### 2.1 文件结构

每个 Agent 一个 `.md` 文件，位于 `.codebuddy/agents/` 目录下：

```
.codebuddy/agents/<agent-name>.md
```

**命名规范**：
- 使用小写字母和连字符（kebab-case）
- 以领域 + 角色命名，如 `mobile-optimization-specialist`、`vfx-artist`

### 2.2 Frontmatter 规范

```yaml
---
name: agent-name
description: "该 Agent 的职责描述，50-150 字。"
tools: Read, Glob, Grep, Write, Edit, Bash, Task
model: sonnet
maxTurns: 20
---
```

| 字段 | 必填 | 说明 |
|------|------|------|
| `name` | 是 | 必须与文件名一致（不含 .md） |
| `description` | 是 | 用于路由和协调决策 |
| `tools` | 是 | 可用工具集，通常比 Skill 更宽泛 |
| `model` | 否 | 默认 `sonnet` |
| `maxTurns` | 否 | 最大对话轮数，复杂任务可设为 30-50 |

### 2.3 必备章节

```markdown
## Collaboration Protocol

描述该 Agent 与用户的协作方式：
- 写代码前必须阅读设计文档
- 提出架构方案并征得同意
- 写文件前询问 "May I write...?"
- 遇到歧义 STOP 并询问

## Core Responsibilities

- 职责一
- 职责二

## Best Practices

### 子领域 A
- 规范一
- 规范二

### 子领域 B
- 规范一

## Delegation Map

**Reports to**: [上级 Agent]
**Delegates to**: [下级 Agent 列表]
**Escalation targets**: [升级目标]
**Coordinates with**: [平级协作对象]

## What This Agent Must NOT Do

- 不做 XXX 决策
- 不覆盖 YYY 的架构决策
- 不直接实施 ZZZ（应委派给下属）
```

### 2.4 融入层级体系

创建 Agent 后，必须将其注册到现有层级中：

1. **更新上级 Agent**：在上级 Agent 的 `Delegates to` 中新增该 Agent
2. **更新平级 Agent**：在需要协作的平级 Agent 的 `Coordinates with` 中新增
3. **更新 agent-roster.md**：在 `.codebuddy/docs/agent-roster.md` 中登记
4. **更新 coordination-rules**：如有特殊协调规则，更新 `.codebuddy/docs/coordination-rules.md`

---

## 3. 创建新 Rule

### 3.1 文件结构

```
.codebuddy/rules/<rule-name>.md
```

**命名规范**：
- 使用小写字母和连字符
- 以作用域命名，如 `audio-code.md`、`localization-data.md`

### 3.2 Frontmatter 规范

```yaml
---
paths:
  - "src/xxx/**"
  - "assets/xxx/**"
---
```

| 字段 | 必填 | 说明 |
|------|------|------|
| `paths` | 是 | 作用路径列表，使用 Glob 模式 |

### 3.3 内容编写

Rule 的内容是简单的约束列表：

```markdown
# Rule Title

- 约束一：具体描述和验收标准
- 约束二：具体描述和验收标准
- 约束三：具体描述和验收标准
```

**编写原则**：
- **可验证**：每条规则应有明确的判断标准（如 "budget: 2ms" 而非 "be fast"）
- **无歧义**：避免模糊词汇，使用具体技术术语
- **正交**：不同 Rule 之间的约束不应矛盾
- **适度**：规则数量适中，过多会导致 Agent 上下文膨胀

### 3.4 路径匹配策略

- **精确匹配**：`src/ai/behavior-trees/**` 只命中行为树目录
- **通配匹配**：`src/ai/**` 命中 AI 目录及其所有子目录
- **多路径**：一个 Rule 可覆盖多个不相关的路径
- **避免过度重叠**：若多个 Rule 可能命中同一路径，应检查约束是否冲突

---

## 4. 注册与验证

### 4.1 运行结构检查

创建新文件后，执行以下检查：

```bash
# 检查目录结构
ls .codebuddy/skills/<new-skill>/
# 应包含 SKILL.md

# 检查文件名一致性
cat .codebuddy/skills/<new-skill>/SKILL.md | grep "^name:"
# 应与目录名一致

cat .codebuddy/agents/<new-agent>.md | grep "^name:"
# 应与文件名一致
```

### 4.2 运行 /skill-test

```bash
/skill-test <new-skill-name>
```

检查输出：
- **PASS**：结构合规，可以投入使用
- **WARN**：有警告但不阻塞，建议修复
- **FAIL**：有严重问题，必须修复后才能使用

### 4.3 交叉引用验证

确保新文件被现有体系正确引用：

- [ ] 新 Skill 是否出现在 `.codebuddy/docs/skills-reference.md` 中？
- [ ] 新 Agent 是否出现在 `.codebuddy/docs/agent-roster.md` 中？
- [ ] 新 Agent 的委托关系是否在上级/平级 Agent 中更新？
- [ ] 新 Rule 的 paths 是否与实际目录结构匹配？

---

## 5. 融入现有体系

### 5.1 更新参考文档

| 文档 | 更新内容 |
|------|----------|
| `skills-reference.md` | 在对应分类下新增 Skill 条目 |
| `agent-roster.md` | 新增 Agent 条目，更新协调地图 |
| `coordination-rules.md` | 如有新的协调模式，补充说明 |
| `directory-structure.md` | 如有新的目录约定，更新说明 |

### 5.2 更新模板（可选）

如果新 Skill/Agent 代表了一类可复用的模式，考虑在 `.codebuddy/docs/templates/` 中创建模板，方便未来扩展。

### 5.3 团队同步

- 在团队频道或文档中公告新 Skill/Agent/Rule 的功能和使用方法
- 更新项目的 `CODEBUDDY.md`（如技术栈或分工有重大变化）
- 安排一次 `/code-review` 或设计审查，收集团队反馈

---

## 6. 完整示例

### 6.1 示例：创建自定义 Skill `/custom-audit`

**需求**：团队需要一个 Skill 来审计自定义数据表（`assets/data/tables/`）的格式合规性。

**步骤**：

1. 创建目录：`.codebuddy/skills/custom-audit/`
2. 编写 `SKILL.md`：

```yaml
---
name: custom-audit
description: "Audit custom data tables in assets/data/tables/ for format compliance, missing fields, and referential integrity."
argument-hint: "[table-name] | all"
user-invocable: true
allowed-tools: Read, Glob, Grep, Write
model: sonnet
---
```

3. 设计 Phase：
   - Phase 1: Parse Arguments（单表审计 / 全表审计）
   - Phase 2: Read target table(s)
   - Phase 3: Validate schema, check missing fields, check references
   - Phase 4: Generate audit report
   - Phase 5: Save report（询问用户）

4. 运行 `/skill-test custom-audit` 验证
5. 更新 `skills-reference.md`，在 Reviews & Analysis 分类下新增条目

### 6.2 示例：创建自定义 Agent `mobile-optimization-specialist`

**需求**：项目计划发布到 iOS 和 Android，需要移动端优化专家。

**步骤**：

1. 创建文件：`.codebuddy/agents/mobile-optimization-specialist.md`
2. 编写 Frontmatter 和必备章节
3. 在 `godot-specialist.md`（或 `unity-specialist.md`）的 `Delegates to` 中新增
4. 在 `technical-director.md` 的 `Coordinates with` 中新增（若需要）
5. 在 `performance-analyst.md` 的 `Coordinates with` 中新增
6. 更新 `agent-roster.md`
7. 创建 Rule（可选）：`.codebuddy/rules/mobile-code.md`，paths 为 `src/mobile/**`

---

## 7. 维护与迭代

提示词工程体系不是一次性建设完毕的，需要持续维护：

- **定期审查**：每季度运行 `/skill-test` 扫描所有 Skill，检查结构老化
- **版本同步**：引擎升级后，同步更新相关 Agent 的最佳实践和版本感知文档
- **反馈闭环**：收集团队使用中的痛点，迭代修改 Skill 和 Agent
- **文档保鲜**：确保 `skills-reference.md` 和 `agent-roster.md` 与实际文件同步

恭喜你完成三阶段学习！你现在可以独立扩展和维护 CodeBuddy 提示词工程体系。
