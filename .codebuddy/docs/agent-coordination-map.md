# Agent Coordination and Delegation Map / 代理协调与委派映射

## Organizational Hierarchy / 组织层级

```
                           [Human Developer / 人类开发者]
                                 |
                 +---------------+---------------+
                 |               |               |
         creative-director  technical-director  producer
         创意总监          技术总监           制作人
                 |               |               |
        +--------+--------+     |        (coordinates all / 协调所有)
        |        |        |     |
  game-designer art-dir  narr-dir  lead-programmer  qa-lead  audio-dir
  游戏设计师    美术总监 叙事总监  首席程序员    QA主管   音频总监
        |        |        |         |                |        |
     +--+--+     |     +--+--+  +--+--+--+--+--+   |        |
     |  |  |     |     |     |  |  |  |  |  |  |   |        |
    sys lvl eco  ta   wrt  wrld gp ep  ai net tl ui qa-t    snd
    系统关卡经济 技美  作家 世界 GP EP AI 网络 工具 UI QA  音效
                                 |
                             +---+---+
                             |       |
                          perf-a   devops   analytics
                          性能分析  运维      数据分析

  Additional Leads (report to producer/directors):
  附加主管（向制作人/总监汇报）：
    release-manager         -- Release pipeline, versioning, deployment / 发布管线、版本管理、部署
    localization-lead       -- i18n, string tables, translation pipeline / 国际化、字符串表、翻译管线
    prototyper              -- Rapid throwaway prototypes, concept validation / 快速一次性原型、概念验证
    security-engineer       -- Anti-cheat, exploits, data privacy, network security / 反作弊、漏洞、数据隐私、网络安全
    accessibility-specialist -- WCAG, colorblind, remapping, text scaling / WCAG、色盲、按键重映射、文字缩放
    live-ops-designer       -- Seasons, events, battle passes, retention, live economy / 赛季、活动、通行证、留存、在线经济
    community-manager       -- Patch notes, player feedback, crisis comms / 补丁说明、玩家反馈、危机沟通

  Engine Specialists (use the SET matching your engine):
  引擎专家（使用与你的引擎匹配的专家组）：
    unreal-specialist  -- UE5 lead: Blueprint/C++, GAS overview, UE subsystems / UE5主管：蓝图/C++、GAS概览、UE子系统
      ue-gas-specialist         -- GAS: abilities, effects, attributes, tags, prediction / GAS：能力、效果、属性、标签、预测
      ue-blueprint-specialist   -- Blueprint: BP/C++ boundary, graph standards, optimization / 蓝图：BP/C++边界、图表标准、优化
      ue-replication-specialist -- Networking: replication, RPCs, prediction, bandwidth / 网络：复制、RPC、预测、带宽
      ue-umg-specialist         -- UI: UMG, CommonUI, widget hierarchy, data binding / UI：UMG、CommonUI、控件层级、数据绑定

    unity-specialist   -- Unity lead: MonoBehaviour/DOTS, Addressables, URP/HDRP / Unity主管：MonoBehaviour/DOTS、Addressables、URP/HDRP
      unity-dots-specialist         -- DOTS/ECS: Jobs, Burst, hybrid renderer / DOTS/ECS：Jobs、Burst、混合渲染器
      unity-shader-specialist       -- Shaders: Shader Graph, VFX Graph, SRP customization / 着色器：Shader Graph、VFX Graph、SRP定制
      unity-addressables-specialist -- Assets: async loading, bundles, memory, CDN / 资产：异步加载、包、内存、CDN
      unity-ui-specialist           -- UI: UI Toolkit, UGUI, UXML/USS, data binding / UI：UI Toolkit、UGUI、UXML/USS、数据绑定

    godot-specialist   -- Godot 4 lead: GDScript, node/scene, signals, resources / Godot 4主管：GDScript、节点/场景、信号、资源
      godot-gdscript-specialist    -- GDScript: static typing, patterns, signals, performance / GDScript：静态类型、模式、信号、性能
      godot-shader-specialist      -- Shaders: Godot shading language, visual shaders, VFX / 着色器：Godot着色语言、可视化着色器、特效
      godot-gdextension-specialist -- Native: C++/Rust bindings, GDExtension, build systems / 原生：C++/Rust绑定、GDExtension、构建系统
```

