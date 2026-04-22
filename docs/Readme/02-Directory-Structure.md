# Directory Structure / 目录结构详解

This document explains the purpose, contents, and features of each directory in the project.

> **中文翻译**：本文档详细解释项目中每个目录的用途、包含的文件以及提供的功能。

---

## 整体结构

```
Claude-Code-Game-Studios/
├── CODEBUDDY.md                    # 主配置文件（入口点）
├── README.md                       # 项目介绍
├── .codebuddy/                     # Agent 定义、技能、钩子、规则
├── src/                            # 游戏源代码
├── assets/                         # 游戏资源
├── design/                         # 游戏设计文档
├── docs/                           # 技术文档
│   ├── engine-reference/           # 引擎 API 参考
│   └── Readme/                     # 项目说明文档（本目录）
├── tests/                          # 测试套件
├── tools/                          # 构建和工具
├── prototypes/                     # 原型（可丢弃）
├── production/                     # 生产管理
└── graphify-out/                   # 知识图谱输出
```

---

## .codebuddy/ - 核心配置目录

这是整个架构的核心，包含所有 Agent 定义、技能、自动化钩子和规则。

### .codebuddy/agents/ - Agent 定义（49 个文件）

**用途**: 定义 49 个专业 AI Agent 的行为、职责和协作协议。

**文件格式**: Markdown + YAML Frontmatter

**示例结构**:
```yaml
---
name: producer
description: "管理所有生产相关事务..."
tools: Read, Glob, Grep, Write, Edit, Bash, WebSearch
model: DeepSeek-V3.2
maxTurns: 30
memory: user
skills: [sprint-plan, scope-check, estimate, milestone-review]
---
```

**Agent 分类**:

| 类别 | Agent | 职责 |
|------|-------|------|
| **领导层** | `creative-director` | 高层创意决策、视觉风格冲突解决 |
| | `technical-director` | 架构决策、技术栈选择、性能策略 |
| | `producer` | 进度规划、里程碑跟踪、风险管理 |
| **设计** | `game-designer` | 机制、系统、进度、经济、平衡 |
| | `systems-designer` | 具体机制实现、公式设计 |
| | `level-designer` | 关卡布局、节奏、遭遇设计 |
| | `economy-designer` | 资源经济、战利品表、进度曲线 |
| **程序** | `lead-programmer` | 系统设计、代码审查、API 设计 |
| | `gameplay-programmer` | 功能实现、游戏系统代码 |
| | `engine-programmer` | 核心引擎、渲染、物理、内存管理 |
| | `ai-programmer` | 行为树、寻路、NPC 逻辑 |
| | `network-programmer` | 网络代码、复制、延迟补偿 |
| **艺术** | `art-director` | 风格指南、艺术圣经、资源标准 |
| | `technical-artist` | 着色器、VFX、优化、艺术管线工具 |
| **音频** | `audio-director` | 音乐方向、声音风格、音频实现策略 |
| | `sound-designer` | SFX 设计文档、音频事件列表 |
| **QA** | `qa-lead` | 测试策略、Bug 分类、发布准备 |
| | `qa-tester` | 编写测试用例、Bug 报告、测试清单 |
| **引擎专属** | `godot-specialist` | Godot 4 架构建议 |
| | `unity-specialist` | Unity 架构建议 |
| | `unreal-specialist` | Unreal Engine 5 架构建议 |
| | ... | 更多子专家（见完整列表） |

---

### .codebuddy/skills/ - 技能定义（72 个目录）

**用途**: 定义 72 个斜杠命令（/skills），每个目录是一个独立技能。

**文件格式**: 每个目录包含 `SKILL.md`

**技能分类**:

#### 入门与导航
| 技能 | 用途 |
|------|------|
| `/start` | 首次入门引导 |
| `/help` | 上下文感知帮助 |
| `/project-stage-detect` | 项目阶段检测 |
| `/setup-engine` | 引擎配置 |
| `/adopt` | 现有项目迁移 |

#### 游戏设计
| 技能 | 用途 |
|------|------|
| `/brainstorm` | 引导式创意构思 |
| `/map-systems` | 系统分解与依赖映射 |
| `/design-system` | 分节式 GDD 编写 |
| `/quick-design` | 轻量级设计规范 |
| `/review-all-gdds` | 跨 GDD 一致性审查 |
| `/propagate-design-change` | 设计变更传播 |

