# Cocos 平台提示词使用说明

本文档梳理在 CodeBuddy 框架中使用 Cocos Creator 引擎时的专属 Agent、Skill 和提示词特点。

---

## 一、专属 Agent 列表

| Agent | 文件路径 | 核心职责 |
|-------|----------|----------|
| `cocos-specialist` | `.codebuddy/agents/cocos-specialist.md` | Cocos Creator 引擎总专家，TypeScript/JavaScript、组件系统、渲染管线、跨平台发布 |
| `cocos_2d-expert` | `.codebuddy/agents/cocos_2d-expert.md` | 2D 渲染、精灵、文本、遮罩、UI 组件 |
| `cocos_3d-expert` | `.codebuddy/agents/cocos_3d-expert.md` | 3D 网格渲染、蒙皮网格、模型加载与管理 |
| `cocos_animation-expert` | `.codebuddy/agents/cocos_animation-expert.md` | 动画剪辑、骨骼动画、动画状态机、动画混合 |
| `cocos_core-expert` | `.codebuddy/agents/cocos_core-expert.md` | 组件、节点、场景图、生命周期、事件系统、对象池 |
| `cocos_gfx-expert` | `.codebuddy/agents/cocos_gfx-expert.md` | 着色器、GPU 缓冲区/纹理、自定义渲染管线、图形后端适配 |
| `cocos_physics-expert` | `.codebuddy/agents/cocos_physics-expert.md` | 3D 刚体、碰撞体、射线检测、物理模拟 |
| `cocos_physics-2d-expert` | `.codebuddy/agents/cocos_physics-2d-expert.md` | 2D 刚体、碰撞检测、Box2D 集成 |
| `cocos_rendering-expert` | `.codebuddy/agents/cocos_rendering-expert.md` | 渲染管线、相机、光照、阴影、后处理、Draw Call 优化 |

### Agent 协作关系

```
technical-director
  └── lead-programmer
        └── cocos-specialist
              ├── cocos_core-expert
              ├── cocos_2d-expert
              ├── cocos_3d-expert
              ├── cocos_animation-expert
              ├── cocos_rendering-expert
              ├── cocos_gfx-expert
              ├── cocos_physics-expert
              └── cocos_physics-2d-expert
```

---

## 二、专属 Skill 列表

Cocos 本身没有独占的 Skill（Skill 是跨引擎的），但以下 Skill 在 Cocos 项目中有特殊用法：

| Skill | Cocos 项目中的特殊注意点 |
|-------|--------------------------|
| `/setup-engine` | 检测 Cocos Creator 版本，填充 `docs/engine-reference/cocos/` 目录 |
| `/dev-story` | 路由到 `cocos-specialist` 或相关子专家 |
| `/test-setup` | 使用 Cocos 的测试框架或 Jest（TypeScript 项目） |
| `/asset-audit` | 检查 SpriteAtlas、纹理压缩、模型 LOD、音频格式 |

---

## 三、引擎参考文档路径

| 文档 | 路径 | 用途 |
|------|------|------|
| 版本说明 | `docs/engine-reference/cocos/VERSION.md` | 确认 Cocos Creator 版本 |
| 废弃 API | `docs/engine-reference/cocos/deprecated-apis.md` | 避免已废弃的 API |
| 破坏性变更 | `docs/engine-reference/cocos/breaking-changes.md` | 版本升级兼容性 |
| 模块文档 | `docs/engine-reference/cocos/modules/*.md` | 子系统参考（2D、3D、动画、物理、渲染） |

---

## 四、提示词使用特点

### 4.1 语言选择

Cocos Creator 主要支持 TypeScript 和 JavaScript：

| 场景 | 推荐语言 | 说明 |
|------|----------|------|
| 商业项目、中大型团队 | TypeScript | 静态类型、更好的 IDE 支持、可维护性高 |
| 快速原型、教学 | JavaScript | 上手快，但缺乏类型安全 |

Agent 默认推荐 TypeScript，并强制使用类型注解。

### 4.2 核心架构模式

- **组件化**：所有功能通过组件挂载到 Node 上，如 `Sprite`、`Label`、`RigidBody`
- **场景树**：使用场景（Scene）组织节点层次，通过 `cc.director` 管理场景切换
- **资源系统**：使用 `AssetManager` 加载资源，支持 Bundle 分包和远程加载
- **事件系统**：使用 `Node.on/off/emit` 进行节点级事件，或自定义事件总线

### 4.3 常见代码审查点

- 是否使用 `Prefab` 复用场景元素（避免手动重复创建）
- 是否正确使用 `cc.assetManager` 释放资源（避免内存泄漏）
- UI 节点是否使用 `Widget` 组件进行多分辨率适配
- 动画是否使用 `Animation` 组件或 `Tween` 系统（避免在 `update` 中手动插值）
- 物理碰撞回调是否及时注销（避免节点销毁后回调报错）

---

## 五、2D vs 3D 项目差异

| 维度 | 2D 项目 | 3D 项目 |
|------|---------|---------|
| 核心 Agent | `cocos_2d-expert` | `cocos_3d-expert` |
| 渲染优化 | SpriteAtlas、自动合批 | LOD、Occlusion Culling、多光源管理 |
| 物理 | `cocos_physics-2d-expert`（Box2D） | `cocos_physics-expert`（Bullet/Cannon） |
| UI | Canvas + Widget | 3D UI 或屏幕空间 Canvas |
| 典型游戏 | 平台、益智、卡牌、SLG | FPS、TPS、开放世界（轻量） |

---

## 六、最佳实践

1. **Draw Call 优化**：使用 SpriteAtlas 合批、减少 Mask 和剪裁、避免频繁修改节点层级
2. **对象池**：使用 `cc.NodePool` 管理频繁创建销毁的节点（子弹、敌人、特效）
3. **资源分包**：使用 Asset Bundle 将资源按场景/功能分包，减少首包大小
4. **纹理压缩**：针对不同平台使用 PVRTC（iOS）、ETC（Android）、ASTC（高端设备）
5. **性能监控**：使用 Cocos 内置 Profiler 和 Chrome DevTools 分析性能瓶颈

---

## 七、常见问题

**Q: Cocos Creator 3.x 与 2.x 的 Skill 有区别吗？**
A: 有。3.x 的 3D 能力大幅增强，组件 API 有变化。Agent 会根据 `VERSION.md` 确认版本后使用对应 API。

**Q: Cocos 项目发布到微信小游戏需要注意什么？**
A: 除了 Cocos 本身的优化，还需关注微信平台的包体限制、启动性能、安全域适配。`wechat-specialist` 会协助处理平台特定问题。

**Q: FairyGUI 在 Cocos 中如何使用？**
A: FairyGUI 是跨平台 UI 编辑器，可导出 Cocos 项目。`cocos-specialist` 和 `wechat-ui-specialist` 都可协助集成 FairyGUI。
