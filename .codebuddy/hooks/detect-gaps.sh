#!/bin/bash
# Hook: detect-gaps.sh
# Event: SessionStart
# Purpose: Detect missing documentation when code/prototypes exist
# 目的: 检测代码/原型存在时缺失的文档
# Cross-platform: Windows Git Bash compatible (uses grep -E, not -P)
# 跨平台: Windows Git Bash 兼容 (使用 grep -E，非 grep -P)

# Exit on error for debugging (but don't fail the session)
# 错误时退出用于调试（但不要使会话失败）
set +e

echo "=== Checking for Documentation Gaps / 检查文档缺口 ==="

# --- Check 0: Fresh project detection (suggests /start) ---
# 检查 0: 新项目检测（建议运行 /start）
FRESH_PROJECT=true

# Check if engine is configured
# 检查引擎是否已配置
if [ -f ".codebuddy/docs/technical-preferences.md" ]; then
  ENGINE_LINE=$(grep -E "^\- \*\*Engine\*\*:" .codebuddy/docs/technical-preferences.md 2>/dev/null)
  if [ -n "$ENGINE_LINE" ] && ! echo "$ENGINE_LINE" | grep -q "TO BE CONFIGURED" 2>/dev/null; then
    FRESH_PROJECT=false
  fi
fi

# Check if game concept exists
# 检查游戏概念是否存在
if [ -f "design/gdd/game-concept.md" ]; then
  FRESH_PROJECT=false
fi

# Check if source code exists
# 检查源代码是否存在
if [ -d "src" ]; then
  SRC_CHECK=$(find src -type f \( -name "*.gd" -o -name "*.cs" -o -name "*.cpp" -o -name "*.c" -o -name "*.h" -o -name "*.hpp" -o -name "*.rs" -o -name "*.py" -o -name "*.js" -o -name "*.ts" \) 2>/dev/null | head -1)
  if [ -n "$SRC_CHECK" ]; then
    FRESH_PROJECT=false
  fi
fi

if [ "$FRESH_PROJECT" = true ]; then
  echo ""
  echo "🚀 NEW PROJECT / 新项目: No engine configured, no game concept, no source code."
  echo "   没有配置引擎，没有游戏概念，没有源代码。"
  echo "   This looks like a fresh start! Run: /start"
  echo "   这看起来是一个全新的开始！运行: /start"
  echo ""
  echo "💡 To get a comprehensive project analysis, run: /project-stage-detect"
  echo "   要获取全面的项目分析，运行: /project-stage-detect"
  echo "==================================="
  exit 0
fi

# --- Check 1: Substantial codebase but sparse design docs ---
# 检查 1: 大量代码库但设计文档稀疏
if [ -d "src" ]; then
  # Count source files (cross-platform, handles Windows paths)
  # 统计源文件（跨平台，处理 Windows 路径）
  SRC_FILES=$(find src -type f \( -name "*.gd" -o -name "*.cs" -o -name "*.cpp" -o -name "*.c" -o -name "*.h" -o -name "*.hpp" -o -name "*.rs" -o -name "*.py" -o -name "*.js" -o -name "*.ts" \) 2>/dev/null | wc -l)
else
  SRC_FILES=0
fi

if [ -d "design/gdd" ]; then
  DESIGN_FILES=$(find design/gdd -type f -name "*.md" 2>/dev/null | wc -l)
else
  DESIGN_FILES=0
fi

# Normalize whitespace from wc output
# 规范化 wc 输出的空白字符
SRC_FILES=$(echo "$SRC_FILES" | tr -d ' ')
DESIGN_FILES=$(echo "$DESIGN_FILES" | tr -d ' ')

if [ "$SRC_FILES" -gt 50 ] && [ "$DESIGN_FILES" -lt 5 ]; then
  echo "⚠️  GAP / 缺口: Substantial codebase ($SRC_FILES source files) but sparse design docs ($DESIGN_FILES files)"
  echo "    大量代码库（$SRC_FILES 个源文件）但设计文档稀疏（$DESIGN_FILES 个文件）"
  echo "    Suggested action / 建议操作: /reverse-document design src/[system]"
  echo "    Or run / 或运行: /project-stage-detect to get full analysis / 获取完整分析"
fi

