---
paths:
  - "src/ai/**"
---

# AI Code Rules / AI 代码规则

- AI update budget: 2ms per frame maximum — profile to verify
  > **中文翻译**：AI 更新预算：每帧最多 2ms — 必须通过性能分析验证
- All AI parameters must be tunable from data files (behavior tree weights, perception ranges, timers)
  > **中文翻译**：所有 AI 参数必须可从数据文件调优（行为树权重、感知范围、计时器）
- AI must be debuggable: implement visualization hooks for all AI state (paths, perception cones, decision trees)
  > **中文翻译**：AI 必须可调试：为所有 AI 状态实现可视化钩子（路径、感知锥、决策树）
- AI should telegraph intentions — players need time to read and react
  > **中文翻译**：AI 应发出意图信号 — 玩家需要时间读取并做出反应
- Prefer utility-based or behavior tree approaches over hard-coded if/else chains
  > **中文翻译**：优先使用基于效用或行为树的方法，而非硬编码的 if/else 链
- Group AI must support formation, flanking, and role assignment from data
  > **中文翻译**：群体 AI 必须从数据支持编队、侧翼包抄和角色分配
- All AI state machines must log transitions for debugging
  > **中文翻译**：所有 AI 状态机必须记录状态转换以便调试
- Never trust AI input from the network without validation
  > **中文翻译**：永远不要未经验证就信任来自网络的 AI 输入