### Legend / 图例
```
sys  = systems-designer 系统设计师    gp  = gameplay-programmer 游戏逻辑程序员
lvl  = level-designer 关卡设计师      ep  = engine-programmer 引擎程序员
eco  = economy-designer 经济设计师    ai  = ai-programmer AI程序员
ta   = technical-artist 技术美术      net = network-programmer 网络程序员
wrt  = writer 作家                    tl  = tools-programmer 工具程序员
wrld = world-builder 世界构建师       ui  = ui-programmer UI程序员
snd  = sound-designer 音效设计师      qa-t = qa-tester QA测试员
narr-dir = narrative-director 叙事总监 perf-a = performance-analyst 性能分析师
art-dir = art-director 美术总监
```

## Delegation Rules / 委派规则

### Who Can Delegate to Whom / 谁可以委派给谁

| From | Can Delegate To |
|------|----------------|
| creative-director | game-designer, art-director, audio-director, narrative-director |
| technical-director | lead-programmer, devops-engineer, performance-analyst, technical-artist (technical decisions) |
| producer | Any agent (task assignment within their domain only) |
| game-designer | systems-designer, level-designer, economy-designer |
| lead-programmer | gameplay-programmer, engine-programmer, ai-programmer, network-programmer, tools-programmer, ui-programmer |
| art-director | technical-artist, ux-designer |
| audio-director | sound-designer |
| narrative-director | writer, world-builder |
| qa-lead | qa-tester |
| release-manager | devops-engineer (release builds), qa-lead (release testing) |
| localization-lead | writer (string review), ui-programmer (text fitting) |
| prototyper | (works independently, reports findings to producer and relevant leads) |
| security-engineer | network-programmer (security review), lead-programmer (secure patterns) |
| accessibility-specialist | ux-designer (accessible patterns), ui-programmer (implementation), qa-tester (a11y testing) |
| [engine]-specialist | engine sub-specialists (delegates subsystem-specific work) |
| [engine] sub-specialists | (advises all programmers on engine subsystem patterns and optimization) |
| live-ops-designer | economy-designer (live economy), community-manager (event comms), analytics-engineer (engagement metrics) |
| community-manager | (works with producer for approval, release-manager for patch note timing) |

> **中文翻译**：

| 从 | 可委派给 |
|----|----------|
| creative-director 创意总监 | game-designer、art-director、audio-director、narrative-director |
| technical-director 技术总监 | lead-programmer、devops-engineer、performance-analyst、technical-artist（技术决策） |
| producer 制作人 | 任何代理（仅在其领域内分配任务） |
| game-designer 游戏设计师 | systems-designer、level-designer、economy-designer |
| lead-programmer 首席程序员 | gameplay-programmer、engine-programmer、ai-programmer、network-programmer、tools-programmer、ui-programmer |
| art-director 美术总监 | technical-artist、ux-designer |
| audio-director 音频总监 | sound-designer |
| narrative-director 叙事总监 | writer、world-builder |
| qa-lead QA主管 | qa-tester |
| release-manager 发布经理 | devops-engineer（发布构建）、qa-lead（发布测试） |
| localization-lead 本地化主管 | writer（字符串审查）、ui-programmer（文本适配） |
| prototyper 原型师 | （独立工作，向制作人和相关主管汇报发现） |
| security-engineer 安全工程师 | network-programmer（安全审查）、lead-programmer（安全模式） |
| accessibility-specialist 无障碍专家 | ux-designer（无障碍模式）、ui-programmer（实现）、qa-tester（a11y测试） |
| [引擎]-specialist | 引擎子专家（委派子系统特定工作） |
| [引擎] 子专家 | （向所有程序员建议引擎子系统模式和优化） |
| live-ops-designer 在线运营设计师 | economy-designer（在线经济）、community-manager（活动沟通）、analytics-engineer（参与指标） |
| community-manager 社区经理 | （与制作人协作审批、与release-manager协作补丁说明时间） |

