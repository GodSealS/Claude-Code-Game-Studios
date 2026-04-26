---
name: test-flakiness
description: "Detect non-deterministic (flaky) tests by reading CI run logs or test result history. Aggregates pass rates per test, identifies intermittent failures, recommends quarantine or fix, and maintains a flaky test registry. Best run during Polish phase or after multiple CI runs. / 通过读取 CI 运行日志或测试结果历史检测非确定性（不稳定）测试。聚合每个测试的通过率，识别间歇性失败，建议隔离或修复，并维护不稳定测试注册表。最好在打磨阶段或多次 CI 运行后使用。"
argument-hint: "[ci-log-path | scan | registry]"
user-invocable: true
allowed-tools: Read, Glob, Grep, Write, Edit, Bash
---

# Test Flakiness Detection / 测试不稳定性检测

A flaky test is one that sometimes passes and sometimes fails without any code
change. Flaky tests are worse than no tests in some ways — they train the team
to ignore red CI runs, masking genuine failures. This skill identifies them,
explains likely causes, and recommends whether to quarantine or fix each one.

> **中文翻译**：不稳定测试是指在没有代码更改的情况下有时通过有时失败的测试。在某些方面，不稳定测试比没有测试更糟糕 — 它们让团队习惯于忽略红色 CI 运行，掩盖了真正的失败。此技能识别它们，解释可能的原因，并建议隔离还是修复每个测试。

**Output:** Updated `tests/regression-suite.md` quarantine section + optional
`production/qa/flakiness-report-[date].md`

> **中文翻译**：**输出**：更新 `tests/regression-suite.md` 隔离部分 + 可选的 `production/qa/flakiness-report-[date].md`

**When to run:** / **何时运行：**
- Polish phase (tests have had many runs; statistical signal is reliable) / 打磨阶段（测试已运行多次；统计信号可靠）
- When developers start dismissing CI failures as "probably flaky" / 当开发者开始将 CI 失败视为"可能是不稳定"而忽略时
- After `/regression-suite` identifies quarantined tests that need diagnosis / 在 `/regression-suite` 识别需要诊断的隔离测试后

---

## 1. Parse Arguments / 第 1 步：解析参数

**Modes:** / **模式：**
- `/test-flakiness [ci-log-path]` — analyse a specific CI run log file / 分析特定 CI 运行日志文件
- `/test-flakiness scan` — scan all available CI logs in `.github/` or / 扫描 `.github/` 或标准日志输出目录中的所有可用 CI 日志
  standard log output directories / 
- `/test-flakiness registry` — read existing regression-suite.md quarantine / 读取现有 regression-suite.md 隔离部分并为已知不稳定测试提供修复指导
  section and provide remediation guidance for already-known flaky tests / 
- No argument — auto-detect: run `scan` if CI logs are accessible, else / 无参数 — 自动检测：如果 CI 日志可访问则运行 `scan`，否则运行 `registry`
  `registry` / 

---

## 2. Locate CI Log Data / 第 2 步：定位 CI 日志数据

### Option A — GitHub Actions (preferred) / 选项 A — GitHub Actions（首选）

Check for test result artifacts: / 检查测试结果工件：
```bash
ls -t .github/ 2>/dev/null
ls -t test-results/ 2>/dev/null
```

For Godot projects: GdUnit4 outputs XML results compatible with JUnit format. / 对于 Godot 项目：GdUnit4 输出与 JUnit 格式兼容的 XML 结果。
Check `test-results/` for `.xml` files. / 检查 `test-results/` 中的 `.xml` 文件。

For Unity projects: game-ci test runner outputs NUnit XML to `test-results/` / 对于 Unity 项目：game-ci 测试运行器默认输出 NUnit XML 到 `test-results/`
by default. / 

For Unreal projects: automation logs go to `Saved/Logs/`. Grep for / 对于 Unreal 项目：自动化日志输出到 `Saved/Logs/`。使用 grep 查找
`Result: Success` and `Result: Fail` patterns. / `Result: Success` 和 `Result: Fail` 模式。

