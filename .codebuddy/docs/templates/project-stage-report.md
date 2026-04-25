# Project Stage Analysis Report / 项目阶段分析报告

**Generated** / **生成于**: [DATE] / [日期]
**Stage** / **阶段**: [Concept | Systems Design | Technical Setup | Pre-Production | Production | Polish | Release] / [概念 | 系统设计 | 技术设置 | 预生产 | 生产 | 打磨 | 发布]
**Analysis Scope** / **分析范围**: [Full project | Specific role: programmer/designer/producer] / [完整项目 | 特定角色：程序员/设计师/制作人]

---

## Executive Summary / 执行摘要

[1-2 paragraph overview of project state, primary gaps, and recommended priority] / [关于项目状态、主要差距和推荐优先级的1-2段概述]

**Current Focus** / **当前重点**: [What the project is actively working on] / [项目正在积极进行的工作]
**Blocking Issues** / **阻塞问题**: [Critical gaps preventing progress] / [阻碍进展的关键差距]
**Estimated Time to Next Stage** / **到下一阶段的估计时间**: [If applicable] / [如果适用]

---

## Completeness Overview / 完成度概览

### Design Documentation / 设计文档
- **Status** / **状态**: [X%] complete / [X%] 完成
- **Files Found** / **找到的文件**: [N] documents in `design/` / [N] 个文档在 `design/` 中
  - GDD sections: [N] files in `design/gdd/` / GDD部分：[N] 个文件在 `design/gdd/` 中
  - Narrative docs: [N] files in `design/narrative/` / 叙事文档：[N] 个文件在 `design/narrative/` 中
  - Level designs: [N] files in `design/levels/` / 关卡设计：[N] 个文件在 `design/levels/` 中
- **Key Gaps** / **关键差距**:
  - [ ] [Missing doc 1 + why it matters] / [缺失的文档1 + 为什么重要]
  - [ ] [Missing doc 2 + why it matters] / [缺失的文档2 + 为什么重要]

### Source Code / 源代码
- **Status** / **状态**: [X%] complete / [X%] 完成
- **Files Found** / **找到的文件**: [N] source files in `src/` / [N] 个源文件在 `src/` 中
- **Major Systems Identified** / **识别的主要系统**:
  - ✅ [System 1] (`src/path/`) — [brief status] / [系统1] (`src/path/`) — [简要状态]
  - ✅ [System 2] (`src/path/`) — [brief status] / [系统2] (`src/path/`) — [简要状态]
  - ⚠️  [System 3] (`src/path/`) — [issue or incomplete] / [系统3] (`src/path/`) — [问题或不完整]
- **Key Gaps** / **关键差距**:
  - [ ] [Missing system 1 + impact] / [缺失的系统1 + 影响]
  - [ ] [Missing system 2 + impact] / [缺失的系统2 + 影响]

### Architecture Documentation
- **Status**: [X%] complete
- **ADRs Found**: [N] decisions documented in `docs/architecture/`
- **Coverage**:
  - ✅ [Decision area 1] — documented
  - ⚠️  [Decision area 2] — undocumented but implemented
  - ❌ [Decision area 3] — neither documented nor decided
- **Key Gaps**:
  - [ ] [Missing ADR 1 + why it's needed]
  - [ ] [Missing ADR 2 + why it's needed]

### Production Management
- **Status**: [X%] complete
- **Found**:
  - Sprint plans: [N] in `production/sprints/`
  - Milestones: [N] in `production/milestones/`
  - Roadmap: [Exists | Missing]
- **Key Gaps**:
  - [ ] [Missing production artifact + impact]

### Testing
- **Status**: [X%] coverage (estimated)
- **Test Files**: [N] in `tests/`
- **Coverage by System**:
  - [System 1]: [X%] (estimated)
  - [System 2]: [X%] (estimated)
- **Key Gaps**:
  - [ ] [Missing test area + risk]

### Prototypes
- **Active Prototypes**: [N] in `prototypes/`
  - ✅ [Prototype 1] — documented with README
  - ⚠️  [Prototype 2] — no README, unclear status
- **Archived**: [N] (experiments completed)
- **Key Gaps**:
  - [ ] [Undocumented prototype + why it matters]

---

## Stage Classification Rationale

**Why [Stage]?**

[Explain why the project is classified at this stage based on indicators found]

**Indicators for this stage**:
- [Indicator 1 that matches this stage]
- [Indicator 2 that matches this stage]

**Next stage requirements**:
- [ ] [Requirement 1 to reach next stage]
- [ ] [Requirement 2 to reach next stage]
- [ ] [Requirement 3 to reach next stage]

---

## Gaps Identified (with Clarifying Questions)

### Critical Gaps (block progress)

1. **[Gap Name]**
   - **Impact**: [Why this blocks progress]
   - **Question**: [Clarifying question before assuming solution]
   - **Suggested Action**: [What could be done, pending clarification]

### Important Gaps (affect quality/velocity)

2. **[Gap Name]**
   - **Impact**: [Why this matters]
   - **Question**: [Clarifying question]
   - **Suggested Action**: [Proposed solution]

### Nice-to-Have Gaps (polish/best practices)

3. **[Gap Name]**
   - **Impact**: [Minor but valuable]
   - **Question**: [Clarifying question]
   - **Suggested Action**: [Optional improvement]

---

## Recommended Next Steps

### Immediate Priority (Do First)
1. **[Action 1]** — [Why it's priority 1]
   - Suggested skill: `/[skill-name]` or manual work
   - Estimated effort: [S/M/L]

2. **[Action 2]** — [Why it's priority 2]
   - Suggested skill: `/[skill-name]`
   - Estimated effort: [S/M/L]

### Short-Term (This Sprint/Week)
3. **[Action 3]** — [Why it's important soon]
4. **[Action 4]** — [Why it's important soon]

### Medium-Term (Next Milestone)
5. **[Action 5]** — [Future need]
6. **[Action 6]** — [Future need]

---

## Role-Specific Recommendations

[If role filter was used, provide role-specific guidance]

### For [Role]:
- **Focus areas**: [What this role should prioritize]
- **Blockers**: [What's blocking this role's work]
- **Next tasks**:
  1. [Task 1]
  2. [Task 2]

---

## Follow-Up Skills to Run

Based on gaps identified, consider running:

- `/reverse-document [type] [path]` — [For which gap]
- `/architecture-decision` — [For which gap]
- `/sprint-plan` — [If production planning missing]
- `/milestone-review` — [If approaching deadline]
- `/onboard [role]` — [If new contributor joining]

---

## Appendix: File Counts by Directory

```
design/
  gdd/           [N] files
  narrative/     [N] files
  levels/        [N] files

src/
  core/          [N] files
  gameplay/      [N] files
  ai/            [N] files
  networking/    [N] files
  ui/            [N] files

docs/
  architecture/  [N] ADRs

production/
  sprints/       [N] plans
  milestones/    [N] definitions

tests/           [N] test files
prototypes/      [N] directories
```

---

**End of Report**

*Generated by `/project-stage-detect` skill*
