# Cocos Creator 引擎使用指南

> 如何激活和使用新增的 Cocos Creator 引擎提示词、代理与技能。

本指南介绍如何将 Cocos Creator 作为项目游戏引擎，并通过相应的专家代理（Agents）和技能（Skills）进行高效开发。

---

## 1. 简介

Cocos Creator 是一套完整的跨平台游戏开发工具链，包含编辑器、组件系统、2D/3D 渲染、动画、物理、UI 等完整模块。项目现已集成以下 Cocos Creator 专用资源：

- **引擎总协调员**：`cocos‑specialist`
- **8 位子系统专家**：2D 渲染、3D 渲染、动画、核心引擎、图形 API、3D 物理、2D 物理、渲染管线
- **8 项专业技能**：对应上述各领域的知识库与最佳实践

这些资源已完全嵌入当前的 48‑Agent 协作架构，与 Unity、Unreal、Godot 等引擎专家平级，可无缝用于实际的游戏开发任务。

---

## 2. 选择 Cocos Creator 作为项目引擎

在项目启动或技术栈确认阶段，请在 `CODEBUDDY.md` 的 **Technology Stack** 部分明确选择 Cocos Creator：

```markdown
- **Engine**: [CHOOSE: Godot 4 / Unity / Unreal Engine 5 / Cocos Creator]
```

> **注意**：引擎专家代理（包括 `cocos‑specialist` 及其子专家）已全部就绪。请使用与所选引擎匹配的专家集合。

---

## 3. 可用代理概览

完整的代理清单见 `.codebuddy/docs/agent-roster.md`。Cocos Creator 相关的代理如下：

### 3.1 引擎总协调员（Engine Lead）

| Agent | Engine | Model | 何时使用 |
|-------|--------|-------|----------|
| `cocos‑specialist` | Cocos Creator | DeepSeek‑V3.2 | 组件系统、场景图、渲染管线、Cocos 性能优化、整体架构决策 |

### 3.2 子系统专家（Sub‑Specialists）

| Agent | 子系统 | Model | 何时使用 |
|-------|--------|-------|----------|
| `cocos_2d‑expert` | 2D 渲染 | DeepSeek‑V3.2 | 精灵、UI 组件、2D 图形、文本渲染、遮罩效果 |
| `cocos_3d‑expert` | 3D 渲染 | DeepSeek‑V3.2 | 网格渲染、蒙皮动画、模型管理、LOD |
| `cocos_animation‑expert` | 动画系统 | DeepSeek‑V3.2 | 动画剪辑、骨骼动画、状态机、混合 |
| `cocos_core‑expert` | 核心引擎 | DeepSeek‑V3.2 | 组件系统、场景图、生命周期管理、事件系统 |
| `cocos_gfx‑expert` | 图形 API | DeepSeek‑V3.2 | 着色器、GPU 资源、跨平台后端、渲染管线 |
| `cocos_physics‑expert` | 3D 物理 | DeepSeek‑V3.2 | 刚体、碰撞检测、射线投射、关节 |
| `cocos_physics‑2d‑expert` | 2D 物理 | DeepSeek‑V3.2 | Box2D 集成、2D 碰撞检测、物理事件 |
| `cocos_rendering‑expert` | 渲染管线 | DeepSeek‑V3.2 | 相机系统、光照、阴影、后处理、优化 |

所有子专家均向 `cocos‑specialist` 汇报，并与其他部门专家（如 `gameplay‑programmer`、`technical‑artist`）协调工作。

---

## 4. 激活与调用方法

### 4.1 使用 Task 工具调用引擎总协调员

当任务涉及 Cocos Creator 整体架构、模块选择、渲染管线配置等全局决策时，直接调用 `cocos‑specialist`：

```typescript
// 示例：请求 Cocos 专家规划 UI 系统的组件架构
Task(
  subagent_name: "cocos-specialist",
  description: "规划 UI 组件架构",
  prompt: "我们需要为游戏设计一个可复用的 UI 组件系统，要求支持多分辨率适配、数据绑定和动画过渡。请提出基于 Cocos Creator 的组件架构方案，并说明与核心引擎、2D 渲染子专家的协作方式。"
)
```

### 4.2 使用 Task 工具调用子系统专家

当任务明确属于某个子系统时，可绕过总协调员直接调用对应的子专家：

```typescript
// 示例：请求 2D 渲染专家实现一个精灵动画系统
Task(
  subagent_name: "cocos_2d-expert",
  description: "实现精灵动画",
  prompt: "请基于 Cocos Creator 的 Sprite 组件和 SpriteAtlas 资源，实现一个支持帧动画、循环播放、事件回调的精灵动画系统。要求代码符合项目 TypeScript 标准，并优化 Draw Call。"
)

// 示例：请求动画专家配置角色骨骼动画状态机
Task(
  subagent_name: "cocos_animation-expert",
  description: "配置骨骼动画状态机",
  prompt: "角色拥有 idle、walk、run、jump 四个动画剪辑，需要配置一个动画状态机，支持状态切换、混合和事件触发。请提供完整的 TypeScript 实现，并说明如何与 gameplay‑programmer 协调输入检测逻辑。"
)
```

### 4.3 使用 use_skill 工具调用专业技能

当需要参考特定领域的知识、API 或最佳实践时，可使用对应的技能：

```typescript
// 示例：激活 2D 渲染技能，获取 Sprite、Label、Mask 等组件的使用指南
use_skill("cocos_2d")

// 示例：激活 3D 渲染技能，了解模型加载、LOD 设置、材质优化
use_skill("cocos_3d")

// 其他可用技能：
// - cocos_animation
// - cocos_core
// - cocos_gfx
// - cocos_physics
// - cocos_physics-2d
// - cocos_rendering
```

