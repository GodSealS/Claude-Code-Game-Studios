# Diagrams and Charts / 图表

This document contains various flowcharts and organizational charts for CodeBuddy Game Studios, written in Mermaid syntax.

> **中文翻译**：本文档包含 CodeBuddy Game Studios 的各种流程图和组织结构图，使用 Mermaid 语法编写。

---

## 1. 项目整体架构图

```mermaid
graph TB
    subgraph "项目根目录"
        CODEBUDDY[CODEBUDDY.md<br/>主配置文件]
        README[README.md<br/>项目介绍]
    end
    
    subgraph ".codebuddy/ 核心配置"
        direction TB
        AGENTS[agents/<br/>49 Agent定义]
        SKILLS[skills/<br/>72 Skill定义]
        HOOKS[hooks/<br/>12 钩子脚本]
        RULES[rules/<br/>11 规则文件]
        DOCS[docs/<br/>架构文档]
        SETTINGS[settings.json<br/>项目设置]
    end
    
    subgraph "游戏项目目录"
        direction TB
        SRC[src/<br/>源代码]
        DESIGN[design/<br/>设计文档]
        ASSETS[assets/<br/>游戏资源]
        TESTS[tests/<br/>测试套件]
        PROD[production/<br/>生产管理]
        PROTOS[prototypes/<br/>原型]
    end
    
    subgraph "知识管理"
        GRAPHIFY[graphify-out/<br/>知识图谱]
        DOCSROOT[docs/<br/>技术文档]
    end
    
    CODEBUDDY --> SETTINGS
    SETTINGS --> AGENTS
    SETTINGS --> SKILLS
    SETTINGS --> HOOKS
    SETTINGS --> RULES
    
    AGENTS -.-> SRC
    SKILLS -.-> DESIGN
    RULES -.-> SRC
    HOOKS -.-> PROD
    
    STYLE CODEBUDDY fill:#e1f5ff,stroke:#01579b,stroke-width:3px
    STYLE SETTINGS fill:#fff3e0,stroke:#e65100,stroke-width:2px
```

---

## 2. Agent 三层级组织结构图

```mermaid
graph TB
    subgraph "Tier 1: 领导层 (Leadership)"
        direction LR
        CD[🎨 Creative Director<br/>创意总监]
        TD[⚙️ Technical Director<br/>技术总监]
        PRODUCER[📊 Producer<br/>制作人]
    end
    
    subgraph "Tier 2: 部门主管 (Department Leads)"
        direction LR
        GD[🎮 Game Designer<br/>游戏设计师]
        LP[💻 Lead Programmer<br/>首席程序员]
        AD[🎭 Art Director<br/>艺术总监]
        AUD[🔊 Audio Director<br/>音频总监]
        ND[📝 Narrative Director<br/>叙事总监]
        QA[🐞 QA Lead<br/>QA主管]
        RM[📦 Release Manager<br/>发布经理]
        LL[🌍 Localization Lead<br/>本地化主管]
    end
    
    subgraph "Tier 3: 设计专家"
        direction LR
        SD[Systems Designer<br/>系统设计师]
        LD[Level Designer<br/>关卡设计师]
        ED[Economy Designer<br/>经济设计师]
        UX[UX Designer<br/>UX设计师]
    end
    
    subgraph "Tier 3: 程序专家"
        direction LR
        GP[Gameplay Programmer<br/>游戏程序员]
        EP[Engine Programmer<br/>引擎程序员]
        AIP[AI Programmer<br/>AI程序员]
        NP[Network Programmer<br/>网络程序员]
        UIP[UI Programmer<br/>UI程序员]
        TP[Tools Programmer<br/>工具程序员]
    end
    
    subgraph "Tier 3: 艺术与技术专家"
        direction LR
        TA[Technical Artist<br/>技术美术]
        SDES[Sound Designer<br/>声音设计师]
        WR[Writer<br/>编剧]
        WB[World Builder<br/>世界观设计师]
    end
    
    subgraph "Tier 3: 引擎专属专家"
        direction TB
        subgraph "Godot"
            GS[Godot Specialist]
            GDS[GDScript Specialist]
            GSH[Shader Specialist]
            GDE[GDExtension Specialist]
        end
        
        subgraph "Unity"
            US[Unity Specialist]
            UDOTS[DOTS Specialist]
            USH[Shader Specialist]
            UA[Addressables Specialist]
            UUI[UI Specialist]
        end
        
        subgraph "Unreal"
            UE[Unreal Specialist]
            GAS[GAS Specialist]
            BP[Blueprint Specialist]
            REP[Replication Specialist]
            UMG[UMG Specialist]
        end
    end
    
    CD --> GD
    CD --> AD
    CD --> ND
    
    TD --> LP
    TD --> EP
    
    PRODUCER --> QA
    PRODUCER --> RM
    
    GD --> SD
    GD --> LD
    GD --> ED
    
    LP --> GP
    LP --> EP
    LP --> AIP
    LP --> NP
    
    AD --> TA
    AUD --> SDES
    ND --> WR
    ND --> WB
    
    LP -.-> GS
    LP -.-> US
    LP -.-> UE
```