# --- Check 2: Prototypes without documentation ---
# 检查 2: 没有文档的原型
if [ -d "prototypes" ]; then
  PROTOTYPE_DIRS=$(find prototypes -mindepth 1 -maxdepth 1 -type d 2>/dev/null)
  UNDOCUMENTED_PROTOS=()

  if [ -n "$PROTOTYPE_DIRS" ]; then
    while IFS= read -r proto_dir; do
      # Normalize path separators for Windows
      # 规范化 Windows 的路径分隔符
      proto_dir=$(echo "$proto_dir" | sed 's|\\|/|g')

      # Check for README.md or CONCEPT.md
      # 检查 README.md 或 CONCEPT.md
      if [ ! -f "${proto_dir}/README.md" ] && [ ! -f "${proto_dir}/CONCEPT.md" ]; then
        proto_name=$(basename "$proto_dir")
        UNDOCUMENTED_PROTOS+=("$proto_name")
      fi
    done <<< "$PROTOTYPE_DIRS"

    if [ ${#UNDOCUMENTED_PROTOS[@]} -gt 0 ]; then
      echo "⚠️  GAP / 缺口: ${#UNDOCUMENTED_PROTOS[@]} undocumented prototype(s) found / 发现未记录的原型:"
      for proto in "${UNDOCUMENTED_PROTOS[@]}"; do
        echo "    - prototypes/$proto/ (no README or CONCEPT doc / 没有 README 或 CONCEPT 文档)"
      done
      echo "    Suggested action / 建议操作: /reverse-document concept prototypes/[name]"
    fi
  fi
fi

# --- Check 3: Core systems without architecture docs ---
# 检查 3: 没有架构文档的核心系统
if [ -d "src/core" ] || [ -d "src/engine" ]; then
  if [ ! -d "docs/architecture" ]; then
    echo "⚠️  GAP / 缺口: Core engine/systems exist but no docs/architecture/ directory"
    echo "    核心引擎/系统存在但没有 docs/architecture/ 目录"
    echo "    Suggested action / 建议操作: Create docs/architecture/ and run /architecture-decision"
  else
    ADR_COUNT=$(find docs/architecture -type f -name "*.md" 2>/dev/null | wc -l)
    ADR_COUNT=$(echo "$ADR_COUNT" | tr -d ' ')

    if [ "$ADR_COUNT" -lt 3 ]; then
      echo "⚠️  GAP / 缺口: Core systems exist but only $ADR_COUNT ADR(s) documented"
      echo "    核心系统存在但只有 $ADR_COUNT 个 ADR 被记录"
      echo "    Suggested action / 建议操作: /reverse-document architecture src/core/[system]"
    fi
  fi
fi

# --- Check 4: Gameplay systems without design docs ---
# 检查 4: 没有设计文档的游戏系统
if [ -d "src/gameplay" ]; then
  # Find major gameplay subdirectories (those with 5+ files)
  # 查找主要游戏子目录（5个以上文件的）
  GAMEPLAY_SYSTEMS=$(find src/gameplay -mindepth 1 -maxdepth 1 -type d 2>/dev/null)

  if [ -n "$GAMEPLAY_SYSTEMS" ]; then
    while IFS= read -r system_dir; do
      system_dir=$(echo "$system_dir" | sed 's|\\|/|g')
      system_name=$(basename "$system_dir")
      file_count=$(find "$system_dir" -type f 2>/dev/null | wc -l)
      file_count=$(echo "$file_count" | tr -d ' ')

      # If system has 5+ files, check for corresponding design doc
      # 如果系统有 5+ 文件，检查对应的设计文档
      if [ "$file_count" -ge 5 ]; then
        # Check for design doc (allow variations: combat-system.md, combat.md)
        # 检查设计文档（允许变体：combat-system.md、combat.md）
        design_doc_1="design/gdd/${system_name}-system.md"
        design_doc_2="design/gdd/${system_name}.md"

        if [ ! -f "$design_doc_1" ] && [ ! -f "$design_doc_2" ]; then
          echo "⚠️  GAP / 缺口: Gameplay system 'src/gameplay/$system_name/' ($file_count files) has no design doc"
          echo "    游戏系统 'src/gameplay/$system_name/'（$file_count 个文件）没有设计文档"
          echo "    Expected / 期望: design/gdd/${system_name}-system.md or design/gdd/${system_name}.md"
          echo "    Suggested action / 建议操作: /reverse-document design src/gameplay/$system_name"
        fi
      fi
    done <<< "$GAMEPLAY_SYSTEMS"
  fi
fi

# --- Check 5: Production planning ---
# 检查 5: 生产规划
if [ "$SRC_FILES" -gt 100 ]; then
  # For projects with substantial code, check for production planning
  # 对于有大量代码的项目，检查生产规划
  if [ ! -d "production/sprints" ] && [ ! -d "production/milestones" ]; then
    echo "⚠️  GAP / 缺口: Large codebase ($SRC_FILES files) but no production planning found"
    echo "    大型代码库（$SRC_FILES 个文件）但没有发现生产规划"
    echo "    Suggested action / 建议操作: /sprint-plan or create production/ directory"
  fi
fi

# --- Summary ---
echo ""
echo "💡 To get a comprehensive project analysis, run: /project-stage-detect"
echo "   要获取全面的项目分析，运行: /project-stage-detect"
echo "==================================="

exit 0
