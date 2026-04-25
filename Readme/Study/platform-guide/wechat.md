# 微信小游戏平台提示词使用说明

本文档梳理在 CodeBuddy 框架中使用微信小游戏（WeChat Mini Game）时的专属 Agent、Skill 和提示词特点。

---

## 一、专属 Agent 列表

| Agent | 文件路径 | 核心职责 |
|-------|----------|----------|
| `wechat-specialist` | `.codebuddy/agents/wechat-specialist.md` | 微信小游戏总专家，平台适配、性能优化、审核规范、云开发 |
| `wechat-minigame-specialist` | `.codebuddy/agents/wechat-minigame-specialist.md` | 小游戏框架、Canvas 渲染、包体控制、启动优化 |
| `wechat-cloudbase-specialist` | `.codebuddy/agents/wechat-cloudbase-specialist.md` | 云开发（云函数、数据库、存储、静态托管） |
| `wechat-shader-specialist` | `.codebuddy/agents/wechat-shader-specialist.md` | WebGL 着色器、GLSL、移动端 GPU 优化 |
| `wechat-ui-specialist` | `.codebuddy/agents/wechat-ui-specialist.md` | 小游戏 UI 适配、FairyGUI、屏幕管理、安全域 |

### Agent 协作关系

```
technical-director
  └── lead-programmer
        └── wechat-specialist
              ├── wechat-minigame-specialist
              ├── wechat-cloudbase-specialist
              ├── wechat-shader-specialist
              └── wechat-ui-specialist
```

---

## 二、专属 Skill 列表

| Skill | 文件路径 | 功能 |
|-------|----------|------|
| `/setup-wechat-minigame` | `setup-wechat-minigame/SKILL.md` | 初始化微信小游戏项目，含平台配置、脚手架代码、目录结构 |
| `/wechat-shader` | `wechat-shader/SKILL.md` | 初始化 WebGL 着色器管线，转换 Unity/Unreal/Godot 着色器到 WebGL GLSL |
| `/wechat-ui-design` | `wechat-ui-design/SKILL.md` | 使用 FairyGUI 设计 UI，生成自适应布局和数据绑定 |
| `/wechat-build` | `wechat-build/SKILL.md` | 微信小游戏构建流程，包体优化、代码压缩、资源分包 |
| `/wechat-physics-box2d` | `wechat-physics-box2d/SKILL.md` | 初始化 Box2D WASM 2D 物理引擎 |
| `/wechat-physics-bullet` | `wechat-physics-bullet/SKILL.md` | 初始化 Bullet (ammo.js) WASM 3D 物理引擎 |
| `/wechat-physics-jolt` | `wechat-physics-jolt/SKILL.md` | 初始化 JoltPhysics WASM 高性能 3D 物理引擎 |

---

## 三、引擎参考文档路径

| 文档 | 路径 | 用途 |
|------|------|------|
| 平台规范 | `docs/engine-reference/wechat/platform-spec.md` | 微信小游戏官方技术规范 |
| 性能预算 | `docs/engine-reference/wechat/performance-budget.md` | 包体大小、内存、帧率预算 |
| API 限制 | `docs/engine-reference/wechat/api-restrictions.md` | 受限 API 和替代方案 |

---

## 四、提示词使用特点

### 4.1 平台约束

微信小游戏有严格的平台约束，Agent 会在所有决策中优先考虑：

- **包体限制**：主包通常限制 4MB（可分包到 20MB+），Agent 会强制进行资源压缩和分包策略
- **内存限制**：iOS 小游戏内存敏感，Agent 会建议对象池、纹理压缩、动态加载
- **启动时间**：首屏加载必须快，Agent 会优先推荐异步加载和分包加载
- **Canvas 渲染**：2D 游戏使用 Canvas/WebGL，3D 使用 WebGL，Agent 会根据复杂度推荐

### 4.2 云开发集成

微信云开发（CloudBase）是小游戏后端的重要选项：

- **云函数**：无需自建服务器，Agent 会建议将逻辑简单的后端放在云函数
- **数据库**：使用 JSON 文档数据库，`wechat-cloudbase-specialist` 负责数据模型设计
- **存储**：用于用户生成内容（UGC）和动态资源更新
- **静态托管**：用于 H5 活动页或资源 CDN

### 4.3 物理引擎选择

微信小游戏支持三种 WASM 物理引擎：

| 引擎 | 维度 | 特点 | Skill |
|------|------|------|-------|
| Box2D | 2D | 轻量、成熟、适合平台/益智游戏 | `/wechat-physics-box2d` |
| Bullet | 3D | 功能全面、支持软体 | `/wechat-physics-bullet` |
| Jolt | 3D | 高性能、确定性、内置角色控制器 | `/wechat-physics-jolt` |

Agent 会根据游戏类型推荐合适的物理引擎。

---

## 五、最佳实践

1. **包体控制**：使用纹理压缩（PVRTC/ETC/ASTC）、音频压缩、代码 Tree-Shaking
2. **分包策略**：将非首屏资源放入分包，使用 `wx.loadSubpackage` 动态加载
3. **帧率稳定**：目标 60fps，复杂场景降质保帧，使用 `requestAnimationFrame`
4. **适配方案**：使用 `wx.getSystemInfoSync` 获取屏幕信息，动态计算安全域
5. **审核预检**：发布前检查内容安全、用户隐私协议、虚拟支付合规性

---

## 六、常见问题

**Q: 微信小游戏能使用 Cocos 还是只能原生开发？**
A: 微信小游戏可以使用 Cocos Creator、Unity（WebGL 导出）、原生 Canvas/WebGL 等多种方案。Agent 会根据项目需求推荐。

**Q: 云开发和自建服务器如何选择？**
A: 快速迭代、中小型项目优先云开发；需要复杂后端逻辑、实时对战建议自建服务器 + 长连接。

**Q: 着色器如何从 Unity/Godot 转换到微信小游戏？**
A: 使用 `/wechat-shader` Skill，Agent 会自动将 HLSL/Godot Shader Language 转换为 WebGL GLSL，并针对移动端优化。
