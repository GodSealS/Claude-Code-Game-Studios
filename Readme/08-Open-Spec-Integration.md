# Open Spec 集成指南

本文档介绍如何将 CodeBuddy Game Studios 提示词工程与 Open Spec 结合使用，实现更强大的游戏开发工作流。

---

## 什么是 Open Spec？

Open Spec 是一种开放规范格式，用于定义：
- **API 规范** - 接口和数据格式
- **工作流规范** - 流程和步骤
- **Agent 规范** - 角色和能力
- **项目规范** - 项目结构和约定

通过与 Open Spec 集成，可以：
1. **标准化** - 统一项目间的规范
2. **可移植性** - 在不同项目间复用配置
3. **验证** - 自动验证项目合规性
4. **文档化** - 自动生成文档

---

## 集成架构

```
┌─────────────────────────────────────────────────────────────┐
│                    Open Spec 层                              │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────────────┐  │
│  │ API Specs   │  │ Workflow    │  │ Agent Definitions   │  │
│  │             │  │ Specs       │  │                     │  │
│  └─────────────┘  └─────────────┘  └─────────────────────┘  │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│              CodeBuddy Game Studios 层                       │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────────────┐  │
│  │ Agents      │  │ Skills      │  │ Hooks & Rules       │  │
│  │ (49)        │  │ (72)        │  │                     │  │
│  └─────────────┘  └─────────────┘  └─────────────────────┘  │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                    项目实现层                                │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────────────┐  │
│  │ Source Code │  │ Design Docs │  │ Tests               │  │
│  └─────────────┘  └─────────────┘  └─────────────────────┘  │
└─────────────────────────────────────────────────────────────┘
```

---

## 集成方式

### 方式 1: Spec 驱动的项目生成

使用 Open Spec 定义项目模板，自动生成 CodeBuddy Game Studios 结构。

**步骤**:

1. **定义项目 Spec**
   ```yaml
   # project-spec.yaml
   project:
     name: "My RPG Game"
     type: "rpg"
     engine: "godot"
     engine_version: "4.6"
     
   agents:
     include:
       - leadership
       - design
       - programming
       - godot-specialists
     exclude:
       - unreal-specialists
       - unity-specialists
   
   systems:
     - combat
     - inventory
     - progression
     - dialogue
   
   workflow:
     sprints:
       duration: 2_weeks
     gates:
       - concept
       - pre_production
       - production_alpha
       - production_beta
       - polish
       - release
   ```

2. **生成项目结构**
   ```bash
   openspec generate project-spec.yaml --template ccbgs
   ```

3. **输出**
   - 完整的 `.codebuddy/` 结构
   - 根据系统列表生成的 GDD 模板
   - 配置好的 `CODEBUDDY.md`

---

### 方式 2: Spec 验证和合规性检查

使用 Open Spec 验证项目是否符合规范。

**步骤**:

1. **定义规范**
   ```yaml
   # compliance-spec.yaml
   compliance:
     required_docs:
       - design/game-pillars.md
       - design/systems-index.md
       - docs/architecture/overview.md
     
     required_agents:
       - producer
       - game-designer
       - lead-programmer
     
     coding_standards:
       - no_hardcoded_values
       - delta_time_for_movement
       - data_driven_design
   ```

2. **运行合规性检查**
   ```bash
   openspec validate . --spec compliance-spec.yaml
   ```

3. **输出报告**
   ```
   ✅ design/game-pillars.md - 存在
   ✅ design/systems-index.md - 存在
   ❌ docs/architecture/overview.md - 缺失
   ⚠️  src/gameplay/player.gd:12 - 检测到硬编码值
   ```

---

### 方式 3: Agent 能力 Spec 化

将 Agent 定义导出为 Open Spec，便于在其他工具中使用。

**导出 Agent Spec**

```bash
# 从 CCBGS 导出 Agent 定义
ccbg export-agents --format openspec
```

**输出示例**
```yaml
# agents-spec.yaml
agents:
  producer:
    name: "Producer"
    description: "管理所有生产相关事务..."
    tier: "leadership"
    capabilities:
      - sprint_planning
      - milestone_tracking
      - risk_management
    tools:
      - Read
      - Write
      - Bash
    skills:
      - sprint-plan
      - scope-check
      - estimate
    model: "DeepSeek-V3.2"
    
  game-designer:
    name: "Game Designer"
    description: "游戏机制、系统、进度设计..."
    tier: "department_lead"
    capabilities:
      - mechanic_design
      - system_design
      - balance_tuning
    skills:
      - design-system
      - balance-check
```

---

### 方式 4: 工作流集成

将 CCBGS Skills 与 Open Spec 工作流引擎集成。

