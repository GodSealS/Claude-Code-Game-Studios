# Agents 参考手册

本文档详细介绍 CodeBuddy Game Studios 架构中所有 49 个 Agent 的职责、能力和使用场景。

---

## Agent 层级结构

```
Tier 1: 领导层 (Leadership)
    ├── creative-director
    ├── technical-director
    └── producer

Tier 2: 部门主管 (Department Leads)
    ├── game-designer
    ├── lead-programmer
    ├── art-director
    ├── audio-director
    ├── narrative-director
    ├── qa-lead
    ├── release-manager
    └── localization-lead

Tier 3: 专家 (Specialists)
    ├── Designers: systems-designer, level-designer, economy-designer, ux-designer
    ├── Programmers: gameplay-programmer, engine-programmer, ai-programmer, network-programmer, tools-programmer, ui-programmer
    ├── Art: technical-artist
    ├── Audio: sound-designer
    ├── Writers: writer, world-builder
    ├── QA: qa-tester, performance-analyst
    └── Engineers: devops-engineer, analytics-engineer, security-engineer, accessibility-specialist

引擎专属专家 (Engine Specialists)
    ├── Godot: godot-specialist, godot-gdscript-specialist, godot-shader-specialist, godot-gdextension-specialist
    ├── Unity: unity-specialist, unity-dots-specialist, unity-shader-specialist, unity-addressables-specialist, unity-ui-specialist
    ├── Unreal: unreal-specialist, ue-gas-specialist, ue-blueprint-specialist, ue-replication-specialist, ue-umg-specialist
    └── WeChat Mini Game: wechat-minigame-specialist, wechat-cloudbase-specialist, wechat-shader-specialist, wechat-ui-specialist
```

---

## Tier 1: 领导层

### creative-director（创意总监）

**模型**: GLM-5.1

**职责**:
- 高层创意决策
- 视觉和叙事方向最终裁决
- 设计支柱冲突解决
- 游戏愿景的统一和维护

**何时使用**:
- 设计方向存在分歧
- 需要权衡创意 vs 技术限制
- 定义或修改游戏支柱
- 评估重大设计变更请求

**示例对话**:
```
用户: "我们的战斗系统应该更注重策略还是动作？"
creative-director: "这涉及到我们的核心设计支柱...
    选项 A: 策略方向 - 适合...但会牺牲...
    选项 B: 动作方向 - 适合...但需要...
    我推荐选项 A，因为这与我们的'有意义的决策'支柱一致。
    但最终这是你的决定。"
```

---

### technical-director（技术总监）

**模型**: GLM-5.1

**职责**:
- 架构决策
- 技术栈选择
- 性能策略制定
- 技术风险评估

**何时使用**:
- 需要做出重大架构决策
- 技术方案选择
- 性能瓶颈分析
- 技术债务评估

**技能**:
- `/architecture-decision` - 创建 ADR
- `/architecture-review` - 审查架构
- `/tech-debt` - 技术债务分析

---

### producer（制作人）

**模型**: DeepSeek-V3.2

**职责**:
- 进度规划和管理
- 里程碑跟踪
- 风险管理
- 跨部门协调
- 范围谈判

**何时使用**:
- 需要规划迭代
- 跟踪项目进度
- 协调多个部门
- 处理范围蔓延
- 风险评估

**技能**:
- `/sprint-plan` - 迭代规划
- `/sprint-status` - 迭代状态
- `/scope-check` - 范围检查
- `/estimate` - 工作量估算
- `/milestone-review` - 里程碑审查

**示例对话**:
```
用户: "我们需要在三个月内发布，但功能列表太多了。"
producer: "让我分析一下...
    当前范围: X 个故事点
    团队速度: Y 点/迭代
    预测完成: 4 个月
    
    建议选项:
    1. 削减功能 A、B（影响最小）
    2. 增加资源（成本 X）
    3. 延长到 4 个月
    
    我推荐选项 1，因为这保留了核心体验。"
```

---

## Tier 2: 部门主管

### game-designer（游戏设计师）

**模型**: DeepSeek-V3.2

