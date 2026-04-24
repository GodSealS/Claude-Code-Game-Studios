---
name: project-stage-detect
description: "Automatically analyze project state, detect stage, identify gaps, and recommend next steps based on existing artifacts. Use when user asks 'where are we in development', 'what stage are we in', 'full project audit'. / 自动分析项目状态，检测阶段，识别差距，并基于现有工件推荐下一步。当用户问'我们开发到哪了'、'我们处于什么阶段'、'全面项目审计'时使用。"
argument-hint: "[optional: role filter like 'programmer' or 'designer']"
user-invocable: true
allowed-tools: Read, Glob, Grep, Bash, Write
model: haiku
# Read-only diagnostic skill — no specialist agent delegation needed
# 只读诊断技能 — 无需专家代理委派
---

# Project Stage Detection / 项目阶段检测

This skill scans your project to determine its current development stage, completeness
of artifacts, and gaps that need attention. It's especially useful when:
> **中文翻译**：此技能扫描你的项目以确定其当前开发阶段、工件的完整性和需要关注的差距。在以下情况特别有用：

- Starting with an existing project / 接手现有项目
- Onboarding to a codebase / 入职到代码库
- Checking what's missing before a milestone / 在里程碑前检查缺失内容
- Understanding "where are we?" / 了解"我们进展到哪了？"

---

## Workflow / 工作流程

### 1. Scan Key Directories / 1. 扫描关键目录

Analyze project structure and content:
> **中文翻译**：分析项目结构和内容：

**Design Documentation** (`design/`):
> **中文翻译**：**设计文档**（`design/`）：

- Count GDD files in `design/gdd/*.md` / 统计 `design/gdd/*.md` 中的 GDD 文件数量
- Check for game-concept.md, game-pillars.md, systems-index.md / 检查 game-concept.md、game-pillars.md、systems-index.md 是否存在
- If systems-index.md exists, count total systems vs. designed systems / 如果 systems-index.md 存在，统计总系统数与已设计系统数
- Analyze completeness (Overview, Detailed Design, Edge Cases, etc.) / 分析完整性（概述、详细设计、边缘情况等）
- Count narrative docs in `design/narrative/` / 统计 `design/narrative/` 中的叙事文档数量
- Count level designs in `design/levels/` / 统计 `design/levels/` 中的关卡设计数量

**Source Code** (`src/`):
> **中文翻译**：**源代码**（`src/`）：

- Count source files (language-agnostic) / 统计源文件数量（与语言无关）
- Identify major systems (directories with 5+ files) / 识别主要系统（包含 5 个以上文件的目录）
- Check for core/, gameplay/, ai/, networking/, ui/ directories / 检查 core/、gameplay/、ai/、networking/、ui/ 目录是否存在
- Estimate lines of code (rough scale) / 估算代码行数（粗略规模）

**Production Artifacts** (`production/`):
> **中文翻译**：**生产工件**（`production/`）：

- Check for active sprint plans / 检查活跃的冲刺计划
- Look for milestone definitions / 查找里程碑定义
- Find roadmap documents / 查找路线图文档

**Prototypes** (`prototypes/`):
> **中文翻译**：**原型**（`prototypes/`）：

- Count prototype directories / 统计原型目录数量
- Check for READMEs (documented vs undocumented) / 检查 README（已文档化 vs 未文档化）
- Assess if prototypes are archived or active / 评估原型是已归档还是活跃的

**Architecture Docs** (`docs/architecture/`):
> **中文翻译**：**架构文档**（`docs/architecture/`）：

- Count ADRs (Architecture Decision Records) / 统计 ADR（架构决策记录）数量
- Check for overview/index documents / 检查概述/索引文档是否存在

**Tests** (`tests/`):
> **中文翻译**：**测试**（`tests/`）：

- Count test files / 统计测试文件数量
- Estimate test coverage (rough heuristic) / 估算测试覆盖率（粗略启发式）

