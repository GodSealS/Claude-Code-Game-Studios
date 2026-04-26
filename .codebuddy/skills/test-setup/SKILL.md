---
name: test-setup
description: "Scaffold the test framework and CI/CD pipeline for the project's engine. Creates the tests/ directory structure, engine-specific test runner configuration, and GitHub Actions workflow. Run once during Technical Setup phase before the first sprint begins. / 为项目的引擎搭建测试框架和 CI/CD 管线。创建 tests/ 目录结构、引擎特定的测试运行器配置和 GitHub Actions 工作流。在技术设置阶段首次冲刺开始前运行一次。"
argument-hint: "[force]"
user-invocable: true
allowed-tools: Read, Glob, Grep, Bash, Write
---

# Test Setup / 测试设置

This skill scaffolds the automated testing infrastructure for the project.
It detects the configured engine, generates the appropriate test runner
configuration, creates the standard directory layout, and wires up CI/CD
so tests run on every push.

> **中文翻译**：此技能为项目搭建自动化测试基础设施。它检测配置的引擎，生成适当的测试运行器配置，创建标准目录布局，并连接 CI/CD 以便每次推送时运行测试。

Run this once during the Technical Setup phase, before any implementation
begins. A test framework installed at sprint start costs 30 minutes.
A test framework installed at sprint four costs 3 sprints.

> **中文翻译**：在技术设置阶段、任何实现开始之前运行一次此技能。冲刺开始时安装测试框架花费 30 分钟。冲刺四时安装测试框架花费 3 个冲刺。

**Output:** `tests/` directory structure + `.github/workflows/tests.yml`

> **中文翻译**：**输出**：`tests/` 目录结构 + `.github/workflows/tests.yml`

---

## Phase 1: Detect Engine and Existing State / 第 1 阶段：检测引擎和现有状态

1. **Read engine config**: / **读取引擎配置**：
   - Read `.codebuddy/docs/technical-preferences.md` and extract the `Engine:` value. / 读取 `.codebuddy/docs/technical-preferences.md` 并提取 `Engine:` 值。
   - If engine is not configured (`[TO BE CONFIGURED]`), stop: / 如果引擎未配置（`[TO BE CONFIGURED]`），停止：
     "Engine not configured. Run `/setup-engine` first, then re-run `/test-setup`." / "引擎未配置。先运行 `/setup-engine`，然后重新运行 `/test-setup`。"

2. **Check for existing test infrastructure**: / **检查现有测试基础设施**：
   - Glob `tests/` — does the directory exist? / Glob `tests/` — 目录是否存在？
   - Glob `tests/unit/` and `tests/integration/` — do subdirectories exist? / Glob `tests/unit/` 和 `tests/integration/` — 子目录是否存在？
   - Glob `.github/workflows/` — does a CI workflow file exist? / Glob `.github/workflows/` — CI 工作流文件是否存在？
   - Glob `tests/gdunit4_runner.gd` (Godot) or `tests/EditMode/` (Unity) or / Glob `tests/gdunit4_runner.gd`（Godot）或 `tests/EditMode/`（Unity）或
     `Source/Tests/` (Unreal) for engine-specific artifacts. / `Source/Tests/`（Unreal）获取引擎特定工件。

3. **Report findings**: / **报告发现**：
   - "Engine: [engine]. Test directory: [found / not found]. CI workflow: [found / not found]." / "引擎：[engine]。测试目录：[找到 / 未找到]。CI 工作流：[找到 / 未找到]。"
   - If everything already exists AND `force` argument was not passed: / 如果一切已存在且未传递 `force` 参数：
     "Test infrastructure appears to be in place. Re-run with `/test-setup force` / "测试基础设施似乎已就位。使用 `/test-setup force` 重新运行
     to regenerate. Proceeding will not overwrite existing test files." / 以重新生成。继续不会覆盖现有测试文件。"

If the `force` argument is passed, skip the "already exists" early-exit and / 如果传递了 `force` 参数，跳过"已存在"的提前退出并
proceed — but still do not overwrite files that already exist at a given path. / 继续 — 但仍不覆盖给定路径上已存在的文件。
Only create files that are missing. / 仅创建缺失的文件。

---

## Phase 2: Present Plan / 第 2 阶段：呈现计划

Based on the engine detected and the existing state, present a plan: / 基于检测到的引擎和现有状态，呈现计划：