#### 架构
| 技能 | 用途 |
|------|------|
| `/create-architecture` | 主架构文档编写 |
| `/architecture-decision` | 创建 ADR |
| `/architecture-review` | ADR 审查 |
| `/create-control-manifest` | 生成程序员规则表 |

#### 故事与迭代
| 技能 | 用途 |
|------|------|
| `/create-epics` | 创建史诗任务 |
| `/create-stories` | 将史诗分解为故事 |
| `/dev-story` | 读取并实现故事 |
| `/sprint-plan` | 迭代规划 |
| `/sprint-status` | 迭代状态快照 |
| `/story-readiness` | 故事准备度检查 |
| `/story-done` | 故事完成审查 |
| `/estimate` | 工作量估算 |

#### 审查与分析
| 技能 | 用途 |
|------|------|
| `/design-review` | 设计文档审查 |
| `/code-review` | 代码架构审查 |
| `/balance-check` | 游戏平衡分析 |
| `/asset-audit` | 资源合规审查 |
| `/content-audit` | 内容实现审计 |
| `/scope-check` | 范围蔓延检测 |
| `/perf-profile` | 性能分析 |
| `/tech-debt` | 技术债务跟踪 |
| `/gate-check` | 阶段门检查 |
| `/consistency-check` | 跨文档一致性检查 |

#### QA 与测试
| 技能 | 用途 |
|------|------|
| `/qa-plan` | 生成 QA 测试计划 |
| `/smoke-check` | 冒烟测试 |
| `/soak-test` | 浸泡测试协议 |
| `/regression-suite` | 回归测试套件 |
| `/test-setup` | 测试框架搭建 |
| `/test-helpers` | 测试辅助库生成 |

#### 团队协调
| 技能 | 用途 |
|------|------|
| `/team-combat` | 战斗团队协调 |
| `/team-narrative` | 叙事团队协调 |
| `/team-ui` | UI 团队协调 |
| `/team-release` | 发布团队协调 |
| `/team-polish` | 打磨团队协调 |
| `/team-audio` | 音频团队协调 |
| `/team-level` | 关卡团队协调 |
| `/team-live-ops` | 运营团队协调 |
| `/team-qa` | QA 团队协调 |

---

### .codebuddy/hooks/ - 自动化钩子（12 个脚本）

**用途**: 在特定事件触发时自动执行的 Bash 脚本。

**配置位置**: `.codebuddy/settings.json`

| 钩子脚本 | 触发时机 | 功能 |
|----------|----------|------|
| `session-start.sh` | 会话开始 | 加载迭代上下文、里程碑、Git 活动 |
| `detect-gaps.sh` | 会话开始 | 检测新项目或缺失文档 |
| `pre-compact.sh` | 上下文压缩前 | 保存会话状态以便恢复 |
| `post-compact.sh` | 上下文压缩后 | 提醒恢复会话状态 |
| `session-stop.sh` | 会话结束 | 总结成果并更新日志 |
| `validate-commit.sh` | `git commit` 前 | 验证设计文档、JSON 数据 |
| `validate-push.sh` | `git push` 前 | 保护分支警告 |
| `validate-assets.sh` | 资源文件修改后 | 检查命名规范和 JSON 有效性 |
| `validate-skill-change.sh` | Skill 文件修改后 | 建议运行 `/skill-test` |
| `notify.sh` | 通知事件 | Windows 弹窗通知 |
| `log-agent.sh` | Agent 启动时 | 审计日志开始 |
| `log-agent-stop.sh` | Agent 停止时 | 审计日志结束 |

---

### .codebuddy/rules/ - 路径特定规则（11 个文件）

**用途**: 当编辑特定路径的文件时自动应用的规则。

