# Coding Standards / 编码标准

- All game code must include doc comments on public APIs / 所有游戏代码必须在公共API上包含文档注释
- Every system must have a corresponding architecture decision record in `docs/architecture/` / 每个系统必须在 `docs/architecture/` 中有相应的架构决策记录
- Gameplay values must be data-driven (external config), never hardcoded / 游戏值必须是数据驱动的（外部配置），绝不能硬编码
- All public methods must be unit-testable (dependency injection over singletons) / 所有公共方法必须是可单元测试的（依赖注入优于单例）
- Commits must reference the relevant design document or task ID / 提交必须引用相关设计文档或任务ID
- **Verification-driven development / 验证驱动开发**: Write tests first when adding gameplay systems. / 添加游戏系统时先编写测试。
  For UI changes, verify with screenshots. Compare expected output to actual output / 对于UI更改，使用截图验证。将预期输出与实际输出进行比较
  before marking work complete. Every implementation should have a way to prove it works. / 在标记工作完成前。每个实现都应该有一种方法来证明它有效。

# Design Document Standards / 设计文档标准

- All design docs use Markdown / 所有设计文档使用 Markdown
- Each mechanic has a dedicated document in `design/gdd/` / 每个机制在 `design/gdd/` 中有专门的文档
- Documents must include these 8 required sections: / 文档必须包含以下8个必需章节：
  1. **Overview / 概述** -- one-paragraph summary / 一句话摘要
  2. **Player Fantasy / 玩家幻想** -- intended feeling and experience / 预期的感觉和体验
  3. **Detailed Rules / 详细规则** -- unambiguous mechanics / 明确的机制
  4. **Formulas / 公式** -- all math defined with variables / 所有使用变量定义的数学公式
  5. **Edge Cases / 边界情况** -- unusual situations handled / 处理的异常情况
  6. **Dependencies / 依赖** -- other systems listed / 列出的其他系统
  7. **Tuning Knobs / 调整参数** -- configurable values identified / 识别的可配置值
  8. **Acceptance Criteria / 验收标准** -- testable success conditions / 可测试的成功条件
- Balance values must link to their source formula or rationale / 平衡值必须链接到其来源公式或原理

# Testing Standards / 测试标准

## Test Evidence by Story Type / 按故事类型的测试证据

All stories must have appropriate test evidence before they can be marked Done: / 所有故事在标记为完成之前必须有适当的测试证据：

| Story Type / 故事类型 | Required Evidence / 所需证据 | Location / 位置 | Gate Level / 关卡级别 |
|---|---|---|---|
| **Logic / 逻辑** (formulas, AI, state machines / 公式、AI、状态机) | Automated unit test — must pass / 自动化单元测试 — 必须通过 | `tests/unit/[system]/` | BLOCKING / 阻塞 |
| **Integration / 集成** (multi-system / 多系统) | Integration test OR documented playtest / 集成测试或记录的游戏测试 | `tests/integration/[system]/` | BLOCKING / 阻塞 |
| **Visual/Feel / 视觉/感觉** (animation, VFX, feel / 动画、特效、感觉) | Screenshot + lead sign-off / 截图 + 负责人签字 | `production/qa/evidence/` | ADVISORY / 建议 |
| **UI** (menus, HUD, screens / 菜单、HUD、屏幕) | Manual walkthrough doc OR interaction test / 手动演练文档或交互测试 | `production/qa/evidence/` | ADVISORY / 建议 |
| **Config/Data / 配置/数据** (balance tuning / 平衡调整) | Smoke check pass / 冒烟检查通过 | `production/qa/smoke-[date].md` | ADVISORY / 建议 |

## Automated Test Rules / 自动化测试规则

- **Naming / 命名**: `[system]_[feature]_test.[ext]` for files; `test_[scenario]_[expected]` for functions / 文件使用；函数使用
- **Determinism / 确定性**: Tests must produce the same result every run — no random seeds, no time-dependent assertions / 测试每次运行必须产生相同结果 — 没有随机种子，没有时间相关的断言
- **Isolation / 隔离**: Each test sets up and tears down its own state; tests must not depend on execution order / 每个测试设置和拆除自己的状态；测试不能依赖执行顺序
- **No hardcoded data / 无硬编码数据**: Test fixtures use constant files or factory functions, not inline magic numbers / 测试夹具使用常量文件或工厂函数，而非内联魔法数字
  (exception: boundary value tests where the exact number IS the point) / （例外：精确数字就是重点的边界值测试）
- **Independence / 独立性**: Unit tests do not call external APIs, databases, or file I/O — use dependency injection / 单元测试不调用外部API、数据库或文件I/O — 使用依赖注入

## What NOT to Automate / 什么不应该自动化

- Visual fidelity (shader output, VFX appearance, animation curves) / 视觉保真度（着色器输出、特效外观、动画曲线）
- "Feel" qualities (input responsiveness, perceived weight, timing) / "感觉"品质（输入响应、感知重量、时机）
- Platform-specific rendering (test on target hardware, not headlessly) / 平台特定渲染（在目标硬件上测试，而非无头模式）
- Full gameplay sessions (covered by playtesting, not automation) / 完整游戏会话（由游戏测试覆盖，而非自动化）

## CI/CD Rules / CI/CD 规则

- Automated test suite runs on every push to main and every PR / 自动化测试套件在每次推送到main和每个PR时运行
- No merge if tests fail — tests are a blocking gate in CI / 如果测试失败则禁止合并 — 测试是CI中的阻塞关卡
- Never disable or skip failing tests to make CI pass — fix the underlying issue / 永远不要禁用或跳过失败的测试以使CI通过 — 修复根本问题
- Engine-specific CI commands: / 引擎特定CI命令：
  - **Godot**: `godot --headless --script tests/gdunit4_runner.gd`
  - **Unity**: `game-ci/unity-test-runner@v4` (GitHub Actions)
  - **Unreal**: headless runner with `-nullrhi` flag / 带 `-nullrhi` 标志的无头运行器