```
## Test Setup Plan — [Engine] / 测试设置计划 — [引擎]

I will create the following (skipping any that already exist): / 我将创建以下内容（跳过任何已存在的）：

tests/ / 测试/
  unit/           — Isolated unit tests for formulas, state, and logic / 隔离单元测试（公式、状态机和逻辑）
  integration/    — Cross-system tests and save/load round-trips / 跨系统测试和保存/加载往返
  smoke/          — Critical path test list (15-minute manual gate) / 关键路径测试列表（15分钟手动门）
  evidence/       — Screenshot and manual test sign-off records / 截图和手动测试签署记录
  README.md       — Test framework documentation / 测试框架文档

[Engine-specific files — see per-engine details below] / [引擎特定文件 — 见以下每引擎详情]

.github/workflows/tests.yml  — CI: run tests on every push to main / CI：每次推送到 main 时运行测试

Estimated time: ~5 minutes to create all files. / 预计时间：约 5 分钟创建所有文件。
```

Ask: "May I create these files? I will not overwrite any test files that / 询问："我可以创建这些文件吗？我不会覆盖这些路径上已存在的任何测试文件。"
already exist at these paths." / 

Do not proceed without approval. / 未经批准不得继续。

---

## Phase 3: Create Directory Structure / 第 3 阶段：创建目录结构

After approval, create the following files: / 批准后，创建以下文件：

<!-- 中文翻译 -->
### `tests/README.md`

```markdown
# Test Infrastructure / 测试基础设施

**Engine**: [engine name + version] / **引擎**：[引擎名称 + 版本]
**Test Framework**: [GdUnit4 | Unity Test Framework | UE Automation] / **测试框架**：[GdUnit4 | Unity 测试框架 | UE 自动化]
**CI**: `.github/workflows/tests.yml` / **CI**：`.github/workflows/tests.yml`
**Setup date**: [date] / **设置日期**：[date]

## Directory Layout / 目录布局

```
tests/ / 测试/
  unit/           # Isolated unit tests (formulas, state machines, logic) / 隔离单元测试（公式、状态机、逻辑）
  integration/    # Cross-system and save/load tests / 跨系统和保存/加载测试
  smoke/          # Critical path test list for /smoke-check gate / 用于 /smoke-check 门的关键路径测试列表
  evidence/       # Screenshot logs and manual test sign-off records / 截图日志和手动测试签署记录
```

## Running Tests / 运行测试

[Engine-specific command — see below] / [引擎特定命令 — 见下方]

## Test Naming / 测试命名

- **Files**: `[system]_[feature]_test.[ext]` / **文件**：`[系统]_[功能]_test.[扩展名]`
- **Functions**: `test_[scenario]_[expected]` / **函数**：`test_[场景]_[预期结果]`
- **Example**: `combat_damage_test.gd` → `test_base_attack_returns_expected_damage()` / **示例**：`combat_damage_test.gd` → `test_base_attack_returns_expected_damage()`

## Story Type → Test Evidence / 故事类型 → 测试证据

| Story Type | Required Evidence | Location | / 故事类型 | 必需证据 | 位置 |
|---|---|---|
| Logic | Automated unit test — must pass | `tests/unit/[system]/` | / 逻辑 | 自动化单元测试 — 必须通过 | `tests/unit/[系统]/` |
| Integration | Integration test OR playtest doc | `tests/integration/[system]/` | / 集成 | 集成测试或游玩测试文档 | `tests/integration/[系统]/` |
| Visual/Feel | Screenshot + lead sign-off | `tests/evidence/` | / 视觉/感觉 | 截图 + 主管签署 | `tests/evidence/` |
| UI | Manual walkthrough OR interaction test | `tests/evidence/` | / UI | 手动演练或交互测试 | `tests/evidence/` |
| Config/Data | Smoke check pass | `production/qa/smoke-*.md` | / 配置/数据 | 冒烟检查通过 | `production/qa/smoke-*.md` |

## CI / 持续集成

Tests run automatically on every push to `main` and on every pull request. / 每次推送到 `main` 和每个拉取请求时自动运行测试。
A failed test suite blocks merging. / 失败的测试套件会阻止合并。
```

### Engine-specific files / 引擎特定文件

<!-- 中文翻译 -->
#### Godot 4 (`Engine: Godot`) / Godot 4（`Engine: Godot`）

Create `tests/gdunit4_runner.gd`: / 创建 `tests/gdunit4_runner.gd`：

```gdscript
# GdUnit4 test runner — invoked by CI and /smoke-check
# Usage: godot --headless --script tests/gdunit4_runner.gd
extends SceneTree

func _init() -> void:
    var runner := load("res://addons/gdunit4/GdUnitRunner.gd")
    if runner == null:
        push_error("GdUnit4 not found. Install via AssetLib or addons/.")
        quit(1)
        return
    var instance = runner.new()
    instance.run_tests()
    quit(0)
```

