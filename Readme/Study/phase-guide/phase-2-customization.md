# 阶段二：定制修改

目标：根据项目需求修改现有提示词内容、调整协作协议与职责边界，使框架更贴合团队实际工作流。

---

## 1. 修改 Skill

### 1.1 调整 Frontmatter

Skill 的 Frontmatter 控制其元行为和权限。常见修改场景：

| 属性 | 修改场景 | 示例 |
|------|----------|------|
| `description` | Skill 功能演进后更新描述 | 增加新的分析模式 |
| `argument-hint` | 参数格式变化 | 从 `[description]` 改为 `[description] \| analyze [path]` |
| `allowed-tools` | 需要新的工具权限 | 增加 `Task` 以支持子智能体委派 |
| `model` | 任务复杂度变化 | 从默认 `sonnet` 降级到 `haiku`（仅读取格式化）或升级到 `opus`（多文档综合） |
| `user-invocable` | 控制用户是否可直接调用 | 设为 `false` 以隐藏内部 Skill |

**修改示例**：

```yaml
---
name: bug-report
description: "Creates a structured bug report from a description, or analyzes code to identify potential bugs."
argument-hint: "[description] | analyze [path-to-file] | verify [BUG-ID] | close [BUG-ID]"
user-invocable: true
allowed-tools: Read, Glob, Grep, Write, Edit, Task
model: sonnet
---
```

### 1.2 调整阶段逻辑

Skill 的主体由多个 Phase 组成。修改时应：

- **增加阶段**：在适当位置插入新 Phase，保持编号连续性（Phase 2A, 2B, 2C...）
- **删除阶段**：确保删除后上下游逻辑连贯，不会引用已删除阶段的内容
- **调整模板**：修改输出模板时，保持与项目其他 Skill 的格式一致性
- **增加边界情况**：在实际使用中遇到未覆盖的场景时，补充到 Edge Cases 章节

**注意事项**：
- 修改后应运行 `/skill-test` 验证结构合规性
- 若修改了 `allowed-tools`，确保新工具在实际环境可用
- 若升级了 `model`，评估 token 消耗和响应时间的变化

---

## 2. 修改 Agent

### 2.1 调整核心职责

当项目技术栈或团队分工变化时，可能需要调整 Agent 的职责范围。

**示例**：团队决定从 GDScript 全面转向 C#，需要修改 `godot-specialist.md`：
- 在 Core Responsibilities 中提升 C# 决策的优先级
- 在 Best Practices 中增加 C#/.NET 特定规范
- 调整 Delegation Map，增加与 `godot-csharp-specialist` 的协作频率

### 2.2 调整协作协议

协作协议是 Agent 与用户的交互契约。可根据团队偏好调整：

| 协议项 | 可调整内容 | 风险 |
|--------|------------|------|
| 架构询问 | 减少询问数量以加速流程 | 可能遗漏关键约束 |
| 文件写入确认 | 改为批量确认（多文件一次问） | 用户可能漏审个别文件 |
| 测试提供 | 从"主动提供"改为"应请求提供" | 可能遗漏测试 |
| 偏差报告 | 从"STOP 并询问"改为"记录并继续" | 设计与实现可能不一致 |

**建议**：对 `creative-director` 和 `technical-director` 的协议不要轻易修改，他们是裁决层。

### 2.3 调整委托地图

委托地图定义了 Agent 的协作网络。以下情况需要调整：

- **新增子专家**：如新增 `mobile-optimization-specialist`，需要在其上级 Agent 的 Delegates to 中注册
- **变更汇报线**：如 `wechat-specialist` 从汇报给 `lead-programmer` 改为汇报给 `technical-director`
- **新增协作对象**：如引入新的 analytics 管道，需要让相关 Agent 与 `analytics-engineer` 建立协作关系

**修改示例**：

```markdown
## Delegation Map

**Reports to**: `technical-director` (via `lead-programmer`)

**Delegates to**:
- `godot-gdscript-specialist` for GDScript architecture
- `godot-shader-specialist` for shaders
- `godot-gdextension-specialist` for native bindings
- `mobile-optimization-specialist` for mobile performance *(新增)*

**Escalation targets**:
- `technical-director` for engine version upgrades
- `lead-programmer` for architecture conflicts

**Coordinates with**:
- `gameplay-programmer` for gameplay frameworks
- `technical-artist` for VFX
- `performance-analyst` for profiling
- `analytics-engineer` for telemetry integration *(新增)*
```

### 2.4 调整最佳实践

最佳实践应随引擎版本和项目演进更新：