### Option B — Local log files / 选项 B — 本地日志文件

If a path argument is provided, read that file directly. / 如果提供了路径参数，直接读取该文件。

### Option C — No log data available / 选项 C — 无日志数据可用

If no logs found: / 如果未找到日志：
> "No CI log data found. To detect flaky tests, this skill needs test result / "未找到 CI 日志数据。要检测不稳定测试，此技能需要多次运行的测试结果历史。选项：
> history from multiple runs. Options: / 
> 1. Run the test suite at least 3 times and collect the output logs / 1. 至少运行测试套件 3 次并收集输出日志
> 2. Check CI pipeline output and save a log to `test-results/` / 2. 检查 CI 流水线输出并将日志保存到 `test-results/`
> 3. Run `/test-flakiness registry` to review tests already flagged as flaky / 3. 运行 `/test-flakiness registry` 审查已标记为不稳定的测试
>    in `tests/regression-suite.md`" / 在 `tests/regression-suite.md` 中"

Stop and ask the user which option to pursue. / 停止并询问用户选择哪个选项。

---

## 3. Parse Test Results / 第 3 步：解析测试结果

For each CI log or result file found, parse: / 对于找到的每个 CI 日志或结果文件，解析：

**JUnit XML format** (GdUnit4 / Unity): / **JUnit XML 格式**（GdUnit4 / Unity）：
- Grep for `<testcase name=` to get test names / 使用 grep 查找 `<testcase name=` 以获取测试名称
- Grep for `<failure` or `<error` to identify failures / 使用 grep 查找 `<failure` 或 `<error` 以识别失败
- Parse `classname` and `name` attributes for full test identifiers / 解析 `classname` 和 `name` 属性以获取完整测试标识符

**Plain text logs**: / **纯文本日志**：
- Grep for pass/fail patterns: / 使用 grep 查找通过/失败模式：
  - Godot: `PASSED` / `FAILED` adjacent to test names / Godot：测试名称附近的 `PASSED` / `FAILED`
  - Unreal: `Result: Success` / `Result: Fail` / Unreal：`Result: Success` / `Result: Fail`
  - Unity: `Test passed` / `Test failed` / Unity：`Test passed` / `Test failed`

Build a table: `test_id → [run1_result, run2_result, run3_result, ...]` / 构建表：`test_id → [run1_result, run2_result, run3_result, ...]`

---

## 4. Identify Flaky Tests / 第 4 步：识别不稳定测试

A test is **flaky** if it appears in the result history with both PASS and / 如果测试在结果历史中出现在没有代码更改的不同运行中既有 PASS 又有 FAIL 结果，则该测试是**不稳定的**。
FAIL outcomes across runs with no code changes between them. / 

> **中文翻译**：如果测试在结果历史中出现在没有代码更改的不同运行中既有 PASS 又有 FAIL 结果，则该测试是**不稳定的**。

Flakiness thresholds: / 不稳定性阈值：

> **中文翻译**：不稳定性阈值：
- **High flakiness**: Fails in >25% of runs — quarantine immediately / **高不稳定性**：在 >25% 的运行中失败 — 立即隔离
- **Moderate flakiness**: Fails in 5–25% of runs — investigate and fix soon / **中等不稳定性**：在 5-25% 的运行中失败 — 尽快调查和修复
- **Low/suspected flakiness**: Fails in 1–5% of runs — monitor; may be / **低/疑似不稳定性**：在 1-5% 的运行中失败 — 监控；可能是真正的罕见故障
  genuinely rare failure / 

For each flaky test, classify the likely cause: / 对于每个不稳定测试，分类可能的原因：

### Cause classification / 原因分类