Create `tests/unit/.gdignore_placeholder` with content: / 创建 `tests/unit/.gdignore_placeholder` 内容为：
`# Unit tests go here — one subdirectory per system (e.g., tests/unit/combat/)` / `# 单元测试放这里 — 每个系统一个子目录（例如 tests/unit/combat/）`

Create `tests/integration/.gdignore_placeholder` with content: / 创建 `tests/integration/.gdignore_placeholder` 内容为：
`# Integration tests go here — one subdirectory per system` / `# 集成测试放这里 — 每个系统一个子目录`

Note in the README: **Installing GdUnit4** / 在 README 中备注：**安装 GdUnit4**
```
1. Open Godot → AssetLib → search "GdUnit4" → Download & Install / 1. 打开 Godot → 资产库 → 搜索 "GdUnit4" → 下载并安装
2. Enable the plugin: Project → Project Settings → Plugins → GdUnit4 ✓ / 2. 启用插件：项目 → 项目设置 → 插件 → GdUnit4 ✓
3. Restart the editor / 3. 重启编辑器
4. Verify: res://addons/gdunit4/ exists / 4. 验证：res://addons/gdunit4/ 存在
```

<!-- 中文翻译 -->
#### Unity (`Engine: Unity`)

Create `tests/EditMode/` placeholder file `tests/EditMode/README.md`: / 创建 `tests/EditMode/` 占位符文件 `tests/EditMode/README.md`：
```markdown
# Edit Mode Tests / 编辑模式测试
Unit tests that run without entering Play Mode. / 无需进入播放模式的单元测试。
Use for pure logic: formulas, state machines, data validation. / 用于纯逻辑：公式、状态机、数据验证。
Assembly definition required: `tests/EditMode/EditModeTests.asmdef` / 需要程序集定义：`tests/EditMode/EditModeTests.asmdef`
```

Create `tests/PlayMode/README.md`: / 创建 `tests/PlayMode/README.md`：
```markdown
# Play Mode Tests / 播放模式测试
Integration tests that run in a real game scene. / 在真实游戏场景中运行的集成测试。
Use for cross-system interactions, physics, and coroutines. / 用于跨系统交互、物理和协程。
Assembly definition required: `tests/PlayMode/PlayModeTests.asmdef` / 需要程序集定义：`tests/PlayMode/PlayModeTests.asmdef`
```

Note in the README: **Enabling Unity Test Framework** / 在 README 中备注：**启用 Unity 测试框架**
```
Window → General → Test Runner / 窗口 → 常规 → 测试运行器
(Unity Test Framework is included by default in Unity 2019+) / （Unity 2019+ 默认包含 Unity 测试框架）
```

#### Unreal Engine (`Engine: Unreal` or `Engine: UE5`) / Unreal 引擎（`Engine: Unreal` 或 `Engine: UE5`）

Create `Source/Tests/README.md`: / 创建 `Source/Tests/README.md`：
```markdown
# Unreal Automation Tests / Unreal 自动化测试
Tests use the UE Automation Testing Framework. / 测试使用 UE 自动化测试框架。
Run via: Session Frontend → Automation → select "MyGame." tests / 运行方式：会话前端 → 自动化 → 选择 "MyGame." 测试
Or headlessly: UnrealEditor -nullrhi -ExecCmds="Automation RunTests MyGame.; Quit" / 或无头模式：UnrealEditor -nullrhi -ExecCmds="Automation RunTests MyGame.; Quit"

Test class naming: F[SystemName]Test / 测试类命名：F[系统名称]Test
Test category naming: "MyGame.[System].[Feature]" / 测试类别命名："MyGame.[系统].[功能]"
```

---

## Phase 4: Create CI/CD Workflow / 第 4 阶段：创建 CI/CD 工作流

<!-- 中文翻译 -->
### Godot 4

Create `.github/workflows/tests.yml`: / 创建 `.github/workflows/tests.yml`：