### Escalation Paths / 升级路径

| Situation | Escalate To |
|-----------|------------|
| Two designers disagree on a mechanic | game-designer |
| Game design vs narrative conflict | creative-director |
| Game design vs technical feasibility | producer (facilitates), then creative-director + technical-director |
| Art vs audio tonal conflict | creative-director |
| Code architecture disagreement | technical-director |
| Cross-system code conflict | lead-programmer, then technical-director |
| Schedule conflict between departments | producer |
| Scope exceeds capacity | producer, then creative-director for cuts |
| Quality gate disagreement | qa-lead, then technical-director |
| Performance budget violation | performance-analyst flags, technical-director decides |

> **中文翻译**：

| 情况 | 升级给 |
|------|--------|
| 两名设计师对机制意见不一致 | game-designer |
| 游戏设计与叙事冲突 | creative-director |
| 游戏设计与技术可行性冲突 | producer（协调），然后 creative-director + technical-director |
| 美术与音频基调冲突 | creative-director |
| 代码架构分歧 | technical-director |
| 跨系统代码冲突 | lead-programmer，然后 technical-director |
| 部门间进度冲突 | producer |
| 范围超出能力 | producer，然后 creative-director 做裁剪 |
| 质量门控分歧 | qa-lead，然后 technical-director |
| 性能预算违规 | performance-analyst 标记，technical-director 决定 |

## Common Workflow Patterns / 常见工作流模式

### Pattern 1: New Feature (Full Pipeline) / 模式1：新功能（完整管线）

```
1. creative-director  -- Approves feature concept aligns with vision / 批准与愿景一致的功能概念
2. game-designer      -- Creates design document with full spec / 创建完整规格的设计文档
3. producer           -- Schedules work, identifies dependencies / 安排工作、识别依赖
4. lead-programmer    -- Designs code architecture, creates interface sketch / 设计代码架构、创建接口草图
5. [specialist-programmer] -- Implements the feature / 实现功能
6. technical-artist   -- Implements visual effects (if needed) / 实现视觉效果（如需要）
7. writer             -- Creates text content (if needed) / 创建文本内容（如需要）
8. sound-designer     -- Creates audio event list (if needed) / 创建音频事件列表（如需要）
9. qa-tester          -- Writes test cases / 编写测试用例
10. qa-lead           -- Reviews and approves test coverage / 审查并批准测试覆盖
11. lead-programmer   -- Code review / 代码审查
12. qa-tester         -- Executes tests / 执行测试
13. producer          -- Marks task complete / 标记任务完成
```

### Pattern 2: Bug Fix / 模式2：缺陷修复

```
1. qa-tester          -- Files bug report with /bug-report / 用 /bug-report 提交缺陷报告
2. qa-lead            -- Triages severity and priority / 分类严重性和优先级
3. producer           -- Assigns to sprint (if not S1) / 分配到冲刺（如果不是S1级）
4. lead-programmer    -- Identifies root cause, assigns to programmer / 确定根因、分配给程序员
5. [specialist-programmer] -- Fixes the bug / 修复缺陷
6. lead-programmer    -- Code review / 代码审查
7. qa-tester          -- Verifies fix and runs regression / 验证修复并运行回归测试
8. qa-lead            -- Closes bug / 关闭缺陷
```

### Pattern 3: Balance Adjustment / 模式3：平衡调整

```
1. analytics-engineer -- Identifies imbalance from data (or player reports) / 从数据（或玩家报告）识别失衡
2. game-designer      -- Evaluates the issue against design intent / 对照设计意图评估问题
3. economy-designer   -- Models the adjustment / 对调整建模
4. game-designer      -- Approves the new values / 批准新数值
5. [data file update] -- Change configuration values / 更改配置值
6. qa-tester          -- Regression test affected systems / 回归测试受影响系统
7. analytics-engineer -- Monitor post-change metrics / 监控变更后指标
```