---

## 3. 7阶段开发工作流程图

```mermaid
flowchart LR
    subgraph "Phase 1"
        A[💡 概念阶段<br/>Concept]
    end
    
    subgraph "Phase 2"
        B[📐 预制作<br/>Pre-Production]
    end
    
    subgraph "Phase 3"
        C[🔨 制作 Alpha<br/>Production α]
    end
    
    subgraph "Phase 4"
        D[🔨 制作 Beta<br/>Production β]
    end
    
    subgraph "Phase 5"
        E[✨ 打磨阶段<br/>Polish]
    end
    
    subgraph "Phase 6"
        F[🚀 发布准备<br/>Release Prep]
    end
    
    subgraph "Phase 7"
        G[🌐 上线运营<br/>Live Ops]
    end
    
    A -->|/setup-engine<br/>/map-systems| B
    B -->|/create-architecture<br/>/design-system| C
    C -->|/create-epics<br/>/dev-story| D
    D -->|/content-audit<br/>/balance-check| E
    E -->|/team-polish<br/>/bug-triage| F
    F -->|/release-checklist<br/>/launch-checklist| G
    
    style A fill:#e3f2fd
    style B fill:#e8f5e9
    style C fill:#fff3e0
    style D fill:#fff3e0
    style E fill:#fce4ec
    style F fill:#f3e5f5
    style G fill:#e8eaf6
```

---

## 4. 概念阶段详细流程图

```mermaid
flowchart TD
    START([开始]) --> DETECT{已有概念?}
    
    DETECT -->|没有| BRAINSTORM[/brainstorm open/]
    DETECT -->|有模糊想法| BRAINSTORM2[/brainstorm 主题/]
    DETECT -->|有明确概念| SETUP[/setup-engine/]
    
    BRAINSTORM --> SELECT{选择概念}
    BRAINSTORM2 --> SELECT
    
    SELECT --> CONCEPT_DOC[创建<br/>game-concept.md]
    SELECT --> PILLARS[创建<br/>game-pillars.md]
    
    CONCEPT_DOC --> SETUP
    PILLARS --> SETUP
    
    SETUP --> ENGINE{引擎选择}
    
    ENGINE -->|Godot| GODOT_CONFIG[配置 Godot<br/>技术偏好]
    ENGINE -->|Unity| UNITY_CONFIG[配置 Unity<br/>技术偏好]
    ENGINE -->|Unreal| UNREAL_CONFIG[配置 Unreal<br/>技术偏好]
    
    GODOT_CONFIG --> TECH_PREF[.codebuddy/docs/<br/>technical-preferences.md]
    UNITY_CONFIG --> TECH_PREF
    UNREAL_CONFIG --> TECH_PREF
    
    TECH_PREF --> MAP_SYSTEMS[/map-systems/]
    
    MAP_SYSTEMS --> SYSTEMS_INDEX[design/<br/>systems-index.md]
    
    SYSTEMS_INDEX --> GATE_CHECK{检查点<br/>/gate-check concept}
    
    GATE_CHECK -->|PASS| END([进入预制作阶段])
    GATE_CHECK -->|FAIL| REVISE[修改概念]
    REVISE --> GATE_CHECK
    
    style START fill:#4caf50,color:#fff
    style END fill:#2196f3,color:#fff
    style GATE_CHECK fill:#ff9800
    style REVISE fill:#f44336,color:#fff
```

---

## 5. 游戏开发决策树

