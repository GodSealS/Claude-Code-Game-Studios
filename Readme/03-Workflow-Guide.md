# Workflow Guide / 工作流指南

This document details the complete workflow for game development under the CodeBuddy Game Studios architecture.

> **中文翻译**：本文档详细解释在 CodeBuddy Game Studios 架构下开发游戏的完整工作流程。

---

## 7 阶段开发管道

```
概念 (Concept) → 预制作 (Pre-Production) → 制作 (Production) 
    → 打磨 (Polish) → 发布准备 (Release Prep) → 上线 (Live Ops)
```

---

## Phase 1: 概念阶段 (Concept)

**目标**: 找到你的游戏概念，定义核心循环和设计支柱。

### 入口点

#### 场景 A: 完全没有想法
```
/start
# 或
/brainstorm open
```

**流程**:
1. **创意探索** - 使用 `/brainstorm open` 进行开放式探索
2. **概念选择** - 从生成的概念中选择最吸引你的
3. **引擎选择** - 根据概念推荐选择合适的引擎
4. **引擎配置** - 运行 `/setup-engine` 配置引擎

#### 场景 B: 有模糊想法
```
/brainstorm [主题/类型]
# 例如: /brainstorm "太空探索" 或 /brainstorm "roguelike"
```

**流程**:
1. **主题探索** - 基于你的主题进行头脑风暴
2. **概念细化** - 扩展和细化初始想法
3. **核心循环定义** - 明确核心游戏循环
4. **设计支柱确立** - 确定 3-5 个设计支柱

#### 场景 C: 有明确概念
```
# 直接在 design/gdd/ 创建 game-concept.md
# 然后运行设计审查
/design-review design/gdd/game-concept.md
```

### 阶段输出

| 输出文档 | 位置 | 说明 |
|----------|------|------|
| 游戏概念文档 | `design/gdd/game-concept.md` | MDA、SDT、Flow、Bartle 分析 |
| 设计支柱 | `design/game-pillars.md` | 3-5 个核心设计原则 |
| 技术偏好 | `.codebuddy/docs/technical-preferences.md` | 引擎配置、命名规范 |

### 阶段检查点

运行 `/gate-check concept` 验证：
- ✅ 核心循环已定义
- ✅ 设计支柱已确立
- ✅ 目标玩家群体明确
- ✅ 平台和技术选择合理

---

## Phase 2: 预制作阶段 (Pre-Production)

**目标**: 将概念分解为系统，完成所有系统设计文档。

### 系统分解

```
/map-systems
```

**功能**:
- 枚举所有游戏系统
- 映射系统间依赖关系
- 确定系统设计优先级顺序
- 输出系统索引文档

**输出**: `design/systems-index.md`

### 系统设计

对于每个系统（按依赖顺序）:

```
/design-system [system-name]
```

**示例**:
```
/design-system combat
/design-system inventory
/design-system progression
```

**GDD 模板包含**:
1. 系统概述
2. 目标与体验
3. 机制详解
4. 数学公式和数值
5. 边界情况和错误处理
6. UI/UX 需求
7. 音频需求
8. 与其他系统的关系

### 架构设计

```
/create-architecture
```

**输出**:
- 主架构文档
- 初始 ADR（架构决策记录）
- 技术风险评估

### 阶段检查点

运行 `/gate-check pre-production` 验证：
- ✅ 所有核心系统 GDD 完成
- ✅ 架构文档完成
- ✅ 关键技术风险已识别和缓解
- ✅ 第一个里程碑定义完成

---

## Phase 3: 制作阶段 - 第一部分 (Production Alpha)

**目标**: 实现核心循环，建立垂直切片。

### 创建史诗

```
/create-epics
```

**功能**:
- 将 GDD 和 ADR 转换为史诗任务
- 每个架构模块一个史诗
- 定义史诗间的依赖关系

**输出**: `production/epics/` 目录下的史诗文件

### 创建故事

对于每个史诗:

```
/create-stories [epic-slug]
```

**故事格式**:
```yaml
---
epic: combat-system
status: ready
---
# Story: 实现基础攻击系统

## 验收标准
- [ ] 玩家可以执行基础攻击
- [ ] 攻击有伤害计算
- [ ] 目标显示受击反馈

## 技术任务
- [ ] 创建 AttackComponent
- [ ] 实现伤害公式
- [ ] 添加动画触发
```

### 开发故事

```
/dev-story [story-file]
```

**流程**:
1. Agent 读取故事文件
2. 验证准备度 (`/story-readiness`)
3. 路由到合适的程序员 Agent
4. 实现代码和测试
5. 验证验收标准
6. 标记完成 (`/story-done`)

### 迭代规划

```
/sprint-plan new
```

**迭代周期**: 建议 2 周

**迭代计划包含**:
- 迭代目标和成功标准
- 故事列表（按优先级排序）
- 风险缓解策略
- 验收检查清单

