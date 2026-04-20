---
name: unity-agents-collaboration-design
overview: 分析5个Unity Agent的功能、关系和协作模式，生成设计文档存储到docs/Readme/目录下
todos:
  - id: create-unity-guide
    content: 创建 docs/Readme/11-Unity-Agent-Collaboration-Guide.md 协作指南文档
    status: pending
---

## Product Overview

分析 Unity 5 个 Agent（unity-specialist、unity-ui-specialist、unity-dots-specialist、unity-shader-specialist、unity-addressables-specialist）的功能职责、层级关系和协作模式，生成一份完整的协作指南设计文档。

## Core Features

- 5 个 Unity Agent 的详细功能描述和职责边界
- Agent 之间的层级关系（unity-specialist 为父节点，4 个 sub-specialist 为分支）
- Agent 之间的横向协作关系（如 shader 与 UI、DOTS 与 shader 等）
- 典型 Unity 项目开发场景下的协作工作流
- Mermaid 图表可视化架构和协作流程
- 文档存储到 docs/Readme/ 目录下

## Tech Stack

- 文档格式：Markdown
- 图表：Mermaid 流程图
- 存储位置：`docs/Readme/11-Unity-Agent-Collaboration-Guide.md`

## Implementation Approach

基于已读取的 5 个 Agent 定义文件，提取其 Delegation Map、Coordination、Core Responsibilities 等关键信息，综合分析后生成结构化设计文档。文档需包含：

1. **Agent 概览**：每个 Agent 的角色、模型、核心职责
2. **层级架构**：unity-specialist 作为团队 Lead，4 个 sub-specialist 作为分支的树形结构
3. **协作矩阵**：Agent 之间的双向协作关系表格
4. **典型工作流**：覆盖项目初始化、性能优化、UI 开发、渲染管线、资源管理等场景
5. **Mermaid 图表**：架构图、协作流程图、任务委派流程图

## Directory Structure

```
docs/Readme/
└── 11-Unity-Agent-Collaboration-Guide.md  # [NEW] Unity Agent 协作指南
```