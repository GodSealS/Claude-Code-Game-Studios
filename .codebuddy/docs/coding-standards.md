# Coding Standards / 编码标准

- All game code must include doc comments on public APIs
  > **中文翻译**：所有游戏代码必须在公共API上包含文档注释
- Every system must have a corresponding architecture decision record in `docs/architecture/`
  > **中文翻译**：每个系统必须在 `docs/architecture/` 中有对应的架构决策记录
- Gameplay values must be data-driven (external config), never hardcoded
  > **中文翻译**：游戏逻辑值必须是数据驱动的（外部配置），绝不硬编码
- All public methods must be unit-testable (dependency injection over singletons)
  > **中文翻译**：所有公共方法必须可单元测试（依赖注入优于单例）
- Commits must reference the relevant design document or task ID
  > **中文翻译**：提交必须引用相关设计文档或任务ID
- **Verification-driven development**: Write tests first when adding gameplay systems.
  For UI changes, verify with screenshots. Compare expected output to actual output
  before marking work complete. Every implementation should have a way to prove it works.
  > **中文翻译**：**验证驱动开发**：添加游戏系统时先编写测试。对于UI变更，用截图验证。在标记工作完成之前，比较预期输出与实际输出。每个实现都应有证明其工作方式。

# Design Document Standards / 设计文档标准

- All design docs use Markdown
  > **中文翻译**：所有设计文档使用Markdown
- Each mechanic has a dedicated document in `design/gdd/`
  > **中文翻译**：每个机制在 `design/gdd/` 中有专属文档
- Documents must include these 8 required sections:
  > **中文翻译**：文档必须包含以下8个必需章节：
  1. **Overview** -- one-paragraph summary
     > **中文翻译**：**概述** -- 一段总结
  2. **Player Fantasy** -- intended feeling and experience
     > **中文翻译**：**玩家幻想** -- 预期的感受和体验
  3. **Detailed Rules** -- unambiguous mechanics
     > **中文翻译**：**详细规则** -- 无歧义的机制
  4. **Formulas** -- all math defined with variables
     > **中文翻译**：**公式** -- 所有数学用变量定义
  5. **Edge Cases** -- unusual situations handled
     > **中文翻译**：**边界情况** -- 处理非寻常情况
  6. **Dependencies** -- other systems listed
     > **中文翻译**：**依赖** -- 列出其他系统
  7. **Tuning Knobs** -- configurable values identified
     > **中文翻译**：**调节旋钮** -- 识别可配置值
  8. **Acceptance Criteria** -- testable success conditions
     > **中文翻译**：**验收标准** -- 可测试的成功条件
- Balance values must link to their source formula or rationale
  > **中文翻译**：平衡值必须链接到其来源公式或理由

# Testing Standards / 测试标准

## Test Evidence by Story Type / 按故事类型的测试证据

All stories must have appropriate test evidence before they can be marked Done:

> **中文翻译**：所有故事在标记为完成之前必须有适当的测试证据：

| Story Type | Required Evidence | Location | Gate Level |
|---|---|---|---|
| **Logic** (formulas, AI, state machines) | Automated unit test — must pass | `tests/unit/[system]/` | BLOCKING |
| **Integration** (multi-system) | Integration test OR documented playtest | `tests/integration/[system]/` | BLOCKING |
| **Visual/Feel** (animation, VFX, feel) | Screenshot + lead sign-off | `production/qa/evidence/` | ADVISORY |
| **UI** (menus, HUD, screens) | Manual walkthrough doc OR interaction test | `production/qa/evidence/` | ADVISORY |
| **Config/Data** (balance tuning) | Smoke check pass | `production/qa/smoke-[date].md` | ADVISORY |

> **中文翻译**：

| 故事类型 | 必需证据 | 位置 | 门控级别 |
|---|---|---|---|
| **逻辑型**（公式、AI、状态机） | 自动化单元测试 — 必须通过 | `tests/unit/[system]/` | 阻断 |
| **集成型**（多系统） | 集成测试或文档化的试玩 | `tests/integration/[system]/` | 阻断 |
| **视觉/感觉型**（动画、特效、手感） | 截图 + 主管签字 | `production/qa/evidence/` | 建议 |
| **UI型**（菜单、HUD、界面） | 手动走查文档或交互测试 | `production/qa/evidence/` | 建议 |
| **配置/数据型**（平衡调优） | 冒烟测试通过 | `production/qa/smoke-[date].md` | 建议 |

## Automated Test Rules / 自动化测试规则

- **Naming**: `[system]_[feature]_test.[ext]` for files; `test_[scenario]_[expected]` for functions
  > **中文翻译**：**命名**：文件使用 `[system]_[feature]_test.[ext]`；函数使用 `test_[scenario]_[expected]`
- **Determinism**: Tests must produce the same result every run — no random seeds, no time-dependent assertions
  > **中文翻译**：**确定性**：测试每次运行必须产生相同结果 — 无随机种子、无时间依赖的断言
- **Isolation**: Each test sets up and tears down its own state; tests must not depend on execution order
  > **中文翻译**：**隔离性**：每个测试自行设置和清理状态；测试不得依赖执行顺序
- **No hardcoded data**: Test fixtures use constant files or factory functions, not inline magic numbers
  (exception: boundary value tests where the exact number IS the point)
  > **中文翻译**：**无硬编码数据**：测试夹具使用常量文件或工厂函数，而非内联魔数（例外：边界值测试中精确数字本身就是要测试的点）
- **Independence**: Unit tests do not call external APIs, databases, or file I/O — use dependency injection
  > **中文翻译**：**独立性**：单元测试不调用外部API、数据库或文件I/O — 使用依赖注入

## What NOT to Automate / 不应自动化的内容

- Visual fidelity (shader output, VFX appearance, animation curves)
  > **中文翻译**：视觉保真度（着色器输出、特效外观、动画曲线）
- "Feel" qualities (input responsiveness, perceived weight, timing)
  > **中文翻译**："手感"特质（输入响应、感知重量、时机）
- Platform-specific rendering (test on target hardware, not headlessly)
  > **中文翻译**：平台特定渲染（在目标硬件上测试，而非无头模式）
- Full gameplay sessions (covered by playtesting, not automation)
  > **中文翻译**：完整游戏会话（由试玩覆盖，而非自动化）

## CI/CD Rules / CI/CD 规则

- Automated test suite runs on every push to main and every PR
  > **中文翻译**：自动化测试套件在每次推送到main和每个PR时运行
- No merge if tests fail — tests are a blocking gate in CI
  > **中文翻译**：测试失败则不得合并 — 测试是CI中的阻断门控
- Never disable or skip failing tests to make CI pass — fix the underlying issue
  > **中文翻译**：永远不要禁用或跳过失败测试来让CI通过 — 修复根本问题
- Engine-specific CI commands:
  > **中文翻译**：引擎特定CI命令：
  - **Godot**: `godot --headless --script tests/gdunit4_runner.gd`
  - **Unity**: `game-ci/unity-test-runner@v4` (GitHub Actions)
  - **Unreal**: headless runner with `-nullrhi` flag
