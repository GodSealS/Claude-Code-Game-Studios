# Directory Structure / 目录结构

```text
/
├── CLAUDE.md                    # Master configuration / 主配置
├── .codebuddy/                     # Agent definitions, skills, hooks, rules, docs / 代理定义、技能、钩子、规则、文档
├── src/                         # Game source code (core, gameplay, ai, networking, ui, tools) / 游戏源代码
├── assets/                      # Game assets (art, audio, vfx, shaders, data) / 游戏资源
├── design/                      # Game design documents (gdd, narrative, levels, balance) / 游戏设计文档
├── docs/                        # Technical documentation (architecture, api, postmortems) / 技术文档
│   └── engine-reference/        # Curated engine API snapshots (version-pinned) / 引擎API快照
├── tests/                       # Test suites (unit, integration, performance, playtest) / 测试套件
├── tools/                       # Build and pipeline tools (ci, build, asset-pipeline) / 构建和管线工具
├── prototypes/                  # Throwaway prototypes (isolated from src/) / 可丢弃原型
└── production/                  # Production management (sprints, milestones, releases) / 生产管理
    ├── session-state/           # Ephemeral session state (active.md — gitignored) / 临时会话状态
    └── session-logs/            # Session audit trail (gitignored) / 会话审计跟踪
```
