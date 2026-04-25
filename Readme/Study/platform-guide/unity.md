# Unity 平台提示词使用说明

本文档梳理在 CodeBuddy 框架中使用 Unity 引擎时的专属 Agent、Skill 和提示词特点。

---

## 一、专属 Agent 列表

| Agent | 文件路径 | 核心职责 |
|-------|----------|----------|
| `unity-specialist` | `.codebuddy/agents/unity-specialist.md` | Unity 引擎总专家，C# 脚本、MonoBehaviour/ScriptableObject 架构、资源管理 |
| `unity-dots-specialist` | `.codebuddy/agents/unity-dots-specialist.md` | DOTS 架构、ECS、Job System、Burst Compiler |
| `unity-addressables-specialist` | `.codebuddy/agents/unity-addressables-specialist.md` | 可寻址资源系统、动态加载、热更新 |
| `unity-shader-specialist` | `.codebuddy/agents/unity-shader-specialist.md` | Shader Graph、HLSL、URP/HDRP 着色器 |
| `unity-ui-specialist` | `.codebuddy/agents/unity-ui-specialist.md` | UGUI、UI Toolkit、自适应布局 |

### Agent 协作关系

```
technical-director
  └── lead-programmer
        └── unity-specialist
              ├── unity-dots-specialist
              ├── unity-addressables-specialist
              ├── unity-shader-specialist
              └── unity-ui-specialist
```

---

## 二、专属 Skill 列表

| Skill | Unity 项目中的特殊注意点 |
|-------|--------------------------|
| `/setup-engine` | 检测 Unity 版本，填充 `docs/engine-reference/unity/` 目录 |
| `/dev-story` | 路由到 `unity-specialist` 或相关子专家 |
| `/test-setup` | 使用 Unity Test Framework（UTF） |
| `/asset-audit` | 检查 Addressables 分组、资源依赖、AssetBundle 配置 |

---

## 三、引擎参考文档路径

| 文档 | 路径 | 用途 |
|------|------|------|
| 版本说明 | `docs/engine-reference/unity/VERSION.md` | 确认 Unity 版本和渲染管线（URP/HDRP/Built-in） |
| 废弃 API | `docs/engine-reference/unity/deprecated-apis.md` | 避免已废弃的 API |
| 破坏性变更 | `docs/engine-reference/unity/breaking-changes.md` | 版本升级兼容性 |

---

## 四、提示词使用特点

### 4.1 架构模式

Unity 的提示词工程强调以下模式：

- **MonoBehaviour 节制**：避免过度使用 MonoBehaviour，对纯数据逻辑使用 ScriptableObject 或普通 C# 类
- **DOTS 适用场景**：大规模实体模拟（如万人同屏）时，`unity-dots-specialist` 会推荐 ECS + Job System
- **Addressables 资源管理**：中大型项目必须使用 Addressables，`unity-addressables-specialist` 负责分组策略和加载优化
- **渲染管线选择**：URP（通用）、HDRP（高端）、Built-in（兼容），Agent 会根据目标平台推荐

### 4.2 常见代码审查点

- 是否在 `Update()` 中进行大量计算（应移到 Job System 或协程）
- 是否使用 `GetComponent` 缓存（避免每帧调用）
- 资源加载是否使用 Addressables（禁止直接 `Resources.Load` 在新项目中）
- UI 是否使用 UI Toolkit 或 UGUI 的最佳实践
- Shader 是否考虑平台差异（移动端精度、Shader Variant）

---

## 五、最佳实践

1. **C# 规范**：遵循微软 C# 编码规范，结合 Unity 特定约定（如 `PascalCase` 公共字段）
2. **序列化安全**：使用 `[SerializeField]` 而非公共字段暴露编辑器属性
3. **对象池**：使用 Unity 的 Object Pooling API 或自定义池，避免运行时实例化 GC 压力
4. **Burst 编译**：DOTS 项目中，确保 Job 标记 `[BurstCompile]` 以获取原生性能
5. **Profiler 验证**：使用 Unity Profiler 和 Frame Debugger 验证性能，不凭直觉优化

---

## 六、常见问题

**Q: 何时使用 DOTS？**
A: 需要处理大量实体（>1000 个动态对象）或复杂模拟时。小规模项目使用传统 MonoBehaviour 更简单。

**Q: Addressables 和 AssetBundle 的区别？**
A: Addressables 是 AssetBundle 的高级封装，提供更易用的 API 和依赖管理。新项目优先使用 Addressables。

**Q: UI Toolkit 能完全替代 UGUI 吗？**
A: 目前 UI Toolkit 在运行时 UI 上已较成熟，但部分复杂交互和第三方插件仍依赖 UGUI。Agent 会根据具体需求推荐。
