# Hook: pre-commit-code-quality / 钩子：提交前代码质量

## Trigger / 触发条件

Runs before any commit that modifies files in `src/`.

> **中文翻译**：在修改 `src/` 中文件的提交前运行。

## Purpose / 目的

Enforces coding standards before code enters version control. Catches style
violations, missing documentation, overly complex methods, and hardcoded
values that should be data-driven.

> **中文翻译**：在代码进入版本控制前强制执行编码标准。捕获风格违规、缺失文档、过于复杂的方法以及应该数据驱动的硬编码值。

## Implementation / 实现

```bash
#!/bin/bash
# Pre-commit hook: Code quality checks
# 提交前钩子：代码质量检查
# Adapt the specific checks to your language and tooling
# 根据你的语言和工具调整具体检查

CODE_FILES=$(git diff --cached --name-only --diff-filter=ACM | grep -E '^src/')

EXIT_CODE=0

if [ -n "$CODE_FILES" ]; then
    for file in $CODE_FILES; do
        # Check for hardcoded magic numbers in gameplay code
        # 检查玩法代码中的硬编码魔术数字
        if [[ "$file" == src/gameplay/* ]]; then
            # Look for numeric literals that are likely balance values
            # 查找可能是平衡数值的数字字面量
            # Adjust the pattern for your language / 根据你的语言调整模式
            if grep -nE '(damage|health|speed|rate|chance|cost|duration)[[:space:]]*[:=][[:space:]]*[0-9]+' "$file"; then
                echo "WARNING: $file may contain hardcoded gameplay values. Use data files."
                # Warning only, not blocking / 仅警告，不阻止
            fi
        fi

        # Check for TODO/FIXME without assignee
        # 检查没有负责人的 TODO/FIXME
        if grep -nE '(TODO|FIXME|HACK)[^(]' "$file"; then
            echo "WARNING: $file has TODO/FIXME without owner tag. Use TODO(name) format."
        fi

        # Run language-specific linter (uncomment appropriate line)
        # 运行特定语言的代码检查器（取消注释相应行）
        # For GDScript: gdlint "$file" || EXIT_CODE=1
        # For C#: dotnet format --check "$file" || EXIT_CODE=1
        # For C++: clang-format --dry-run -Werror "$file" || EXIT_CODE=1
    done

    # Run unit tests for modified systems
    # 为修改的系统运行单元测试
    # Uncomment and adapt for your test framework / 取消注释并根据你的测试框架调整
    # python -m pytest tests/unit/ -x --quiet || EXIT_CODE=1
fi

exit $EXIT_CODE
```

## Agent Integration / 代理集成

When this hook fails:
> **中文翻译**：当此钩子失败时：

1. For style violations: auto-fix with your formatter or invoke `lead-programmer`
   > **中文翻译**：风格违规：使用格式化工具自动修复或调用 `lead-programmer`
2. For hardcoded values: invoke `gameplay-programmer` to externalize the values
   > **中文翻译**：硬编码值：调用 `gameplay-programmer` 将值外部化
3. For test failures: invoke `qa-tester` to diagnose and `gameplay-programmer` to fix
   > **中文翻译**：测试失败：调用 `qa-tester` 诊断并调用 `gameplay-programmer` 修复