```yaml
name: Automated Tests / 自动化测试

on:
  push:
    branches: [main] / 分支：[main]
  pull_request:
    branches: [main] / 分支：[main]

jobs:
  test:
    name: Run GdUnit4 Tests / 运行 GdUnit4 测试
    runs-on: ubuntu-latest / 运行在：ubuntu-latest

    steps:
      - name: Checkout / 检出
        uses: actions/checkout@v4
        with:
          lfs: true / 启用 LFS

      - name: Run GdUnit4 Tests / 运行 GdUnit4 测试
        uses: MikeSchulze/gdUnit4-action@v1
        with:
          godot-version: '[VERSION FROM docs/engine-reference/godot/VERSION.md]' / 从 docs/engine-reference/godot/VERSION.md 获取的版本号
          paths: |
            tests/unit / 单元测试
            tests/integration / 集成测试
          report-name: test-results / 报告名称：test-results

      - name: Upload Test Results / 上传测试结果
        if: always() / 条件：总是
        uses: actions/upload-artifact@v4
        with:
          name: test-results / 名称：test-results
          path: reports/ / 路径：reports/
```

<!-- 中文翻译 -->
### Unity

Create `.github/workflows/tests.yml`: / 创建 `.github/workflows/tests.yml`：

```yaml
name: Automated Tests / 自动化测试

on:
  push:
    branches: [main] / 分支：[main]
  pull_request:
    branches: [main] / 分支：[main]

jobs:
  test:
    name: Run Unity Tests / 运行 Unity 测试
    runs-on: ubuntu-latest / 运行在：ubuntu-latest

    steps:
      - name: Checkout / 检出
        uses: actions/checkout@v4
        with:
          lfs: true / 启用 LFS

      - name: Run Edit Mode Tests / 运行编辑模式测试
        uses: game-ci/unity-test-runner@v4
        env:
          UNITY_LICENSE: ${{ secrets.UNITY_LICENSE }} / Unity 许可证
        with:
          testMode: editmode / 测试模式：editmode
          artifactsPath: test-results/editmode / 工件路径：test-results/editmode

      - name: Run Play Mode Tests / 运行播放模式测试
        uses: game-ci/unity-test-runner@v4
        env:
          UNITY_LICENSE: ${{ secrets.UNITY_LICENSE }} / Unity 许可证
        with:
          testMode: playmode / 测试模式：playmode
          artifactsPath: test-results/playmode / 工件路径：test-results/playmode

      - name: Upload Test Results / 上传测试结果
        if: always() / 条件：总是
        uses: actions/upload-artifact@v4
        with:
          name: test-results / 名称：test-results
          path: test-results/ / 路径：test-results/
```

Note: Unity CI requires a `UNITY_LICENSE` secret. Add to GitHub repository / 注意：Unity CI 需要 `UNITY_LICENSE` 密钥。在首次 CI 运行前添加到 GitHub 仓库
secrets before the first CI run. / 密钥中。

### Unreal Engine / Unreal 引擎

Create `.github/workflows/tests.yml`: / 创建 `.github/workflows/tests.yml`：

```yaml
name: Automated Tests / 自动化测试

on:
  push:
    branches: [main] / 分支：[main]
  pull_request:
    branches: [main] / 分支：[main]

jobs:
  test:
    name: Run UE Automation Tests / 运行 UE 自动化测试
    runs-on: self-hosted  # UE requires a local runner with the editor installed / UE 需要安装编辑器的本地运行器

    steps:
      - name: Checkout / 检出
        uses: actions/checkout@v4
        with:
          lfs: true / 启用 LFS

      - name: Run Automation Tests / 运行自动化测试
        run: |
          "$UE_EDITOR_PATH" "${{ github.workspace }}/[ProjectName].uproject" \
            -nullrhi -nosound \
            -ExecCmds="Automation RunTests MyGame.; Quit" \
            -log -unattended
        shell: bash / shell：bash

      - name: Upload Logs / 上传日志
        if: always() / 条件：总是
        uses: actions/upload-artifact@v4
        with:
          name: test-logs / 名称：test-logs
          path: Saved/Logs/ / 路径：Saved/Logs/
```

Note: UE CI requires a self-hosted runner with Unreal Editor installed. / 注意：UE CI 需要安装 Unreal Editor 的自托管运行器。
Set the `UE_EDITOR_PATH` environment variable on the runner. / 在运行器上设置 `UE_EDITOR_PATH` 环境变量。

---

## Phase 5: Create Smoke Test Seed / 第 5 阶段：创建冒烟测试种子

Create `tests/smoke/critical-paths.md`: / 创建 `tests/smoke/critical-paths.md`：