**定义工作流**
```yaml
# workflow-spec.yaml
workflow:
  name: "Feature Development"
  
  stages:
    - name: "Design"
      tasks:
        - type: skill
          name: "/design-system"
          input:
            system_name: "{{system_name}}"
      output:
        - design/gdd/{{system_name}}.md
      
    - name: "Review"
      tasks:
        - type: skill
          name: "/design-review"
          input:
            document: "design/gdd/{{system_name}}.md"
      gate:
        condition: approved
        
    - name: "Architecture"
      tasks:
        - type: skill
          name: "/architecture-decision"
          condition: "{{needs_adr}}"
      
    - name: "Implementation"
      tasks:
        - type: skill
          name: "/create-epics"
        - type: skill
          name: "/create-stories"
        - type: parallel
          tasks:
            - type: skill
              name: "/dev-story"
              for_each: "{{stories}}"
```

**执行工作流**
```bash
openspec run workflow-spec.yaml \
  --var system_name=combat \
  --var needs_adr=true
```

---

## 具体集成场景

### 场景 1: 跨项目复用 Agent 配置

**问题**: 多个游戏项目，希望使用相同的 Agent 配置。

**解决方案**:

1. **导出基础 Agent Spec**
   ```bash
   ccbg export-agents --filter "tier=leadership,department_lead" \
     > base-agents.yaml
   ```

2. **在不同项目中导入**
   ```bash
   openspec apply base-agents.yaml --project ./game-a
   openspec apply base-agents.yaml --project ./game-b
   ```

3. **项目特定扩展**
   ```yaml
   # game-a-specific.yaml
   agents:
     extends: base-agents.yaml
     add:
       - godot-gdscript-specialist
       - godot-shader-specialist
   ```

---

### 场景 2: CI/CD 集成

**问题**: 在 CI/CD 中自动验证项目合规性。

**解决方案**:

1. **定义 CI Spec**
   ```yaml
   # ci-spec.yaml
   pipeline:
     stages:
       - name: "Validate Docs"
         steps:
           - openspec validate --rule "design-docs-exist"
           - openspec validate --rule "gdd-complete"
       
       - name: "Check Consistency"
         steps:
           - ccbg run /consistency-check
       
       - name: "Code Standards"
         steps:
           - openspec validate --rule "no-hardcoded-values"
           - openspec validate --rule "naming-conventions"
   ```

2. **GitHub Actions 配置**
   ```yaml
   # .github/workflows/compliance.yml
   name: Compliance Check
   on: [push, pull_request]
   
   jobs:
     validate:
       runs-on: ubuntu-latest
       steps:
         - uses: actions/checkout@v3
         - name: Validate with Open Spec
           run: |
             openspec validate . --spec ci-spec.yaml
         - name: Run CCBGS Checks
           run: |
             ccbg run /gate-check pre-production
   ```

---

### 场景 3: 生成外部文档

**问题**: 为团队生成 Markdown/PDF 文档。

**解决方案**:

1. **导出项目结构为 Spec**
   ```bash
   ccbg export-project --format openspec > project-spec.yaml
   ```

2. **使用模板生成文档**
   ```bash
   openspec generate-docs project-spec.yaml \
     --template templates/team-handbook.md \
     --output docs/team-handbook.md
   ```

3. **生成 PDF**
   ```bash
   openspec generate-docs project-spec.yaml \
     --template templates/design-doc.pdf \
     --output design-document.pdf \
     --format pdf
   ```

---

### 场景 4: 与其他 AI 工具集成

**问题**: 在 Cursor、Windsurf 等其他 AI IDE 中使用 CCBGS Agent 定义。

**解决方案**:

1. **导出为通用格式**
   ```bash
   ccbg export-agents --format cursor-rules > .cursor/rules/ccbgs.mdc
   ccbg export-agents --format windsurf-rules > .windsurf/rules.md
   ```

2. **导出 Skills 为指令**
   ```bash
   ccbg export-skills --format prompts > prompts/
   ```

---

## 推荐集成模式

### 模式 1: 项目模板仓库

```
templates/
├── rpg-template/
│   ├── project-spec.yaml
│   ├── base-agents.yaml
│   └── initial-gdds/
├── shooter-template/
│   ├── project-spec.yaml
│   ├── base-agents.yaml
│   └── initial-gdds/
└── strategy-template/
    ├── project-spec.yaml
    ├── base-agents.yaml
    └── initial-gdds/
```

**使用**:
```bash
openspec generate templates/rpg-template \
  --var project_name="My RPG" \
  --output ./my-rpg
```

---

### 模式 2: 分层配置

