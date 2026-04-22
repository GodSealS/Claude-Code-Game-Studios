# Hook: post-sprint-retrospective / 钩子：冲刺后回顾

## Trigger / 触发条件

Manual trigger at the end of each sprint (typically invoked by the producer
agent or the human developer).

> **中文翻译**：每个冲刺结束时的手动触发（通常由制作人代理或人类开发者调用）。

## Purpose / 目的

Automatically generates a retrospective starting point by analyzing the sprint
data: what was planned vs completed, velocity changes, bug trends, and common
blockers. This is not a git hook but a workflow hook invoked through the
`producer` agent.

> **中文翻译**：通过分析冲刺数据自动生成回顾起点：计划与完成对比、速度变化、缺陷趋势和常见阻塞因素。这不是 git 钩子，而是通过 `producer` 代理调用的工作流钩子。

## Implementation / 实现

This is a workflow hook, not a git hook. It is invoked by running:
> **中文翻译**：这是工作流钩子，不是 git 钩子。通过以下方式调用：

```
@producer Generate sprint retrospective for Sprint [N]
```

The producer agent should:
> **中文翻译**：制作人代理应：

1. **Read the sprint plan** from `production/sprints/sprint-[N].md`
   > **中文翻译**：**读取冲刺计划**，从 `production/sprints/sprint-[N].md`
2. **Calculate metrics**:
   > **中文翻译**：**计算指标**：
   - Tasks planned vs completed
     > **中文翻译**：计划任务与完成任务对比
   - Story points planned vs completed (if used)
     > **中文翻译**：计划故事点与完成故事点对比（如使用）
   - Carryover items from previous sprint
     > **中文翻译**：上一冲刺的结转项
   - New tasks added mid-sprint
     > **中文翻译**：冲刺中途新增的任务
   - Average task completion time
     > **中文翻译**：平均任务完成时间
3. **Analyze patterns**:
   > **中文翻译**：**分析模式**：
   - Most common blockers
     > **中文翻译**：最常见的阻塞因素
   - Which agent/area had the most incomplete work
     > **中文翻译**：哪个代理/领域有最多的未完成工作
   - Which estimates were most inaccurate
     > **中文翻译**：哪些估算最不准确
4. **Generate the retrospective**:
   > **中文翻译**：**生成回顾**：

```markdown
# Sprint [N] Retrospective / 冲刺 [N] 回顾

## Metrics / 指标
| Metric | Value |
|--------|-------|
| Tasks Planned | [N] |
| Tasks Completed | [N] |
| Completion Rate | [X%] |
| Carryover from Previous | [N] |
| New Tasks Added | [N] |
| Bugs Found | [N] |
| Bugs Fixed | [N] |

## Velocity Trend / 速度趋势
[Sprint N-2]: [X] | [Sprint N-1]: [Y] | [Sprint N]: [Z]
Trend: [Improving / Stable / Declining]
趋势：[改善 / 稳定 / 下降]

## What Went Well / 做得好的方面
- [Automatically detected: tasks completed ahead of estimate]
- [自动检测：提前完成的任务]
- [Facilitator adds team observations]
- [引导者添加团队观察]

## What Went Poorly / 做得不好的方面
- [Automatically detected: tasks that were carried over or cut]
- [自动检测：被结转或削减的任务]
- [Automatically detected: areas with significant estimate overruns]
- [自动检测：估算严重超出的领域]
- [Facilitator adds team observations]
- [引导者添加团队观察]

## Blockers / 阻塞因素
| Blocker | Frequency | Resolution Time | Prevention |
|---------|-----------|----------------|-----------|

## Action Items for Next Sprint / 下一冲刺行动项
| # | Action | Owner | Priority |
|---|--------|-------|----------|

## Estimation Accuracy / 估算准确度
| Area | Avg Planned | Avg Actual | Accuracy |
|------|------------|-----------|----------|
```

5. **Save** to `production/sprints/sprint-[N]-retro.md`
   > **中文翻译**：**保存**到 `production/sprints/sprint-[N]-retro.md`
