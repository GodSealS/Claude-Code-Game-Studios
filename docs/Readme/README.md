# CodeBuddy Game Studios - 文档索引

欢迎来到 CodeBuddy Game Studios 的完整文档目录。本文档集提供了对项目架构、工作流程和使用方法的全面介绍。

---

## 文档清单

| 序号 | 文档 | 内容概述 | 适合读者 |
|------|------|----------|----------|
| 01 | [项目概览](./01-Project-Overview.md) | 核心理念、架构概览、快速开始 | 所有人 |
| 02 | [目录结构详解](./02-Directory-Structure.md) | 每个目录的用途和内容详解 | 新手、使用者 |
| 03 | [工作流程指南](./03-Workflow-Guide.md) | 7 阶段开发管道详解 | 使用者、项目经理 |
| 04 | [Agents 参考手册](./04-Agents-Reference.md) | 49 个 Agent 的完整参考 | 所有人 |
| 05 | [Skills 参考手册](./05-Skills-Reference.md) | 72 个 Skill 的完整参考 | 所有人 |
| 06 | [Hooks 和 Rules 说明](./06-Hooks-and-Rules.md) | 自动化系统详解 | 高级用户、维护者 |
| 07 | [游戏开发使用指南](./07-Game-Development-Guide.md) | 如何使用本架构开发游戏 | 游戏开发者 |
| 08 | [Open Spec 集成指南](./08-Open-Spec-Integration.md) | 与 Open Spec 的集成方法 | 高级用户、架构师 |
| 09 | [流程图和组织结构图](./09-Diagrams-and-Charts.md) | 项目架构图、流程图、决策树 | 视觉学习者 |
| 10 | [微信小游戏开发指南](./10-WeChat-Mini-Game-Guide.md) | 微信小游戏专用开发指南 | 微信小游戏开发者 |

---

## 阅读路径推荐

### 路径 1: 快速入门（15 分钟）

适合想快速了解项目的人：

1. [项目概览](./01-Project-Overview.md) - 核心理念和统计
2. [目录结构详解](./02-Directory-Structure.md) - 了解项目组织
3. [游戏开发使用指南](./07-Game-Development-Guide.md) - 开发流程

### 路径 2: 使用者指南（30 分钟）

适合准备使用本架构开发游戏的人：

1. [项目概览](./01-Project-Overview.md)
2. [目录结构详解](./02-Directory-Structure.md)
3. [工作流程指南](./03-Workflow-Guide.md)
4. [游戏开发使用指南](./07-Game-Development-Guide.md)

### 路径 3: 完整参考（60 分钟）

适合需要深入了解所有功能的人：

1. [项目概览](./01-Project-Overview.md)
2. [目录结构详解](./02-Directory-Structure.md)
3. [工作流程指南](./03-Workflow-Guide.md)
4. [Agents 参考手册](./04-Agents-Reference.md)
5. [Skills 参考手册](./05-Skills-Reference.md)
6. [Hooks 和 Rules 说明](./06-Hooks-and-Rules.md)

### 路径 4: 架构师指南（45 分钟）

适合需要扩展或定制架构的人：

1. [项目概览](./01-Project-Overview.md)
2. [目录结构详解](./02-Directory-Structure.md)
3. [Hooks 和 Rules 说明](./06-Hooks-and-Rules.md)
4. [Open Spec 集成指南](./08-Open-Spec-Integration.md)

---

## 关键概念速查

### 什么是 Agent？

Agent 是专门化的 AI 角色，模拟游戏工作室中的职位。共有 49 个 Agent，分为 3 个层级：

- **Tier 1**: 领导层（创意总监、技术总监、制作人）
- **Tier 2**: 部门主管（游戏设计师、首席程序员、艺术总监等）
- **Tier 3**: 专家（程序员、设计师、艺术家等）

### 什么是 Skill？

Skill 是可调用的工作流命令（以 `/` 开头）。共有 72 个 Skill，覆盖：

- 入门与导航
- 游戏设计
- 架构设计
- 故事与迭代
- 审查与分析
- QA 与测试
- 发布管理

### 什么是 Hook？

Hook 是在特定事件时自动执行的脚本，用于：

- 会话开始时加载上下文
- Git 提交前验证
- 文件修改后检查

### 什么是 Rule？

Rule 是针对特定路径文件的编码规范，自动在编辑时应用。

---

## 快速命令参考

### 开始使用

```
/start                  # 引导式入门
/help                   # 获取帮助
/project-stage-detect   # 检测项目状态
```

### 设计阶段

```
/brainstorm             # 头脑风暴
/map-systems            # 系统分解
/design-system [name]   # 系统设计
```

### 开发阶段

```
/create-architecture    # 创建架构
/create-epics           # 创建史诗
/create-stories [epic]  # 创建故事
/dev-story [story]      # 开发故事
```

### 审查和检查

```
/design-review [doc]    # 设计审查
/code-review [file]     # 代码审查
/gate-check [phase]     # 阶段检查
/consistency-check      # 一致性检查
```

### 团队协作

```
/team-combat            # 战斗团队
/team-ui                # UI 团队
/team-release           # 发布团队
```

---

## 外部资源

### 项目根目录文档

- `CODEBUDDY.md` - 项目主配置
- `README.md` - 项目介绍

### .codebuddy 目录

- `docs/quick-start.md` - 快速开始指南
- `docs/agent-roster.md` - Agent 名册
- `docs/skills-reference.md` - Skills 参考
- `docs/templates/` - 文档模板

---

## 贡献和反馈

如果你发现文档中的问题或有改进建议，请：

1. 修改相关文档文件
2. 提交变更
3. 创建 Pull Request

---

## 许可证

本文档采用与项目相同的开源许可证。

---

> **提示**: 如果你在阅读文档时遇到问题，可以运行 `/help` 命令获取上下文感知的帮助。
