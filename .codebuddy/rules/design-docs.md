---
paths:
  - "design/gdd/**"
---

# Design Document Rules / 设计文档规则

- Every design document MUST contain these 8 sections: Overview, Player Fantasy, Detailed Rules, Formulas, Edge Cases, Dependencies, Tuning Knobs, Acceptance Criteria / 每个设计文档必须包含以下 8 个章节：概述、玩家幻想、详细规则、公式、边界情况、依赖关系、调优旋钮、验收标准
- Formulas must include variable definitions, expected value ranges, and example calculations / 公式必须包含变量定义、预期值范围和示例计算
- Edge cases must explicitly state what happens, not just "handle gracefully" / 边界情况必须明确说明会发生什么，而非仅仅"优雅处理"
- Dependencies must be bidirectional — if system A depends on B, B's doc must mention A / 依赖关系必须是双向的 — 如果系统 A 依赖 B，则 B 的文档必须提及 A
- Tuning knobs must specify safe ranges and what gameplay aspect they affect / 调优旋钮必须指定安全范围以及影响的玩法方面
- Acceptance criteria must be testable — a QA tester must be able to verify pass/fail / 验收标准必须是可测试的 — QA 测试人员必须能够验证通过/失败
- No hand-waving: "the system should feel good" is not a valid specification / 不允许含糊其辞："系统应该感觉不错"不是有效的规格说明
- Balance values must link to their source formula or rationale / 平衡数值必须关联到其源公式或依据
- Design documents MUST be written incrementally: create skeleton first, then fill each section one at a time with user approval between sections. Write each approved section to the file immediately to persist decisions and manage context / 设计文档必须增量编写：先创建骨架，然后逐个填充每个章节，每个章节之间需要用户批准。将每个已批准的章节立即写入文件，以持久化决策并管理上下文