### Pattern 4: New Area/Level / 模式4：新区域/关卡

```
1. narrative-director -- Defines narrative purpose and beats for the area / 定义区域的叙事目的和节拍
2. world-builder      -- Creates lore and environmental context / 创建背景和环境上下文
3. level-designer     -- Designs layout, encounters, pacing / 设计布局、遭遇、节奏
4. game-designer      -- Reviews mechanical design of encounters / 审查遭遇的机制设计
5. art-director       -- Defines visual direction for the area / 定义区域视觉方向
6. audio-director     -- Defines audio direction for the area / 定义区域音频方向
7. [implementation by relevant programmers and artists] / [由相关程序员和美术实现]
8. writer             -- Creates area-specific text content / 创建区域特定文本内容
9. qa-tester          -- Tests the complete area / 测试完整区域
```

### Pattern 5: Sprint Cycle / 模式5：冲刺周期

```
1. producer           -- Plans sprint with /sprint-plan new / 用 /sprint-plan new 规划冲刺
2. [All agents]       -- Execute assigned tasks / 执行分配的任务
3. producer           -- Daily status with /sprint-plan status / 用 /sprint-plan status 每日状态
4. qa-lead            -- Continuous testing during sprint / 冲刺期间持续测试
5. lead-programmer    -- Continuous code review during sprint / 冲刺期间持续代码审查
6. producer           -- Sprint retrospective with post-sprint hook / 用冲刺后钩子进行冲刺回顾
7. producer           -- Plans next sprint incorporating learnings / 融入经验规划下一冲刺
```

### Pattern 6: Milestone Checkpoint / 模式6：里程碑检查点

```
1. producer           -- Runs /milestone-review / 运行 /milestone-review
2. creative-director  -- Reviews creative progress / 审查创意进度
3. technical-director -- Reviews technical health / 审查技术健康
4. qa-lead            -- Reviews quality metrics / 审查质量指标
5. producer           -- Facilitates go/no-go discussion / 主持通过/不通过讨论
6. [All directors]    -- Agree on scope adjustments if needed / 如需要则同意范围调整
7. producer           -- Documents decisions and updates plans / 记录决策并更新计划
```

### Pattern 7: Release Pipeline / 模式7：发布管线

```text
1. producer             -- Declares release candidate, confirms milestone criteria met / 声明发布候选，确认里程碑标准已满足
2. release-manager      -- Cuts release branch, generates /release-checklist / 切割发布分支，生成 /release-checklist
3. qa-lead              -- Runs full regression, signs off on quality / 运行完整回归，签署质量确认
4. localization-lead    -- Verifies all strings translated, text fitting passes / 验证所有字符串已翻译、文本适配通过
5. performance-analyst  -- Confirms performance benchmarks within targets / 确认性能基准在目标内
6. devops-engineer      -- Builds release artifacts, runs deployment pipeline / 构建发布产物，运行部署管线
7. release-manager      -- Generates /changelog, tags release, creates release notes / 生成 /changelog、标记发布、创建发布说明
8. technical-director   -- Final sign-off on major releases / 重大发布的最终签字
9. release-manager      -- Deploys and monitors for 48 hours / 部署并监控48小时
10. producer            -- Marks release complete / 标记发布完成
```

### Pattern 8: Rapid Prototype / 模式8：快速原型

```text
1. game-designer        -- Defines the hypothesis and success criteria / 定义假设和成功标准
2. prototyper           -- Scaffolds prototype with /prototype / 用 /prototype 搭建原型
3. prototyper           -- Builds minimal implementation (hours, not days) / 构建最小实现（几小时，而非几天）
4. game-designer        -- Evaluates prototype against criteria / 对照标准评估原型
5. prototyper           -- Documents findings report / 记录发现报告
6. creative-director    -- Go/no-go decision on proceeding to production / 是否进入制作的通过/不通过决策
7. producer             -- Schedules production work if approved / 如批准则安排制作工作
```

