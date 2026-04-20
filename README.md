<p align="center">
  <h1 align="center">CodeBuddy Game Studios / CodeBuddy 游戏工作室</h1>
  <p align="center">
    Turn a single CodeBuddy session into a full game development studio.
    将单个 CodeBuddy 会话转变为完整的游戏开发工作室。
    <br />
    49 agents / 49 个代理. 72 skills / 72 个技能. One coordinated AI team / 一个协调的 AI 团队.
  </p>
</p>

<p align="center">
  <a href="LICENSE"><img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="MIT License / MIT 许可证"></a>
  <a href=".codebuddy/agents"><img src="https://img.shields.io/badge/agents-49-blueviolet" alt="49 Agents / 49 个代理"></a>
  <a href=".codebuddy/skills"><img src="https://img.shields.io/badge/skills-72-green" alt="72 Skills / 72 个技能"></a>
  <a href=".codebuddy/hooks"><img src="https://img.shields.io/badge/hooks-12-orange" alt="12 Hooks / 12 个钩子"></a>
  <a href=".codebuddy/rules"><img src="https://img.shields.io/badge/rules-11-red" alt="11 Rules / 11 条规则"></a>
  <a href="https://www.codebuddy.ai"><img src="https://img.shields.io/badge/built%20for-CodeBuddy-f5f5f5?logo=codebuddy" alt="Built for CodeBuddy / 为 CodeBuddy 构建"></a>
  <a href="https://www.buymeacoffee.com/donchitos3"><img src="https://img.shields.io/badge/Buy%20Me%20a%20Coffee-Support%20this%20project-FFDD00?logo=buymeacoffee&logoColor=black" alt="Buy Me a Coffee / 请支持这个项目"></a>
  <a href="https://github.com/sponsors/Donchitos"><img src="https://img.shields.io/badge/GitHub%20Sponsors-Support%20this%20project-ea4aaa?logo=githubsponsors&logoColor=white" alt="GitHub Sponsors / GitHub 赞助"></a>
</p>

---

## Why This Exists / 为什么创建这个

Building a game solo with AI is powerful — but a single chat session has no structure. No one stops you from hardcoding magic numbers, skipping design docs, or writing spaghetti code. There's no QA pass, no design review, no one asking "does this actually fit the game's vision?"
使用 AI 独立开发游戏很强大——但单个聊天会话没有结构。没有人阻止你硬编码魔法数字、跳过设计文档或编写意大利面条式代码。没有 QA 审查，没有设计评审，没有人问"这真的符合游戏愿景吗？"

**CodeBuddy Game Studios** solves this by giving your AI session the structure of a real studio. Instead of one general-purpose assistant, you get 49 specialized agents organized into a studio hierarchy — directors who guard the vision, department leads who own their domains, and specialists who do the hands-on work. Each agent has defined responsibilities, escalation paths, and quality gates.
**CodeBuddy 游戏工作室**通过为您的 AI 会话提供真实工作室的结构来解决这个问题。您不再是一个通用助手，而是获得 49 个专业代理，组织成工作室层级结构——守护愿景的总监、拥有各自领域的部门负责人，以及执行实际工作的专家。每个代理都有明确的职责、升级路径和质量关卡。

The result: you still make every decision, but now you have a team that asks the right questions, catches mistakes early, and keeps your project organized from first brainstorm to launch.
结果是：您仍然做出每个决策，但现在您有一个团队会问正确的问题、及早发现错误，并将您的项目从首次头脑风暴到发布都保持井井有条。

---

## Table of Contents / 目录

