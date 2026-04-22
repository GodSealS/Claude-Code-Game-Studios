---
paths:
  - "tests/**"
---

# Test Standards / 测试标准

- Test naming: `test_[system]_[scenario]_[expected_result]` pattern
  > **中文翻译**：测试命名：`test_[系统]_[场景]_[预期结果]` 模式
- Every test must have a clear arrange/act/assert structure
  > **中文翻译**：每个测试必须有清晰的 准备/执行/断言 结构
- Unit tests must not depend on external state (filesystem, network, database)
  > **中文翻译**：单元测试不得依赖外部状态（文件系统、网络、数据库）
- Integration tests must clean up after themselves
  > **中文翻译**：集成测试必须自行清理
- Performance tests must specify acceptable thresholds and fail if exceeded
  > **中文翻译**：性能测试必须指定可接受阈值，超出时必须失败
- Test data must be defined in the test or in dedicated fixtures, never shared mutable state
  > **中文翻译**：测试数据必须在测试中或专用夹具中定义，绝不使用共享可变状态
- Mock external dependencies — tests should be fast and deterministic
  > **中文翻译**：模拟外部依赖 — 测试应快速且确定性
- Every bug fix must have a regression test that would have caught the original bug
  > **中文翻译**：每个缺陷修复必须有能捕获原始缺陷的回归测试

## Examples / 示例

**Correct** (proper naming + Arrange/Act/Assert):
> **中文翻译**：**正确**（正确命名 + 准备/执行/断言）：

```gdscript
func test_health_system_take_damage_reduces_health() -> void:
    # Arrange / 准备
    var health := HealthComponent.new()
    health.max_health = 100
    health.current_health = 100

    # Act / 执行
    health.take_damage(25)

    # Assert / 断言
    assert_eq(health.current_health, 75)
```

**Incorrect**:
> **中文翻译**：**错误**：

```gdscript
func test1() -> void:  # VIOLATION: no descriptive name / 违规：无描述性名称
    var h := HealthComponent.new()
    h.take_damage(25)  # VIOLATION: no arrange step, no clear assert / 违规：无准备步骤，无清晰断言
    assert_true(h.current_health < 100)  # VIOLATION: imprecise assertion / 违规：不精确的断言
```