技能加载后，系统会提供该领域的完整知识库，包括核心设计模式、关键 API、代码示例和最佳实践。

---

## 5. 典型工作流示例

### 5.1 创建 2D 游戏 UI 界面

1. **选择引擎**：在 `CODEBUDDY.md` 中确认使用 Cocos Creator。
2. **调用总协调员**：
   ```typescript
   Task(
     subagent_name: "cocos-specialist",
     description: "UI 系统规划",
     prompt: "我们需要设计一个包含主菜单、设置面板、游戏 HUD 的 UI 系统。请给出基于 Cocos Creator 的组件划分、Canvas 布局方案，并指定 2D 渲染专家负责具体实现。"
   )
   ```
3. **委托实现**：`cocos‑specialist` 会委托 `cocos_2d‑expert` 进行具体开发。
4. **使用技能**：在实现过程中，通过 `use_skill("cocos_2d")` 获取 Sprite、Label、Widget 等组件的详细指导。
5. **协调测试**：与 `gameplay‑programmer`、`ui‑programmer` 协调，确保 UI 与游戏逻辑正确交互。

### 5.2 实现 3D 角色动画

1. **调用动画专家**：
   ```typescript
   Task(
     subagent_name: "cocos_animation-expert",
     description: "角色动画系统",
     prompt: "角色模型已导入，拥有 idle、walk、run、attack 四个动画剪辑。请实现一个动画状态机，支持基于输入的状态切换、动画混合（crossFade）和事件回调。"
   )
   ```
2. **调用 3D 渲染专家**（如需模型优化）：
   ```typescript
   Task(
     subagent_name: "cocos_3d-expert",
     description: "模型 LOD 设置",
     prompt: "为角色模型配置三级 LOD，并设置合适的切换距离。"
   )
   ```
3. **使用技能**：`use_skill("cocos_animation")`、`use_skill("cocos_3d")`。
4. **性能调优**：与 `performance‑analyst` 协作，使用 Cocos Creator Profiler 分析动画性能。

### 5.3 配置渲染管线与后处理

1. **调用渲染管线专家**：
   ```typescript
   Task(
     subagent_name: "cocos_rendering-expert",
     description: "前向渲染管线配置",
     prompt: "项目需要前向渲染管线，要求支持实时光照、阴影、Bloom 和 Color Grading。请提供完整的管线配置步骤和参数建议。"
   )
   ```
2. **调用图形 API 专家**（如需自定义着色器）：
   ```typescript
   Task(
     subagent_name: "cocos_gfx-expert",
     description: "自定义后处理着色器",
     prompt: "实现一个简单的自定义后处理着色器，用于屏幕扭曲效果。"
   )
   ```
3. **使用技能**：`use_skill("cocos_rendering")`、`use_skill("cocos_gfx")`。

---

## 6. 最佳实践与注意事项

### 6.1 协作原则
- **总协调员优先**：涉及多子系统或架构决策时，先咨询 `cocos‑specialist`。
- **明确职责**：子专家仅修改其对应目录下的文件（如 `cocos/2d/`、`cocos/3d/`）。
- **透明沟通**：所有代理均遵循 **Question → Options → Decision → Draft → Approval** 协作流程。

### 6.2 代码规范
- **TypeScript 优先**：所有 Cocos Creator 代码使用 TypeScript，遵循项目编码标准。
- **组件缓存**：避免在 `update()` 中调用 `getComponent()`，应在 `onLoad()` 中缓存引用。
- **属性装饰器**：使用 `@property` 装饰器声明序列化字段，而非公共字段。

### 6.3 性能优化
- **Draw Call 优化**：使用 SpriteAtlas 合并精灵，启用静态/动态合批。
- **内存管理**：对频繁创建/销毁的对象（如子弹、特效）使用 `NodePool`。
- **平台适配**：针对不同目标平台配置纹理压缩、网格质量等导入设置。

### 6.4 常见陷阱
- ❌ 在 `update()` 中进行内存分配（字符串、数组等）。
- ❌ 忘记对已销毁对象进行空值检查。
- ❌ 过度使用 `DontDestroyOnLoad`，应使用场景管理模式。
- ❌ 忽略脚本执行顺序对初始化依赖系统的影响。

---

## 7. 相关文件索引

| 文件 | 描述 |
|------|------|
| `CODEBUDDY.md` | 项目主文档，技术栈选择 |
| `.codebuddy/docs/agent-roster.md` | 完整代理清单，含 Cocos 专家列表 |
| `.codebuddy/agents/cocos‑specialist.md` | 引擎总协调员定义 |
| `.codebuddy/agents/cocos_*‑expert.md` | 8 个子专家定义 |
| `.codebuddy/skills/cocos_*/skill.md` | 8 项专业技能知识库 |
| `docs/Readme/04‑Agents‑Reference.md` | 代理参考（含 Cocos 专家） |
| `docs/Readme/05‑Skills‑Reference.md` | 技能参考（含 Cocos 技能） |

---

## 8. 快速参考命令

```bash
# 调用 Cocos 引擎总协调员
Task(subagent_name: "cocos-specialist", description: "...", prompt: "...")

# 调用 2D 渲染专家
Task(subagent_name: "cocos_2d-expert", description: "...", prompt: "...")

# 调用 3D 渲染专家
Task(subagent_name: "cocos_3d-expert", description: "...", prompt: "...")

# 激活 2D 渲染技能
use_skill("cocos_2d")

# 激活动画技能
use_skill("cocos_animation")

# 检查 Cocos 代理是否就绪
搜索 "cocos" 于 agent‑roster.md
```

---

> **下一步**：如需开始具体开发，请运行 `/start` 进入引导式工作流，或直接使用上述 Task 命令调用相应专家。