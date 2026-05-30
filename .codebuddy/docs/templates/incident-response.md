# Incident Response: [Incident Title] / 事件响应：[事件标题]

**Severity**: [S1-Critical / S2-Major / S3-Moderate / S4-Minor] / **严重性**: [S1-严重 / S2-重大 / S3-中等 / S4-轻微]
**Status**: [Active / Mitigated / Resolved / Post-Mortem Complete] / **状态**: [活跃 / 已缓解 / 已解决 / 事后分析完成]
**Detected**: [Date Time UTC] / **检测时间**: [日期时间 UTC]
**Resolved**: [Date Time UTC or ONGOING] / **解决时间**: [日期时间 UTC 或 进行中]
**Duration**: [Total time from detection to resolution] / **持续时间**: [从检测到解决的总时间]
**Incident Commander**: [Name/Role] / **事件指挥官**: [姓名/角色]

---

<!-- 中文翻译 -->
## Impact Summary / 影响摘要

[2-3 sentences describing what players experienced. Write from the player
perspective, not the technical perspective.] / [2-3句话描述玩家经历了什么。从玩家视角而非技术视角撰写。]

- **Players affected**: [estimated count or percentage] / **受影响玩家**: [估计数量或百分比]
- **Platforms affected**: [PC / Console / Mobile / All] / **受影响平台**: [PC / 主机 / 移动 / 全部]
- **Regions affected**: [All / specific regions] / **受影响区域**: [全部 / 特定区域]
- **Revenue impact**: [estimated if applicable] / **收入影响**: [如果适用，估计值]

---

<!-- 时间线 -->
## Timeline / 时间线

| Time (UTC) | Event | Action Taken | 时间 (UTC) | 事件 | 采取行动 |
| ---- | ---- | ---- | ---- | ---- | ---- |
| [HH:MM] | Incident detected via [monitoring/player report/etc.] | Incident commander assigned | [HH:MM] | 通过[监控/玩家报告等]检测到事件 | 指定事件指挥官 |
| [HH:MM] | Root cause identified | [Brief description of cause] | [HH:MM] | 根因已确定 | [原因简述] |
| [HH:MM] | Mitigation deployed | [What was done] | [HH:MM] | 缓解措施已部署 | [采取的行动] |
| [HH:MM] | Service restored / Fix confirmed | Monitoring for recurrence | [HH:MM] | 服务已恢复 / 修复已确认 | 监控是否复发 |
| [HH:MM] | All-clear declared | Post-mortem scheduled | [HH:MM] | 宣布解除警报 | 安排事后分析 |

---

<!-- 中文翻译 -->
## Root Cause / 根因

<!-- 中文翻译 -->
### What Happened / 发生了什么
[Technical description of the root cause. Be specific about the chain of events
that led to the incident.] / [根因的技术描述。详细说明导致事件的事件链。]

<!-- 中文翻译 -->
### Why It Happened / 为什么会发生
[Systemic cause — why did existing processes, tests, or safeguards fail to
prevent this? This is more important than the technical cause.] / [系统性原因——为什么现有的流程、测试或防护措施未能阻止此事件？这比技术原因更重要。]

<!-- 中文翻译 -->
### Contributing Factors / 促发因素
- [Factor 1 — e.g., "Insufficient load testing for the new matchmaking system"] / [因素1——例如："新匹配系统的负载测试不足"]
- [Factor 2 — e.g., "Monitoring alert threshold was set too high"] / [因素2——例如："监控警报阈值设置过高"]
- [Factor 3] / [因素3]

---

<!-- 中文翻译 -->
## Mitigation and Resolution / 缓解和解决

<!-- 中文翻译 -->
### Immediate Actions (during incident) / 即时行动（事件期间）
1. [Action taken to stop the bleeding] / [为止损采取的行动]
2. [Action taken to restore service] / [为恢复服务采取的行动]
3. [Action taken to verify resolution] / [为验证解决方案采取的行动]

<!-- 中文翻译 -->
### Follow-Up Actions (after resolution) / 后续行动（解决后）
1. [Permanent fix if immediate action was a workaround] / [如果即时行动是临时方案，这里是永久修复]
2. [Additional testing or monitoring added] / [添加的额外测试或监控]
3. [Process changes to prevent recurrence] / [防止再次发生的流程变更]