| 规则文件 | 路径模式 | 强制规则 |
|----------|----------|----------|
| `gameplay-code.md` | `src/gameplay/**` | 数据驱动值、Delta 时间、无 UI 引用 |
| `engine-code.md` | `src/core/**` | 热路径零分配、线程安全、API 稳定性 |
| `ai-code.md` | `src/ai/**` | 性能预算、可调试性、数据驱动参数 |
| `network-code.md` | `src/networking/**` | 服务器权威、版本化消息、安全 |
| `ui-code.md` | `src/ui/**` | 无游戏状态所有权、本地化就绪、无障碍 |
| `design-docs.md` | `design/gdd/**` | 必需 8 个章节、公式格式、边界情况 |
| `narrative.md` | `design/narrative/**` | 传说一致性、角色声音、正典级别 |
| `data-files.md` | `assets/data/**` | JSON 有效性、命名规范、Schema 规则 |
| `test-standards.md` | `tests/**` | 测试命名、覆盖率要求、夹具模式 |
| `prototype-code.md` | `prototypes/**` | 宽松标准、必需 README、假设文档化 |
| `shader-code.md` | `assets/shaders/**` | 命名规范、性能目标、跨平台规则 |

---

### .codebuddy/docs/ - 架构文档

| 文件 | 内容 |
|------|------|
| `quick-start.md` | 快速入门指南 |
| `agent-roster.md` | Agent 名册与职责 |
| `skills-reference.md` | 技能参考 |
| `hooks-reference.md` | 钩子参考 |
| `rules-reference.md` | 规则参考 |
| `coding-standards.md` | 编码标准 |
| `coordination-rules.md` | 协调规则 |
| `context-management.md` | 上下文管理 |
| `directory-structure.md` | 目录结构 |
| `technical-preferences.md` | 技术偏好（由 `/setup-engine` 填充） |
| `templates/` | 38 个文档模板 |

---

### .codebuddy/settings.json - 项目设置

**用途**: CodeBuddy IDE 的项目级配置。

**主要内容**:
- `$schema`: CodeBuddy 设置 Schema
- `statusLine`: 状态栏命令
- `permissions`: 允许/拒绝的 Bash 命令
- `hooks`: 钩子配置

---

## src/ - 游戏源代码

**用途**: 游戏的核心源代码。

**建议子目录**:
```
src/
├── core/              # 核心系统（引擎扩展）
├── gameplay/          # 游戏玩法系统
├── ai/                # AI 系统
├── networking/        # 网络代码
├── ui/                # UI 系统
└── tools/             # 编辑器工具
```

---

## design/ - 游戏设计文档

**用途**: 所有游戏设计相关文档。

**建议子目录**:
```
design/
├── gdd/               # 游戏设计文档
├── narrative/         # 叙事设计（故事、角色、世界）
├── levels/            # 关卡设计
└── balance/           # 平衡数据
```

---

## docs/ - 技术文档

**用途**: 技术文档和参考材料。

**内容**:
- `engine-reference/` - 引擎 API 参考文档
- `Readme/` - 项目说明文档（本目录）
- `architecture/` - 架构文档
- `api/` - API 文档

---

## tests/ - 测试套件

**用途**: 自动化测试。

**建议子目录**:
```
tests/
├── unit/              # 单元测试
├── integration/       # 集成测试
├── performance/       # 性能测试
└── playtest/          # 游戏测试记录
```

---

## production/ - 生产管理

**用途**: 项目管理和生产追踪。

**建议子目录**:
```
production/
├── sprints/           # 迭代计划
├── milestones/        # 里程碑定义
├── bugs/              # Bug 跟踪
├── risks/             # 风险登记
└── session-state/     # 会话状态（gitignored）
```

---

## prototypes/ - 原型

**用途**: 可丢弃的原型，用于快速验证想法。

**规则**:
- 与 `src/` 隔离
- 每个原型有自己的 README
- 记录假设和结论

---

## graphify-out/ - 知识图谱

**用途**: graphify 生成的知识图谱输出。

**文件**:
- `graph.json` - 图谱数据
- `graph.html` - 交互式可视化
- `GRAPH_REPORT.md` - 关键节点报告

---

## 总结

| 目录 | 类型 | 用途 |
|------|------|------|
| `.codebuddy/` | 配置 | Agent、Skill、Hook、Rule 定义 |
| `src/` | 代码 | 游戏源代码 |
| `design/` | 设计 | 游戏设计文档 |
| `docs/` | 文档 | 技术文档和参考 |
| `tests/` | 测试 | 自动化测试 |
| `production/` | 管理 | 项目和生产管理 |
| `prototypes/` | 原型 | 可丢弃的原型 |
