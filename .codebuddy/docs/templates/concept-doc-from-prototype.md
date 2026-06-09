# [Prototype Name] — Concept Document / [原型名称] — 概念文档

---
**Status**: Reverse-Documented from Prototype
**Prototype Path**: `prototypes/[name]/`
**Date**: [YYYY-MM-DD]
**Creator**: [User name]
**Outcome**: [Success | Partial Success | Failed | Needs More Testing]
---

> **⚠️ 反向文档化通知** / **⚠️ Reverse-Documentation Notice**
>
> This concept document was created **after** the prototype was built. It captures
> the core mechanic, learnings, and design insights discovered through prototyping.
> This is a formalization of experimental work, not a pre-planned design. / 此概念文档是在原型**构建之后**创建的。它捕捉了通过原型设计发现的核心机制、学习和设计见解。这是实验工作的形式化，而不是预先计划的设计。

---

<!-- 中文翻译 -->
## 1. Prototype Overview / 原型概述

**Original Hypothesis**: / **原始假设**：
[What question or idea was this prototype testing?] / [此原型测试了什么问题或想法？]

**Approach**: / **方法**：
[How was the prototype built? Quick and dirty? Focused on one mechanic?] / [原型是如何构建的？快速而粗糙？专注于一个机制？]

**Duration**: / **持续时间**：
- Time spent: [X hours/days] / 花费时间：[X小时/天]
- Complexity: [Throwaway | Could be production-ready | Needs full rewrite] / 复杂度：[一次性|可能生产就绪|需要完全重写]

