# Godot 平台提示词使用说明

本文档梳理在 CodeBuddy 框架中使用 Godot 引擎时的专属 Agent、Skill 和提示词特点。

---

## 一、专属 Agent 列表

| Agent | 文件路径 | 核心职责 |
|-------|----------|----------|
| `godot-specialist` | `.codebuddy/agents/godot-specialist.md` | Godot 引擎总专家，负责语言选择、节点/场景架构、信号与资源管理、导出配置 |
| `godot-gdscript-specialist` | `.codebuddy/agents/godot-gdscript-specialist.md` | GDScript 架构、静态类型、信号、协程 |
| `godot-csharp-specialist` | `.codebuddy/agents/godot-csharp-specialist.md` | Godot C# 集成、.NET 特性、性能优化 |
| `godot-gdextension-specialist` | `.codebuddy/agents/godot-gdextension-specialist.md` | C++/Rust 原生绑定、GDExtension 模块、自定义节点 |
| `godot-shader-specialist` | `.codebuddy/agents/godot-shader-specialist.md` | Godot 着色语言、视觉着色器、粒子系统 |

### Agent 协作关系

```
technical-director
  └── lead-programmer
        └── godot-specialist
              ├── godot-gdscript-specialist
              ├── godot-csharp-specialist
              ├── godot-gdextension-specialist
              └── godot-shader-specialist
```

---

## 二、专属 Skill 列表

Godot 本身没有独占的 Skill（Skill 是跨引擎的），但以下 Skill 在 Godot 项目中有特殊用法：

| Skill | Godot 项目中的特殊注意点 |
|-------|--------------------------|
| `/setup-engine` | 会检测 Godot 版本，填充 `docs/engine-reference/godot/` 目录 |
| `/dev-story` | 路由到 `godot-specialist` 或 `godot-gdscript-specialist` |
| `/test-setup` | 使用 Godot 内置测试框架（GUT 或内置单元测试） |
| `/prototype` | 使用 Godot 的场景系统快速搭建原型 |
| `/code-review` | 检查 GDScript 静态类型、信号连接、节点引用方式 |

---

## 三、引擎参考文档路径

| 文档 | 路径 | 用途 |
|------|------|------|
| 版本说明 | `docs/engine-reference/godot/VERSION.md` | 确认当前项目锁定的 Godot 版本 |
| 废弃 API | `docs/engine-reference/godot/deprecated-apis.md` | 避免使用已废弃的 API |
| 破坏性变更 | `docs/engine-reference/godot/breaking-changes.md` | 版本升级时的兼容性检查 |
| 模块文档 | `docs/engine-reference/godot/modules/*.md` | 子系统参考（渲染、物理、音频等） |

**重要**：`godot-specialist` 在实施前必须阅读以上参考文档，优先使用参考文档中的 API 而非训练数据。

---

## 四、提示词使用特点

### 4.1 语言选择决策

Godot 支持三种开发语言，Agent 会根据场景推荐：

| 场景 | 推荐语言 | 负责 Agent |
|------|----------|------------|
| 快速原型、小团队 | GDScript | `godot-gdscript-specialist` |
| 大型项目、需要 .NET 生态 | C# | `godot-csharp-specialist` |
| 性能瓶颈、原生库集成 | GDExtension (C++/Rust) | `godot-gdextension-specialist` |

### 4.2 核心架构模式

Godot 的提示词工程强调以下模式，Agent 会在代码审查中强制执行：

- **组合优于继承**：通过子节点附加行为，避免深层类继承
- **场景自包含**：每个场景应有清晰职责，避免对父节点的隐式依赖
- **@onready 引用**：使用 `@onready` 获取节点引用，禁止硬编码长路径
- **信号解耦**：优先使用信号而非直接方法调用
- **Resource 数据驱动**：使用 `Resource` 子类保存共享数据（.tres 文件）

### 4.3 常见代码审查点

当 `godot-specialist` 或子专家审查代码时，重点关注：

- 是否使用静态类型（`var health: int = 100`）
- 信号是否在 `_ready()` 中连接（禁止在 `_process()` 中连接）
- 是否使用对象池（频繁实例化的场景如子弹、粒子）
- 是否最小化 `_process()` 和 `_physics_process()`（空闲时 `set_process(false)`）
- 自动加载（Autoload）是否仅用于真正全局的系统

---

## 五、最佳实践

1. **版本锁定**：在 `technical-preferences.md` 中明确 Godot 版本，所有 Agent 实施前检查 `VERSION.md`
2. **场景树浅层化**：保持场景树扁平，深层嵌套会导致性能和可读性问题
3. **资源 UID**：使用资源 UID 稳定引用，避免重命名导致路径断裂
4. **信号总线**：对全局事件使用自动加载的信号总线（Signal Bus），减少直接耦合
5. **性能分析**：使用 Godot 内置分析器验证性能预算，不要仅凭直觉优化

---

## 六、常见问题

**Q: Godot 4 的 GDScript 与 Godot 3 的 yield 有何区别？**
A: Godot 4 使用 `await` 处理异步操作（信号、定时器、Tween），`yield` 是 Godot 3 的模式，Agent 会强制要求使用 `await`。

**Q: 如何判断该用 GDScript 还是 C#？**
A: 向 `godot-specialist` 描述你的场景（团队规模、性能需求、.NET 依赖），它会给出建议并解释 trade-off。

**Q: Shader 应该找哪个 Agent？**
A: `godot-shader-specialist` 负责 Godot 着色语言和视觉着色器。如需与美术协作，`technical-artist` 也会参与。