### 2. Classify Project Stage / 2. 分类项目阶段

Based on scanned artifacts, determine stage. Check `production/stage.txt` first —
if it exists, use its value (explicit override from `/gate-check`). Otherwise,
auto-detect using these heuristics (check from most-advanced backward):
> **中文翻译**：基于扫描的工件，确定阶段。首先检查 `production/stage.txt` — 如果存在，使用其值（来自 `/gate-check` 的显式覆盖）。否则，使用以下启发式规则自动检测（从最先进阶段向后检查）：

| Stage | Indicators |
|-------|-----------|
| **Concept** | No game concept doc, brainstorming phase |
| **Systems Design** | Game concept exists, systems index missing or incomplete |
| **Technical Setup** | Systems index exists, engine not configured |
| **Pre-Production** | Engine configured, `src/` has <10 source files |
| **Production** | `src/` has 10+ source files, active development |
| **Polish** | Explicit only (set by `/gate-check` Production → Polish gate) |
| **Release** | Explicit only (set by `/gate-check` Polish → Release gate) |

> **中文翻译**：
> | 阶段 | 指标 |
> |-------|-----------|
> | **概念** | 无游戏概念文档，头脑风暴阶段 |
> | **系统设计** | 游戏概念存在，系统索引缺失或不完整 |
> | **技术设置** | 系统索引存在，引擎未配置 |
> | **预生产** | 引擎已配置，`src/` 少于 10 个源文件 |
> | **生产** | `src/` 有 10 个以上源文件，活跃开发中 |
> | **打磨** | 仅显式设置（由 `/gate-check` 生产→打磨门控设置） |
> | **发布** | 仅显式设置（由 `/gate-check` 打磨→发布门控设置） |

### 3. Collaborative Gap Identification / 3. 协作式差距识别

**DO NOT** just list missing files. Instead, **ask clarifying questions**:
> **中文翻译**：**不要**只是列出缺失的文件。相反，**提出澄清问题**：

- "I see combat code (`src/gameplay/combat/`) but no `design/gdd/combat-system.md`. Was this prototyped first, or should we reverse-document?" / "我看到战斗代码（`src/gameplay/combat/`）但没有 `design/gdd/combat-system.md`。这是先做的原型，还是应该反向文档化？"
- "You have 15 ADRs but no architecture overview. Should I create one to help new contributors?" / "你有 15 个 ADR 但没有架构概述。我应该创建一个来帮助新贡献者吗？"
- "No sprint plans in `production/`. Are you tracking work elsewhere (Jira, Trello, etc.)?" / "`production/` 中没有冲刺计划。你是在其他地方跟踪工作吗（Jira、Trello 等）？"
- "I found a game concept but no systems index. Have you decomposed the concept into individual systems yet, or should we run `/map-systems`?" / "我找到了游戏概念但没有系统索引。你是否已将概念分解为单独的系统，还是应该运行 `/map-systems`？"
- "Prototypes directory has 3 projects with no READMEs. Were these experiments, or do they need documentation?" / "原型目录有 3 个项目没有 README。这些是实验性的，还是需要文档化？"

### 4. Generate Stage Report / 4. 生成阶段报告

Use template: `.codebuddy/docs/templates/project-stage-report.md`
> **中文翻译**：使用模板：`.codebuddy/docs/templates/project-stage-report.md`

**Report structure**:
> **中文翻译**：**报告结构**：

```markdown
# Project Stage Analysis

**Date**: [date]
**Stage**: [Concept/Systems Design/Technical Setup/Pre-Production/Production/Polish/Release]
**Stage Confidence**: [PASS — clearly detected / CONCERNS — ambiguous signals / FAIL — critical gaps block progress]

## Completeness Overview
- Design: [X%] ([N] docs, [gaps])
- Code: [X%] ([N] files, [systems])
- Architecture: [X%] ([N] ADRs, [gaps])
- Production: [X%] ([status])
- Tests: [X%] ([coverage estimate])

## Gaps Identified
1. [Gap description + clarifying question]
2. [Gap description + clarifying question]

## Recommended Next Steps
[Priority-ordered list based on stage and role]
```