---

<!-- 中文翻译 -->
## Player Communication / 玩家沟通

<!-- 中文翻译 -->
### Initial Acknowledgment / 初始确认
*Sent: [Time] via [channel]* / *发送：[时间] 通过 [渠道]*
> [Exact text of the first public message acknowledging the issue] / [首次公开确认问题的确切文本]

<!-- 中文翻译 -->
### Status Updates / 状态更新
*Sent: [Time] via [channel]* / *发送：[时间] 通过 [渠道]*
> [Text of each subsequent update] / [每次后续更新的文本]

<!-- 中文翻译 -->
### Resolution Notice / 解决通知
*Sent: [Time] via [channel]* / *发送：[时间] 通过 [渠道]*
> [Text announcing the fix and any compensation] / [宣布修复和任何补偿的文本]

<!-- 中文翻译 -->
### Compensation (if applicable) / 补偿（如适用）
- **What**: [description of compensation — e.g., "500 premium currency + 24-hour XP boost"] / **内容**: [补偿描述——例如："500高级货币 + 24小时经验加成"]
- **Who**: [all players / affected players only / players who logged in during incident] / **对象**: [所有玩家 / 仅受影响玩家 / 事件期间登录的玩家]
- **When**: [delivery date and method] / **时间**: [发放日期和方式]
- **Rationale**: [why this compensation is appropriate for the impact] / **理由**: [为什么此补偿适合事件影响]

---

<!-- 中文翻译 -->
## Prevention / 预防

<!-- 中文翻译 -->
### What We Are Changing / 我们将改变什么

| Action Item | Owner | Deadline | Status | 行动项 | 负责人 | 截止日期 | 状态 |
| ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
| [Specific preventive measure] | [Role] | [Date] | [TODO/Done] | [具体预防措施] | [角色] | [日期] | [待办/已完成] |
| [Add monitoring for X] | [Role] | [Date] | [TODO/Done] | [为X添加监控] | [角色] | [日期] | [待办/已完成] |
| [Add test coverage for Y] | [Role] | [Date] | [TODO/Done] | [为Y添加测试覆盖] | [角色] | [日期] | [待办/已完成] |
| [Update runbook for Z] | [Role] | [Date] | [TODO/Done] | [更新Z的运行手册] | [角色] | [日期] | [待办/已完成] |

<!-- 中文翻译 -->
### Process Improvements / 流程改进
- [Process change to prevent similar incidents] / [防止类似事件发生的流程变更]
- [Monitoring/alerting improvement] / [监控/警报改进]
- [Testing improvement] / [测试改进]

---

<!-- 中文翻译 -->
## Lessons Learned / 经验教训

<!-- 中文翻译 -->
### What Went Well / 做得好的方面
- [Positive aspect of incident response — e.g., "Detection was fast due to
  monitoring alerts"] / [事件响应的积极方面——例如："监控警报使检测速度很快"]
- [Positive aspect] / [积极方面]

<!-- 中文翻译 -->
### What Went Poorly / 做得不好的方面
- [Problem with response — e.g., "Took 20 minutes to identify the correct
  on-call person"] / [响应中的问题——例如："花费了20分钟才确定正确的值班人员"]
- [Problem] / [问题]

<!-- 中文翻译 -->
### Where We Got Lucky / 侥幸之处
- [Factor that reduced impact by chance rather than design — these are hidden
  risks to address] / [因运气而非设计降低了影响的因素——这些是需要处理的隐藏风险]

---

## Sign-Offs / 签字

- [ ] Technical Director — Root cause accurate, prevention plan sufficient / 技术总监——根因准确，预防计划充分
- [ ] QA Lead — Test coverage gaps addressed / QA主管——测试覆盖缺口已处理
- [ ] Producer — Timeline and communication reviewed / 制作人——时间线和沟通已审查
- [ ] Community Manager — Player communication reviewed / 社区经理——玩家沟通已审查

---

*This document is filed in `production/hotfixes/` and linked from the
release notes for the fix version.* / *此文档归档于 `production/hotfixes/` 并在修复版本的发布说明中引用。*