### Pattern 9: Live Event / Season Launch / 模式9：在线活动/赛季上线

```text
1. live-ops-designer     -- Designs event/season content, rewards, schedule / 设计活动/赛季内容、奖励、日程
2. game-designer         -- Validates gameplay mechanics for event / 验证活动游戏机制
3. economy-designer      -- Balances event economy and reward values / 平衡活动经济和奖励值
4. narrative-director    -- Provides seasonal narrative theme / 提供赛季叙事主题
5. writer                -- Creates event descriptions and lore / 创建活动描述和背景
6. producer              -- Schedules implementation work / 安排实现工作
7. [implementation by relevant programmers] / [由相关程序员实现]
8. qa-lead               -- Test event flow end-to-end / 端到端测试活动流程
9. community-manager     -- Drafts event announcement and patch notes / 起草活动公告和补丁说明
10. release-manager      -- Deploys event content / 部署活动内容
11. analytics-engineer   -- Monitors event participation and metrics / 监控活动参与度和指标
12. live-ops-designer    -- Post-event analysis and learnings / 活动后分析和经验
```

## Cross-Domain Communication Protocols / 跨领域沟通协议

### Design Change Notification / 设计变更通知

When a design document changes, the game-designer must notify:
- lead-programmer (implementation impact)
- qa-lead (test plan update needed)
- producer (schedule impact assessment)
- Relevant specialist agents depending on the change

> **中文翻译**：当设计文档变更时，game-designer 必须通知：
- lead-programmer（实现影响）
- qa-lead（需要更新测试计划）
- producer（进度影响评估）
- 根据变更相关的专家代理

### Architecture Change Notification / 架构变更通知

When an ADR is created or modified, the technical-director must notify:
- lead-programmer (code changes needed)
- All affected specialist programmers
- qa-lead (testing strategy may change)
- producer (schedule impact)

> **中文翻译**：当ADR创建或修改时，technical-director 必须通知：
- lead-programmer（需要代码变更）
- 所有受影响的专家程序员
- qa-lead（测试策略可能变更）
- producer（进度影响）

### Asset Standard Change Notification / 资产标准变更通知

When the art bible or asset standards change, the art-director must notify:
- technical-artist (pipeline changes)
- All content creators working with affected assets
- devops-engineer (if build pipeline is affected)

> **中文翻译**：当美术圣经或资产标准变更时，art-director 必须通知：
- technical-artist（管线变更）
- 所有使用受影响资产的内容创作者
- devops-engineer（如果构建管线受影响）

## Anti-Patterns to Avoid / 应避免的反模式

1. **Bypassing the hierarchy**: A specialist agent should never make decisions
   that belong to their lead without consultation.
   > **中文翻译**：**绕过层级**：专家代理不应在未经协商的情况下做出属于其主管的决策。
2. **Cross-domain implementation**: An agent should never modify files outside
   their designated area without explicit delegation from the relevant owner.
   > **中文翻译**：**跨领域实现**：代理不应在未经相关所有者明确委派的情况下修改其指定区域之外的文件。
3. **Shadow decisions**: All decisions must be documented. Verbal agreements
   without written records lead to contradictions.
   > **中文翻译**：**影子决策**：所有决策必须文档化。没有书面记录的口头协议会导致矛盾。
4. **Monolithic tasks**: Every task assigned to an agent should be completable
   in 1-3 days. If it is larger, it must be broken down first.
   > **中文翻译**：**单体任务**：分配给代理的每个任务应在1-3天内可完成。如果更大，必须先拆分。
5. **Assumption-based implementation**: If a spec is ambiguous, the implementer
   must ask the specifier rather than guessing. Wrong guesses are more expensive
   than a question.
   > **中文翻译**：**基于假设的实现**：如果规格有歧义，实现者必须询问规格制定者而非猜测。错误的猜测比一个问题代价更高。