```mermaid
flowchart TD
    START([开始]) --> FIRST_TIME{第一次使用?}
    
    FIRST_TIME -->|是| START_CMD[/start/]
    FIRST_TIME -->|否| PROJECT_STATE{项目状态?}
    
    START_CMD --> STATE_A{当前状态}
    
    STATE_A -->|没有想法| BRAINSTORM[/brainstorm open/]
    STATE_A -->|模糊想法| BRAINSTORM_HINT[/brainstorm 主题/]
    STATE_A -->|明确概念| SETUP[/setup-engine/]
    STATE_A -->|已有工作| ADOPT[/adopt/]
    
    PROJECT_STATE -->|概念阶段| CONCEPT_WORK[概念设计]
    PROJECT_STATE -->|预制作| PRE_PROD[系统设计]
    PROJECT_STATE -->|制作中| PRODUCTION[功能开发]
    PROJECT_STATE -->|打磨中| POLISH[品质提升]
    PROJECT_STATE -->|准备发布| RELEASE[发布准备]
    
    CONCEPT_WORK -->|需要创意| BRAINSTORM
    CONCEPT_WORK -->|需要分解| MAP_SYSTEMS[/map-systems/]
    
    PRE_PROD -->|设计系统| DESIGN_SYSTEM[/design-system/]
    PRE_PROD -->|创建架构| ARCH[/create-architecture/]
    
    PRODUCTION -->|创建史诗| EPICS[/create-epics/]
    PRODUCTION -->|创建故事| STORIES[/create-stories/]
    PRODUCTION -->|开发故事| DEV_STORY[/dev-story/]
    
    POLISH -->|性能优化| PERF[/perf-profile/]
    POLISH -->|Bug修复| BUGS[/bug-triage/]
    POLISH -->|打磨团队| POLISH_TEAM[/team-polish/]
    
    RELEASE -->|发布清单| REL_CHECK[/release-checklist/]
    RELEASE -->|发布团队| REL_TEAM[/team-release/]
    
    BRAINSTORM --> SETUP
    ADOPT --> SETUP
    MAP_SYSTEMS --> SETUP
    DESIGN_SYSTEM --> ARCH
    EPICS --> STORIES
    STORIES --> DEV_STORY
    DEV_STORY --> CODE_REVIEW[/code-review/]
    CODE_REVIEW --> STORY_DONE[/story-done/]
    PERF --> POLISH_TEAM
    BUGS --> POLISH_TEAM
    REL_CHECK --> REL_TEAM
    
    style START fill:#4caf50,color:#fff
    style FIRST_TIME fill:#2196f3,color:#fff
    style STATE_A fill:#ff9800
```

---

## 6. Skill 分类结构图

```mermaid
mindmap
  root((CCBGS<br/>Skills))
    入门与导航
      /start - 引导入门
      /help - 获取帮助
      /project-stage-detect - 项目检测
      /setup-engine - 引擎配置
      /adopt - 项目迁移
    游戏设计
      /brainstorm - 头脑风暴
      /map-systems - 系统分解
      /design-system - 系统设计
      /quick-design - 快速设计
      /review-all-gdds - 设计审查
      /propagate-design-change - 变更传播
    架构设计
      /create-architecture - 创建架构
      /architecture-decision - ADR决策
      /architecture-review - 架构审查
      /create-control-manifest - 控制清单
    故事与迭代
      /create-epics - 创建史诗
      /create-stories - 创建故事
      /dev-story - 开发故事
      /sprint-plan - 迭代规划
      /sprint-status - 迭代状态
      /story-readiness - 准备度检查
      /story-done - 故事完成
      /estimate - 工作量估算
    审查与分析
      /design-review - 设计审查
      /code-review - 代码审查
      /balance-check - 平衡检查
      /asset-audit - 资源审计
      /scope-check - 范围检查
      /gate-check - 阶段检查
      /consistency-check - 一致性检查
    QA与测试
      /qa-plan - QA计划
      /smoke-check - 冒烟测试
      /regression-suite - 回归测试
      /test-setup - 测试设置
      /test-helpers - 测试助手
    团队协作
      /team-combat - 战斗团队
      /team-narrative - 叙事团队
      /team-ui - UI团队
      /team-release - 发布团队
      /team-polish - 打磨团队
      /team-level - 关卡团队
      /team-qa - QA团队
      /team-live-ops - 运营团队
```

---

## 7. 团队协作流程图