| Cause | Symptoms | Fix direction | / 原因 | 症状 | 修复方向 |
|-------|----------|---------------|
| **Timing / async** | Fails after awaiting signals or timers; pass rate correlates with system load | Add explicit await/synchronisation; avoid time-based delays | / **时序/异步** | 在等待信号或计时器后失败；通过率与系统负载相关 | 添加显式等待/同步；避免基于时间的延迟 |
| **Order dependency** | Fails when run after specific other tests; passes in isolation | Add proper setup/teardown; ensure test isolation | / **顺序依赖性** | 在特定其他测试后运行时失败；单独运行通过 | 添加适当的设置/清理；确保测试隔离 |
| **Random seed** | Fails intermittently with no pattern; involves RNG | Pass explicit seed; don't use `randf()` in tests | / **随机种子** | 无规律地间歇性失败；涉及随机数生成 | 传递显式种子；测试中不使用 `randf()` |
| **Resource leak** | Fails more often later in a test run | Fix cleanup in teardown; check orphan nodes (Godot) or object disposal (Unity) | / **资源泄漏** | 在测试运行后期更频繁失败 | 修复清理中的清理；检查孤儿节点（Godot）或对象处置（Unity） |
| **External state** | Fails when a file, scene, or global exists from a prior test | Isolate test from file system; use in-memory mocks | / **外部状态** | 当先前测试的文件、场景或全局变量存在时失败 | 使测试与文件系统隔离；使用内存模拟 |
| **Floating point** | Fails on comparisons like `== 0.5` | Use epsilon comparison (`is_equal_approx`, `Assert.AreApproximately`) | / **浮点数** | 在类似 `== 0.5` 的比较上失败 | 使用 epsilon 比较（`is_equal_approx`, `Assert.AreApproximately`） |
| **Scene/prefab load race** | Fails when scenes are not yet ready | Await one frame after instantiation; use `await get_tree().process_frame` | / **场景/预制体加载竞争** | 当场景尚未准备好时失败 | 实例化后等待一帧；使用 `await get_tree().process_frame` |

Use Grep to check the test file for timing calls, randf, global state access, / 使用 Grep 检查测试文件中的计时调用、randf、全局状态访问，
or equality comparisons on floats to narrow down the cause. / 或浮点数相等比较以缩小原因范围。

---

## 5. Recommend Action / 第 5 步：推荐操作

For each flaky test: / 对于每个不稳定测试：

**Quarantine (High flakiness):** / **隔离（高不稳定性）：**
> "Quarantine this test immediately. Disable it in CI by adding / "立即隔离此测试。通过添加
> `@pytest.mark.skip` / `[Ignore]` / `GdUnitSkip` annotation. Log it in / `@pytest.mark.skip` / `[Ignore]` / `GdUnitSkip` 注解在 CI 中禁用它。将其记录在
> `tests/regression-suite.md` quarantine section. The test is now opt-in only. / `tests/regression-suite.md` 隔离部分中。该测试现在仅为选择加入。
> Fix the root cause before removing quarantine." / 在移除隔离之前修复根本原因。"

**Investigate and fix soon (Moderate):** / **调查并尽快修复（中等）：**
> "This test is intermittently unreliable. Root cause appears to be [cause]. / "此测试间歇性不可靠。根本原因似乎是 [cause]。
> Suggested fix: [specific fix based on cause classification]. Do not quarantine / 建议修复：[基于原因分类的具体修复]。暂时不要隔离
> yet — fix the test directly." / — 直接修复测试。"

**Monitor (Low/suspected):** / **监控（低/疑似）：**
> "This test shows suspected flakiness. Collect more run data before / "此测试显示疑似不稳定性。在隔离之前收集更多运行数据。
> quarantining. Note it as 'suspected' in the regression suite." / 在回归套件中将其标记为'疑似'。"

---

## 6. Generate Reports / 第 6 步：生成报告

### In-conversation summary / 对话中摘要

