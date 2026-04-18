---
name: ccgs-to-codebuddy-migration-audit
overview: 审查 Claude Code Game Studios (CCGS) 工程从 Claude Code 适配到 CodeBuddy 的转换质量，检测漏改、错误、警告和异常，并修复所有发现的问题。
design:
  architecture:
    framework: html
todos:
  - id: fix-critical-branding
    content: 修复 CODEBUDDY.md 自身及 statusline.sh 的品牌引用残留（Claude Code -> CodeBuddy）
    status: completed
  - id: fix-hooks-branding
    content: 修复全部 12 个 hook 脚本的头部注释和 notify.sh 弹窗文本中的 Claude Code 残留引用
    status: completed
  - id: fix-docs-branding
    content: 修复 .codebuddy/docs 目录下 8 个文档文件的 Claude Code / CLAUDE.md 残留引用
    status: completed
  - id: fix-skills-claude-ref
    content: 修复 Skills 中 29 处 CLAUDE.md / Claude Code 残留引用（重点：setup-engine 13处、start、design-system、brainstorm 等）
    status: completed
    dependencies:
      - fix-docs-branding
  - id: fix-readme-upgrading
    content: 修复 README.md 和 UPGRADING.md 的大规模未更新内容，包括标题、Prerequisites、Setup步骤、工作笔记清理
    status: completed
  - id: fix-testing-framework
    content: 修复 CCGS Skill Testing Framework 中的 20+ 处 CLAUDE.md / Claude Code 残留引用
    status: completed
  - id: audit-api-compatibility
    content: 全面审计 Skills/Agents 的 frontmatter 和 body 中 allowed-tools、AskUserQuestion、Task() 等 Claude Code 特有 API，输出兼容性报告和修复建议
    status: completed
    dependencies:
      - fix-skills-claude-ref
---

## 产品概述

对 **Claude Code Game Studios (CCGS)** 工程进行全面迁移审查，检测从 **Claude Code** 适配到 **CodeBuddy** 过程中存在的漏改、错误、警告和异常问题。工程包含 49 个 Agents、72 个 Skills、12 个 Hooks、11 个 Rules、39 个 Templates 以及一个 CCGS Skill Testing Framework。

## 核心审查发现

### CRITICAL - 严重问题（必须修复）

**1. CLAUDE.md 残留引用 -- 约 77+ 处**

- **Skills (29处)**: `setup-engine/SKILL.md` 含 13 处 `CLAUDE.md` 引用；`start`, `design-system`, `brainstorm`, `architecture-decision`, `onboard`, `code-review`, `design-review`, `gate-check`, `estimate`, `release-checklist`, `prototype`, `asset-audit`, `perf-profile`, `launch-checklist`, `map-systems` 等 Skill 文件均含残留引用
- **Hooks (12处)**: 全部 12 个 `.sh` 脚本头部注释均保留 "Claude Code" 字样；`notify.sh` 中弹窗标题为 "Claude Code"；`statusline.sh` 标题为 "Claude Code Game Studios"
- **Docs (8处)**: `setup-requirements.md` 将 Claude Code 列为必需工具；`skills-reference.md`, `settings-local-template.md`, `quick-start.md`, `context-management.md` 均有残留

**2. CODEBUDDY.md 主配置文件自身未完成适配**

- L3: "managed through 48 coordinated Claude Code subagents" 应改为 CodeBuddy
- 项目名称/品牌标识未更新

### HIGH - 高优先级问题

**3. README.md 大量未更新内容**

- 标题、描述、Prerequisites(仍要求 npm 安装 claude-code)、Setup 步骤(用 claude 命令)、Project Structure(显示 CLAUDE.md)、底部 "*Built for Claude Code*"
- L314-343: 包含大量翻译规则工作笔记，不属于正式文档内容

**4. UPGRADING.md 完全未更新**

- 全文标题及内容均为 "Upgrading Claude Code Game Studios"
- 大量 "CLAUDE.md" 文件名引用、"claude" 命令引用
- GitHub 仓库地址指向原版

**5. Skills/Agents 使用 Claude Code 特有 API**

- Skills frontmatter 使用 `allowed-tools:` 字段（234处匹配）
- Skills body 大量使用 `AskUserQuestion` 工具调用语法（183+处）
- Skills body 大量使用 `Task(` 子代理调用语法
- Agent frontmatter 使用 `tools:`, `disallowedTools:`, `model:`, `maxTurns:`, `memory:`, `skills:` 等字段
- 需确认这些字段在 CodeBuddy 中的等效写法

### MEDIUM - 中等问题

**6. CCGS Skill Testing Framework 未适配**

- README.md 引用 "CLAUDE.md"
- CODEBUDDY.md 内容仍有 "Claude Code" / "Claude Instructions" 引用
- 测试规格文件中约 20 处 CLAUDE.md 残留

**7. settings.json Hook 事件兼容性**

- 已使用 CodeBuddy schema ($schema 指向 codebuddy.cn)
- 事件名如 SessionStart, PreToolUse, PostToolUse, SubagentStart, SubagentStop 等需与 CodeBuddy 规范对照验证

## 技术方案

### 技术栈

- **目标平台**: CodeBuddy IDE 插件系统
- **文件格式**: Markdown (.md) + YAML Frontmatter + JSON 配置 + Bash Shell Scripts (.sh)
- **核心变更**: 文本替换/品牌重命名 + API 字段映射 + 格式规范化

### 实施策略

#### 分层修复策略（按严重程度递减）

**Layer 1: 品牌标识统一（纯文本替换）**

- 将所有 "Claude Code" -> "CodeBuddy"（作为产品名称时）
- 将所有 "CLAUDE.md" -> "CODEBUDDY.md"（作为文件名引用时）
- 将 "claude" 命令 -> "codebuddy" 命令（CLI 命令引用时）
- 将 "Anthropic"/"@anthropic-ai" 相关安装指令移除或替换

**Layer 2: API 字段映射（需逐文件审核）**

- Skills frontmatter: `allowed-tools` -> CodeBuddy 对应字段
- Agent frontmatter: `tools`/`disallowedTools` -> CodeBuddy 对应字段
- Body 内的 `AskUserQuestion()`/`Task()` 调用 -> CodeBuddy 对应交互模式

**Layer 3: 内容修正（需要人工判断）**

- 移除 README.md 底部的工作笔记（L314-343）
- 更新 Prerequisites 和 Setup 流程说明
- 更新 UPGRADING.md 的版本信息和仓库地址

### 关键执行原则

1. **每处修改先询问确认** -- 展示修改原因和具体变更内容
2. **保持向后兼容** -- 不改变功能逻辑，仅做适配性修改
3. **保留注释完整性** -- Hook 注释中的功能描述同步更新品牌名

本任务不涉及 UI 创建或重大界面改造，属于代码/文本工程审查和修复任务，无需设计部分。

## 推荐的 Agent 扩展

本次任务主要依赖代码搜索和文本编辑能力，不需要特殊的 MCP 或 Skill 扩展。所有工作均可通过基础的文件读写和搜索工具完成。