```mermaid
sequenceDiagram
    actor User as 用户
    participant Producer as Producer<br/>(制作人)
    participant GD as Game Designer<br/>(游戏设计师)
    participant GP as Gameplay Programmer<br/>(游戏程序员)
    participant QA as QA Tester<br/>(测试员)
    participant Art as Technical Artist<br/>(技术美术)
    
    User->>Producer: 我想实现战斗系统
    Producer->>GD: 委派：设计战斗机制
    GD->>GD: 创建战斗设计文档
    GD-->>Producer: 设计完成
    
    Producer->>GP: 委派：实现战斗代码
    GP->>GP: 编写核心战斗逻辑
    
    par 并行工作
        GP->>Art: 请求：战斗特效
        Art->>Art: 创建特效
        Art-->>GP: 特效完成
    and
        GP->>GP: 继续实现
    end
    
    GP-->>Producer: 实现完成
    
    Producer->>QA: 委派：测试战斗系统
    QA->>QA: 执行测试用例
    QA-->>Producer: 测试报告
    
    alt 发现Bug
        Producer->>GP: 修复Bug
        GP-->>QA: 重新测试
    else 测试通过
        Producer-->>User: 战斗系统完成
    end
```

---

## 8. /dev-story 详细流程图

```mermaid
flowchart TD
    START([开始开发故事]) --> READ_STORY[读取故事文件]
    
    READ_STORY --> READINESS[/story-readiness/]
    
    READINESS --> STATE{准备度}
    
    STATE -->|READY| ROUTE{故事类型}
    STATE -->|NEEDS WORK| CLARIFY[澄清需求]
    STATE -->|BLOCKED| UNBLOCK[解决阻塞]
    
    CLARIFY --> READINESS
    UNBLOCK --> READINESS
    
    ROUTE -->|Gameplay| GP[@gameplay-programmer]
    ROUTE -->|AI| AI[@ai-programmer]
    ROUTE -->|UI| UI[@ui-programmer]
    ROUTE -->|Engine| EP[@engine-programmer]
    ROUTE -->|Network| NP[@network-programmer]
    
    GP --> IMPLEMENT[实现代码]
    AI --> IMPLEMENT
    UI --> IMPLEMENT
    EP --> IMPLEMENT
    NP --> IMPLEMENT
    
    IMPLEMENT --> WRITE_TESTS[编写测试]
    
    WRITE_TESTS --> CODE_REVIEW[/code-review/]
    
    CODE_REVIEW --> REVIEW_RESULT{审查结果}
    
    REVIEW_RESULT -->|APPROVED| VERIFY_AC[验证验收标准]
    REVIEW_RESULT -->|CHANGES| REVISE[修改代码]
    REVISE --> CODE_REVIEW
    
    VERIFY_AC --> CRITERIA{验收通过?}
    
    CRITERIA -->|YES| UPDATE_DOC[更新文档]
    CRITERIA -->|NO| FIX_ISSUES[修复问题]
    FIX_ISSUES --> VERIFY_AC
    
    UPDATE_DOC --> STORY_DONE[/story-done/]
    
    STORY_DONE --> MARK_COMPLETE[标记故事完成]
    
    MARK_COMPLETE --> END([故事开发完成])
    
    style START fill:#4caf50,color:#fff
    style END fill:#2196f3,color:#fff
    style READINESS fill:#ff9800
    style STATE fill:#ff9800
    style REVIEW_RESULT fill:#ff9800
    style CRITERIA fill:#ff9800
```

---

## 9. 迭代（Sprint）流程图

```mermaid
flowchart LR
    subgraph "迭代开始"
        A[/sprint-plan new/] --> B[创建迭代计划]
    end
    
    subgraph "每日开发"
        C[/dev-story/] --> D[开发功能]
        D --> E[/code-review/]
        E --> F[/story-done/]
        F -.-> C
    end
    
    subgraph "迭代监控"
        G[/sprint-status/] --> H{进度正常?}
        H -->|是| 继续
        H -->|否| I[/scope-check/]
        I --> J[调整范围]
    end
    
    subgraph "迭代结束"
        K[/qa-plan/] --> L[QA测试]
        L --> M[/smoke-check/]
        M -->|PASS| N[/retrospective/]
        M -->|FAIL| O[修复问题]
        O --> L
        N --> P{继续下个<br/>迭代?}
        P -->|是| Q[/sprint-plan new/]
        P -->|否| R[阶段检查]
    end
    
    A --> C
    F --> G
    J --> K
    Q -.-> C
    
    style A fill:#e3f2fd
    style Q fill:#e3f2fd
    style N fill:#e8f5e9
    style R fill:#fff3e0
```

