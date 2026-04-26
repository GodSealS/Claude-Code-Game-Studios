# Incident Response: [Incident Title] / 事件响应：[事件标题]

**Severity**: [S1-Critical / S2-Major / S3-Moderate / S4-Minor]
**Status**: [Active / Mitigated / Resolved / Post-Mortem Complete]
**Detected**: [Date Time UTC]
**Resolved**: [Date Time UTC or ONGOING]
**Duration**: [Total time from detection to resolution]
**Incident Commander**: [Name/Role]

---

<!-- 中文翻译 -->
## Impact Summary

[2-3 sentences describing what players experienced. Write from the player
perspective, not the technical perspective.]

- **Players affected**: [estimated count or percentage]
- **Platforms affected**: [PC / Console / Mobile / All]
- **Regions affected**: [All / specific regions]
- **Revenue impact**: [estimated if applicable]

---

<!-- 时间线 -->
## Timeline

| Time (UTC) | Event | Action Taken |
| ---- | ---- | ---- |
| [HH:MM] | Incident detected via [monitoring/player report/etc.] | Incident commander assigned |
| [HH:MM] | Root cause identified | [Brief description of cause] |
| [HH:MM] | Mitigation deployed | [What was done] |
| [HH:MM] | Service restored / Fix confirmed | Monitoring for recurrence |
| [HH:MM] | All-clear declared | Post-mortem scheduled |

---

<!-- 中文翻译 -->
## Root Cause

<!-- 中文翻译 -->
### What Happened
[Technical description of the root cause. Be specific about the chain of events
that led to the incident.]

<!-- 中文翻译 -->
### Why It Happened
[Systemic cause — why did existing processes, tests, or safeguards fail to
prevent this? This is more important than the technical cause.]

<!-- 中文翻译 -->
### Contributing Factors
- [Factor 1 — e.g., "Insufficient load testing for the new matchmaking system"]
- [Factor 2 — e.g., "Monitoring alert threshold was set too high"]
- [Factor 3]

---

<!-- 中文翻译 -->
## Mitigation and Resolution

<!-- 中文翻译 -->
### Immediate Actions (during incident)
1. [Action taken to stop the bleeding]
2. [Action taken to restore service]
3. [Action taken to verify resolution]

<!-- 中文翻译 -->
### Follow-Up Actions (after resolution)
1. [Permanent fix if immediate action was a workaround]
2. [Additional testing or monitoring added]
3. [Process changes to prevent recurrence]

---

<!-- 中文翻译 -->
## Player Communication

<!-- 中文翻译 -->
### Initial Acknowledgment
*Sent: [Time] via [channel]*
> [Exact text of the first public message acknowledging the issue]

<!-- 中文翻译 -->
### Status Updates
*Sent: [Time] via [channel]*
> [Text of each subsequent update]

<!-- 中文翻译 -->
### Resolution Notice
*Sent: [Time] via [channel]*
> [Text announcing the fix and any compensation]

<!-- 中文翻译 -->
### Compensation (if applicable)
- **What**: [description of compensation — e.g., "500 premium currency + 24-hour XP boost"]
- **Who**: [all players / affected players only / players who logged in during incident]
- **When**: [delivery date and method]
- **Rationale**: [why this compensation is appropriate for the impact]

---

<!-- 中文翻译 -->
## Prevention

<!-- 中文翻译 -->
### What We Are Changing

| Action Item | Owner | Deadline | Status |
| ---- | ---- | ---- | ---- |
| [Specific preventive measure] | [Role] | [Date] | [TODO/Done] |
| [Add monitoring for X] | [Role] | [Date] | [TODO/Done] |
| [Add test coverage for Y] | [Role] | [Date] | [TODO/Done] |
| [Update runbook for Z] | [Role] | [Date] | [TODO/Done] |

<!-- 中文翻译 -->
### Process Improvements
- [Process change to prevent similar incidents]
- [Monitoring/alerting improvement]
- [Testing improvement]

---

<!-- 中文翻译 -->
## Lessons Learned

<!-- 中文翻译 -->
### What Went Well
- [Positive aspect of incident response — e.g., "Detection was fast due to
  monitoring alerts"]
- [Positive aspect]

<!-- 中文翻译 -->
### What Went Poorly
- [Problem with response — e.g., "Took 20 minutes to identify the correct
  on-call person"]
- [Problem]

<!-- 中文翻译 -->
### Where We Got Lucky
- [Factor that reduced impact by chance rather than design — these are hidden
  risks to address]

---

## Sign-Offs / 签字

- [ ] Technical Director — Root cause accurate, prevention plan sufficient
- [ ] QA Lead — Test coverage gaps addressed
- [ ] Producer — Timeline and communication reviewed
- [ ] Community Manager — Player communication reviewed

---

*This document is filed in `production/hotfixes/` and linked from the
release notes for the fix version.*
