<p align="center">
  <h1 align="center">CodeBuddy Game Studios</h1>
  <p align="center">
    Turn a single CodeBuddy session into a full game development studio.
    <br />
    将一个 CodeBuddy 会话转变为一个完整的游戏开发工作室。
    <br />
    49 agents. 72 skills. One coordinated AI team.
    <br />
    49个代理。72项技能。一支协调的AI团队。
  </p>
</p>

<p align="center">
  <a href="LICENSE"><img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="MIT License"></a>
  <a href=".codebuddy/agents"><img src="https://img.shields.io/badge/agents-49-blueviolet" alt="49 Agents"></a>
  <a href=".codebuddy/skills"><img src="https://img.shields.io/badge/skills-72-green" alt="72 Skills"></a>
  <a href=".codebuddy/hooks"><img src="https://img.shields.io/badge/hooks-12-orange" alt="12 Hooks"></a>
  <a href=".codebuddy/rules"><img src="https://img.shields.io/badge/rules-11-red" alt="11 Rules"></a>
  <a href="https://www.codebuddy.ai"><img src="https://img.shields.io/badge/built%20for-CodeBuddy-f5f5f5?logo=codebuddy" alt="Built for CodeBuddy"></a>
  <a href="https://www.buymeacoffee.com/donchitos3"><img src="https://img.shields.io/badge/Buy%20Me%20a%20Coffee-Support%20this%20project-FFDD00?logo=buymeacoffee&logoColor=black" alt="Buy Me a Coffee"></a>
  <a href="https://github.com/sponsors/Donchitos"><img src="https://img.shields.io/badge/GitHub%20Sponsors-Support%20this%20project-ea4aaa?logo=githubsponsors&logoColor=white" alt="GitHub Sponsors"></a>
</p>

---

## Why This Exists / 为什么存在

Building a game solo with AI is powerful — but a single chat session has no structure. No one stops you from hardcoding magic numbers, skipping design docs, or writing spaghetti code. There's no QA pass, no design review, no one asking "does this actually fit the game's vision?"
<br />
独自用AI制作游戏很强大——但单个聊天会话没有结构。没人阻止你硬编码魔法数字、跳过设计文档、或者写意大利面条代码。没有QA环节、没有设计评审、没有人问"这真的符合游戏愿景吗？"

**CodeBuddy Game Studios** solves this by giving your AI session the structure of a real studio. Instead of one general-purpose assistant, you get 49 specialized agents organized into a studio hierarchy — directors who guard the vision, department leads who own their domains, and specialists who do the hands-on work. Each agent has defined responsibilities, escalation paths, and quality gates.
<br />
**CodeBuddy Game Studios** 通过给你的AI会话赋予真实工作室的结构来解决这个问题。你不是得到一个通用助手，而是获得49个专业代理，按工作室层级组织——守卫愿景的总监、负责各自领域的部门主管、以及做实际工作的专家。每个代理都有明确的职责、升级路径和质量关卡。

The result: you still make every decision, but now you have a team that asks the right questions, catches mistakes early, and keeps your project organized from first brainstorm to launch.
<br />
结果：你仍然做每一个决策，但现在你拥有一支提出正确问题、及早发现错误、并从最初的头脑风暴到发布全程保持项目有序的团队。

---

## Table of Contents / 目录