**职责**:
- 游戏机制设计
- 系统设计
- 进度设计
- 经济系统设计
- 平衡调整

**何时使用**:
- 设计新机制
- 审查系统间交互
- 解决设计冲突
- 评估设计可行性

**技能**:
- `/design-system` - 系统设计
- `/balance-check` - 平衡检查
- `/review-all-gdds` - 跨 GDD 审查

---

### lead-programmer（首席程序员）

**模型**: DeepSeek-V3.2

**职责**:
- 代码架构审查
- API 设计
- 重构决策
- 代码标准执行
- 技术债务优先级

**何时使用**:
- 架构审查
- API 设计评审
- 代码重构决策
- 技术实现冲突

**技能**:
- `/code-review` - 代码审查
- `/create-architecture` - 创建架构
- `/create-control-manifest` - 生成规则表

---

### art-director（艺术总监）

**模型**: DeepSeek-V3.2

**职责**:
- 视觉风格定义
- 艺术圣经维护
- 资源标准制定
- UI/UX 视觉方向

**何时使用**:
- 定义视觉风格
- 审查艺术资产
- 解决视觉冲突
- 创建艺术圣经

**技能**:
- `/art-bible` - 创建艺术圣经
- `/asset-audit` - 资源审计

---

### audio-director（音频总监）

**模型**: DeepSeek-V3.2

**职责**:
- 音频方向定义
- 声音风格制定
- 音频实现策略
- 混音平衡

**何时使用**:
- 定义音频风格
- 音频架构决策
- 音频管道设计

---

### narrative-director（叙事总监）

**模型**: DeepSeek-V3.2

**职责**:
- 故事弧线设计
- 世界观构建
- 角色设计
- 对话策略

**何时使用**:
- 故事结构设计
- 角色发展
- 传说一致性审查

---

### qa-lead（QA 主管）

**模型**: DeepSeek-V3.2

**职责**:
- 测试策略
- Bug 分类
- 发布准备评估
- 回归测试规划

**何时使用**:
- 制定测试策略
- Bug 优先级排序
- 发布决策

**技能**:
- `/qa-plan` - QA 计划
- `/bug-triage` - Bug 分类
- `/regression-suite` - 回归测试套件

---

### release-manager（发布经理）

**模型**: DeepSeek-V3.2

**职责**:
- 构建管理
- 版本控制
- 变更日志
- 部署流程
- 回滚计划

**何时使用**:
- 发布准备
- 版本规划
- 部署决策

**技能**:
- `/release-checklist` - 发布清单
- `/launch-checklist` - 上线清单
- `/changelog` - 变更日志

---

### localization-lead（本地化主管）

**模型**: DeepSeek-V3.2

**职责**:
- 字符串外化
- 翻译管道
- 本地化测试

**何时使用**:
- 准备多语言版本
- 本地化审查

**技能**:
- `/localize` - 本地化工作流

---

## Tier 3: 专家 (按领域分类)

### 设计专家

#### systems-designer（系统设计师）

**模型**: DeepSeek-V3.2

**职责**: 具体机制实现、公式设计、游戏循环

**何时使用**: 需要详细设计特定机制时

---

#### level-designer（关卡设计师）

**模型**: Kimi-K2.5

**职责**: 关卡布局、节奏、遭遇设计、流程

**何时使用**: 创建或审查关卡设计

---

#### economy-designer（经济设计师）

**模型**: DeepSeek-V3.2

**职责**: 虚拟经济、资源流动、战利品表

**何时使用**: 设计或平衡游戏经济

---

#### ux-designer（UX 设计师）

**模型**: GLM-5.1

**职责**: 用户流程、线框图、无障碍、输入处理

**何时使用**: 设计界面交互和流程

---

### 程序专家

#### gameplay-programmer（游戏程序员）

**模型**: DeepSeek-V3.2

**职责**: 功能实现、游戏系统代码

**何时使用**: 实现游戏玩法功能

---

#### engine-programmer（引擎程序员）

**模型**: DeepSeek-V3.2

**职责**: 核心引擎、渲染、物理、内存管理

