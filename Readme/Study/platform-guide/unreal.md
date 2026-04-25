# Unreal 平台提示词使用说明

本文档梳理在 CodeBuddy 框架中使用 Unreal Engine 时的专属 Agent、Skill 和提示词特点。

---

## 一、专属 Agent 列表

| Agent | 文件路径 | 核心职责 |
|-------|----------|----------|
| `unreal-specialist` | `.codebuddy/agents/unreal-specialist.md` | Unreal 引擎总专家，Blueprint/C++ 决策、UObject 架构、渲染管线 |
| `ue-blueprint-specialist` | `.codebuddy/agents/ue-blueprint-specialist.md` | Blueprint 可视化脚本、蓝图通信、蓝图优化 |
| `ue-gas-specialist` | `.codebuddy/agents/ue-gas-specialist.md` | Gameplay Ability System、Gameplay Tags、Attribute Sets |
| `ue-replication-specialist` | `.codebuddy/agents/ue-replication-specialist.md` | 网络复制、RPC、Dedicated Server |
| `ue-umg-specialist` | `.codebuddy/agents/ue-umg-specialist.md` | UMG UI 框架、蓝图绑定、动态 UI |

### Agent 协作关系

```
technical-director
  └── lead-programmer
        └── unreal-specialist
              ├── ue-blueprint-specialist
              ├── ue-gas-specialist
              ├── ue-replication-specialist
              └── ue-umg-specialist
```

---

## 二、专属 Skill 列表

| Skill | Unreal 项目中的特殊注意点 |
|-------|--------------------------|
| `/setup-engine` | 检测 Unreal 版本，填充 `docs/engine-reference/unreal/` 目录 |
| `/dev-story` | 路由到 `unreal-specialist` 或相关子专家 |
| `/test-setup` | 使用 Unreal Automation Tool（UAT）和内置测试框架 |

---

## 三、引擎参考文档路径

| 文档 | 路径 | 用途 |
|------|------|------|
| 版本说明 | `docs/engine-reference/unreal/VERSION.md` | 确认 Unreal 版本和插件清单 |
| 废弃 API | `docs/engine-reference/unreal/deprecated-apis.md` | 避免已废弃的 API |
| 破坏性变更 | `docs/engine-reference/unreal/breaking-changes.md` | 版本升级兼容性 |

---

## 四、提示词使用特点

### 4.1 Blueprint vs C++ 决策

Unreal 的核心决策之一是 Blueprint 和 C++ 的分配：

| 场景 | 推荐 | 负责 Agent |
|------|------|------------|
| 快速迭代、设计师主导 | Blueprint | `ue-blueprint-specialist` |
| 性能敏感、底层系统 | C++ | `unreal-specialist` |
| 复杂Gameplay逻辑 | Blueprint + C++ 混合 | `unreal-specialist` + `ue-blueprint-specialist` |

### 4.2 核心架构模式

- **UObject 生命周期**：理解 UObject 的垃圾回收、引用链和弱引用
- **GAS 能力系统**：RPG/MOBA 类游戏优先使用 GAS，`ue-gas-specialist` 负责 Ability、Attribute、Tag 设计
- **Replication**：多人游戏必须考虑网络复制，`ue-replication-specialist` 负责 RPC、Property Replication、Server/Client 边界
- **UMG 数据绑定**：使用蓝图绑定或 C++ 委托，避免每帧手动更新 UI

### 4.3 常见代码审查点

- Blueprint 中是否有性能热点（如每帧执行的蓝图节点）
- C++ 中是否正确使用 `UFUNCTION`、`UPROPERTY` 宏
- GAS 中 Attribute 修改是否通过 Gameplay Effect 而非直接设置
- 网络代码中 Server/Client 边界是否清晰，RPC 是否经过验证
- UMG 中是否使用 Invalidation Box 优化复杂 UI

---

## 五、最佳实践

1. **模块划分**：使用 Unreal 的 Plugin/Module 系统隔离功能，降低编译依赖
2. **Asset 命名规范**：严格遵循 `BP_`、`SK_`、`T_`、`M_` 等前缀约定
3. **GAS 调试**：使用 `showdebug abilitysystem` 控制台命令调试 Ability
4. **网络模拟**：使用 `Network Emulation` 测试高延迟/丢包场景
5. **Cook 优化**：合理设置 Asset 的 Cook 规则，减少包体大小

---

## 六、常见问题

**Q: 纯 Blueprint 项目能发布吗？**
A: 可以，但部分平台（如某些主机）和性能敏感模块需要 C++。Agent 会根据目标平台建议。

**Q: GAS 是否必须用于所有游戏类型？**
A: 不是。GAS 最适合技能/属性复杂的游戏（RPG、MOBA）。简单游戏使用普通蓝图/C++ 更轻量。

**Q: Dedicated Server 和 Listen Server 如何选择？**
A: 竞技类游戏优先 Dedicated Server（公平性）；合作/休闲游戏可用 Listen Server（成本低）。