- **引擎版本升级**：如 Godot 4.2 → 4.3，检查是否有新 API 或废弃 API 需要更新
- **项目特定约束**：如团队决定禁止使用某些设计模式，应在相关 Agent 的最佳实践中明确
- **性能预算变化**：如目标平台从 PC 改为 Switch，需要收紧性能相关规范

---

## 3. 修改 Rule

### 3.1 调整作用路径

Rule 的 `paths` 使用 Glob 模式匹配。修改场景：

- **新增模块**：如新增 `src/animation/**`，需要决定是复用现有 Rule 还是创建新 Rule
- **路径重构**：如将 `src/ai/` 重命名为 `src/npc/`，需要同步更新 `ai-code.md` 的 paths
- **细化粒度**：如 `ui-code` 原先覆盖 `src/ui/**`，现在需要为 `src/ui/hud/**` 和 `src/ui/menus/**` 设置不同规则

### 3.2 调整规则内容

Rule 的内容是简单的列表，每项是一个约束。修改时：

- **增加规则**：在列表末尾追加，保持与现有规则的风格一致
- **删除规则**：若某项规则不再适用，直接删除并记录变更原因
- **修改规则**：更新数值（如性能预算从 2ms 改为 1ms）或措辞

**修改示例**：

```markdown
# AI Code Rules

- AI update budget: 1ms per frame maximum — profile to verify *(从 2ms 调整为 1ms)*
- All AI parameters must be tunable from data files
- AI must be debuggable: implement visualization hooks for all AI state
- AI should telegraph intentions — players need time to read and react
- Prefer utility-based or behavior tree approaches over hard-coded if/else chains
- Group AI must support formation, flanking, and role assignment from data
- All AI state machines must log transitions for debugging
- Never trust AI input from the network without validation
- *(新增)* AI pathfinding must use asynchronous queries to avoid frame drops
```

### 3.3 创建 Rule 变体

当不同子目录需要相似的规则但参数不同时，可以：

- **方案 A**：在一个 Rule 文件中用注释区分（简单，但不够清晰）
- **方案 B**：创建多个 Rule 文件（推荐，职责单一，易于维护）

---

## 4. 调整模型层级分配

模型层级直接影响响应质量和成本。调整原则：

| 场景 | 建议调整 |
|------|----------|
| Skill 频繁超时或输出质量下降 | 升级到 `opus` |
| Skill 仅做格式化和简单查找 | 降级到 `haiku` 以节省 token |
| Agent 需要处理复杂多文件分析 | 确保为 `sonnet` 或 `opus` |
| 子任务独立且简单 | 使用 `haiku` 并行处理 |

**参考**：`.codebuddy/docs/coordination-rules.md` 中的 Model Tier Assignment 章节提供了官方指导。

---

## 5. 修改审查模式

审查模式存储在 `production/review-mode.txt` 中，直接编辑即可：

```bash
echo "lean" > production/review-mode.txt
```

**何时调整**：
- 团队规模变化（多人 → 单人，可改为 Solo）
- 项目阶段变化（原型 → 生产，应从 Solo 改为 Lean 或 Full）
- 学习需求（新成员加入时，临时改为 Full）

---

## 6. 注意事项与风险控制

### 6.1 修改前的检查清单

- [ ] 是否已阅读原始文件的完整内容？
- [ ] 修改是否与其他 Skill/Agent/Rule 存在冲突？
- [ ] 是否更新了相关的交叉引用（如 skills-reference.md、agent-roster.md）？
- [ ] 是否运行了 `/skill-test` 验证结构合规性？
- [ ] 是否在 Git 中提交了修改前的版本（便于回滚）？

### 6.2 常见风险

| 风险 | 原因 | 缓解措施 |
|------|------|----------|
| 工具权限不足 | `allowed-tools` 遗漏必要工具 | 对照实际操作检查工具列表 |
| 阶段逻辑断裂 | 删除 Phase 后上下游引用失效 | 全文搜索被删除 Phase 的编号 |
| 委托循环 | Agent A 委托给 B，B 又委托给 A | 检查 Delegation Map 的闭环 |
| Rule 路径重叠 | 多个 Rule 匹配同一路径，约束冲突 | 检查路径的包含关系 |
| 模型降级导致质量下降 | `haiku` 处理复杂任务 | 根据任务复杂度分配合适模型 |

### 6.3 版本控制建议

所有提示词工程文件都应纳入 Git 版本控制。修改时：

1. 在独立分支上进行修改
2. 小步提交，每次只修改一个 Skill/Agent/Rule
3. 提交信息明确说明修改原因（如 `Update godot-specialist: add C# best practices`）
4. 修改后让同事审阅，或使用 `/code-review` 自我审查

完成以上学习后，你可以进入[阶段三：扩展新建](phase-3-extension.md)。
