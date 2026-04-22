---
name: full-bilingual-adaptation
overview: 对项目中除 docs/Readme 和 .github 外的所有文件进行全面双语适配，确保不仅是 description 字段，所有面向用户的文本内容（标题、说明、规则、步骤等）都添加中文翻译。
todos:
  - id: bilingual-codebuddy-docs-rules
    content: 完成 .codebuddy/docs/ 和 .codebuddy/rules/ 全部文件的双语适配（约 71 文件）
    status: completed
  - id: bilingual-agents
    content: 完成 .codebuddy/agents/ 全部 54 个代理定义文件的双语适配
    status: completed
    dependencies:
      - bilingual-codebuddy-docs-rules
  - id: bilingual-skills
    content: 完成 .codebuddy/skills/ 全部 79 个技能文件的双语适配
    status: completed
    dependencies:
      - bilingual-codebuddy-docs-rules
  - id: bilingual-templates
    content: 完成 .codebuddy/docs/templates/ 全部 38 个模板文件的双语适配
    status: completed
    dependencies:
      - bilingual-codebuddy-docs-rules
  - id: bilingual-docs-root
    content: 完成 docs/ 目录（排除 Readme/）全部文件的双语适配
    status: completed
  - id: bilingual-root-and-remaining
    content: 完成根目录文件及 design/、src/、CCGS Skill Testing Framework/ 等剩余目录的双语适配
    status: completed
---

## 用户需求

提示词工程中仅对 `description` 字段做英中双语适配不够，项目所有文本内容都应做完整的双语适配。

## 产品概述

对项目中除 `docs/Readme/` 和 `.github/` 目录以外的所有 Markdown 文件，补充完整的英中双语内容。当前仅 `description` 字段和部分文档有中文翻译，大量正文内容仍为纯英文，需要按已有双语格式规范统一添加中文翻译。

## 核心功能

- 按已有双语格式规范（标题 `/ 中文标题`、`> **中文翻译**：` 行内翻译、表格复制翻译），为所有缺少中文翻译的文件内容补充双语适配
- 覆盖 `.codebuddy/agents/`（54 文件）、`.codebuddy/skills/`（79 文件）、`.codebuddy/docs/`（~60 文件含模板）、`.codebuddy/rules/`（11 文件）、`docs/`（排除 Readme/）及根目录文件
- 保持现有英文内容不变，仅追加中文翻译，不改变文件结构和功能逻辑

## 技术方案

### 双语格式规范（沿用项目已有约定）

- **标题**：`## English Title / 中文标题`
- **行内翻译**：在英文段落下方添加 `> **中文翻译**：中文内容`
- **列表项翻译**：在每个英文列表项下方添加 `> **中文翻译**：中文翻译`
- **表格翻译**：复制整个表格，在上方添加 `> **中文翻译**：` 前缀，表头和内容均翻译
- **代码注释翻译**：行内注释使用 `// English comment / 中文注释` 或 `# English / 中文`
- **frontmatter description**：已有格式 `"English / 中文"` 保持不变
- **frontmatter 其他字段**（argument-hint 等）：使用 `"English / 中文"` 格式

### 实施策略

1. **按目录分批处理**：每个目录内的文件结构相似，批量处理效率最高
2. **优先级排序**：先处理被高频引用的配置文档，再处理代理定义和技能文件
3. **保持幂等性**：已有中文翻译的内容不重复添加，仅补充缺失部分
4. **质量校验**：每批完成后抽查翻译准确性和格式一致性

### 注意事项

- 不修改英文原文，仅在下方追加中文翻译块
- 代码示例中的注释也需双语适配
- YAML frontmatter 中仅 description 和 argument-hint 需要双语，其他字段（name, tools, model 等）保持英文
- 模板文件中的占位符说明文本需要双语，但占位符本身（如 `[Working Title]`）不翻译
- 行内代码块（如 \`/command\`）、文件路径、变量名等技术标识不翻译