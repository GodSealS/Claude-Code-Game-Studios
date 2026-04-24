---
name: onboard
description: "Generates a contextual onboarding document for a new contributor or agent joining the project. Summarizes project state, architecture, conventions, and current priorities relevant to the specified role or area. / 为加入项目的新贡献者或代理生成上下文入职文档。总结项目状态、架构、约定和与指定角色或领域相关的当前优先级。"
argument-hint: "[role|area]"
user-invocable: true
allowed-tools: Read, Glob, Grep, Write
model: haiku
---

## Phase 1: Load Project Context / 阶段 1：加载项目上下文

Read CLAUDE.md for project overview and standards.

> **中文翻译**：读取 CLAUDE.md 获取项目概览和标准。

Read the relevant agent definition from `.codebuddy/agents/` if a specific role is specified.

> **中文翻译**：如果指定了特定角色，从 `.codebuddy/agents/` 读取相关的代理定义。

---

## Phase 2: Scan Relevant Area / 阶段 2：扫描相关领域

- For programmers: scan `src/` for architecture, patterns, key files / 对于程序员：扫描 `src/` 了解架构、模式和关键文件
- For designers: scan `design/` for existing design documents / 对于设计师：扫描 `design/` 了解现有设计文档
- For narrative: scan `design/narrative/` for world-building and story docs / 对于叙事：扫描 `design/narrative/` 了解世界观和故事文档
- For QA: scan `tests/` for existing test coverage / 对于 QA：扫描 `tests/` 了解现有测试覆盖
- For production: scan `production/` for current sprint and milestone / 对于制作：扫描 `production/` 了解当前冲刺和里程碑

Read recent changes (git log if available) to understand current momentum.

> **中文翻译**：读取最近的更改（如可用则使用 git log）以了解当前进展。

---

## Phase 3: Generate Onboarding Document / 阶段 3：生成入职文档

```markdown
# Onboarding: [Role/Area]

## Project Summary
[2-3 sentence summary of what this game is and its current state]

## Your Role
[What this role does on this project, key responsibilities, who you report to]

## Project Architecture
[Relevant architectural overview for this role]

### Key Directories
| Directory | Contents | Your Interaction |
|-----------|----------|-----------------|

### Key Files
| File | Purpose | Read Priority |
|------|---------|--------------|

## Current Standards and Conventions
[Summary of conventions relevant to this role from CODEBUDDY.md and agent definition]

## Current State of Your Area
[What has been built, what is in progress, what is planned next]

## Current Sprint Context
[What the team is working on now and what is expected of this role]

## Key Dependencies
[What other roles/systems this role interacts with most]

## Common Pitfalls
[Things that trip up new contributors in this area]

## First Tasks
[Suggested first tasks to get oriented and productive]

1. [Read these documents first]
2. [Review this code/content]
3. [Start with this small task]

## Questions to Ask
[Questions the new contributor should ask to get fully oriented]
```

---

## Phase 4: Save Document / 阶段 4：保存文档

Present the onboarding document to the user.

> **中文翻译**：将入职文档呈现给用户。

Ask: "May I write this to `production/onboarding/onboard-[role]-[date].md`?"

> **中文翻译**：询问："我可以将此写入 `production/onboarding/onboard-[role]-[date].md` 吗？"

If yes, write the file, creating the directory if needed.

> **中文翻译**：如果同意，写入文件，如需要则创建目录。

---

## Phase 5: Next Steps / 阶段 5：后续步骤

Verdict: **COMPLETE** — onboarding document generated.

> **中文翻译**：裁决：**COMPLETE** — 入职文档已生成。

- Share the onboarding doc with the new contributor before their first session. / 在新贡献者首次会话前与其分享入职文档。
- Run `/sprint-status` to show the new contributor current progress. / 运行 `/sprint-status` 向新贡献者展示当前进度。
- Run `/help` if the contributor needs guidance on what to work on next. / 如果贡献者需要下一步工作指导，运行 `/help`。