---

## 10. Gate Check 阶段门检查流程

```mermaid
flowchart TD
    START([开始阶段检查]) --> SELECT_PHASE{选择阶段}
    
    SELECT_PHASE -->|Concept| CHECK_CONCEPT[/gate-check concept/]
    SELECT_PHASE -->|Pre-Production| CHECK_PRE[/gate-check pre-production/]
    SELECT_PHASE -->|Production α| CHECK_ALPHA[/gate-check production-alpha/]
    SELECT_PHASE -->|Production β| CHECK_BETA[/gate-check production-beta/]
    SELECT_PHASE -->|Polish| CHECK_POLISH[/gate-check polish/]
    SELECT_PHASE -->|Release| CHECK_RELEASE[/gate-check release/]
    
    CHECK_CONCEPT --> RESULT{检查结果}
    CHECK_PRE --> RESULT
    CHECK_ALPHA --> RESULT
    CHECK_BETA --> RESULT
    CHECK_POLISH --> RESULT
    CHECK_RELEASE --> RESULT
    
    RESULT -->|PASS| APPROVED[✅ 阶段通过]
    RESULT -->|CONCERNS| CONCERNS[⚠️ 有顾虑]
    RESULT -->|FAIL| FAIL[❌ 阶段失败]
    
    APPROVED --> NEXT_PHASE[进入下一阶段]
    
    CONCERNS --> REVIEW[审查顾虑项]
    REVIEW --> MITIGATE[制定缓解计划]
    MITIGATE --> RESULT2{接受风险?}
    RESULT2 -->|是| NEXT_PHASE
    RESULT2 -->|否| FIX_CONCERNS[修复问题]
    FIX_CONCERNS --> CHECK_CONCEPT
    
    FAIL --> IDENTIFY[识别问题]
    IDENTIFY --> FIX[修复问题]
    FIX --> RE_CHECK{重新检查}
    RE_CHECK -->|通过| APPROVED
    RE_CHECK -->|未通过| FAIL
    
    NEXT_PHASE --> END([阶段门完成])
    
    style START fill:#4caf50,color:#fff
    style END fill:#2196f3,color:#fff
    style APPROVED fill:#4caf50,color:#fff
    style CONCERNS fill:#ff9800
    style FAIL fill:#f44336,color:#fff
    style RESULT fill:#2196f3,color:#fff
    style RESULT2 fill:#2196f3,color:#fff
```

---

## 11. 文件依赖关系图

```mermaid
graph TB
    subgraph "概念层"
        PILLARS[design/game-pillars.md<br/>设计支柱]
        CONCEPT[design/gdd/game-concept.md<br/>游戏概念]
    end
    
    subgraph "系统层"
        SYSTEMS[design/systems-index.md<br/>系统索引]
        GDD1[design/gdd/combat.md<br/>战斗系统GDD]
        GDD2[design/gdd/inventory.md<br/>库存系统GDD]
        GDD3[design/gdd/progression.md<br/>进度系统GDD]
    end
    
    subgraph "架构层"
        ARCH[docs/architecture/overview.md<br/>架构文档]
        ADR1[docs/architecture/adr/combat-system.md<br/>战斗系统ADR]
        ADR2[docs/architecture/adr/inventory-system.md<br/>库存系统ADR]
    end
    
    subgraph "实现层"
        EPICS[production/epics/combat-epic.md<br/>战斗史诗]
        STORY1[production/stories/basic-attack.md<br/>基础攻击故事]
        STORY2[production/stories/combo-system.md<br/>连击系统故事]
        CODE1[src/gameplay/combat/attack.gd<br/>攻击代码]
        CODE2[src/gameplay/combat/combo.gd<br/>连击代码]
    end
    
    subgraph "测试层"
        TEST1[tests/gameplay/test_attack.gd<br/>攻击测试]
        TEST2[tests/gameplay/test_combo.gd<br/>连击测试]
    end
    
    PILLARS --> CONCEPT
    CONCEPT --> SYSTEMS
    SYSTEMS --> GDD1
    SYSTEMS --> GDD2
    SYSTEMS --> GDD3
    
    GDD1 --> ADR1
    GDD2 --> ADR2
    
    ADR1 --> ARCH
    ADR2 --> ARCH
    
    GDD1 --> EPICS
    ADR1 --> EPICS
    
    EPICS --> STORY1
    EPICS --> STORY2
    
    STORY1 --> CODE1
    STORY2 --> CODE2
    
    CODE1 --> TEST1
    CODE2 --> TEST2
    
    style PILLARS fill:#e3f2fd
    style CONCEPT fill:#e3f2fd
    style SYSTEMS fill:#e8f5e9
    style GDD1 fill:#e8f5e9
    style GDD2 fill:#e8f5e9
    style GDD3 fill:#e8f5e9
    style ARCH fill:#fff3e0
    style ADR1 fill:#fff3e0
    style ADR2 fill:#fff3e0
    style EPICS fill:#fce4ec
    style STORY1 fill:#fce4ec
    style STORY2 fill:#fce4ec
    style CODE1 fill:#f3e5f5
    style CODE2 fill:#f3e5f5
```

