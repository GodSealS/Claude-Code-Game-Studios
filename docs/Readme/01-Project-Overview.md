# CodeBuddy Game Studios - 项目概览

> **一个完整的 AI 驱动游戏开发工作室架构**

## 什么是 CodeBuddy Game Studios？

CodeBuddy Game Studios (CCGS) 是一个为 **CodeBuddy IDE** 设计的完整游戏开发提示词工程架构。它将 48+ 个专业化的 AI Agent 组织成一个模拟真实游戏工作室的层级结构，通过定义明确的职责、委派规则和协调协议，帮助开发者以专业工作室的标准进行游戏开发。

---

## 核心理念

### 1. 分层架构（Studio Hierarchy）
模拟真实游戏工作室的组织结构：

```
┌─────────────────────────────────────────────┐
│  Tier 1: 领导层 (Directors)                 │
│  - Creative Director (创意总监)             │
│  - Technical Director (技术总监)            │
│  - Producer (制作人)                        │
├─────────────────────────────────────────────┤
│  Tier 2: 部门主管 (Department Leads)        │
│  - Game Designer, Lead Programmer           │
│  - Art Director, Audio Director             │
│  - QA Lead, Release Manager                 │
├─────────────────────────────────────────────┤
│  Tier 3: 专家 (Specialists)                 │
│  - Programmers, Designers, Artists          │
│  - Writers, Testers, Engineers              │
└─────────────────────────────────────────────┘
```

### 2. 协作优先（Collaboration First）
**用户驱动的协作，而非自主执行**。每个任务遵循：

```
问题 (Question) → 选项 (Options) → 决策 (Decision) → 草稿 (Draft) → 批准 (Approval)
```

Agent 在写入文件前必须询问用户确认，展示草稿后再请求批准。

### 3. 引擎无关（Engine Agnostic）
支持三种主流游戏引擎，每种都有专门的 Agent 团队：

| 引擎 | 专家团队 |
|------|----------|
| **Godot 4** | `godot-specialist`, `godot-gdscript-specialist`, `godot-shader-specialist`, `godot-gdextension-specialist` |
| **Unity** | `unity-specialist`, `unity-dots-specialist`, `unity-shader-specialist`, `unity-addressables-specialist`, `unity-ui-specialist` |
| **Unreal Engine 5** | `unreal-specialist`, `ue-gas-specialist`, `ue-blueprint-specialist`, `ue-replication-specialist`, `ue-umg-specialist` |

### 4. 基于游戏设计理论
所有设计 Agent 和模板都基于成熟的游戏设计理论：
- **MDA Framework** (Mechanics-Dynamics-Aesthetics)
- **Self-Determination Theory** (自主、胜任、归属感)
- **Flow State** (心流状态)
- **Bartle Player Types** (玩家类型学)

---

## 项目统计

| 组件 | 数量 | 说明 |
|------|------|------|
| **Agents** | 49 | 专业领域 Agent 定义 |
| **Skills** | 72 | 斜杠命令 / 工作流技能 |
| **Hooks** | 12 | 自动化事件钩子 |
| **Rules** | 11 | 路径特定规则 |
| **Templates** | 38 | 文档模板 |

---

## 快速开始

### 新项目？
```
/start          # 引导式入门，根据你的情况推荐工作流
```

### 已有项目？
```
/project-stage-detect    # 分析现有项目状态
/adopt                   # 将现有项目迁移到本架构
```

### 开始设计
```
/brainstorm              # 头脑风暴游戏概念
/map-systems             # 将概念分解为系统
/design-system [name]    # 设计具体系统
```

### 开始开发
```
/create-architecture     # 创建架构文档
/create-epics            # 创建史诗任务
/create-stories [epic]   # 将史诗分解为故事
/dev-story [story]       # 实现故事
```

---

## 文档索引

本目录包含完整的项目文档：

| 文档 | 内容 |
|------|------|
| `01-Project-Overview.md` | 本文件 - 项目概览 |
| `02-Directory-Structure.md` | 目录结构详解 |
| `03-Workflow-Guide.md` | 工作流程指南 |
| `04-Agents-Reference.md` | Agents 参考手册 |
| `05-Skills-Reference.md` | Skills 参考手册 |
| `06-Hooks-and-Rules.md` | Hooks 和 Rules 说明 |
| `07-Game-Development-Guide.md` | 游戏开发使用指南 |
| `08-Open-Spec-Integration.md` | Open Spec 集成指南 |

---

## 设计理念

### Separation of Concerns（关注点分离）
每个 Agent 拥有明确的职责边界，避免功能重叠和冲突。

### Progressive Disclosure（渐进式披露）
新手可以从 `/start` 开始，逐步学习；专家可以直接调用特定 Agent 或 Skill。

### Documentation as Code（文档即代码）
所有设计文档、架构决策都纳入版本控制，可追溯、可审查。

### Honest AI（诚实的 AI）
Agent 会明确说明什么是从文档中发现的，什么是合理推断的。

---

## 许可证

本项目采用开源许可证，允许自由使用和修改。

---

> **提示**: 如果你是第一次使用，建议从 `/start` 命令开始，让系统引导你完成初始设置。
