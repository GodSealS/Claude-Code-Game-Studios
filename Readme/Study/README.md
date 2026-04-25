# CodeBuddy 提示词工程系统学习方案

本学习方案基于 `Claude Code Game Studios` 项目中的 CodeBuddy 提示词工程体系，涵盖 **96+ Skills**、**63+ Agents**、**11+ Rules** 及配套文档。目标是从"熟练使用"逐步进阶到"独立扩展"。

## 三阶段学习路径

| 阶段 | 目标 | 对应文档 |
|------|------|----------|
| 阶段一：熟练使用 | 理解框架结构，正确调用 Skill 与 Agent，阅读并遵循 Rule | [phase-1-proficiency.md](phase-guide/phase-1-proficiency.md) |
| 阶段二：定制修改 | 根据项目需求修改现有提示词内容、调整协作协议与职责边界 | [phase-2-customization.md](phase-guide/phase-2-customization.md) |
| 阶段三：扩展新建 | 独立创建新的 Skill、Agent、Rule 并融入现有体系 | [phase-3-extension.md](phase-guide/phase-3-extension.md) |

## 文档地图

```
Study/
├── README.md                          # 本文件：学习路线图总纲
├── dictionary/
│   ├── terminology-dictionary.md      # 术语中英文对照与功能解释
│   ├── directory-reference.md         # 目录关系说明
│   └── file-reference.md              # 核心文件功能索引
├── phase-guide/
│   ├── phase-1-proficiency.md         # 阶段一：熟练使用
│   ├── phase-2-customization.md       # 阶段二：定制修改
│   └── phase-3-extension.md           # 阶段三：扩展新建
├── architecture/
│   └── prompt-engineering-flow.md     # 提示词工程流程图与模块关系
└── platform-guide/
    ├── godot.md                       # Godot 平台提示词使用说明
    ├── unity.md                       # Unity 平台提示词使用说明
    ├── unreal.md                      # Unreal 平台提示词使用说明
    ├── wechat.md                      # 微信小游戏平台提示词使用说明
    └── cocos.md                       # Cocos 平台提示词使用说明
```

## 快速开始

1. **新手入门**：先阅读 [phase-1-proficiency.md](phase-guide/phase-1-proficiency.md)，了解如何调用 `/start`、`/help` 等基础 Skill。
2. **查阅术语**：遇到不明术语时，随时查阅 [terminology-dictionary.md](dictionary/terminology-dictionary.md)。
3. **了解架构**：通过 [prompt-engineering-flow.md](architecture/prompt-engineering-flow.md) 掌握模块间的调用关系。
4. **平台专项**：根据项目所用引擎，阅读对应的 [platform-guide/](platform-guide/) 文档。
5. **进阶扩展**：掌握基础后，阅读 [phase-3-extension.md](phase-guide/phase-3-extension.md) 学习如何创建自己的 Skill 和 Agent。
6. **快速查找**：需要快速定位特定问题时，查阅 [INDEX.md](INDEX.md) 的关键词索引和问题索引。

## 学习建议

- **实践优先**：每阅读一个 Skill，尝试在项目中实际调用一次。
- **对比学习**：对比相似 Skill（如 `/bug-report` 与 `/bug-triage`）的差异，理解设计意图。
- **由点到面**：先熟悉自己负责领域的 Agent 和 Skill，再逐步扩展到全局。
- **保持同步**：提示词工程体系会随项目演进，定期回顾本学习方案并更新。
