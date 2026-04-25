---
name: prompt-engineering-study-plan
overview: 建立 CodeBuddy 提示词工程系统性学习方案，包含三阶段学习路径、查询字典、流程图与多平台使用说明。
todos:
  - id: create-study-structure
    content: 创建 Study 目录结构与 README 总纲文档
    status: completed
  - id: generate-dictionary
    content: 生成查询字典：术语表、目录关系、文件索引
    status: completed
    dependencies:
      - create-study-structure
  - id: draw-architecture-flow
    content: 绘制提示词工程流程图与模块关系文档
    status: completed
    dependencies:
      - create-study-structure
  - id: write-phase-guides
    content: 撰写三阶段学习指南：熟练使用、定制修改、添加新文件
    status: completed
    dependencies:
      - generate-dictionary
      - draw-architecture-flow
  - id: write-platform-guides
    content: 撰写多平台提示词使用说明：Godot/Unity/Unreal/WeChat/Cocos
    status: completed
    dependencies:
      - create-study-structure
  - id: cross-review-and-index
    content: 交叉校验文档一致性，补充总索引与快速跳转链接
    status: completed
    dependencies:
      - write-phase-guides
      - write-platform-guides
---

## 产品概述

基于当前 CodeBuddy 游戏工作室框架（包含 96+ Skills、63+ Agents、11+ Rules 的提示词工程体系），建立一套系统性的提示词工程学习方案文档。帮助学习者从“熟练使用现有提示词系统”逐步进阶到“能够定制修改”乃至“能够独立扩展新文件”。

## 核心需求

- **文档输出位置**：所有学习文档统一存放于项目根目录 `/Study` 下
- **忽略范围**：不处理 `根/docs/Readme` 目录内容
- **三阶段学习路径**：

1. 熟练使用：理解并调用现有 Skills、Agents、Rules
2. 定制修改：根据项目需求修改现有提示词内容、调整协作协议与职责边界
3. 添加新文件：独立创建新的 Skill、Agent、Rule 文件并融入现有体系

- **查询字典**：建立术语中英文对照与功能解释、目录关系图、核心文件功能索引
- **流程图文档**：梳理提示词工程的核心模块及其调用/委托/规则触发关系
- **多平台说明**：覆盖 Godot、Unity、Unreal、WeChat、Cocos 五大平台的提示词使用差异与专用 Agent/Skill 集合

## 技术方案

- **文档格式**：Markdown，与项目现有文档规范保持一致
- **文档组织**：按功能域划分为 `dictionary/`、`phase-guide/`、`architecture/`、`platform-guide/` 四个子目录
- **流程图表示**：使用 Mermaid 语法绘制模块关系图，嵌入 Markdown 文件中
- **内容来源**：基于已验证的项目文件结构（`.codebuddy/skills/`、`.codebuddy/agents/`、`.codebuddy/rules/`、`docs/` 等），不虚构路径或 API
- **可维护性**：字典与索引采用表格形式，便于后续随着项目扩展而更新

## 架构设计

```
Study/
├── README.md                    # 学习路线图总纲，三阶段索引
├── dictionary/
│   ├── terminology-dictionary.md   # 术语表：Skill/Agent/Rule/Frontmatter 等中英文对照与释义
│   ├── directory-reference.md      # 目录关系：.codebuddy/、docs/、design/、src/ 等存放规则
│   └── file-reference.md           # 文件索引：关键 SKILL.md、agent.md、rules.md 的功能速查
├── phase-guide/
│   ├── phase-1-proficiency.md      # 阶段一：调用与使用（如何使用 / 命令、理解 Agent 分工）
│   ├── phase-2-customization.md    # 阶段二：修改与调优（编辑 Frontmatter、调整协作协议、改写 Rules）
│   └── phase-3-extension.md        # 阶段三：扩展与新建（创建 Skill、Agent、Rule 的规范与验证）
├── architecture/
│   └── prompt-engineering-flow.md  # 提示词工程全景图：模块划分与关系（Skill→Agent→Rule→Hook 的交互链路）
└── platform-guide/
    ├── godot.md
    ├── unity.md
    ├── unreal.md
    ├── wechat.md
    └── cocos.md
```

## 关键实现说明

- 所有文件路径基于真实项目结构，如 `.codebuddy/skills/bug-report/SKILL.md`、`.codebuddy/agents/godot-specialist.md`、`.codebuddy/rules/ai-code.md`
- 三阶段内容边界清晰：阶段一侧重“调用与阅读”，阶段二侧重“编辑与适配”，阶段三侧重“新建与注册”
- 多平台章节分别梳理各平台专属的 Agent 列表、Skill 列表及引擎参考文档路径（如 `docs/engine-reference/godot/`）
- 流程图覆盖：用户输入 → Skill 路由 → Agent 选择 → Rule 校验 → 工具执行 → 结果输出

## Agent Extensions

### Skill

- **skill-test**
- Purpose: 在阶段三文档中，用于说明如何验证新建 Skill 的结构合规性与行为正确性
- Expected outcome: 提供静态检查、规格验证、审计报告的使用示例，作为学习者的自检工具
- **project-stage-detect**
- Purpose: 在阶段一文档中，作为入门示例展示如何调用现有 Skill 进行项目审计
- Expected outcome: 给出该 Skill 的典型使用场景与输出解读