```
config/
├── base/                    # 所有项目共享
│   ├── agents-core.yaml
│   └── skills-core.yaml
├── engine/                  # 引擎特定
│   ├── godot-agents.yaml
│   ├── unity-agents.yaml
│   └── unreal-agents.yaml
├── genre/                   # 类型特定
│   ├── rpg-agents.yaml
│   └── shooter-agents.yaml
└── project/                 # 项目特定
    └── project-override.yaml
```

**合并配置**:
```bash
openspec merge \
  config/base/agents-core.yaml \
  config/engine/godot-agents.yaml \
  config/genre/rpg-agents.yaml \
  > .codebuddy/agents/
```

---

### 模式 3: 运行时集成

```python
# integration.py
from ccbgs import AgentSystem
from openspec import Validator

# 加载 CCBGS Agent 系统
agents = AgentSystem.load(".codebuddy/agents/")

# 加载 Open Spec 验证器
validator = Validator.load("compliance-spec.yaml")

# 验证 Agent 配置
results = validator.validate_agents(agents)

# 导出为其他格式
agents.export("cursor", ".cursor/rules/")
agents.export("claude", ".claude/agents/")
```

---

## 实施步骤

### 第 1 步: 评估需求

确定你需要什么样的集成：
- [ ] 项目模板生成？
- [ ] 合规性验证？
- [ ] 跨工具复用？
- [ ] CI/CD 集成？

### 第 2 步: 导出当前配置

```bash
# 导出 Agents
ccbg export-agents > my-agents.yaml

# 导出 Skills
ccbg export-skills > my-skills.yaml

# 导出项目结构
ccbg export-project > my-project.yaml
```

### 第 3 步: 定义 Open Spec

基于导出的配置，创建 Open Spec 定义。

### 第 4 步: 设置验证

```bash
# 添加 pre-commit hook
echo "openspec validate ." > .git/hooks/pre-commit
chmod +x .git/hooks/pre-commit
```

### 第 5 步: CI 集成

添加 GitHub Actions/GitLab CI 工作流。

---

## 最佳实践

### 1. 版本控制 Spec

```bash
# 将 Open Spec 纳入版本控制
git add project-spec.yaml compliance-spec.yaml
```

### 2. 增量更新

```bash
# 只验证变更的部分
openspec validate --diff HEAD~1
```

### 3. 分层验证

```bash
# 基础验证（快速）
openspec validate --level basic

# 完整验证（慢速，CI 中使用）
openspec validate --level full
```

### 4. 自定义规则

```yaml
# my-rules.yaml
rules:
  - name: "gdd-requires-formulas"
    pattern: "design/gdd/*.md"
    must_contain: "## Math"
    severity: error
    
  - name: "no-hardcoded-colors"
    pattern: "src/**/*.gd"
    must_not_contain: "Color\\(1, 0, 0"
    severity: warning
```

---

## 工具链集成

### 与预提交钩子集成

```yaml
# .pre-commit-config.yaml
repos:
  - repo: local
    hooks:
      - id: openspec-validate
        name: Open Spec Validation
        entry: openspec validate
        language: system
        files: \\
.(md|gd|cs|cpp)$
```

### 与 Makefile 集成

```makefile
# Makefile
validate:
	openspec validate . --spec compliance-spec.yaml

generate-docs:
	openspec generate-docs project-spec.yaml --output docs/

export-agents:
	ccbg export-agents --format openspec > agents-spec.yaml
```

### 与 VS Code 集成

```json
// .vscode/tasks.json
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "Validate Project",
      "type": "shell",
      "command": "openspec validate .",
      "group": "test"
    }
  ]
}
```

---

## 常见问题

### Q: Open Spec 会替代 CCBGS 吗？

**A**: 不会。Open Spec 是对 CCBGS 的补充，提供标准化和可移植性。

### Q: 需要学习 Open Spec 语法吗？

**A**: 基础使用不需要。高级定制需要了解 YAML/JSON Schema。

### Q: 可以部分集成吗？

**A**: 可以。可以从最简单的 CI 验证开始，逐步深入。

### Q: 有现成的模板吗？

**A**: 社区正在开发标准模板，可以先从导出当前配置开始。

---

## 未来展望

### 计划中的集成

1. **Agent Registry** - 共享 Agent 定义的中央仓库
2. **Workflow Marketplace** - 预定义工作流模板
3. **IDE 插件** - 原生支持 Open Spec 的 IDE 插件
4. **可视化编辑器** - 图形化编辑 Spec 的工具

---

> **提示**: Open Spec 集成是可选的。如果你不需要跨项目复用或 CI 验证，可以仅使用 CCBGS 的核心功能。
