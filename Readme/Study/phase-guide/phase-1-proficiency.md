# 阶段一：熟练使用

目标：理解 CodeBuddy 提示词工程框架的结构，能够正确调用 Skill 与 Agent，阅读并遵循 Rule。

---

## 1. 调用 Skill（斜杠命令）

### 基本语法

在 CodeBuddy 输入框中输入 `/skill-name [参数]` 即可调用对应 Skill。

示例：
```
/start
/help
/bug-report 玩家进入战斗场景时崩溃
/project-stage-detect
/setup-engine
```

### 查看可用 Skill

- 输入 `/` 触发自动补全，浏览所有可用的斜杠命令。
- 查阅 `.codebuddy/docs/skills-reference.md` 获取完整的 73 个命令速查表。
- 使用 `/help` 获取上下文感知的下一步建议。

### 参数传递

- 无参数：如 `/start`、`/help`、`/project-stage-detect`
- 单参数：如 `/brainstorm open`、`/bug-report analyze src/player.gd`
- 多参数：如 `/architecture-decision retrofit design/architecture/old-decision.md`

### 调用前的自检

1. 当前项目阶段是否适合调用该 Skill？（可用 `/project-stage-detect` 确认）
2. 是否已准备好该 Skill 所需的输入材料？（如 `/design-system` 需要先有系统概念）
3. 审查模式是否会影响输出？（检查 `production/review-mode.txt`）

---

## 2. 常用 Skill 入门示例

### 2.1 `/start` — 首次入职引导

**何时使用**：新用户首次进入项目，或需要重新确认项目状态时。

**典型流程**：
1. 系统自动检测项目状态（引擎是否配置、是否有概念文档、是否有源代码）
2. 询问用户当前处于哪个阶段（A: 无想法 / B: 模糊想法 / C: 清晰概念 / D: 已有工作）
3. 根据选择展示推荐的工作流路径
4. 设置审查模式（Full / Lean / Solo）

**学习要点**：
- 观察 Skill 如何通过 `AskUserQuestion` 提供选项而非直接执行
- 理解不同审查模式对后续工作流的影响

### 2.2 `/help` — 下一步导航

**何时使用**：不确定下一步该做什么时。

**典型输出**：
- 当前项目阶段检测
- 推荐下一步 Skill
- 可选的并行任务

**学习要点**：
- `/help` 是上下文感知的，会根据 `active.md` 和现有文件推荐最合适的下一步

### 2.3 `/project-stage-detect` — 项目审计

**何时使用**：想了解项目当前处于哪个阶段、缺少什么文档时。

**典型输出**：
- 检测到的项目阶段（Concept / Architecture / Pre-Production / Production / Polish / Release）
- 存在性缺口（缺少的文档或目录）
- 格式合规性状态
- 推荐下一步

**学习要点**：
- 理解项目各阶段的准入条件
- 识别哪些缺口是阻塞性的，哪些可以并行补齐

---

## 3. 阅读 Agent 定义

### 3.1 文件位置

所有 Agent 定义位于 `.codebuddy/agents/` 目录下，每个 Agent 一个 `.md` 文件。

### 3.2 阅读顺序

阅读 Agent 文件时，建议按以下顺序关注信息：

1. **Frontmatter**：确认 Agent 的 `name`、`description`、`tools`、`model`、`maxTurns`
2. **核心职责（Core Responsibilities）**：了解该 Agent 负责的技术领域
3. **协作协议（Collaboration Protocol）**：理解该 Agent 如何与用户协作（询问→选项→决策→草稿→批准）
4. **最佳实践（Best Practices）**：掌握该领域的技术规范
5. **委托地图（Delegation Map）**：明确该 Agent 的上下级关系和协作对象
6. **禁止事项（Must NOT Do）**：划定能力边界，避免提出越权请求

### 3.3 示例：阅读 `godot-specialist.md`

