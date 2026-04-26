---
name: code-review
description: "Performs an architectural and quality code review on a specified file or set of files. Checks for coding standard compliance, architectural pattern adherence, SOLID principles, testability, and performance concerns. / 对指定文件或文件集执行架构和质量代码审查。检查编码标准合规性、架构模式遵循、SOLID 原则、可测试性和性能问题。"
argument-hint: "[path-to-file-or-directory]"
user-invocable: true
allowed-tools: Read, Glob, Grep, Bash, Task
agent: lead-programmer
---

<!-- 第 1 阶段：加载目标文件 -->
## Phase 1: Load Target Files
> **中文翻译**：## 第 1 阶段：加载目标文件


Read the target file(s) in full. Read CODEBUDDY.md for project coding standards.
> **中文翻译**：完整阅读目标文件。阅读 CODEBUDDY.md 了解项目编码标准。


---

<!-- 第 2 阶段：识别引擎专家 -->
## Phase 2: Identify Engine Specialists

Read `.codebuddy/docs/technical-preferences.md`, section `## Engine Specialists`. Note:

- The **Primary** specialist (used for architecture and broad engine concerns)
- The **Language/Code Specialist** (used when reviewing the project's primary language files)
- The **Shader Specialist** (used when reviewing shader files)
- The **UI Specialist** (used when reviewing UI code)

If the section reads `[TO BE CONFIGURED]`, no engine is pinned — skip engine specialist steps.

---

<!-- 第 3 阶段：ADR 合规性检查 -->
## Phase 3: ADR Compliance Check
> **中文翻译**：## 第 3 阶段：ADR 合规性检查


Search for ADR references in the story file, commit messages, and header comments. Look for patterns like `ADR-NNN` or `docs/architecture/ADR-`.
> **中文翻译**：在故事文件、提交消息和标题注释中搜索 ADR 引用。寻找诸如“ADR-NNN”或“docs/architecture/ADR-”之类的模式。


If no ADR references found, note: "No ADR references found — skipping ADR compliance check."
> **中文翻译**：如果未找到 ADR 参考，请注意：“未找到 ADR 参考 — 跳过 ADR 合规性检查。”


For each referenced ADR: read the file, extract the **Decision** and **Consequences** sections, then classify any deviation:
> **中文翻译**：对于每个引用的 ADR：读取文件，提取 **决策** 和 **后果** 部分，然后对任何偏差进行分类：


- **ARCHITECTURAL VIOLATION** (BLOCKING): Uses a pattern explicitly rejected in the ADR
  > **中文翻译**：**架构违规**（阻止）：使用 ADR 中明确拒绝的模式
- **ADR DRIFT** (WARNING): Meaningfully diverges from the chosen approach without using a forbidden pattern
  > **中文翻译**：**ADR DRIFT**（警告）：在不使用禁止模式的情况下明显偏离所选方法
- **MINOR DEVIATION** (INFO): Small difference from ADR guidance that doesn't affect overall architecture
  > **中文翻译**：**轻微偏差**（信息）：与 ADR 指南略有差异，不会影响整体架构


---

<!-- 第 4 阶段：标准合规性 -->
## Phase 4: Standards Compliance

Identify the system category (engine, gameplay, AI, networking, UI, tools) and evaluate:

- [ ] Public methods and classes have doc comments
- [ ] Cyclomatic complexity under 10 per method
- [ ] No method exceeds 40 lines (excluding data declarations)
- [ ] Dependencies are injected (no static singletons for game state)
- [ ] Configuration values loaded from data files
- [ ] Systems expose interfaces (not concrete class dependencies)

---

<!-- 第 5 阶段：架构和 SOLID -->
## Phase 5: Architecture and SOLID
> **中文翻译**：## 第 5 阶段：架构和 SOLID


**Architecture:**
> **中文翻译**：**建筑学：**

- [ ] Correct dependency direction (engine <- gameplay, not reverse)
  > **中文翻译**：[ ] 正确的依赖方向（引擎 <- 游戏玩法，而不是反向）
- [ ] No circular dependencies between modules
  > **中文翻译**：[ ] 模块之间没有循环依赖关系
- [ ] Proper layer separation (UI does not own game state)
  > **中文翻译**：[ ] 适当的层分离（UI 不拥有游戏状态）
- [ ] Events/signals used for cross-system communication
  > **中文翻译**：[ ] 用于跨系统通信的事件/信号
- [ ] Consistent with established patterns in the codebase
  > **中文翻译**：[ ] 与代码库中既定的模式一致


**SOLID:**
> **中文翻译**：**坚硬的：**

- [ ] Single Responsibility: Each class has one reason to change
  > **中文翻译**：[ ] 单一职责：每个类都有一个改变的理由
- [ ] Open/Closed: Extendable without modification
  > **中文翻译**：[ ] 开放/封闭：无需修改即可扩展
- [ ] Liskov Substitution: Subtypes substitutable for base types
  > **中文翻译**：[ ] Liskov Substitution：可替换基本类型的子类型
- [ ] Interface Segregation: No fat interfaces
  > **中文翻译**：[ ] 接口隔离：无胖接口
- [ ] Dependency Inversion: Depends on abstractions, not concretions
  > **中文翻译**：[ ] 依赖倒置：依赖于抽象，而不是具体


---

<!-- 第 6 阶段：游戏特定关注点 -->
## Phase 6: Game-Specific Concerns

- [ ] Frame-rate independence (delta time usage)
- [ ] No allocations in hot paths (update loops)
- [ ] Proper null/empty state handling
- [ ] Thread safety where required
- [ ] Resource cleanup (no leaks)

---

<!-- 第 7 阶段：专家评审（并行） -->
## Phase 7: Specialist Reviews (Parallel)
> **中文翻译**：## 第 7 阶段：专家评审（并行）


Spawn all applicable specialists simultaneously via Task — do not wait for one before starting the next.
> **中文翻译**：通过任务同时产生所有适用的专家 - 不要等待一个专家才开始下一个。


<!-- 引擎专家 -->
### Engine Specialists
> **中文翻译**：### 发动机专家


If an engine is configured, determine which specialist applies to each file and spawn in parallel:
> **中文翻译**：如果配置了引擎，请确定哪个专家适用于每个文件并并行生成：


- Primary language files (`.gd`, `.cs`, `.cpp`) → Language/Code Specialist
  > **中文翻译**：主要语言文件（`.gd`、`.cs`、`.cpp`）→ 语言/代码专家
- Shader files (`.gdshader`, `.hlsl`, shader graph) → Shader Specialist
  > **中文翻译**：着色器文件（`.gdshader`、`.hlsl`、着色器图）→ Shader Specialist
- UI screen/widget code → UI Specialist
  > **中文翻译**：UI 屏幕/小部件代码 → UI 专家
- Cross-cutting or unclear → Primary Specialist
  > **中文翻译**：交叉或不清楚 → 主要专家


Also spawn the **Primary Specialist** for any file touching engine architecture (scene structure, node hierarchy, lifecycle hooks).
> **中文翻译**：还为任何文件接触引擎架构（场景结构、节点层次结构、生命周期挂钩）生成**主要专家**。


<!-- QA 可测试性审查 -->
### QA Testability Review
> **中文翻译**：### QA 可测试性审查


For Logic and Integration stories, also spawn `qa-tester` via Task in parallel with the engine specialists. Pass:
> **中文翻译**：对于逻辑和集成故事，还可以通过任务与引擎专家并行生成“qa-tester”。经过：

- The implementation files being reviewed
  > **中文翻译**：正在审查实施文件
- The story's `## QA Test Cases` section (the pre-written test specs from qa-lead)
  > **中文翻译**：故事的“## QA 测试用例”部分（来自 qa-lead 的预先编写的测试规范）
- The story's `## Acceptance Criteria`
  > **中文翻译**：故事的“## 接受标准”


Ask the qa-tester to evaluate:
> **中文翻译**：请质量保证测试人员评估：

- [ ] Are all test hooks and interfaces exposed (not hidden behind private/internal access)?
  > **中文翻译**：[ ] 是否所有测试挂钩和接口都公开（未隐藏在私有/内部访问后面）？
- [ ] Do the QA test cases from the story's `## QA Test Cases` section map to testable code paths?
  > **中文翻译**：[ ] 故事的“## QA 测试用例”部分中的 QA 测试用例是否映射到可测试的代码路径？
- [ ] Are any acceptance criteria untestable as implemented (e.g., hardcoded values, no seam for injection)?
  > **中文翻译**：[ ] 实施时是否存在无法测试的验收标准（例如，硬编码值、无注入缝）？
- [ ] Does the implementation introduce any new edge cases not covered by the existing QA test cases?
  > **中文翻译**：[ ] 该实现是否引入了现有 QA 测试用例未涵盖的任何新边缘情况？
- [ ] Are there any observable side effects that should have a test but don't?
  > **中文翻译**：[ ] 是否有任何可观察到的副作用应该进行测试但没有进行？


For Visual/Feel and UI stories: qa-tester reviews whether the manual verification steps in `## QA Test Cases` are achievable with the implementation as written — e.g., "is the state the manual checker needs to reach actually reachable?"
> **中文翻译**：对于视觉/感觉和 UI 故事：qa-tester 审查“## QA 测试用例”中的手动验证步骤是否可以通过书面实现实现 - 例如，“手动检查器需要达到的状态实际上可以达到吗？”


Collect all specialist findings before producing output.
> **中文翻译**：在产生输出之前收集所有专家的发现。


---

<!-- 第 8 阶段：输出审查 -->
## Phase 8: Output Review

```
## Code Review: [File/System Name]

### Engine Specialist Findings: [N/A — no engine configured / CLEAN / ISSUES FOUND]
[Findings from engine specialist(s), or "No engine configured." if skipped]

### Testability: [N/A — Visual/Feel or Config story / TESTABLE / GAPS / BLOCKING]
[qa-tester findings: test hooks, coverage gaps, untestable paths, new edge cases]
[If BLOCKING: implementation must expose [X] before tests in ## QA Test Cases can run]

### ADR Compliance: [NO ADRS FOUND / COMPLIANT / DRIFT / VIOLATION]
[List each ADR checked, result, and any deviations with severity]

### Standards Compliance: [X/6 passing]
[List failures with line references]

### Architecture: [CLEAN / MINOR ISSUES / VIOLATIONS FOUND]
[List specific architectural concerns]

### SOLID: [COMPLIANT / ISSUES FOUND]
[List specific violations]

### Game-Specific Concerns
[List game development specific issues]

### Positive Observations
[What is done well -- always include this section]

### Required Changes
[Must-fix items before approval — ARCHITECTURAL VIOLATIONs always appear here]

### Suggestions
[Nice-to-have improvements]

### Verdict: [APPROVED / APPROVED WITH SUGGESTIONS / CHANGES REQUIRED]
```

This skill is read-only — no files are written.

---

<!-- 第 9 阶段：后续步骤 -->
## Phase 9: Next Steps
> **中文翻译**：## 第 9 阶段：后续步骤


- If verdict is APPROVED: run `/story-done [story-path]` to close the story.
  > **中文翻译**：如果判决被批准：运行“/story-done [story-path]”来关闭故事。
- If verdict is CHANGES REQUIRED: fix the issues and re-run `/code-review`.
  > **中文翻译**：如果结论是需要更改：修复问题并重新运行“/code-review”。
- If an ARCHITECTURAL VIOLATION is found: run `/architecture-decision` to record the correct approach.
  > **中文翻译**：如果发现架构违规：运行“/architecture-decision”来记录正确的方法。

