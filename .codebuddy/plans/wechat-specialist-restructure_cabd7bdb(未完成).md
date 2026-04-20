---
name: wechat-specialist-restructure
overview: 重构微信小游戏Agent架构：创建wechat-specialist为核心协调者，重构4个子专家的职责和关系，参考Unity/Godot/UE对应Agent设定，最后生成设计文档
todos:
  - id: create-wechat-specialist
    content: 新建 .codebuddy/agents/wechat-specialist.md 核心协调者Agent定义
    status: pending
  - id: rewrite-minigame-specialist
    content: 重构 wechat-minigame-specialist.md 为子专家角色
    status: pending
    dependencies:
      - create-wechat-specialist
  - id: rewrite-shader-specialist
    content: 重构 wechat-shader-specialist.md 增强翻译和性能标准
    status: pending
    dependencies:
      - create-wechat-specialist
  - id: rewrite-ui-specialist
    content: 重构 wechat-ui-specialist.md 增加数据绑定/Screen管理/竖屏适配
    status: pending
    dependencies:
      - create-wechat-specialist
  - id: update-cloudbase-specialist
    content: 更新 wechat-cloudbase-specialist.md 汇报关系
    status: pending
    dependencies:
      - create-wechat-specialist
  - id: update-agent-roster
    content: 更新 agent-roster.md 添加Engine Lead和重构微信团队
    status: pending
    dependencies:
      - create-wechat-specialist
      - rewrite-minigame-specialist
      - rewrite-shader-specialist
      - rewrite-ui-specialist
      - update-cloudbase-specialist
  - id: update-skills-reference
    content: 更新 skills-reference.md 微信相关Skill
    status: pending
    dependencies:
      - update-agent-roster
  - id: update-agents-reference
    content: 更新 docs/Readme/04-Agents-Reference.md
    status: pending
    dependencies:
      - update-agent-roster
  - id: update-wechat-guide
    content: 更新 docs/Readme/10-WeChat-Mini-Game-Guide.md
    status: pending
    dependencies:
      - update-agent-roster
  - id: create-unity-guide
    content: 创建 docs/Readme/11-Unity-Agent-Collaboration-Guide.md
    status: pending
  - id: create-wechat-guide
    content: 创建 docs/Readme/12-WeChat-Agent-Collaboration-Guide.md
    status: pending
    dependencies:
      - update-agent-roster
---

## 产品概述

重构微信小游戏 Agent 架构，以 `wechat-specialist` 为核心协调者（参考 unity-specialist / unreal-specialist / godot-specialist 的定位），将现有 4 个微信 Agent 调整为其子专家/协作者角色，并更新所有相关配置文件和文档。

## 核心功能

### 1. 新建 wechat-specialist（核心协调者）

- 参考 unity-specialist、unreal-specialist、godot-specialist 的 Delegation Map / Best Practices / Sub-Specialist Orchestration 模式
- 语言: TypeScript (首选), JavaScript, WXML, WXSS
- 架构模式: MVC 或 ECS
- 核心模块: 游戏循环 update(dt) 优化、状态管理（单例模式管理 GameState/UserData）、资源管理（预加载与释放，防止内存泄漏）
- 音频管理: 背景音乐与音效分离，处理 iOS 静音模式兼容
- 汇报给 technical-director (via lead-programmer)
- 委派给: wechat-minigame-specialist, wechat-shader-specialist, wechat-ui-specialist, wechat-cloudbase-specialist

### 2. 重构 wechat-minigame-specialist（降级为子专家）

- 汇报给 wechat-specialist
- 职责: 小游戏主要功能实现 + 物理模块(Box2D/Bullet/JoltPhysics + WASM) + 动画模块(Spine/DragonBones 骨骼动画运行时)
- 切图导出精灵图 (Sprite Sheet)
- 移除原来作为协调者的 Delegation Map，改为协作者身份

### 3. 重构 wechat-shader-specialist（增强翻译能力）

- 参考 unity-shader-specialist、godot-shader-specialist 的职责结构
- WebGL 1.0/2.0 Shader 开发
- 增加翻译能力: Unity HLSL/ShaderGraph → GLSL, Unreal Material → GLSL, Godot Shader → GLSL
- 后处理效果、移动端优化、渲染预算
- 汇报给 wechat-specialist

### 4. 重构 wechat-ui-specialist（参考 unity-ui-specialist）

- 参考 unity-ui-specialist 的职责: 数据绑定、Screen Management、跨平台输入、性能标准、无障碍
- UI 默认适配竖屏屏幕
- 设计能力: Figma/Sketch 原型、iOS HIG 与微信规范、视觉层级和交互反馈、精通动效编辑与代码绑定
- 制作能力: FairyGUI 拼装界面、自适应布局 (Anchors & Stretch)
- 汇报给 wechat-specialist

### 5. 更新 wechat-cloudbase-specialist

- 更新汇报关系为 wechat-specialist
- 保持现有职责不变

### 6. 更新所有相关文档

