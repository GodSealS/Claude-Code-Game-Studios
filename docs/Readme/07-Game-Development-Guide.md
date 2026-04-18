# 游戏开发使用指南

本文档详细介绍如何在 CodeBuddy 下使用这套提示词工程开发一款游戏。

---

## 前置条件

### 系统要求

- **CodeBuddy IDE** (VS Code 扩展或 JetBrains 插件)
- **Git** (版本控制)
- **游戏引擎** (Godot 4 / Unity / Unreal Engine 5)

### 项目初始化

1. **克隆或创建项目**
   ```bash
   git clone [your-repo] my-game
   cd my-game
   ```

2. **确保 CODEBUDDY.md 存在**
   
   这是项目的入口点文件。

3. **启动 CodeBuddy 会话**
   
   在 IDE 中打开项目，启动 CodeBuddy。

---

## 场景 1: 从零开始（没有游戏概念）

### 第 1 步: 启动引导流程

```
/start
```

**会发生什么**:
- CodeBuddy 检测项目状态（空项目）
- 询问你的起点:
  - A) 没有想法
  - B) 模糊想法
  - C) 明确概念
  - D) 已有工作

**选择 A: 没有想法**

### 第 2 步: 头脑风暴

```
/brainstorm open
```

**流程**:
1. **创意探索** - 回答关于你喜欢的游戏、兴奋点、约束条件的问题
2. **概念生成** - 系统生成 3 个游戏概念
3. **概念选择** - 选择最吸引你的概念
4. **核心循环定义** - 明确游戏的核心循环
5. **设计支柱确立** - 确定 3-5 个设计支柱

**输出**:
- `design/gdd/game-concept.md` - 游戏概念文档
- `design/game-pillars.md` - 设计支柱

### 第 3 步: 引擎配置

```
/setup-engine
```

**交互式选择**:
- 引擎推荐（基于概念）
- 版本选择
- 命名规范配置

**输出**:
- 更新 `CODEBUDDY.md` 技术栈
- 创建 `.codebuddy/docs/technical-preferences.md`
- 填充引擎参考文档

### 第 4 步: 系统分解

```
/map-systems
```

**功能**:
- 枚举所有游戏系统
- 映射依赖关系
- 确定设计优先级

**输出**:
- `design/systems-index.md`

### 第 5 步: 系统设计

对于每个系统（按依赖顺序）:

```
/design-system [system-name]
```

**示例**:
```
/design-system combat
/design-system inventory
/design-system progression
/design-system ai
```

**输出**:
- `design/gdd/[system-name].md`

### 第 6 步: 原型验证

```
/prototype [core-mechanic]
```

**示例**:
```
/prototype combat
```

**输出**:
- `prototypes/combat/` - 可丢弃的原型

### 第 7 步: 游戏测试

```
/playtest-report
```

**输出**:
- 游戏测试报告

### 第 8 步: 第一个迭代计划

```
/sprint-plan new
```

**输出**:
- `production/sprints/sprint-1.md`

---

## 场景 2: 已有明确概念

### 第 1 步: 引擎配置

```
/setup-engine [engine] [version]
```

**示例**:
```
/setup-engine godot 4.6
```

### 第 2 步: 编写设计支柱

委托给 `creative-director`:

```
请帮我定义游戏的设计支柱
```

**输出**:
- `design/game-pillars.md`

### 第 3 步-8 步: 同上

从场景 1 的第 4 步继续。

---

## 场景 3: 已有项目（迁移到本架构）

### 第 1 步: 项目状态检测

```
/project-stage-detect
```

**输出**:
- 当前阶段报告
- 现有工件清单
- 缺失的关键工件

### 第 2 步: 迁移审计

```
/adopt
```

**功能**:
- 检查现有 GDD/ADR/Story 的格式合规性
- 生成编号迁移计划

### 第 3 步: 引擎配置（如需要）

```
/setup-engine
```

### 第 4 步: 阶段门检查

```
/gate-check [phase]
```

**确定当前所在阶段**:
- `concept` - 概念阶段
- `pre-production` - 预制作
- `production-alpha` - 制作 Alpha
- `production-beta` - 制作 Beta
- `polish` - 打磨

---

## 日常开发工作流

### 迭代规划

**每个迭代开始时**:

```
/sprint-plan new
```

或更新现有迭代:

```
/sprint-plan sprint-3
```

### 实现功能

**方式 1: 使用 /dev-story（推荐）**

```
/dev-story production/stories/combat/basic-attack.md
```

**流程**:
1. 读取 Story 文件
2. 验证准备度 (`/story-readiness`)
3. 路由到合适的程序员 Agent
4. 实现代码和测试
5. 验证验收标准
6. 标记完成 (`/story-done`)