**Outcome** (clarified): / **结果**（澄清）：
- ✅ **Validated**: [What worked and should move forward] / ✅ **已验证**：[有效且应该继续推进的]
- ⚠️ **Needs Work**: [What showed promise but needs refinement] / ⚠️ **需要工作**：[有前景但需要改进的]
- ❌ **Invalidated**: [What didn't work and should be abandoned] / ❌ **已否定**：[无效且应该放弃的]

---

<!-- 中文翻译 -->
## 2. Core Mechanic / 核心机制

**What the Prototype Does**: / **原型功能**：
[Describe the mechanic or system that was prototyped] / [描述被原型化的机制或系统]

**How It Feels** (user feedback): / **感觉如何**（用户反馈）：
- [Feeling 1 — e.g., "Satisfying", "Clunky", "Too complex"] / [感觉1——例如，"满意"、"笨拙"、"太复杂"]
- [Feeling 2 — e.g., "Intuitive", "Confusing", "Needs tutorial"] / [感觉2——例如，"直观"、"困惑"、"需要教程"]
- [Feeling 3 — e.g., "Fun", "Boring", "Has potential"] / [感觉3——例如，"有趣"、"无聊"、"有潜力"]

**Player Fantasy**: / **玩家幻想**：
[What fantasy or experience does this mechanic create?] / [此机制创造了什么幻想或体验？]

**Core Loop** (if applicable): / **核心循环**（如果适用）：
```
[Action 1] → [Result 1] → [Action 2] → [Result 2] → [Repeat or Conclude]
```

**Emergent Behaviors** (unintended but interesting): / **涌现行为**（意外但有趣）：
- [Behavior 1]: [What players did that wasn't planned] / [行为1]：[玩家做了未计划的事情]
- [Behavior 2]: [Unexpected strategy or interaction] / [行为2]：[意外策略或交互]

---

<!-- 中文翻译 -->
## 3. What Worked / 哪些有效

<!-- 中文翻译 -->
### Mechanic Successes / 机制成功

✅ **[Success 1]**: [What worked well] / ✅ **[成功1]**：[哪些有效]
- **Why**: [What made this successful] / **原因**：[什么使其成功]
- **Keep for Production**: [Should this be preserved?] / **保留至生产**：[应该保留这个吗？]

✅ **[Success 2]**: [What worked well] / ✅ **[成功2]**：[哪些有效]
- **Why**: [What made this successful] / **原因**：[什么使其成功]
- **Keep for Production**: [Should this be preserved?] / **保留至生产**：[应该保留这个吗？]

<!-- 中文翻译 -->
### Technical Successes / 技术成功

✅ **[Technical win 1]**: [What technical approach worked] / ✅ **[技术胜利1]**：[哪些技术方法有效]
- **Lesson**: [What we learned] / **经验**：[我们学到了什么]
- **Reusable**: [Can this code/approach be used in production?] / **可重用性**：[此代码/方法可用于生产吗？]

✅ **[Technical win 2]**: [What worked] / ✅ **[技术胜利2]**：[哪些有效]
- **Lesson**: [What we learned] / **经验**：[我们学到了什么]

---

<!-- 中文翻译 -->
## 4. What Didn't Work / 哪些无效

<!-- 中文翻译 -->
### Mechanic Failures / 机制失败

❌ **[Failure 1]**: [What didn't work] / ❌ **[失败1]**：[哪些无效]
- **Why**: [Root cause] / **原因**：[根本原因]
- **Could It Be Fixed**: [Is it salvageable or fundamentally flawed?] / **是否可以修复**：[是否可挽救或根本有缺陷？]

❌ **[Failure 2]**: [What didn't work] / ❌ **[失败2]**：[哪些无效]
- **Why**: [Root cause] / **原因**：[根本原因]
- **Could It Be Fixed**: [Yes/No + how] / **是否可以修复**：[是/否 + 如何]

<!-- 中文翻译 -->
### Technical Failures / 技术失败

❌ **[Technical issue 1]**: [What caused problems] / ❌ **[技术问题1]**：[引起问题的原因]
- **Lesson**: [What to avoid in production] / **经验**：[生产中应避免什么]

❌ **[Technical issue 2]**: [What caused problems] / ❌ **[技术问题2]**：[引起问题的原因]
- **Lesson**: [What to avoid] / **经验**：[应避免什么]

---

<!-- 中文翻译 -->
## 5. What Needs Refinement / 需要改进的方面

⚠️ **[Element 1]**: [What showed promise but needs work] / ⚠️ **[元素1]**：[有前景但需要改进的方面]
- **Issue**: [What's wrong with it currently] / **问题**：[目前有什么问题]
- **Path Forward**: [How to improve it] / **前进路径**：[如何改进]
- **Effort**: [Small | Medium | Large refactor] / **工作量**：[小|中|大重构]

⚠️ **[Element 2]**: [What needs refinement] / ⚠️ **[元素2]**：[需要改进的方面]
- **Issue**: [Current problem] / **问题**：[当前问题]
- **Path Forward**: [Improvement approach] / **前进路径**：[改进方法]
- **Effort**: [Estimate] / **工作量**：[估计]

---

<!-- 6. 关键经验 -->
## 6. Key Learnings / 关键经验

<!-- 中文翻译 -->
### Design Insights / 设计见解

💡 **[Insight 1]**: [What we learned about game design] / 💡 **[见解1]**：[我们学到的关于游戏设计的知识]
- **Implication**: [How this affects future work] / **影响**：[这对未来工作的影响]

💡 **[Insight 2]**: [Design learning] / 💡 **[见解2]**：[设计学习]
- **Implication**: [Impact on GDD or other systems] / **影响**：[对GDD或其他系统的影响]

<!-- 中文翻译 -->
### Technical Insights / 技术见解

💡 **[Insight 3]**: [Technical learning] / 💡 **[见解3]**：[技术学习]
- **Implication**: [Architecture or implementation guidance] / **影响**：[架构或实施指导]

💡 **[Insight 4]**: [Technical learning] / 💡 **[见解4]**：[技术学习]
- **Implication**: [Future technical decisions] / **影响**：[未来技术决策]

<!-- 中文翻译 -->
### Player Psychology Insights / 玩家心理学见解

💡 **[Insight 5]**: [What we learned about player behavior] / 💡 **[见解5]**：[我们学到的关于玩家行为的知识]
- **Implication**: [How this affects design philosophy] / **影响**：[这对设计哲学的影响]

---

<!-- 中文翻译 -->
## 7. Production Readiness Assessment / 生产就绪评估

**Should This Become a Full Feature?**: [Yes | No | Needs More Testing | Pivot to Different Approach] / **这应该成为完整功能吗？**：[是|否|需要更多测试|转向不同方法]

**If Yes — Production Requirements**: / **如果是——生产需求**：
- [ ] [Requirement 1 — e.g., "Rewrite for performance"] / [ ] [需求1——例如，"为性能重写"]
- [ ] [Requirement 2 — e.g., "Add proper UI"] / [ ] [需求2——例如，"添加适当的UI"]
- [ ] [Requirement 3 — e.g., "Design 10 more variations"] / [ ] [需求3——例如，"设计10个以上变体"]
- [ ] [Requirement 4 — e.g., "Integrate with progression system"] / [ ] [需求4——例如，"与进度系统集成"]

**Estimated Production Effort**: [Small | Medium | Large] / **预估生产工作量**：[小|中|大]
- Prototype reusability: [X%] of code can be kept / 原型可重用性：[X%]代码可以保留
- From-scratch effort: [X hours/days to production-ready] / 从零开始工作量：[X小时/天达到生产就绪]

**If No — Why Not?**: / **如果否——为什么不？**：
- [Reason 1 — e.g., "Fun but doesn't fit game pillars"] / [原因1——例如，"有趣但不适合游戏支柱"]
- [Reason 2 — e.g., "Too complex for target audience"] / [原因2——例如，"对目标受众太复杂"]
- [Reason 3 — e.g., "Technically infeasible at scale"] / [原因3——例如，"技术上在规模上不可行"]

**If Pivot — Suggested Direction**: / **如果转向——建议方向**：
- [Alternative approach 1] / [替代方法1]
- [Alternative approach 2] / [替代方法2]

---

<!-- 中文翻译 -->
## 8. Design Pillars Alignment / 设计支柱对齐

**How This Relates to Game Pillars** (if game pillars are defined): / **这与游戏支柱的关系**（如果定义了游戏支柱）：

| Pillar / 支柱 | Alignment / 对齐 | Notes / 备注 |
|--------|-----------|-------|
| [Pillar 1] | ✅ Strong / ⚠️ Weak / ❌ Conflicts | [Explanation] / [解释] |
| [Pillar 2] | ✅ Strong / ⚠️ Weak / ❌ Conflicts | [Explanation] / [解释] |
| [Pillar 3] | ✅ Strong / ⚠️ Weak / ❌ Conflicts | [Explanation] / [解释] |

**Overall Pillar Fit**: [Does this belong in the game?] / **整体支柱契合度**：[这属于游戏吗？]

---

<!-- 中文翻译 -->
## 9. Next Steps / 后续步骤

<!-- 中文翻译 -->
### Immediate (If Moving Forward) / 立即（如果继续推进）
1. **[Task 1]**: [e.g., "Create full design doc for this system"] / **[任务1]**：[例如，"为此系统创建完整设计文档"]
2. **[Task 2]**: [e.g., "Write ADR for technical approach"] / **[任务2]**：[例如，"为技术方法编写ADR"]
3. **[Task 3]**: [e.g., "Add to backlog for Sprint X"] / **[任务3]**：[例如，"添加到Sprint X的待办事项"]

<!-- 中文翻译 -->
### Before Production (If Needs More Work) / 生产前（如果需要更多工作）
1. **[Task 1]**: [e.g., "Build second prototype testing X variation"] / **[任务1]**：[例如，"构建测试X变体的第二个原型"]
2. **[Task 2]**: [e.g., "Playtest with 5+ people"] / **[任务2]**：[例如，"与5人以上进行游戏测试"]
3. **[Task 3]**: [e.g., "Investigate technical feasibility of Y"] / **[任务3]**：[例如，"调查Y的技术可行性"]

<!-- 中文翻译 -->
### If Abandoning / 如果放弃
1. **[Task 1]**: [e.g., "Archive prototype with this document"] / **[任务1]**：[例如，"使用此文档归档原型"]
2. **[Task 2]**: [e.g., "Extract reusable code/learnings"] / **[任务2]**：[例如，"提取可重用代码/学习"]
3. **[Task 3]**: [e.g., "Update game pillars if this changed thinking"] / **[任务3]**：[例如，"如果这改变了思考，更新游戏支柱"]

---

<!-- 中文翻译 -->
## 10. Technical Notes / 技术说明

**Prototype Implementation**: / **原型实现**：
- Language/Engine: [What was used] / 语言/引擎：[使用的]
- Architecture: [How it was structured] / 架构：[结构如何]
- Shortcuts taken: [What was hacky or throwaway] / 采取的捷径：[哪些是临时或一次性的]

**Reusable Code** (if any): / **可重用代码**（如果有）：
- `[file/path 1]`: [What it does, reusability] / `[文件/路径1]`：[功能，可重用性]
- `[file/path 2]`: [What it does, reusability] / `[文件/路径2]`：[功能，可重用性]

**Technical Debt** (if moving to production): / **技术债务**（如果转移到生产）：
- [Debt 1]: [What needs rewriting] / [债务1]：[需要重写的]
- [Debt 2]: [What needs proper implementation] / [债务2]：[需要正确实现的]

---

<!-- 中文翻译 -->
## 11. Playtest Feedback / 游戏测试反馈

*(If prototype was playtested)* / *（如果原型进行了游戏测试）*

**Testers**: [N people, [internal/external]] / **测试者**：[N人，[内部/外部]]

**Positive Feedback**: / **正面反馈**：
- "[Quote 1]" — [Tester name/role] / "[引用1]" — [测试者姓名/角色]
- "[Quote 2]" — [Tester name/role] / "[引用2]" — [测试者姓名/角色]

**Negative Feedback**: / **负面反馈**：
- "[Quote 1]" — [Tester name/role] / "[引用1]" — [测试者姓名/角色]
- "[Quote 2]" — [Tester name/role] / "[引用2]" — [测试者姓名/角色]

**Suggestions**: / **建议**：
- "[Suggestion 1]" — [Tester name] / "[建议1]" — [测试者姓名]
- "[Suggestion 2]" — [Tester name] / "[建议2]" — [测试者姓名]

**Themes**: / **主题**：
- [Theme 1]: [What multiple testers agreed on] / [主题1]：[多个测试者同意的]
- [Theme 2]: [Common feedback] / [主题2]：[共同反馈]

---

<!-- 中文翻译 -->
## 12. Related Work / 相关工作

**Inspired By** (games/mechanics this was influenced by): / **灵感来源**（受影响的游戏/机制）：
- [Game 1]: [What mechanic or feeling] / [游戏1]：[什么机制或感觉]
- [Game 2]: [What was borrowed or adapted] / [游戏2]：[借用或改编了什么]

**Differs From** (how this is unique or different): / **不同之处**（如何独特或不同）：
- [Difference 1] / [区别1]
- [Difference 2] / [区别2]

**Integrates With** (existing game systems): / **集成**（现有游戏系统）：
- [System 1]: [How they would connect] / [系统1]：[它们如何连接]
- [System 2]: [How they would connect] / [系统2]：[它们如何连接]

---

<!-- 中文翻译 -->
## 13. Open Questions / 开放问题

**Design Questions**: / **设计问题**：
1. **[Question 1]**: [What's still undecided about the design?] / **[问题1]**：[关于设计还有什么未决定的？]
2. **[Question 2]**: [What needs playtesting or iteration?] / **[问题2]**：[什么需要游戏测试或迭代？]

**Technical Questions**: / **技术问题**：
3. **[Question 3]**: [What technical unknowns remain?] / **[问题3]**：[还有什么技术未知数？]
4. **[Question 4]**: [What needs feasibility testing?] / **[问题4]**：[什么需要可行性测试？]

---

<!-- 中文翻译 -->
## 14. Appendix: Prototype Assets / 附录：原型资产

**Code**: / **代码**：
- Location: `prototypes/[name]/src/` / 位置：`prototypes/[名称]/src/`
- Status: [Archival | Partial reuse | Full reuse] / 状态：[归档|部分重用|完全重用]

**Art/Audio** (if any): / **美术/音频**（如果有）：
- Location: `prototypes/[name]/assets/` / 位置：`prototypes/[名称]/assets/`
- Status: [Placeholder | Production-ready | Needs replacement] / 状态：[占位符|生产就绪|需要替换]

**Documentation**: / **文档**：
- README: [Exists | Missing] / README：[存在|缺失]
- Build instructions: [Exists | Missing] / 构建说明：[存在|缺失]

---

## Version History / 版本历史

| Date / 日期 | Author / 作者 | Changes / 变更内容 |
|-------------|---------------|-------------------|
| [Date] | Claude (reverse-doc) | Initial concept doc from prototype analysis / 从原型分析生成初始概念文档 |
| [Date] | [User] | Clarified outcomes, added playtest feedback / 澄清结果，添加试玩反馈 |

---

**Final Recommendation**: [GO | NO-GO | PIVOT] / **最终建议**：[继续|停止|转向]

**Rationale**: [1-2 sentence summary of why] / **理由**：[1-2句原因总结]

---

*This concept document was generated by `/reverse-document concept prototypes/[name]`*