```
## Flakiness Detection Results / 不稳定性检测结果

**Runs analysed**: [N] / **分析运行次数**：[N]
**Tests tracked**: [N] / **跟踪测试数**：[N]

### Flaky Tests Found / 发现的不稳定测试

| Test | System | Fail Rate | Likely Cause | Recommendation | / 测试 | 系统 | 失败率 | 可能原因 | 建议 |
|------|--------|-----------|--------------|----------------|
| [test_name] | [system] | [N]% | Timing | Quarantine + fix async | /  |  |  | 时序 | 隔离 + 修复异步问题 |
| [test_name] | [system] | [N]% | Float comparison | Fix: use epsilon compare | /  |  |  | 浮点数比较 | 修复：使用 epsilon 比较 |
| [test_name] | [system] | [N]% | Order dependency | Investigate teardown | /  |  |  | 顺序依赖性 | 调查清理过程 |

### Clean Tests (no flakiness detected) / 清洁测试（未检测到不稳定性）

[N] tests ran across [N] runs with consistent results — no flakiness detected. / [N] 个测试在 [N] 次运行中结果一致 — 未检测到不稳定性。

### Data Limitations / 数据限制

[Note if fewer than 5 runs were available — fewer runs = less statistical confidence] / [注意如果可用运行次数少于 5 — 运行次数越少，统计置信度越低]
```

---

## 7. Update Regression Suite + Optional Report File / 第 7 步：更新回归测试套件 + 可选报告文件

Ask: "May I update the quarantine section of `tests/regression-suite.md` / 询问："我可以更新 `tests/regression-suite.md` 的隔离部分
with the flaky tests found?" / 并添加发现的不稳定测试吗？"

If yes: use `Edit` to append entries to the Quarantined Tests table. / 如果是：使用 `Edit` 将条目追加到隔离测试表。
Never remove existing quarantine entries — only add new ones. / 绝不删除现有隔离条目 — 仅添加新条目。

Ask (separately): "May I write a full flakiness report to / 询问（单独）："我可以将完整的不稳定性报告写入
`production/qa/flakiness-report-[date].md`?" / `production/qa/flakiness-report-[date].md` 吗？"

The full report includes per-test analysis with cause details and / 完整报告包括每个测试的分析，包含原因详情和
engine-specific fix snippets. / 引擎特定的修复代码片段。

After writing: / 写入后：

- For each quarantined test: "Add the engine-specific skip annotation to / 对于每个隔离测试："添加引擎特定的跳过注解以
  disable this test in CI. Re-enable after the root cause is fixed." / 在 CI 中禁用此测试。在根本原因修复后重新启用。"
- For fix-eligible tests: "The fix for [test] is straightforward — / 对于可修复测试："[test] 的修复很简单 —
  change the equality comparison on line [N] to use `is_equal_approx`." / 将第 [N] 行的相等比较改为使用 `is_equal_approx`。"
- Summary: "Once all quarantine annotations are applied, CI should run green. / 摘要："一旦应用了所有隔离注解，CI 应运行绿色。
  Schedule fix work for the [N] quarantined tests before the release gate." / 在发布门之前安排 [N] 个隔离测试的修复工作。"

---

## Collaborative Protocol / 协作协议

- **Never delete test files** — quarantine means annotate + list, not remove / **绝不删除测试文件** — 隔离意味着注释 + 列表，而非删除
- **Statistical confidence matters** — with < 3 runs, flag findings as / **统计置信度很重要** — 少于 3 次运行时，将发现标记为
  "suspected" not "confirmed"; ask if more run data is available / "疑似"而非"确认"；询问是否有更多运行数据
- **Fix is always the goal** — quarantine is temporary; surface the fix / **修复始终是目标** — 隔离是暂时的；即使建议隔离也要展示修复方向
  direction even when recommending quarantine / 
- **Ask before writing** — both the regression-suite update and the report / **写入前询问** — 回归套件更新和报告文件都需要明确批准。写入时：裁决：**COMPLETE** — 不稳定性报告已写入。拒绝时：裁决：**BLOCKED** — 用户拒绝写入。
  file require explicit approval. On write: Verdict: **COMPLETE** — flakiness report written. On decline: Verdict: **BLOCKED** — user declined write. / 
- **Flakiness in CI is a team problem** — surface the list and recommended / **CI 中的不稳定性是团队问题** — 清晰地展示列表和建议操作；不要在团队不知情的情况下默默隔离
  actions clearly; do not just silently quarantine without the team knowing / 