**方式 2: 直接委托 Agent**

```
@gameplay-programmer 请实现基础攻击系统
```

### 代码审查

**自我审查**:
```
/code-review src/gameplay/combat/attack.gd
```

**审查他人代码**:
```
@lead-programmer 请审查这个实现
```

### 设计审查

```
/design-review design/gdd/combat.md
```

### 范围检查

```
/scope-check
```

检测是否超出计划范围。

### 一致性检查

```
/consistency-check
```

检测跨文档不一致。

---

## 团队协作工作流

### 战斗系统开发

```
/team-combat
```

**协调角色**:
- game-designer - 设计战斗机制
- gameplay-programmer - 实现战斗代码
- ai-programmer - 实现敌人 AI
- technical-artist - 战斗特效
- sound-designer - 战斗音效
- qa-tester - 测试战斗

### 关卡创建

```
/team-level forest-level
```

**协调角色**:
- level-designer - 关卡布局
- narrative-director - 关卡叙事
- world-builder - 世界元素
- art-director - 视觉方向
- systems-designer - 关卡特定机制
- qa-tester - 关卡测试

### UI 开发

```
/team-ui
```

**协调角色**:
- ux-designer - UX 设计
- ui-programmer - UI 实现
- art-director - 视觉风格
- accessibility-specialist - 无障碍

---

## QA 和测试工作流

### QA 计划

```
/qa-plan sprint-3
```

### 冒烟测试

```
/smoke-check
```

### 回归测试

```
/regression-suite
```

### Bug 报告

```
/bug-report
```

**交互式创建 Bug 报告**。

### Bug 分类

```
/bug-triage
```

---

## 发布工作流

### 发布检查清单

```
/release-checklist
```

### 上线检查清单

```
/launch-checklist
```

### 生成变更日志

```
/changelog
```

### 生成补丁说明

```
/patch-notes
```

### 发布团队协调

```
/team-release
```

---

## 运营工作流（上线后）

### 运营团队协调

```
/team-live-ops
```

### 紧急修复

```
/hotfix [bug-id]
```

**绕过正常迭代流程**。

---

## 最佳实践

### 1. 始终从文档开始

```
❌ 错误: 直接写代码
✅ 正确: 先写 GDD，再写代码
```

### 2. 频繁检查点

```
/gate-check [phase]  # 每个阶段结束时
/consistency-check    # 每周
/scope-check          # 每迭代
```

### 3. 小步快跑

```
❌ 错误: 一个 Story 实现一周
✅ 正确: Story 能在 1-2 天完成
```

### 4. 并行工作流

```
使用 /team-* 技能协调多个 Agent 并行工作
```

### 5. 版本控制

```
❌ 错误: 长时间不提交
✅ 正确: 每个 Story 完成时提交
```

### 6. 审查文化

```
/design-review  # 设计审查
/code-review    # 代码审查
```

### 7. 记录决策

```
/architecture-decision  # 记录架构决策
```

---

## 常见问题

### Q: 不确定该用哪个 Agent？

**A**: 运行 `/help` 或询问 `producer`。

### Q: 代码实现遇到引擎问题？

**A**: 咨询引擎专属专家：
- Godot: `@godot-specialist`
- Unity: `@unity-specialist`
- Unreal: `@unreal-specialist`

### Q: 设计决策有冲突？

**A**: 委托给 `creative-director` 裁决。

### Q: 技术决策有冲突？

**A**: 委托给 `technical-director` 裁决。

### Q: 范围蔓延怎么办？

**A**: 运行 `/scope-check`，然后咨询 `producer`。

---

## 示例项目时间线

### 周 1-2: 概念和预制作

```
Week 1:
- /start
- /brainstorm open
- /setup-engine
- /map-systems

Week 2:
- /design-system combat
- /design-system inventory
- /create-architecture
```

### 周 3-4: 开始制作

```
Week 3:
- /create-epics
- /create-stories combat-epic
- /sprint-plan new

Week 4:
- /dev-story (多个 Story)
```

### 周 5-8: 迭代开发

```
每 2 周:
- /sprint-plan new
- /dev-story (实现 Story)
- /code-review
- /story-done
- /sprint-status
- /retrospective
```

### 周 9-10: 打磨和发布

```
Week 9:
- /team-polish
- /bug-triage
- /perf-profile

Week 10:
- /release-checklist
- /team-release
- /launch-checklist
```

---

> **提示**: 这个架构是灵活的，可以根据项目需要调整。关键是保持文档和代码的同步，以及频繁沟通和审查。
