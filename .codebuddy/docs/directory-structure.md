# Directory Structure / 目录结构

```text
/
├── CLAUDE.md                    # Master configuration / 主配置
├── .codebuddy/                     # Agent definitions, skills, hooks, rules, docs / 代理定义、技能、钩子、规则、文档
├── src/                         # Game source code (core, gameplay, ai, networking, ui, tools) / 游戏源代码（核心、游戏逻辑、AI、网络、UI、工具）
├── assets/                      # Game assets (art, audio, vfx, shaders, data) / 游戏资产（美术、音频、特效、着色器、数据）
├── design/                      # Game design documents (gdd, narrative, levels, balance) / 游戏设计文档（GDD、叙事、关卡、平衡）
├── docs/                        # Technical documentation (architecture, api, postmortems) / 技术文档（架构、API、事后分析）
│   └── engine-reference/        # Curated engine API snapshots (version-pinned) / 精选引擎API快照（版本锁定）
├── tests/                       # Test suites (unit, integration, performance, playtest) / 测试套件（单元、集成、性能、试玩）
├── tools/                       # Build and pipeline tools (ci, build, asset-pipeline) / 构建和管线工具（CI、构建、资产管线）
├── prototypes/                  # Throwaway prototypes (isolated from src/) / 一次性原型（与src/隔离）
└── production/                  # Production management (sprints, milestones, releases) / 制作管理（冲刺、里程碑、发布）
    ├── session-state/           # Ephemeral session state (active.md — gitignored) / 临时会话状态（active.md — gitignored）
    └── session-logs/            # Session audit trail (gitignored) / 会话审计追踪（gitignored）
```
