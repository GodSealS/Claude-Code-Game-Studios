---
name: asset-audit
description: "Audits game assets for compliance with naming conventions, file size budgets, format standards, and pipeline requirements. Identifies orphaned assets, missing references, and standard violations. / 审计游戏资产的命名约定、文件大小预算、格式标准和管线要求合规性。识别孤立资产、缺失引用和标准违规。"
argument-hint: "[category|all]"
user-invocable: true
allowed-tools: Read, Glob, Grep
# Read-only diagnostic skill — no specialist agent delegation needed / 只读诊断技能 — 无需专家代理委派
---

## Phase 1: Read Standards / 第 1 阶段：阅读标准

Read the art bible or asset standards from the relevant design docs and the CODEBUDDY.md naming conventions.
> **中文翻译**：从相关设计文档和 CODEBUDDY.md 命名约定中读取美术圣经或资产标准。

---

## Phase 2: Scan Asset Directories / 第 2 阶段：扫描资产目录

Scan the target asset directory using Glob:
> **中文翻译**：使用 Glob 扫描目标资产目录：

- `assets/art/**/*` for art assets / 用于美术资产
- `assets/audio/**/*` for audio assets / 用于音频资产
- `assets/vfx/**/*` for VFX assets / 用于视觉特效资产
- `assets/shaders/**/*` for shaders / 用于着色器
- `assets/data/**/*` for data files / 用于数据文件

---

## Phase 3: Run Compliance Checks / 第 3 阶段：运行合规性检查

**Naming conventions:** / **命名约定：**

- Art: `[category]_[name]_[variant]_[size].[ext]` / 美术：`[类别]_[名称]_[变体]_[尺寸].[扩展名]`
- Audio: `[category]_[context]_[name]_[variant].[ext]` / 音频：`[类别]_[上下文]_[名称]_[变体].[扩展名]`
- All files must be lowercase with underscores / 所有文件必须小写并带下划线

**File standards:** / **文件标准：**

- Textures: Power-of-two dimensions, correct format (PNG for UI, compressed for 3D), within size budget / 纹理：2 的幂尺寸、正确格式（UI 为 PNG，3D 为压缩格式）、在大小预算内
- Audio: Correct sample rate, format (OGG for SFX, OGG/MP3 for music), within duration limits / 音频：正确的采样率、格式（SFX 为 OGG，音乐为 OGG/MP3）、在时长限制内
- Data: Valid JSON/YAML, schema-compliant / 数据：有效的 JSON/YAML、符合架构

**Orphaned assets:** Search code for references to each asset file. Flag any with no references.
> **中文翻译**：**孤立资产**：搜索代码中对每个资产文件的引用。标记任何无引用的文件。

**Missing assets:** Search code for asset references and verify the files exist.
> **中文翻译**：**缺失资产**：搜索代码中的资产引用并验证文件是否存在。

---

## Phase 4: Output Audit Report / 第 4 阶段：输出审计报告

```markdown
# Asset Audit Report -- [Category] -- [Date]

## Summary / 摘要
- **Total assets scanned**: [N] / **扫描资产总数**
- **Naming violations**: [N] / **命名违规**
- **Size violations**: [N] / **大小违规**
- **Format violations**: [N] / **格式违规**
- **Orphaned assets**: [N] / **孤立资产**
- **Missing assets**: [N] / **缺失资产**
- **Overall health**: [CLEAN / MINOR ISSUES / NEEDS ATTENTION] / **整体健康状况**：[清洁 / 小问题 / 需要关注]

## Naming Violations / 命名违规
| File | Expected Pattern | Issue |
|------|-----------------|-------|

## Size Violations / 大小违规
| File | Budget | Actual | Overage |
|------|--------|--------|---------|

## Format Violations / 格式违规
| File | Expected Format | Actual Format |
|------|----------------|---------------|

## Orphaned Assets (no code references found) / 孤立资产（未找到代码引用）
| File | Last Modified | Size | Recommendation |
|------|-------------|------|---------------|

## Missing Assets (referenced but not found) / 缺失资产（已引用但未找到）
| Reference Location | Expected Path |
|-------------------|---------------|

## Recommendations / 建议
[Prioritized list of fixes]

## Verdict: [COMPLIANT / WARNINGS / NON-COMPLIANT] / 裁决：[合规 / 警告 / 不合规]
```

This skill is read-only — it produces a report but does not write files.
> **中文翻译**：此技能为只读 — 它生成报告但不写入文件。

---

## Phase 5: Next Steps / 第 5 阶段：后续步骤

- Fix naming violations using the patterns defined in CLAUDE.md. / 使用 CLAUDE.md 中定义的模式修复命名违规。
- Delete confirmed orphaned assets after manual review. / 人工审核后删除确认的孤立资产。
- Run `/content-audit` to cross-check asset counts against GDD-specified requirements. / 运行 `/content-audit` 对照 GDD 指定的需求交叉检查资产计数。