- agent-roster.md: 添加 wechat-specialist 为 Engine Lead，重构微信团队层级
- skills-reference.md: 更新 Skill 说明
- 04-Agents-Reference.md: 更新微信专家团队结构
- 10-WeChat-Mini-Game-Guide.md: 更新 Agent 协作和工作流
- 新建 11-Unity-Agent-Collaboration-Guide.md: Unity Agent 协作指南
- 新建 12-WeChat-Agent-Collaboration-Guide.md: 微信 Agent 协作指南

## 技术栈

- 文档格式: Markdown
- 图表: Mermaid 流程图
- Agent 定义: YAML Front Matter + Markdown Body
- 存储位置: `.codebuddy/agents/`, `.codebuddy/docs/`, `docs/Readme/`

## 实现方案

### 架构重构核心

参考 Unity/Godot/Unreal 的 Agent 层级结构，建立 `wechat-specialist` 作为微信小游戏平台的 Engine Lead，与 unity-specialist、godot-specialist、unreal-specialist 并列在 Engine Leads 表中。4 个子专家降级为其 Sub-Specialists。

### 新层级结构

```
Engine Leads:
  unreal-specialist → UE Sub-Specialists
  unity-specialist  → Unity Sub-Specialists
  godot-specialist  → Godot Sub-Specialists
  wechat-specialist → WeChat Sub-Specialists  [NEW]
```

### wechat-specialist 设计要点

- **Delegation Map**: 与 unity-specialist 完全对齐的汇报/委派/升级/协调结构
- **Best Practices**: TypeScript 编码规范、微信小游戏 API (wx.*) 最佳实践、MVC/ECS 架构选择指南、游戏循环优化、状态管理单例模式、资源管理预加载/释放、音频管理
- **What This Agent Must NOT Do**: 不做游戏设计决策、不覆盖 lead-programmer 架构、不直接实现功能(委派给子专家)、不批准工具/插件
- **Sub-Specialist Orchestration**: 使用 Task 工具委派给 4 个子专家

### wechat-minigame-specialist 重构要点

- 移除 Delegation Map 中的协调者角色
- 汇报关系改为 wechat-specialist
- 保留物理引擎、WASM、骨骼动画代码示例
- 新增切图/精灵图制作能力
- 明确为功能实现者，不是架构决策者

### wechat-shader-specialist 重构要点

- 参考 unity-shader-specialist 的 Render Pipeline Standards / Shader Variants / VFX Graph Standards / Performance Optimization 结构
- 参考 godot-shader-specialist 的 Shader Type / Code Standards / Particle Shaders 结构
- 增强翻译对照表: Unity → GLSL, Unreal → GLSL, Godot → GLSL 完整映射
- 增加 Shader 渲染预算、性能优化标准、常见反模式

### wechat-ui-specialist 重构要点

- 参考 unity-ui-specialist 的 UI System Selection / Data Binding / Screen Management / Cross-Platform Input / Performance Standards / Accessibility 结构
- 新增: 数据绑定模式 (GameState → ViewModel → UI)、Screen 栈管理系统
- 新增: 竖屏默认适配策略、触摸目标规范、焦点管理
- 新增: UI 性能标准 (< 2ms CPU 帧预算)、虚拟列表、对象池
- 保留现有: Figma/Sketch 原型、FairyGUI 实现、Photoshop/Illustrator 资产制作

## 目录结构

```
.codebuddy/agents/
├── wechat-specialist.md              # [NEW] 微信小游戏平台核心协调者
├── wechat-minigame-specialist.md     # [REWRITE] 降级为子专家，专注功能+物理+动画
├── wechat-shader-specialist.md       # [REWRITE] 增强翻译能力，参考unity/godot shader specialist
├── wechat-ui-specialist.md           # [REWRITE] 参考unity-ui-specialist，增加数据绑定/Screen管理/竖屏适配
└── wechat-cloudbase-specialist.md    # [UPDATE] 更新汇报关系

.codebuddy/docs/
├── agent-roster.md                   # [UPDATE] 添加wechat-specialist为Engine Lead，重构微信团队层级
└── skills-reference.md               # [UPDATE] 更新微信相关Skill说明

docs/Readme/
├── 04-Agents-Reference.md            # [UPDATE] 更新微信专家团队结构和选择指南
├── 10-WeChat-Mini-Game-Guide.md      # [UPDATE] 更新Agent协作和工作流
├── 11-Unity-Agent-Collaboration-Guide.md  # [NEW] Unity Agent协作指南
└── 12-WeChat-Agent-Collaboration-Guide.md # [NEW] 微信Agent协作指南
```

## Skill

- **setup-wechat-minigame**: 初始化微信小游戏项目结构时参考
- **wechat-shader**: Shader 开发和转换流程参考
- **wechat-ui-design**: UI 设计和 FairyGUI 流程参考

## MCP

- **CloudBase AI ToolKit**: 微信云开发相关能力验证和文档生成时参考 cloudbase-platform / miniprogram-development / auth-wechat 等 skill 文档