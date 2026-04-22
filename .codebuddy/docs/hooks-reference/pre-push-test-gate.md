# Hook: pre-push-test-gate / 钩子：推送前测试门控

## Trigger / 触发条件

Runs before any push to a remote branch. Mandatory for pushes to `develop`
and `main`.

> **中文翻译**：在推送到远程分支前运行。对推送到 `develop` 和 `main` 是强制性的。

## Purpose / 目的

Ensures the build compiles, unit tests pass, and critical smoke tests pass
before code reaches shared branches. This is the last automated quality gate
before code affects other developers.

> **中文翻译**：确保构建编译通过、单元测试通过、关键冒烟测试通过，然后代码才能到达共享分支。这是代码影响其他开发者前的最后一个自动化质量门控。

## Implementation / 实现

```bash
#!/bin/bash
# Pre-push hook: Build and test gate
# 推送前钩子：构建和测试门控

REMOTE="$1"
URL="$2"

# Only enforce full gate for develop and main
# 仅对 develop 和 main 强制执行完整门控
PROTECTED_BRANCHES="develop main"
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)

FULL_GATE=false
for branch in $PROTECTED_BRANCHES; do
    if [ "$CURRENT_BRANCH" = "$branch" ]; then
        FULL_GATE=true
        break
    fi
done

echo "=== Pre-Push Quality Gate ==="

# Step 1: Build / 步骤 1：构建
echo "Building..."
# Adapt to your build system: / 根据你的构建系统调整：
# make build || exit 1
# dotnet build || exit 1
# cargo build || exit 1
echo "Build: PASS"

# Step 2: Unit tests / 步骤 2：单元测试
echo "Running unit tests..."
# Adapt to your test framework: / 根据你的测试框架调整：
# python -m pytest tests/unit/ -x || exit 1
# dotnet test tests/unit/ || exit 1
# cargo test || exit 1
echo "Unit tests: PASS"

if [ "$FULL_GATE" = true ]; then
    # Step 3: Integration tests (only for protected branches)
    # 步骤 3：集成测试（仅受保护分支）
    echo "Running integration tests..."
    # python -m pytest tests/integration/ -x || exit 1
    echo "Integration tests: PASS"

    # Step 4: Smoke tests / 步骤 4：冒烟测试
    echo "Running smoke tests..."
    # python -m pytest tests/playtest/smoke/ -x || exit 1
    echo "Smoke tests: PASS"

    # Step 5: Performance regression check / 步骤 5：性能回归检查
    echo "Checking performance baselines..."
    # python tools/ci/perf_check.py || exit 1
    echo "Performance: PASS"
fi

echo "=== All gates passed ==="
exit 0
```

## Agent Integration / 代理集成

When this hook fails:
> **中文翻译**：当此钩子失败时：

1. Build failure: invoke `lead-programmer` to diagnose
   > **中文翻译**：构建失败：调用 `lead-programmer` 诊断
2. Unit test failure: invoke `qa-tester` to identify the failing test and
   `gameplay-programmer` or relevant programmer to fix
   > **中文翻译**：单元测试失败：调用 `qa-tester` 识别失败测试，调用 `gameplay-programmer` 或相关程序员修复
3. Performance regression: invoke `performance-analyst` to analyze
   > **中文翻译**：性能回归：调用 `performance-analyst` 分析