```markdown
# Smoke Test: Critical Paths / 冒烟测试：关键路径

**Purpose**: Run these 10-15 checks in under 15 minutes before any QA hand-off. / **目的**：在任何 QA 交接前 15 分钟内运行这 10-15 项检查。
**Run via**: `/smoke-check` (which reads this file) / **运行方式**：`/smoke-check`（读取此文件）
**Update**: Add new entries when new core systems are implemented. / **更新**：实现新核心系统时添加新条目。

## Core Stability (always run) / 核心稳定性（始终运行）

1. Game launches to main menu without crash / 游戏启动到主菜单无崩溃
2. New game / session can be started from the main menu / 可以从主菜单开始新游戏/会话
3. Main menu responds to all inputs without freezing / 主菜单响应所有输入而不冻结

## Core Mechanic (update per sprint) / 核心机制（每个冲刺更新）

<!-- Add the primary mechanic for each sprint here as it is implemented --> / <!-- 在此处添加每个冲刺的主要机制，随其实现而更新 -->
<!-- Example: "Player can move, jump, and the camera follows correctly" --> / <!-- 示例："玩家可以移动、跳跃，相机正确跟随" -->
4. [Primary mechanic — update when first core system is implemented] / [主要机制 — 第一个核心系统实现时更新]

## Data Integrity / 数据完整性

5. Save game completes without error (once save system is implemented) / 保存游戏完成无错误（一旦保存系统实现）
6. Load game restores correct state (once load system is implemented) / 加载游戏恢复正确状态（一旦加载系统实现）

## Performance / 性能

7. No visible frame rate drops on target hardware (60fps target) / 目标硬件上无明显帧率下降（60fps 目标）
8. No memory growth over 5 minutes of play (once core loop is implemented) / 5 分钟游戏内无内存增长（一旦核心循环实现）
```

---

## Phase 6: Post-Setup Summary / 第 6 阶段：设置后摘要

After writing all files, report: / 写入所有文件后，报告：

```
Test infrastructure created for [engine]. / 为 [engine] 创建了测试基础设施。

Files created: / 创建的文件：
- tests/README.md
- tests/unit/ (directory) / （目录）
- tests/integration/ (directory) / （目录）
- tests/smoke/critical-paths.md
- tests/evidence/ (directory) / （目录）
[engine-specific files] / [引擎特定文件]
- .github/workflows/tests.yml

Next steps: / 下一步：
1. [Engine-specific install step, e.g., "Install GdUnit4 via AssetLib"] / [引擎特定安装步骤，例如"通过资产库安装 GdUnit4"]
2. Write your first test: create tests/unit/[first-system]/[system]_test.[ext] / 编写第一个测试：创建 tests/unit/[第一个系统]/[系统]_test.[扩展名]
3. Run `/qa-plan sprint` before your first sprint to classify stories and set / 在第一个冲刺前运行 `/qa-plan sprint` 以分类故事并设置
   test evidence requirements / 测试证据要求
4. `/smoke-check` before every QA hand-off / 每次 QA 交接前运行 `/smoke-check`

Gate note: /gate-check Technical Setup → Pre-Production now requires: / 门注记：/gate-check 技术设置 → 预生产现在要求：
- tests/ directory with unit/ and integration/ subdirectories / 具有 unit/ 和 integration/ 子目录的 tests/ 目录
- .github/workflows/tests.yml / 
- At least one example test file / 至少一个示例测试文件
Run /test-setup and write one example test before advancing. / 运行 /test-setup 并在前进前编写一个示例测试。

Verdict: **COMPLETE** — test framework scaffolded and CI/CD wired up. / 裁决：**COMPLETE** — 测试框架搭建完成且 CI/CD 已连接。
```

---

## Collaborative Protocol / 协作协议

- **Never overwrite existing test files** — only create files that are missing. / **绝不覆盖现有测试文件** — 仅创建缺失的文件。
  If a test runner file exists, leave it as-is. / 如果测试运行器文件存在，保持原样。
- **Always ask before creating files** — Phase 2 requires explicit approval. / **始终在创建文件前询问** — 第 2 阶段需要明确批准。
- **Engine detection is non-negotiable** — if the engine is not configured, / **引擎检测不可协商** — 如果引擎未配置，
  stop and redirect to `/setup-engine`. Do not guess. / 停止并重定向到 `/setup-engine`。不要猜测。
- **`force` flag skips the "already exists" early-exit but never overwrites.** / **`force` 标志跳过"已存在"提前退出但绝不覆盖。**
  It means "create any missing files even if the directory already exists." / 它意味着"即使目录已存在也创建任何缺失的文件。"
- For Unity CI, note that the `UNITY_LICENSE` secret must be configured / 对于 Unity CI，注意 `UNITY_LICENSE` 密钥必须
  manually. Do not attempt to automate license management. / 手动配置。不要尝试自动化许可证管理。