### 阶段检查点

运行 `/gate-check production-alpha` 验证：
- ✅ 核心循环可玩
- ✅ 垂直切片完成
- ✅ 主要技术风险已解决
- ✅ 性能预算建立

---

## Phase 4: 制作阶段 - 第二部分 (Production Beta)

**目标**: 完成所有功能，内容填充。

### 功能完成

继续 `/dev-story` 循环，直到所有史诗完成。

### 内容创建

使用团队协调技能并行创建内容：

```
/team-level [level-name]      # 关卡创建
/team-narrative               # 叙事内容
/team-audio                   # 音频内容
```

### 平衡调整

```
/balance-check
```

**分析内容**:
- 数值公式合理性
- 进度曲线平滑度
- 经济系统平衡
- 难度曲线

### QA 集成

```
/qa-plan [sprint/feature]
/team-qa
```

### 阶段检查点

运行 `/gate-check production-beta` 验证：
- ✅ 所有功能实现完成
- ✅ 内容填充 ≥ 80%
- ✅ 无 P0/P1 Bug
- ✅ 性能达到目标帧率

---

## Phase 5: 打磨阶段 (Polish)

**目标**: 提升品质，修复 Bug，优化体验。

### 打磨团队协调

```
/team-polish
```

**涉及角色**:
- `performance-analyst` - 性能优化
- `technical-artist` - 视觉品质
- `sound-designer` - 音频品质
- `qa-tester` - Bug 验证

### Bug 分类

```
/bug-triage
```

**流程**:
1. 读取所有打开的 Bug
2. 重新评估优先级 vs 严重性
3. 分配所有者和标签
4. 分配到迭代或里程碑

### 性能分析

```
/perf-profile
```

### 内容审计

```
/content-audit
```

验证 GDD 中指定的内容是否都已实现。

### 阶段检查点

运行 `/gate-check polish` 验证：
- ✅ 所有 P0/P1 Bug 已修复
- ✅ 性能稳定
- ✅ 玩家体验流畅
- ✅ 无阻塞性问题

---

## Phase 6: 发布准备阶段 (Release Prep)

**目标**: 准备发布，认证，部署。

### 发布清单

```
/release-checklist
```

**检查项**:
- 平台认证要求
- 商店元数据
- 版本号和构建信息
- 回滚计划

### 发布团队协调

```
/team-release
```

### 冒烟测试

```
/smoke-check
```

### 浸泡测试

```
/soak-test
```

### 生成发布说明

```
/changelog
/patch-notes
```

### 阶段检查点

运行 `/gate-check release` 验证：
- ✅ 所有认证要求满足
- ✅ 发布清单 100% 完成
- ✅ 回滚计划就绪
- ✅ 监控和告警配置完成

---

## Phase 7: 上线运营阶段 (Live Ops)

**目标**: 发布后支持，更新，活动。

### 运营团队协调

```
/team-live-ops
```

**涉及角色**:
- `live-ops-designer` - 活动和赛季设计
- `economy-designer` - 经济调整
- `community-manager` - 玩家沟通
- `analytics-engineer` - 数据分析

### 紧急修复

```
/hotfix
```

紧急修复工作流，绕过正常迭代流程。

### 事故响应

参考 `production/incident-response/` 中的预案。

### 玩家反馈分析

```
/playtest-report
```

---

## 跨阶段通用工作流

### 架构决策

任何时候需要做出技术决策:

```
/architecture-decision
```

### 代码审查

```
/code-review [file]
```

### 设计审查

```
/design-review [document]
```

### 范围检查

```
/scope-check
```

检测范围蔓延。

### 一致性检查

```
/consistency-check
```

检测跨文档不一致。

---

## 工作流决策树

```
开始
  │
  ├── 新项目？
  │     └── /start → /brainstorm → /setup-engine
  │
  ├── 有概念？
  │     └── /map-systems → /design-system
  │
  ├── 开始开发？
  │     └── /create-architecture → /create-epics → /create-stories
  │
  ├── 实现功能？
  │     └── /dev-story
  │
  ├── 检查状态？
  │     └── /gate-check [phase]
  │
  ├── Bug 修复？
  │     └── /bug-triage → 修复 → /regression-suite
  │
  └── 发布？
        └── /release-checklist → /team-release
```

---

## 最佳实践

### 1. 频繁检查点
每个阶段结束时运行 `/gate-check`，不要等到最后才发现问题。

### 2. 文档先行
代码实现前，确保相关 GDD 和 ADR 已完成并通过审查。

### 3. 小步快跑
故事应该足够小，能在 1-2 天内完成。大的功能要分解。

### 4. 并行工作流
使用 `/team-*` 技能协调多个 Agent 并行工作。

### 5. 持续验证
定期运行 `/consistency-check` 和 `/content-audit` 确保一致性。

---

> **提示**: 不确定下一步该做什么？运行 `/help` 获取上下文感知的建议。