**何时使用**: 引擎级功能实现

---

#### ai-programmer（AI 程序员）

**模型**: DeepSeek-V3.2

**职责**: 行为树、寻路、NPC 逻辑、状态机

**何时使用**: 实现 AI 系统

---

#### network-programmer（网络程序员）

**模型**: DeepSeek-V3.2

**职责**: 网络代码、复制、延迟补偿、匹配

**何时使用**: 实现多人游戏功能

---

#### ui-programmer（UI 程序员）

**模型**: GLM-5v-Turbo

**职责**: UI 框架、界面、组件、数据绑定

**何时使用**: 实现用户界面

---

### 艺术专家

#### technical-artist（技术美术）

**模型**: GLM-5v-Turbo

**职责**: 着色器、VFX、优化、艺术管线工具

**何时使用**: 着色器开发、性能优化

---

### 音频专家

#### sound-designer（声音设计师）

**模型**: MiniMax-M2.7

**职责**: SFX 设计、音频事件、混音笔记

**何时使用**: 设计和实现音效

---

### 写作专家

#### writer（编剧）

**模型**: MiniMax-M2.7

**职责**: 对话写作、传说条目、物品描述

**何时使用**: 编写游戏文本

---

#### world-builder（世界观设计师）

**模型**: MiniMax-M2.7

**职责**: 世界规则、派系设计、历史、地理

**何时使用**: 构建游戏世界观

---

### QA 专家

#### qa-tester（测试员）

**模型**: DeepSeek-V3.2

**职责**: 编写测试用例、Bug 报告、测试清单

**何时使用**: 创建测试用例

---

#### performance-analyst（性能分析师）

**模型**: GLM-5.1

**职责**: 性能分析、优化建议、内存分析

**何时使用**: 性能瓶颈分析

---

### 工程专家

#### devops-engineer（DevOps 工程师）

**模型**: GLM-5.1

**职责**: CI/CD、构建脚本、版本控制工作流

**何时使用**: 设置自动化管道

---

#### analytics-engineer（分析工程师）

**模型**: DeepSeek-V3.2

**职责**: 事件追踪、仪表板、A/B 测试设计

**何时使用**: 实现遥测系统

---

#### security-engineer（安全工程师）

**模型**: DeepSeek-V3.2

**职责**: 反作弊、漏洞预防、存档加密、网络安全

**何时使用**: 安全审查

---

#### accessibility-specialist（无障碍专家）

**模型**: GLM-5v-Turbo

**职责**: WCAG 合规、色盲模式、重映射、文字缩放

**何时使用**: 无障碍审查

---

### 其他专家

#### prototyper（原型师）

**模型**: DeepSeek-V3.2

**职责**: 快速原型、机制测试、可行性验证

**何时使用**: 快速验证想法

---

#### live-ops-designer（运营设计师）

**模型**: DeepSeek-V3.2

**职责**: 赛季、活动、战斗通行证、留存、运营经济

**何时使用**: 设计运营活动

---

#### community-manager（社区经理）

**模型**: GLM-5.0-Turbo

**职责**: 补丁说明、玩家反馈、危机沟通

**何时使用**: 编写面向玩家的文档

---

## 引擎专属专家

### Godot 专家团队

| Agent | 专长 |
|-------|------|
| `godot-specialist` | Godot 4 架构、节点/场景架构、信号、优化 |
| `godot-gdscript-specialist` | GDScript 静态类型、设计模式、性能 |
| `godot-shader-specialist` | Godot 着色语言、视觉着色器、粒子 |
| `godot-gdextension-specialist` | C++/Rust 绑定、原生性能、自定义节点 |

### Unity 专家团队

| Agent | 专长 |
|-------|------|
| `unity-specialist` | Unity 架构、MonoBehaviour vs DOTS、URP/HDRP |
| `unity-dots-specialist` | ECS、Jobs、Burst 编译器 |
| `unity-shader-specialist` | Shader Graph、VFX Graph、后处理 |
| `unity-addressables-specialist` | Addressable 组、异步加载、内存管理 |
| `unity-ui-specialist` | UI Toolkit、UXML/USS、UGUI |