---

## 12. Hook 触发流程图

```mermaid
flowchart TD
    subgraph "Session 生命周期"
        START[SessionStart]
        STOP[Stop]
        PRE_COMPACT[PreCompact]
        POST_COMPACT[PostCompact]
    end
    
    subgraph "工具使用"
        PRE_TOOL[PreToolUse]
        POST_TOOL[PostToolUse]
    end
    
    subgraph "Agent 生命周期"
        AGENT_START[SubagentStart]
        AGENT_STOP[SubagentStop]
    end
    
    subgraph "通知"
        NOTIFY[Notification]
    end
    
    START -->|触发| HOOK1[session-start.sh<br/>加载上下文]
    START -->|触发| HOOK2[detect-gaps.sh<br/>检测缺失]
    
    PRE_TOOL -->|git commit| HOOK3[validate-commit.sh<br/>验证提交]
    PRE_TOOL -->|git push| HOOK4[validate-push.sh<br/>验证推送]
    
    POST_TOOL -->|assets/*| HOOK5[validate-assets.sh<br/>验证资源]
    POST_TOOL -->|skills/*| HOOK6[validate-skill-change.sh<br/>验证Skill]
    
    PRE_COMPACT -->|触发| HOOK7[pre-compact.sh<br/>保存状态]
    POST_COMPACT -->|触发| HOOK8[post-compact.sh<br/>恢复提醒]
    
    STOP -->|触发| HOOK9[session-stop.sh<br/>总结会话]
    
    AGENT_START -->|触发| HOOK10[log-agent.sh<br/>记录开始]
    AGENT_STOP -->|触发| HOOK11[log-agent-stop.sh<br/>记录结束]
    
    NOTIFY -->|触发| HOOK12[notify.sh<br/>弹窗通知]
    
    style HOOK1 fill:#e3f2fd
    style HOOK2 fill:#e3f2fd
    style HOOK3 fill:#e8f5e9
    style HOOK4 fill:#e8f5e9
    style HOOK5 fill:#fff3e0
    style HOOK6 fill:#fff3e0
    style HOOK7 fill:#fce4ec
    style HOOK8 fill:#fce4ec
    style HOOK9 fill:#f3e5f5
    style HOOK10 fill:#e1f5ff
    style HOOK11 fill:#e1f5ff
    style HOOK12 fill:#fff8e1
```

---

## 如何使用这些图表

### 在 Markdown 中查看

这些图表使用 Mermaid 语法，可以在支持 Mermaid 的 Markdown 查看器中渲染：
- GitHub/GitLab
- VS Code (with Mermaid extension)
- Typora
- Notion

### 导出为图片

使用 Mermaid CLI 导出：
```bash
# 安装 Mermaid CLI
npm install -g @mermaid-js/mermaid-cli

# 导出为 PNG
mmdc -i 09-Diagrams-and-Charts.md -o diagrams.png

# 导出为 SVG
mmdc -i 09-Diagrams-and-Charts.md -o diagrams.svg
```

### 在线编辑

在 [Mermaid Live Editor](https://mermaid.live/) 中粘贴代码进行编辑和预览。

---

> **提示**: 这些图表是项目的可视化参考，可以帮助你快速理解架构和工作流程。建议结合文字文档一起阅读。