- [What's Included / 包含内容](#whats-included)
- [Studio Hierarchy / 工作室层级](#studio-hierarchy)
- [Slash Commands / 斜杠命令](#slash-commands)
- [Getting Started / 开始使用](#getting-started)
- [Upgrading / 升级](#upgrading)
- [Project Structure / 项目结构](#project-structure)
- [How It Works / 工作原理](#how-it-works)
- [Design Philosophy / 设计理念](#design-philosophy)
- [Customization / 自定义](#customization)
- [Platform Support / 平台支持](#platform-support)
- [Community / 社区](#community)
- [Supporting This Project / 支持本项目](#supporting-this-project)
- [License / 许可证](#license)

---

## What's Included / 包含内容

| Category / 类别 | Count / 数量 | Description / 描述 |
|----------|-------|-------------|
| **Agents / 代理** | 49 | Specialized subagents across design, programming, art, audio, narrative, QA, and production / 跨设计、编程、美术、音频、叙事、QA 和制作的专业子代理 |
| **Skills / 技能** | 72 | Slash commands for every workflow phase (`/start`, `/design-system`, `/create-epics`, `/create-stories`, `/dev-story`, `/story-done`, etc.) / 每个工作流阶段的斜杠命令 |
| **Hooks / 钩子** | 12 | Automated validation on commits, pushes, asset changes, session lifecycle, agent audit trail, and gap detection / 提交、推送、资源变更、会话生命周期、代理审计跟踪和缺口检测的自动验证 |
| **Rules / 规则** | 11 | Path-scoped coding standards enforced when editing gameplay, engine, AI, UI, network code, and more / 编辑游戏玩法、引擎、AI、UI、网络代码等时强制执行的路径范围编码标准 |
| **Templates / 模板** | 39 | Document templates for GDDs, UX specs, ADRs, sprint plans, HUD design, accessibility, and more / GDD、UX 规范、ADR、冲刺计划、HUD 设计、无障碍等的文档模板 |

## Studio Hierarchy / 工作室层级

Agents are organized into three tiers, matching how real studios operate:
代理按三个层级组织，与真实工作室的运营方式相匹配：

```
Tier 1 — Directors (Opus) / 层级 1 — 总监 (Opus)
  creative-director / 创意总监    technical-director / 技术总监    producer / 制作人

Tier 2 — Department Leads (Sonnet) / 层级 2 — 部门负责人 (Sonnet)
  game-designer / 游戏设计师        lead-programmer / 主程序员       art-director / 美术总监
  audio-director / 音频总监       narrative-director / 叙事总监    qa-lead / QA 负责人
  release-manager / 发布经理      localization-lead / 本地化负责人

Tier 3 — Specialists (Sonnet/Haiku) / 层级 3 — 专家 (Sonnet/Haiku)
  gameplay-programmer / 游戏玩法程序员  engine-programmer / 引擎程序员     ai-programmer / AI 程序员
  network-programmer / 网络程序员     tools-programmer / 工具程序员      ui-programmer / UI 程序员
  systems-designer / 系统设计师       level-designer / 关卡设计师        economy-designer / 经济设计师
  technical-artist / 技术美术         sound-designer / 声音设计师        writer / 编剧
  world-builder / 世界观构建者        ux-designer / UX 设计师           prototyper / 原型设计师
  performance-analyst / 性能分析师    devops-engineer / DevOps 工程师    analytics-engineer / 分析工程师
  security-engineer / 安全工程师      qa-tester / QA 测试员              accessibility-specialist / 无障碍专家
  live-ops-designer / 运营设计师      community-manager / 社区经理
```

### Engine Specialists / 引擎专家

The template includes agent sets for all three major engines. Use the set that matches your project:
模板包含所有三大主流引擎的代理集合。使用与您的项目匹配的集合：

| Engine / 引擎 | Lead Agent / 主代理 | Sub-Specialists / 子专家 |
|--------|-----------|-----------------|
| **Godot 4** | `godot-specialist` | GDScript, Shaders, GDExtension |
| **Unity** | `unity-specialist` | DOTS/ECS, Shaders/VFX, Addressables, UI Toolkit |
| **Unreal Engine 5** | `unreal-specialist` | GAS, Blueprints, Replication, UMG/CommonUI |

## Slash Commands / 斜杠命令

Type `/` in Claude Code to access all 72 skills:
在 Claude Code 中输入 `/` 访问所有 72 个技能：

**Onboarding & Navigation / 入门与导航**
`/start` `/help` `/project-stage-detect` `/setup-engine` `/adopt`

**Game Design / 游戏设计**
`/brainstorm` `/map-systems` `/design-system` `/quick-design` `/review-all-gdds` `/propagate-design-change`

**Art & Assets / 美术与资源**
`/art-bible` `/asset-spec` `/asset-audit`

**UX & Interface Design / UX 与界面设计**
`/ux-design` `/ux-review`

**Architecture / 架构**
`/create-architecture` `/architecture-decision` `/architecture-review` `/create-control-manifest`

**Stories & Sprints / 故事与冲刺**
`/create-epics` `/create-stories` `/dev-story` `/sprint-plan` `/sprint-status` `/story-readiness` `/story-done` `/estimate`

**Reviews & Analysis / 审查与分析**
`/design-review` `/code-review` `/balance-check` `/content-audit` `/scope-check` `/perf-profile` `/tech-debt` `/gate-check` `/consistency-check`

**QA & Testing / QA 与测试**
`/qa-plan` `/smoke-check` `/soak-test` `/regression-suite` `/test-setup` `/test-helpers` `/test-evidence-review` `/test-flakiness` `/skill-test` `/skill-improve`

**Production / 制作**
`/milestone-review` `/retrospective` `/bug-report` `/bug-triage` `/reverse-document` `/playtest-report`

**Release / 发布**
`/release-checklist` `/launch-checklist` `/changelog` `/patch-notes` `/hotfix`

**Creative & Content / 创意与内容**
`/prototype` `/onboard` `/localize`

**Team Orchestration / 团队编排** (coordinate multiple agents on a single feature / 在单个功能上协调多个代理)
`/team-combat` `/team-narrative` `/team-ui` `/team-release` `/team-polish` `/team-audio` `/team-level` `/team-live-ops` `/team-qa`

## Getting Started / 开始使用

### Prerequisites / 先决条件

- [Git](https://git-scm.com/)
- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) (`npm install -g @anthropic-ai/claude-code`)
- **Recommended / 推荐**: [jq](https://jqlang.github.io/jq/) (for hook validation / 用于钩子验证) and Python 3 (for JSON validation / 用于 JSON 验证)

All hooks fail gracefully if optional tools are missing — nothing breaks, you just lose validation.
如果缺少可选工具，所有钩子都会优雅地失败——不会破坏任何东西，您只是失去了验证功能。

### Setup / 设置

1. **Clone or use as template / 克隆或用作模板**:
   ```bash
   git clone https://github.com/Donchitos/Claude-Code-Game-Studios.git my-game
   cd my-game
   ```

2. **Open CodeBuddy and start a session / 打开 CodeBuddy 并开始会话**:
   ```
   Press Ctrl+Shift+P (or Cmd+Shift+P) and type "CodeBuddy: Start Session"
   按 Ctrl+Shift+P（或 Cmd+Shift+P）并输入 "CodeBuddy: Start Session"
   ```

3. **Run `/start`** — the system asks where you are (no idea, vague concept,
   **运行 `/start`** — 系统询问您目前的状态（没有想法、模糊概念、
   clear design, existing work) and guides you to the right workflow. No assumptions.
   清晰设计、已有工作）并引导您进入正确的工作流。不做假设。

   Or jump directly to a specific skill if you already know what you need:
   或者如果您已经知道需要什么，可以直接跳转到特定技能：
   - `/brainstorm` — explore game ideas from scratch / 从零开始探索游戏创意
   - `/setup-engine godot 4.6` — configure your engine if you already know / 如果您已经知道，配置您的引擎
   - `/project-stage-detect` — analyze an existing project / 分析现有项目

## Upgrading / 升级

Already using an older version of this template? See [UPGRADING.md](UPGRADING.md)
已经在使用旧版本的此模板？请参阅 [UPGRADING.md](UPGRADING.md)
for step-by-step migration instructions, a breakdown of what changed between
获取分步迁移说明、版本之间更改内容的详细分解，
versions, and which files are safe to overwrite vs. which need a manual merge.
以及哪些文件可以安全覆盖与哪些需要手动合并。

## Project Structure / 项目结构

```
CLAUDE.md                           # Master configuration / 主配置
.codebuddy/
  settings.json                     # Hooks, permissions, safety rules / 钩子、权限、安全规则
  agents/                           # 49 agent definitions (markdown + YAML frontmatter) / 49 个代理定义
  skills/                           # 72 slash commands (subdirectory per skill) / 72 个斜杠命令
  hooks/                            # 12 hook scripts (bash, cross-platform) / 12 个钩子脚本
  rules/                            # 11 path-scoped coding standards / 11 个路径范围编码标准
  statusline.sh                     # Status line script (context%, model, stage, epic breadcrumb) / 状态行脚本
  docs/
    workflow-catalog.yaml           # 7-phase pipeline definition (read by /help) / 7 阶段管线定义
    templates/                      # 39 document templates / 39 个文档模板
src/                                # Game source code / 游戏源代码
assets/                             # Art, audio, VFX, shaders, data files / 美术、音频、VFX、着色器、数据文件
design/                             # GDDs, narrative docs, level designs / GDD、叙事文档、关卡设计
docs/                               # Technical documentation and ADRs / 技术文档和 ADR
tests/                              # Test suites (unit, integration, performance, playtest) / 测试套件
tools/                              # Build and pipeline tools / 构建和管线工具
prototypes/                         # Throwaway prototypes (isolated from src/) / 可丢弃原型
production/                         # Sprint plans, milestones, release tracking / 冲刺计划、里程碑、发布跟踪
```

## How It Works / 工作原理

### Agent Coordination / 代理协调

Agents follow a structured delegation model:
代理遵循结构化的委派模型：

1. **Vertical delegation / 垂直委派** — directors delegate to leads, leads delegate to specialists / 总监委派给负责人，负责人委派给专家
2. **Horizontal consultation / 横向咨询** — same-tier agents can consult each other but can't make binding cross-domain decisions / 同级代理可以相互咨询，但不能做出具有约束力的跨领域决策
3. **Conflict resolution / 冲突解决** — disagreements escalate up to the shared parent (`creative-director` for design, `technical-director` for technical) / 分歧升级到共同上级
4. **Change propagation / 变更传播** — cross-department changes are coordinated by `producer` / 跨部门变更由 `producer` 协调
5. **Domain boundaries / 领域边界** — agents don't modify files outside their domain without explicit delegation / 代理不会在没有明确委派的情况下修改其领域之外的文件

### Collaborative, Not Autonomous / 协作而非自主

This is **not** an auto-pilot system. Every agent follows a strict collaboration protocol:
这**不是**自动驾驶系统。每个代理都遵循严格的协作协议：

1. **Ask / 询问** — agents ask questions before proposing solutions / 代理在提出解决方案之前先提问
2. **Present options / 呈现选项** — agents show 2-4 options with pros/cons / 代理展示 2-4 个选项及优缺点
3. **You decide / 您决定** — the user always makes the call / 用户始终做出决定
4. **Draft / 草稿** — agents show work before finalizing / 代理在最终确定之前展示工作
5. **Approve / 批准** — nothing gets written without your sign-off / 未经您签字，不会写入任何内容

You stay in control. The agents provide structure and expertise, not autonomy.
您保持控制。代理提供结构和专业知识，而非自主权。

### Automated Safety / 自动安全

**Hooks** run automatically on every session:
**钩子**在每个会话上自动运行：

| Hook / 钩子 | Trigger / 触发器 | What It Does / 功能 |
|------|---------|--------------|
| `validate-commit.sh` | PreToolUse (Bash) | Checks for hardcoded values, TODO format, JSON validity, design doc sections — exits early if the command is not `git commit` / 检查硬编码值、TODO 格式、JSON 有效性、设计文档章节 |
| `validate-push.sh` | PreToolUse (Bash) | Warns on pushes to protected branches — exits early if the command is not `git push` / 推送到受保护分支时警告 |
| `validate-assets.sh` | PostToolUse (Write/Edit) | Validates naming conventions and JSON structure — exits early if the file is not in `assets/` / 验证命名约定和 JSON 结构 |
| `session-start.sh` | Session open | Shows current branch and recent commits for orientation / 显示当前分支和最近提交以供定位 |
| `detect-gaps.sh` | Session open | Detects fresh projects (suggests `/start`) and missing design docs when code or prototypes exist / 检测新项目并建议 `/start`，检测代码或原型存在时缺失的设计文档 |
| `pre-compact.sh` | Before compaction | Preserves session progress notes / 保留会话进度笔记 |
| `post-compact.sh` | After compaction | Reminds Claude to restore session state from `active.md` / 提醒 Claude 从 `active.md` 恢复会话状态 |
| `notify.sh` | Notification event | Shows Windows toast notification via PowerShell / 通过 PowerShell 显示 Windows  toast 通知 |
| `session-stop.sh` | Session close | Archives `active.md` to session log and records git activity / 将 `active.md` 归档到会话日志并记录 git 活动 |
| `log-agent.sh` | Agent spawned | Audit trail start — logs subagent invocation / 审计跟踪开始 — 记录子代理调用 |
| `log-agent-stop.sh` | Agent stops | Audit trail stop — completes subagent record / 审计跟踪停止 — 完成子代理记录 |
| `validate-skill-change.sh` | PostToolUse (Write/Edit) | Advises running `/skill-test` after any `.codebuddy/skills/` change / 在 `.codebuddy/skills/` 更改后建议运行 `/skill-test` |

> **Note** / **注意**: `validate-commit.sh`, `validate-assets.sh`, and `validate-skill-change.sh` fire on every Bash/Write tool call and exit immediately (exit 0) when the command or file path is not relevant. This is normal hook behavior — not a performance concern.
> `validate-commit.sh`、`validate-assets.sh` 和 `validate-skill-change.sh` 在每个 Bash/Write 工具调用时触发，当命令或文件路径不相关时立即退出（exit 0）。这是正常的钩子行为——不是性能问题。

**Permission rules** in `settings.json` auto-allow safe operations (git status, test runs) and block dangerous ones (force push, `rm -rf`, reading `.env` files).
`settings.json` 中的**权限规则**自动允许安全操作（git status、测试运行）并阻止危险操作（强制推送、`rm -rf`、读取 `.env` 文件）。

### Path-Scoped Rules / 路径范围规则

Coding standards are automatically enforced based on file location:
根据文件位置自动强制执行编码标准：

| Path / 路径 | Enforces / 强制执行 |
|------|----------|
| `src/gameplay/**` | Data-driven values, delta time usage, no UI references / 数据驱动值、delta 时间使用、无 UI 引用 |
| `src/core/**` | Zero allocations in hot paths, thread safety, API stability / 热路径零分配、线程安全、API 稳定性 |
| `src/ai/**` | Performance budgets, debuggability, data-driven parameters / 性能预算、可调试性、数据驱动参数 |
| `src/networking/**` | Server-authoritative, versioned messages, security / 服务器权威、版本化消息、安全 |
| `src/ui/**` | No game state ownership, localization-ready, accessibility / 无游戏状态所有权、本地化就绪、无障碍 |
| `design/gdd/**` | Required 8 sections, formula format, edge cases / 必需的 8 个章节、公式格式、边界情况 |
| `tests/**` | Test naming, coverage requirements, fixture patterns / 测试命名、覆盖率要求、夹具模式 |
| `prototypes/**` | Relaxed standards, README required, hypothesis documented / 放宽的标准、需要 README、记录假设 |

## Design Philosophy / 设计理念

This template is grounded in professional game development practices:
此模板基于专业游戏开发实践：

- **MDA Framework** — Mechanics, Dynamics, Aesthetics analysis for game design / 机制、动态、美学分析用于游戏设计
- **Self-Determination Theory** — Autonomy, Competence, Relatedness for player motivation / 自主、能力、关联用于玩家动机
- **Flow State Design** — Challenge-skill balance for player engagement / 挑战-技能平衡用于玩家参与
- **Bartle Player Types** — Audience targeting and validation / 受众定位和验证
- **Verification-Driven Development** — Tests first, then implementation / 测试优先，然后实现

## Customization / 自定义

This is a **template**, not a locked framework. Everything is meant to be customized:
这是一个**模板**，不是锁定的框架。一切都是为了自定义：

- **Add/remove agents / 添加/删除代理** — delete agent files you don't need, add new ones for your domains / 删除不需要的代理文件，为您的新领域添加新代理
- **Edit agent prompts / 编辑代理提示** — tune agent behavior, add project-specific knowledge / 调整代理行为，添加项目特定知识
- **Modify skills / 修改技能** — adjust workflows to match your team's process / 调整工作流以匹配您的团队流程
- **Add rules / 添加规则** — create new path-scoped rules for your project's directory structure / 为项目目录结构创建新的路径范围规则
- **Tune hooks / 调整钩子** — adjust validation strictness, add new checks / 调整验证严格性，添加新检查
- **Pick your engine / 选择您的引擎** — use the Godot, Unity, or Unreal agent set (or none) / 使用 Godot、Unity 或 Unreal 代理集合（或都不使用）
- **Set review intensity / 设置审查强度** — `full` (all director gates), `lean` (phase gates only), or `solo` (none). Set during `/start` or edit `production/review-mode.txt`. Override per-run with `--review solo` on any skill.
  `full`（所有总监关卡）、`lean`（仅阶段关卡）或 `solo`（无）。在 `/start` 期间设置或编辑 `production/review-mode.txt`。在任何技能上使用 `--review solo` 覆盖每次运行。

## Platform Support / 平台支持

Tested on **Windows 10** with Git Bash. All hooks use POSIX-compatible patterns (`grep -E`, not `grep -P`) and include fallbacks for missing tools. Works on macOS and Linux without modification.
在带有 Git Bash 的 **Windows 10** 上测试。所有钩子使用 POSIX 兼容模式（`grep -E`，不是 `grep -P`）并包含缺失工具的后备方案。无需修改即可在 macOS 和 Linux 上工作。

## Community / 社区

- **Discussions / 讨论** — [GitHub Discussions](https://github.com/Donchitos/Claude-Code-Game-Studios/discussions) for questions, ideas, and showcasing what you've built / 用于问题、想法和展示您构建的内容
- **Issues / 问题** — [Bug reports and feature requests](https://github.com/Donchitos/Claude-Code-Game-Studios/issues) / 错误报告和功能请求

---

## Supporting This Project / 支持本项目

CodeBuddy Game Studios is free and open source. If it saves you time or helps you ship your game, consider supporting continued development:
CodeBuddy 游戏工作室是免费开源的。如果它节省了您的时间或帮助您发布游戏，请考虑支持持续开发：

<p>
  <a href="https://www.buymeacoffee.com/donchitos3"><img src="https://img.shields.io/badge/Buy%20Me%20a%20Coffee-FFDD00?style=for-the-badge&logo=buy-me-a-coffee&logoColor=black" alt="Buy Me a Coffee / 请我喝杯咖啡"></a>
  &nbsp;
  <a href="https://github.com/sponsors/Donchitos"><img src="https://img.shields.io/badge/GitHub%20Sponsors-ea4aaa?style=for-the-badge&logo=githubsponsors&logoColor=white" alt="GitHub Sponsors / GitHub 赞助"></a>
</p>

- **[Buy Me a Coffee](https://www.buymeacoffee.com/donchitos3)** — one-time support / 一次性支持
- **[GitHub Sponsors](https://github.com/sponsors/Donchitos)** — recurring support through GitHub / 通过 GitHub 的定期支持

Sponsorships help fund time spent maintaining skills, adding new agents, keeping up with Claude Code and engine API changes, and responding to community issues.
赞助有助于资助维护技能、添加新代理、跟进 Claude Code 和引擎 API 更改以及响应社区问题的时间。

---

*Built for CodeBuddy. Maintained and extended — contributions welcome via [GitHub Discussions](https://github.com/Donchitos/Claude-Code-Game-Studios/discussions).*
*为 CodeBuddy 构建。维护和扩展——欢迎通过 [GitHub Discussions](https://github.com/Donchitos/Claude-Code-Game-Studios/discussions) 贡献。*

## License / 许可证

MIT License. See [LICENSE](LICENSE) for details.
MIT 许可证。详情请参阅 [LICENSE](LICENSE)。
