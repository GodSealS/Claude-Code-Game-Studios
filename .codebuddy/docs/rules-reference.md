# Path-Specific Rules / 路径特定规则

Rules in `.codebuddy/rules/` are automatically enforced when editing files in matching paths:

> **中文翻译**：`.codebuddy/rules/` 中的规则在编辑匹配路径的文件时自动执行：

| Rule File | Path Pattern | Enforces |
| ---- | ---- | ---- |
| `gameplay-code.md` | `src/gameplay/**` | Data-driven values, delta time, no UI references |
| `engine-code.md` | `src/core/**` | Zero allocs in hot paths, thread safety, API stability |
| `ai-code.md` | `src/ai/**` | Performance budgets, debuggability, data-driven params |
| `network-code.md` | `src/networking/**` | Server-authoritative, versioned messages, security |
| `ui-code.md` | `src/ui/**` | No game state ownership, localization-ready, accessibility |
| `design-docs.md` | `design/gdd/**` | Required 8 sections, formula format, edge cases |
| `narrative.md` | `design/narrative/**` | Lore consistency, character voice, canon levels |
| `data-files.md` | `assets/data/**` | JSON validity, naming conventions, schema rules |
| `test-standards.md` | `tests/**` | Test naming, coverage requirements, fixture patterns |
| `prototype-code.md` | `prototypes/**` | Relaxed standards, README required, hypothesis documented |
| `shader-code.md` | `assets/shaders/**` | Naming conventions, performance targets, cross-platform rules |

> **中文翻译**：

| 规则文件 | 路径模式 | 强制执行 |
| ---- | ---- | ---- |
| `gameplay-code.md` | `src/gameplay/**` | 数据驱动值、delta时间、无UI引用 |
| `engine-code.md` | `src/core/**` | 热路径零分配、线程安全、API稳定性 |
| `ai-code.md` | `src/ai/**` | 性能预算、可调试性、数据驱动参数 |
| `network-code.md` | `src/networking/**` | 服务器权威、版本化消息、安全 |
| `ui-code.md` | `src/ui/**` | 无游戏状态所有权、本地化就绪、无障碍 |
| `design-docs.md` | `design/gdd/**` | 必需8个章节、公式格式、边界情况 |
| `narrative.md` | `design/narrative/**` | 背景一致性、角色语调、正典层级 |
| `data-files.md` | `assets/data/**` | JSON有效性、命名约定、模式规则 |
| `test-standards.md` | `tests/**` | 测试命名、覆盖率要求、夹具模式 |
| `prototype-code.md` | `prototypes/**` | 宽松标准、需要README、假设需文档化 |
| `shader-code.md` | `assets/shaders/**` | 命名约定、性能目标、跨平台规则 |