- [What's Included](#whats-included)
- [Studio Hierarchy](#studio-hierarchy)
- [Slash Commands](#slash-commands)
- [Getting Started](#getting-started)
- [Upgrading](#upgrading)
- [Project Structure](#project-structure)
- [How It Works](#how-it-works)
- [Design Philosophy](#design-philosophy)
- [Customization](#customization)
- [Platform Support](#platform-support)
- [Community](#community)
- [Supporting This Project](#supporting-this-project)
- [License](#license)

---

## What's Included / 包含内容

| Category / 类别 | Count / 数量 | Description / 描述 |
|----------|-------|-------------|
| **Agents / 代理** | 49 | Specialized subagents across design, programming, art, audio, narrative, QA, and production / 涵盖设计、编程、美术、音频、叙事、QA和制作的专用子代理 |
| **Skills / 技能** | 72 | Slash commands for every workflow phase (`/start`, `/design-system`, `/create-epics`, `/create-stories`, `/dev-story`, `/story-done`, etc.) / 每个工作流阶段的斜杠命令 |
| **Hooks / 钩子** | 12 | Automated validation on commits, pushes, asset changes, session lifecycle, agent audit trail, and gap detection / 提交、推送、资源变更、会话生命周期、代理审计追踪和差距检测的自动验证 |
| **Rules / 规则** | 11 | Path-scoped coding standards enforced when editing gameplay, engine, AI, UI, network code, and more / 编辑游戏玩法、引擎、AI、UI、网络代码等时强制执行的路径范围编码标准 |
| **Templates / 模板** | 39 | Document templates for GDDs, UX specs, ADRs, sprint plans, HUD design, accessibility, and more / 用于GDD、UX规格、ADR、冲刺计划、HUD设计、无障碍等的文档模板 |

## Studio Hierarchy / 工作室层级

Agents are organized into three tiers, matching how real studios operate:
<br />
代理按三个层级组织，匹配真实工作室的运作方式：

```
Tier 1 — Directors (Opus) / 第一层 — 总监
  creative-director    technical-director    producer

Tier 2 — Department Leads (Sonnet) / 第二层 — 部门主管
  game-designer        lead-programmer       art-director
  audio-director       narrative-director    qa-lead
  release-manager      localization-lead

Tier 3 — Specialists (Sonnet/Haiku) / 第三层 — 专家
  gameplay-programmer  engine-programmer     ai-programmer
  network-programmer   tools-programmer      ui-programmer
  systems-designer     level-designer        economy-designer
  technical-artist     sound-designer        writer
  world-builder        ux-designer           prototyper
  performance-analyst  devops-engineer       analytics-engineer
  security-engineer    qa-tester             accessibility-specialist
  live-ops-designer    community-manager
```

<!-- 引擎专家 -->
### Engine Specialists / 引擎专家

The template includes agent sets for all three major engines. Use the set that matches your project:
<br />
该模板包含全部三大引擎的代理集。使用与你项目匹配的集合：

| Engine / 引擎 | Lead Agent / 主导代理 | Sub-Specialists / 子专家 |
|--------|-----------|-----------------|
| **Godot 4** | `godot-specialist` | GDScript, Shaders / 着色器, GDExtension |
| **Unity** | `unity-specialist` | DOTS/ECS, Shaders/VFX, Addressables, UI Toolkit |
| **Unreal Engine 5** | `unreal-specialist` | GAS, Blueprints / 蓝图, Replication / 复制, UMG/CommonUI |

## Slash Commands / 斜杠命令

Type `/` in Claude Code to access all 72 skills:
<br />
在 Claude Code 中输入 `/` 访问全部 72 项技能：

**Onboarding & Navigation / 入门与导航**
`/start` `/help` `/project-stage-detect` `/setup-engine` `/adopt`

**Game Design / 游戏设计**
`/brainstorm` `/map-systems` `/design-system` `/quick-design` `/review-all-gdds` `/propagate-design-change`

**Art & Assets / 美术与资产**
`/art-bible` `/asset-spec` `/asset-audit`

**UX & Interface Design / 用户体验与界面设计**
`/ux-design` `/ux-review`

**Architecture / 架构**
`/create-architecture` `/architecture-decision` `/architecture-review` `/create-control-manifest`

**Stories & Sprints / 故事与冲刺**
`/create-epics` `/create-stories` `/dev-story` `/sprint-plan` `/sprint-status` `/story-readiness` `/story-done` `/estimate`

**Reviews & Analysis / 评审与分析**
`/design-review` `/code-review` `/balance-check` `/content-audit` `/scope-check` `/perf-profile` `/tech-debt` `/gate-check` `/consistency-check`

**QA & Testing / 质量保证与测试**
`/qa-plan` `/smoke-check` `/soak-test` `/regression-suite` `/test-setup` `/test-helpers` `/test-evidence-review` `/test-flakiness` `/skill-test` `/skill-improve`

**Production / 制作**
`/milestone-review` `/retrospective` `/bug-report` `/bug-triage` `/reverse-document` `/playtest-report`

**Release / 发布**
`/release-checklist` `/launch-checklist` `/changelog` `/patch-notes` `/hotfix`

**Creative & Content / 创意与内容**
`/prototype` `/onboard` `/localize`

**Team Orchestration** (coordinate multiple agents on a single feature) / **团队编排**（协调多个代理完成单个功能）
`/team-combat` `/team-narrative` `/team-ui` `/team-release` `/team-polish` `/team-audio` `/team-level` `/team-live-ops` `/team-qa`

## Getting Started / 快速入门

### Prerequisites / 前置条件

- [Git](https://git-scm.com/)
- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) (`npm install -g @anthropic-ai/claude-code`)
- **Recommended / 推荐**: [jq](https://jqlang.github.io/jq/) (for hook validation / 用于钩子验证) and Python 3 (for JSON validation / 用于JSON验证)

All hooks fail gracefully if optional tools are missing — nothing breaks, you just lose validation.
<br />
如果缺少可选工具，所有钩子都会优雅失败——什么都不会中断，只是失去验证功能。

<!-- 设置 -->
### Setup / 设置

1. **Clone or use as template / 克隆或作为模板使用**:
   ```bash
   git clone https://github.com/Donchitos/Claude-Code-Game-Studios.git my-game
   cd my-game
   ```

2. **Open CodeBuddy / 打开 CodeBuddy** and start a session / 并启动会话:
   ```
   Press Ctrl+Shift+P (or Cmd+Shift+P) and type "CodeBuddy: Start Session"
   按 Ctrl+Shift+P（或 Cmd+Shift+P）输入 "CodeBuddy: Start Session"
   ```

3. **Run `/start` / 运行 `/start`** — the system asks where you are (no idea, vague concept,
   clear design, existing work) and guides you to the right workflow. No assumptions.
   <br />
   系统会询问你处于哪个阶段（毫无头绪、模糊概念、清晰设计、已有作品）并引导你到正确的工作流。不做任何假设。

   Or jump directly to a specific skill if you already know what you need:
   <br />
   或者如果你已经知道需要什么，直接跳到特定技能：
   - `/brainstorm` — explore game ideas from scratch / 从头探索游戏创意
   - `/setup-engine godot 4.6` — configure your engine if you already know / 如已知引擎，直接配置
   - `/project-stage-detect` — analyze an existing project / 分析现有项目

## Upgrading / 升级

Already using an older version of this template? See [UPGRADING.md](UPGRADING.md)
for step-by-step migration instructions, a breakdown of what changed between
versions, and which files are safe to overwrite vs. which need a manual merge.
<br />
已经在使用旧版本模板？查看 [UPGRADING.md](UPGRADING.md) 获取逐步迁移说明、版本间变更的详细分解、以及哪些文件可以安全覆盖、哪些需要手动合并。

## Project Structure / 项目结构

```
CLAUDE.md                           # Master configuration
.codebuddy/
  settings.json                     # Hooks, permissions, safety rules
  agents/                           # 49 agent definitions (markdown + YAML frontmatter)
  skills/                           # 72 slash commands (subdirectory per skill)
  hooks/                            # 12 hook scripts (bash, cross-platform)
  rules/                            # 11 path-scoped coding standards
  statusline.sh                     # Status line script (context%, model, stage, epic breadcrumb)
  docs/
    workflow-catalog.yaml           # 7-phase pipeline definition (read by /help)
    templates/                      # 39 document templates
src/                                # Game source code
assets/                             # Art, audio, VFX, shaders, data files
design/                             # GDDs, narrative docs, level designs
docs/                               # Technical documentation and ADRs
tests/                              # Test suites (unit, integration, performance, playtest)
tools/                              # Build and pipeline tools
prototypes/                         # Throwaway prototypes (isolated from src/)
production/                         # Sprint plans, milestones, release tracking
```

## How It Works / 工作原理

<!-- 中文翻译 -->
### Agent Coordination / 代理协调

Agents follow a structured delegation model:
<br />
代理遵循结构化的委托模型：

1. **Vertical delegation** — directors delegate to leads, leads delegate to specialists / **垂直委托** — 总监委派给主管，主管委派给专家
2. **Horizontal consultation** — same-tier agents can consult each other but can't make binding cross-domain decisions / **横向咨询** — 同级代理可以相互咨询，但不能做出跨域约束决策
3. **Conflict resolution** — disagreements escalate up to the shared parent (`creative-director` for design, `technical-director` for technical) / **冲突解决** — 分歧升级到共同的上级（设计方面→`creative-director`，技术方面→`technical-director`）
4. **Change propagation** — cross-department changes are coordinated by `producer` / **变更传播** — 跨部门变更由 `producer` 协调
5. **Domain boundaries** — agents don't modify files outside their domain without explicit delegation / **领域边界** — 代理未经明确委托不修改其领域之外的文件

<!-- 中文翻译 -->
### Collaborative, Not Autonomous / 协作式，非自主式

This is **not** an auto-pilot system. Every agent follows a strict collaboration protocol:
<br />
这**不是**自动驾驶系统。每个代理都遵循严格的协作协议：

1. **Ask** — agents ask questions before proposing solutions / **提问** — 代理在提出解决方案前先询问
2. **Present options** — agents show 2-4 options with pros/cons / **呈现选项** — 代理展示2-4个选项及其优缺点
3. **You decide** — the user always makes the call / **你决定** — 用户始终做出最终决定
4. **Draft** — agents show work before finalizing / **草案** — 代理在定稿前展示工作成果
5. **Approve** — nothing gets written without your sign-off / **批准** — 未经你的签字确认，任何内容都不会被写入

You stay in control. The agents provide structure and expertise, not autonomy.
<br />
你始终保持控制。代理提供的是结构和专业知识，而非自主权。

<!-- 中文翻译 -->
### Automated Safety / 自动化安全保障

**Hooks** run automatically on every session:
<br />
**钩子**在每个会话中自动运行：

| Hook / 钩子 | Trigger / 触发条件 | What It Does / 功能 |
|------|---------|--------------|
| `validate-commit.sh` | PreToolUse (Bash) | Checks for hardcoded values, TODO format, JSON validity, design doc sections — exits early if the command is not `git commit` / 检查硬编码值、TODO格式、JSON有效性、设计文档章节——如果不是 `git commit` 命令则提前退出 |
| `validate-push.sh` | PreToolUse (Bash) | Warns on pushes to protected branches — exits early if the command is not `git push` / 对推送到受保护分支发出警告——如果不是 `git push` 命令则提前退出 |
| `validate-assets.sh` | PostToolUse (Write/Edit) | Validates naming conventions and JSON structure — exits early if the file is not in `assets/` / 验证命名约定和JSON结构——如果文件不在 `assets/` 中则提前退出 |
| `session-start.sh` | Session open / 会话打开 | Shows current branch and recent commits for orientation / 显示当前分支和最近提交以供定位 |
| `detect-gaps.sh` | Session open / 会话打开 | Detects fresh projects (suggests `/start`) and missing design docs when code or prototypes exist / 检测新项目（建议 `/start`）以及存在代码或原型时缺少的设计文档 |
| `pre-compact.sh` | Before compaction / 压缩前 | Preserves session progress notes / 保存会话进度记录 |
| `post-compact.sh` | After compaction / 压缩后 | Reminds Claude to restore session state from `active.md` / 提醒 Claude 从 `active.md` 恢复会话状态 |
| `notify.sh` | Notification event / 通知事件 | Shows Windows toast notification via PowerShell / 通过 PowerShell 显示 Windows 弹窗通知 |
| `session-stop.sh` | Session close / 会话关闭 | Archives `active.md` to session log and records git activity / 将 `active.md` 归档到会话日志并记录 git 活动 |
| `log-agent.sh` | Agent spawned / 代理生成 | Audit trail start — logs subagent invocation / 审计追踪开始 — 记录子代理调用 |
| `log-agent-stop.sh` | Agent stops / 代理停止 | Audit trail stop — completes subagent record / 审计追踪停止 — 完成子代理记录 |
| `validate-skill-change.sh` | PostToolUse (Write/Edit) | Advises running `/skill-test` after any `.codebuddy/skills/` change / 在 `.codebuddy/skills/` 变更后建议运行 `/skill-test` |

> **Note**: `validate-commit.sh`, `validate-assets.sh`, and `validate-skill-change.sh` fire on every Bash/Write tool call and exit immediately (exit 0) when the command or file path is not relevant. This is normal hook behavior — not a performance concern.
> <br />
> **注意**：`validate-commit.sh`、`validate-assets.sh` 和 `validate-skill-change.sh` 会在每次 Bash/Write 工具调用时触发，并在命令或文件路径不相关时立即退出（exit 0）。这是正常的钩子行为——不是性能问题。

**Permission rules** in `settings.json` auto-allow safe operations (git status, test runs) and block dangerous ones (force push, `rm -rf`, reading `.env` files).
<br />
`settings.json` 中的**权限规则**自动允许安全操作（git status、运行测试）并阻止危险操作（force push、`rm -rf`、读取 `.env` 文件）。

<!-- 中文翻译 -->
### Path-Scoped Rules / 路径范围规则

Coding standards are automatically enforced based on file location:
<br />
编码标准根据文件位置自动强制执行：

| Path / 路径 | Enforces / 强制规则 |
|------|----------|
| `src/gameplay/**` | Data-driven values, delta time usage, no UI references / 数据驱动值、delta time 使用、无UI引用 |
| `src/core/**` | Zero allocations in hot paths, thread safety, API stability / 热路径零分配、线程安全、API稳定性 |
| `src/ai/**` | Performance budgets, debuggability, data-driven parameters / 性能预算、可调试性、数据驱动参数 |
| `src/networking/**` | Server-authoritative, versioned messages, security / 服务器权威、版本化消息、安全性 |
| `src/ui/**` | No game state ownership, localization-ready, accessibility / 不拥有游戏状态、本地化就绪、无障碍 |
| `design/gdd/**` | Required 8 sections, formula format, edge cases / 必需的8个章节、公式格式、边界情况 |
| `tests/**` | Test naming, coverage requirements, fixture patterns / 测试命名、覆盖率要求、fixture模式 |
| `prototypes/**` | Relaxed standards, README required, hypothesis documented / 宽松标准、需要README、记录假设 |

## Design Philosophy / 设计哲学

This template is grounded in professional game development practices:
<br />
此模板基于专业游戏开发实践：

- **MDA Framework** — Mechanics, Dynamics, Aesthetics analysis for game design / **MDA框架** — 游戏设计的机制、动态、美学分析
- **Self-Determination Theory** — Autonomy, Competence, Relatedness for player motivation / **自我决定理论** — 自主性、能力感、关联性，驱动玩家动机
- **Flow State Design** — Challenge-skill balance for player engagement / **心流状态设计** — 挑战与技能的平衡，保持玩家投入
- **Bartle Player Types** — Audience targeting and validation / **Bartle玩家类型** — 受众定位与验证
- **Verification-Driven Development** — Tests first, then implementation / **验证驱动开发** — 先测试，后实现

## Customization / 自定义

This is a **template**, not a locked framework. Everything is meant to be customized:
<br />
这是一个**模板**，而非锁定框架。一切都可自定义：

- **Add/remove agents** — delete agent files you don't need, add new ones for your domains / **添加/移除代理** — 删除不需要的代理文件，为你的领域添加新的
- **Edit agent prompts** — tune agent behavior, add project-specific knowledge / **编辑代理提示词** — 调整代理行为，添加项目特定知识
- **Modify skills** — adjust workflows to match your team's process / **修改技能** — 调整工作流以匹配团队流程
- **Add rules** — create new path-scoped rules for your project's directory structure / **添加规则** — 为项目目录结构创建新的路径范围规则
- **Tune hooks** — adjust validation strictness, add new checks / **调整钩子** — 调整验证严格程度，添加新检查
- **Pick your engine** — use the Godot, Unity, or Unreal agent set (or none) / **选择引擎** — 使用Godot、Unity或Unreal代理集（或不使用）
- **Set review intensity** — `full` (all director gates), `lean` (phase gates only), or `solo` (none). Set during `/start` or edit `production/review-mode.txt`. Override per-run with `--review solo` on any skill. / **设置评审强度** — `full`（全部总监关卡）、`lean`（仅阶段关卡）、`solo`（无）。在 `/start` 期间设置或编辑 `production/review-mode.txt`。在任何技能后用 `--review solo` 覆盖单次运行。

## Platform Support / 平台支持

Tested on **Windows 10** with Git Bash. All hooks use POSIX-compatible patterns (`grep -E`, not `grep -P`) and include fallbacks for missing tools. Works on macOS and Linux without modification.
<br />
已在 **Windows 10** + Git Bash 上测试。所有钩子使用 POSIX 兼容模式（`grep -E`，而非 `grep -P`）并包含缺少工具时的回退方案。无需修改即可在 macOS 和 Linux 上运行。

## Community / 社区

- **Discussions / 讨论** — [GitHub Discussions](https://github.com/Donchitos/Claude-Code-Game-Studios/discussions) for questions, ideas, and showcasing what you've built / 提问、创意分享和展示你的作品
- **Issues / 问题** — [Bug reports and feature requests](https://github.com/Donchitos/Claude-Code-Game-Studios/issues) / 缺陷报告和功能请求

---

## Supporting This Project / 支持此项目

Claude Code Game Studios is free and open source. If it saves you time or helps you ship your game, consider supporting continued development:
<br />
Claude Code Game Studios 是免费且开源的。如果它为你节省了时间或帮你发布了游戏，考虑支持持续开发：

<p>
  <a href="https://www.buymeacoffee.com/donchitos3"><img src="https://img.shields.io/badge/Buy%20Me%20a%20Coffee-FFDD00?style=for-the-badge&logo=buy-me-a-coffee&logoColor=black" alt="Buy Me a Coffee"></a>
  &nbsp;
  <a href="https://github.com/sponsors/Donchitos"><img src="https://img.shields.io/badge/GitHub%20Sponsors-ea4aaa?style=for-the-badge&logo=githubsponsors&logoColor=white" alt="GitHub Sponsors"></a>
</p>

- **[Buy Me a Coffee](https://www.buymeacoffee.com/donchitos3)** — one-time support / 一次性支持
- **[GitHub Sponsors](https://github.com/sponsors/Donchitos)** — recurring support through GitHub / 通过 GitHub 持续支持

Sponsorships help fund time spent maintaining skills, adding new agents, keeping up with Claude Code and engine API changes, and responding to community issues.
<br />
赞助有助于资助维护技能、添加新代理、跟进 Claude Code 和引擎 API 变动以及回应社区问题所花费的时间。

---

*Built for CodeBuddy. Maintained and extended — contributions welcome via [GitHub Discussions](https://github.com/Donchitos/Claude-Code-Game-Studios/discussions).*
<br />
*为 CodeBuddy 构建。持续维护和扩展——欢迎通过 [GitHub Discussions](https://github.com/Donchitos/Claude-Code-Game-Studios/discussions) 贡献。*

## License / 许可证

MIT License. See [LICENSE](LICENSE) for details.
<br />
MIT 许可证。详见 [LICENSE](LICENSE)。
