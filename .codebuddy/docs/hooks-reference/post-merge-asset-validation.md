# Hook: post-merge-asset-validation / 钩子：合并后资产验证

## Trigger / 触发条件

Runs after any merge to the `develop` or `main` branch that includes changes
to `assets/`.

> **中文翻译**：在合并到 `develop` 或 `main` 分支且包含 `assets/` 变更后运行。

## Purpose / 目的

Validates that all assets in the merged branch conform to naming conventions,
size budgets, and format requirements. Prevents non-compliant assets from
accumulating on integration branches.

> **中文翻译**：验证合并分支中所有资产符合命名约定、大小预算和格式要求。防止不合规资产在集成分支上积累。

## Implementation / 实现

```bash
#!/bin/bash
# Post-merge hook: Asset validation
# 合并后钩子：资产验证
# Checks merged assets against project standards
# 根据项目标准检查合并的资产

MERGED_ASSETS=$(git diff --name-only HEAD@{1} HEAD | grep -E '^assets/')

if [ -z "$MERGED_ASSETS" ]; then
    exit 0
fi

EXIT_CODE=0
WARNINGS=""

for file in $MERGED_ASSETS; do
    filename=$(basename "$file")

    # Check naming convention (lowercase with underscores)
    # 检查命名约定（小写加下划线）
    if echo "$filename" | grep -qE '[A-Z[:space:]-]'; then
        WARNINGS="$WARNINGS\nNAMING: $file -- must be lowercase with underscores"
        EXIT_CODE=1
    fi

    # Check texture sizes (must be power of 2)
    # 检查纹理尺寸（必须是 2 的幂）
    if [[ "$file" == *.png || "$file" == *.jpg ]]; then
        # Requires ImageMagick / 需要 ImageMagick
        if command -v identify &> /dev/null; then
            dims=$(identify -format "%w %h" "$file" 2>/dev/null)
            if [ -n "$dims" ]; then
                w=$(echo "$dims" | cut -d' ' -f1)
                h=$(echo "$dims" | cut -d' ' -f2)
                if (( (w & (w-1)) != 0 || (h & (h-1)) != 0 )); then
                    WARNINGS="$WARNINGS\nSIZE: $file -- dimensions ${w}x${h} not power-of-2"
                fi
            fi
        fi
    fi

    # Check file size budgets / 检查文件大小预算
    size=$(stat -f%z "$file" 2>/dev/null || stat -c%s "$file" 2>/dev/null)
    if [ -n "$size" ]; then
        # Textures: max 4MB / 纹理：最大 4MB
        if [[ "$file" == assets/art/* ]] && [ "$size" -gt 4194304 ]; then
            WARNINGS="$WARNINGS\nBUDGET: $file -- ${size} bytes exceeds 4MB texture budget"
            EXIT_CODE=1
        fi
        # Audio: max 10MB for music, 512KB for SFX / 音频：音乐最大 10MB，音效最大 512KB
        if [[ "$file" == assets/audio/sfx* ]] && [ "$size" -gt 524288 ]; then
            WARNINGS="$WARNINGS\nBUDGET: $file -- ${size} bytes exceeds 512KB SFX budget"
        fi
    fi
done

if [ -n "$WARNINGS" ]; then
    echo "=== Asset Validation Report ==="
    echo -e "$WARNINGS"
    echo "================================"
    echo "Run /asset-audit for a full report."
fi

exit $EXIT_CODE
```

## Agent Integration / 代理集成

When this hook reports issues:
> **中文翻译**：当此钩子报告问题时：

1. For naming violations: fix manually or invoke `art-director` for guidance
   > **中文翻译**：命名违规：手动修复或调用 `art-director` 获取指导
2. For size violations: invoke `technical-artist` for optimization advice
   > **中文翻译**：大小违规：调用 `technical-artist` 获取优化建议
3. For a full audit: run `/asset-audit` skill
   > **中文翻译**：完整审计：运行 `/asset-audit` 技能