### Unreal Engine 专家团队

| Agent | 专长 |
|-------|------|
| `unreal-specialist` | UE5 架构、Blueprint vs C++、子系统 |
| `ue-gas-specialist` | Gameplay Ability System、效果、属性集 |
| `ue-blueprint-specialist` | BP/C++ 边界、图表标准 |
| `ue-replication-specialist` | 属性复制、RPC、预测、相关性 |
| `ue-umg-specialist` | Widget 层级、数据绑定、CommonUI |

### 微信小游戏专家团队

| Agent | 专长 | 模型 |
|-------|------|------|
| `wechat-minigame-specialist` | 平台 API、4MB 包体限制、物理引擎(Box2D/Bullet/JoltPhysics)、WebAssembly 集成、Spine/DragonBones 骨骼动画运行时 | DeepSeek-V3.2 |
| `wechat-cloudbase-specialist` | 微信云开发、数据库、云函数、存储、安全规则 | DeepSeek-V3.2 |
| `wechat-shader-specialist` | WebGL 1.0/2.0 Shader、Unity/Unreal/Godot Shader 转 WebGL GLSL、后处理效果 | GLM-5v-Turbo |
| `wechat-ui-specialist` | Figma/Sketch 原型、Photoshop/Illustrator 资产制作、FairyGUI 界面拼装、微信设计规范 | GLM-5v-Turbo |

**使用场景**：
- 开发微信小游戏平台专属功能
- 需要物理引擎集成（2D/3D）
- 需要 WebAssembly 第三方库
- 需要骨骼动画运行时
- 需要自定义 WebGL Shader
- 需要 UI 设计和 FairyGUI 实现

---

## Agent 选择指南

### 编程任务选择流程

```
需要写代码？
    ├── 核心引擎/渲染/物理？
    │   └── engine-programmer
    ├── 游戏玩法功能？
    │   └── gameplay-programmer
    ├── AI 功能？
    │   └── ai-programmer
    ├── 网络功能？
    │   └── network-programmer
    ├── UI 功能？
    │   └── ui-programmer
    ├── 着色器/VFX？
    │   └── technical-artist
    └── 架构决策？
        └── lead-programmer
```

### 设计任务选择流程

```
需要设计？
    ├── 整体游戏概念？
    │   └── game-designer
    ├── 具体机制细节？
    │   └── systems-designer
    ├── 关卡设计？
    │   └── level-designer
    ├── 经济/平衡？
    │   └── economy-designer
    ├── 用户体验/界面？
    │   └── ux-designer
    └── 创意冲突？
        └── creative-director
```

### 引擎相关问题

```
使用 [引擎]？
    ├── Godot
    │   ├── 一般问题 → godot-specialist
    │   ├── GDScript → godot-gdscript-specialist
    │   ├── 着色器 → godot-shader-specialist
    │   └── C++/扩展 → godot-gdextension-specialist
    ├── Unity
    │   ├── 一般问题 → unity-specialist
    │   ├── DOTS/ECS → unity-dots-specialist
    │   ├── 着色器 → unity-shader-specialist
    │   ├── 资源管理 → unity-addressables-specialist
    │   └── UI → unity-ui-specialist
    ├── Unreal
    │   ├── 一般问题 → unreal-specialist
    │   ├── GAS → ue-gas-specialist
    │   ├── Blueprint → ue-blueprint-specialist
    │   ├── 网络复制 → ue-replication-specialist
    │   └── UMG → ue-umg-specialist
    └── 微信小游戏
        ├── 平台 API / 包体优化 / 发布 → wechat-minigame-specialist
        ├── 物理引擎 / WASM / 骨骼动画 → wechat-minigame-specialist
        ├── 云开发后端 → wechat-cloudbase-specialist
        ├── WebGL Shader → wechat-shader-specialist
        └── UI 设计 / FairyGUI → wechat-ui-specialist
```

---

> **提示**: 不确定该用哪个 Agent？运行 `/help` 或询问 `producer` Agent。