### 5. Role-Filtered Recommendations (Optional) / 5. 按角色过滤的推荐（可选）

If user provided a role argument (e.g., `/project-stage-detect programmer`):
> **中文翻译**：如果用户提供了角色参数（例如 `/project-stage-detect programmer`）：

**Programmer**:
> **中文翻译**：**程序员**：

- Focus on architecture docs, test coverage, missing ADRs / 关注架构文档、测试覆盖率、缺失的 ADR
- Code-to-docs gaps / 代码到文档的差距

**Designer**:
> **中文翻译**：**设计师**：

- Focus on GDD completeness, missing design sections / 关注 GDD 完整性、缺失的设计章节
- Prototype documentation / 原型文档化

**Producer**:
> **中文翻译**：**制作人**：

- Focus on sprint plans, milestone tracking, roadmap / 关注冲刺计划、里程碑跟踪、路线图
- Cross-team coordination docs / 跨团队协调文档

**General** (no role):
> **中文翻译**：**通用**（无角色）：

- Holistic view of all gaps / 所有差距的全局视图
- Highest-priority items across domains / 跨领域的最高优先级项目

### 6. Request Approval Before Writing / 6. 写入前请求批准

**Collaborative protocol**:
> **中文翻译**：**协作协议**：

```
I've analyzed your project. Here's what I found:

[Show summary]

Gaps identified:
1. [Gap 1 + question]
2. [Gap 2 + question]

Recommended next steps:
- [Priority 1]
- [Priority 2]
- [Priority 3]

May I write the full stage analysis to production/project-stage-report.md?
```

Wait for user approval before creating the file.
> **中文翻译**：等待用户批准后再创建文件。

---

## Example Usage / 示例用法

```bash
# General project analysis / 通用项目分析
/project-stage-detect

# Programmer-focused analysis / 程序员专注分析
/project-stage-detect programmer

# Designer-focused analysis / 设计师专注分析
/project-stage-detect designer
```

---

## Follow-Up Actions / 后续行动

After generating the report, suggest relevant next steps:
> **中文翻译**：生成报告后，建议相关的下一步：

- **Concept exists but no systems index?** → `/map-systems` to decompose into systems / **概念存在但没有系统索引？** → `/map-systems` 分解为系统
- **Missing design docs?** → `/reverse-document design src/[system]` / **缺少设计文档？** → `/reverse-document design src/[system]`
- **Missing architecture docs?** → `/architecture-decision` or `/reverse-document architecture` / **缺少架构文档？** → `/architecture-decision` 或 `/reverse-document architecture`
- **Prototypes need documentation?** → `/reverse-document concept prototypes/[name]` / **原型需要文档化？** → `/reverse-document concept prototypes/[name]`
- **No sprint plan?** → `/sprint-plan` / **没有冲刺计划？** → `/sprint-plan`
- **Approaching milestone?** → `/milestone-review` / **接近里程碑？** → `/milestone-review`

---

## Collaborative Protocol / 协作协议

This skill follows the collaborative design principle:
> **中文翻译**：此技能遵循协作设计原则：

1. **Question First**: Ask about gaps, don't assume / **先提问**：询问差距，不要假设
2. **Present Options**: "Should I create X, or is it tracked elsewhere?" / **展示选项**："我应该创建 X，还是它在其他地方被跟踪？"
3. **User Decides**: Wait for direction / **用户决定**：等待指示
4. **Show Draft**: Display report summary / **展示草案**：展示报告摘要
5. **Get Approval**: "May I write to production/project-stage-report.md?" / **获得批准**："我可以写入 production/project-stage-report.md 吗？"

**Never** silently write files. **Always** show findings and ask before creating artifacts.
> **中文翻译**：**绝不**静默写入文件。**始终**在创建工件前展示发现并询问。