```markdown
Frontmatter 要点：
- model: DeepSeek-V3.2（默认层级，适合实现和分析）
- tools: Read, Glob, Grep, Write, Edit, Bash, Task（完整工具集）

核心职责：
- 引导语言决策（GDScript vs C# vs GDExtension）
- 确保正确使用 Godot 的节点/场景架构
- 优化渲染、物理和内存模型

协作协议要点：
- 写代码前必须阅读设计文档
- 必须提出架构方案并征得用户同意
- 写文件前必须问 "May I write this to [filepath]?"
- 遇到规范歧义时必须 STOP 并询问

最佳实践要点：
- 优先组合而非继承
- 使用 @onready 引用节点，不使用硬编码长路径
- 信号解耦，避免直接方法调用
- 静态类型 everywhere

委托地图：
- Reports to: technical-director（通过 lead-programmer）
- Delegates to: godot-gdscript-specialist, godot-shader-specialist, godot-gdextension-specialist
- Coordinates with: gameplay-programmer, technical-artist, performance-analyst

禁止事项：
- 不做游戏设计决策
- 不覆盖 lead-programmer 的架构决策
- 不直接实现功能（应委派给子专家）
```

---

## 4. 理解和遵循 Rule

### 4.1 Rule 的触发机制

Rule 是**被动触发**的。当你或 Agent 对某个路径执行操作时，系统会自动检查该路径是否命中任何 Rule 的 `paths` 字段。若命中，该 Rule 的内容会被注入到当前上下文中，作为约束条件。

### 4.2 阅读 Rule 文件

Rule 文件位于 `.codebuddy/rules/` 目录下，结构简单：

```yaml
---
paths:
  - "src/ai/**"
---

# AI Code Rules

- AI update budget: 2ms per frame maximum — profile to verify
- All AI parameters must be tunable from data files
- ...
```

### 4.3 常见 Rule 及其作用域

| Rule | 作用路径 | 核心约束 |
|------|----------|----------|
| `ai-code` | `src/ai/**` | AI 性能预算、可调试性、行为树优先 |
| `gameplay-code` | `src/gameplay/**` | 状态机模式、输入处理、帧率无关逻辑 |
| `ui-code` | `src/ui/**` | 响应式布局、控件复用、动画性能 |
| `shader-code` | `src/shaders/**` | 精度控制、平台宏、Overdraw 优化 |
| `network-code` | `src/network/**` | 序列化、验证、延迟隐藏 |

### 4.4 遵循 Rule 的实践

- 在编写代码前，先确认目标路径命中了哪些 Rule
- 阅读对应 Rule 文件，将约束内化到实现中
- 若 Rule 与实际情况冲突，不要擅自违反，应升级到 `technical-director` 或修改 Rule 文件（进入阶段二）

---

## 5. 上下文管理基础

### 5.1 会话状态文件

`production/session-state/active.md` 是当前会话的持久化状态文件，包含：
- 当前任务和进度
- 关键决策
- 正在编辑的文件
- 未解决的问题

**养成习惯**：任何重要决策或进度更新后，主动检查 `active.md` 是否已同步。

### 5.2 审查模式

`production/review-mode.txt` 控制 Director 级 Agent 的审查频率：
- **Full**：每步关键操作后都进行审查（适合团队、学习阶段）
- **Lean**（推荐）：仅在阶段门控（`/gate-check`）时审查（适合个人开发者、小团队）
- **Solo**：无审查，最大速度（适合 Game Jam、原型）

### 5.3 上下文压缩

当对话变长时，使用 `/compact` 主动压缩上下文：
```
/compact Focus on [current task] — sections 1-3 are written to file, working on section 4
```

压缩后，关键信息会保留在摘要中，但具体实现细节需要重新读取文件。

---

## 6. 阶段一练习清单

完成以下练习，确认你已熟练掌握基础操作：

- [ ] 运行 `/start` 完成入职引导，观察项目状态检测逻辑
- [ ] 运行 `/help` 至少 3 次，分别在 Concept、Architecture、Production 阶段
- [ ] 运行 `/project-stage-detect` 并理解输出中的缺口分析
- [ ] 阅读至少 3 个与你工作相关的 Agent 定义文件（领导层、部门层、专家层各一个）
- [ ] 阅读至少 2 个与你代码路径相关的 Rule 文件
- [ ] 检查 `production/session-state/active.md` 和 `production/review-mode.txt` 是否存在
- [ ] 成功调用一个非导航类的 Skill（如 `/design-review` 或 `/code-review`）

完成以上练习后，你可以进入[阶段二：定制修改](phase-2-customization.md)。
