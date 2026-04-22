---
paths:
  - "prototypes/**"
---

# Prototype Code Standards (Relaxed) / 原型代码标准（放宽）

Prototypes are throwaway code for validating ideas. Standards are intentionally
relaxed to maximize iteration speed. The goal is learning, not production quality.

> **中文翻译**：原型是用于验证想法的一次性代码。标准有意放宽以最大化迭代速度。目标是学习，而非生产质量。

## What's Allowed in Prototypes / 原型中允许的内容

- Hardcoded values (no need for data-driven config)
  > **中文翻译**：硬编码值（无需数据驱动配置）
- Minimal or no doc comments
  > **中文翻译**：最少或不写文档注释
- Simple architecture (no dependency injection required)
  > **中文翻译**：简单架构（无需依赖注入）
- Singletons and global state
  > **中文翻译**：单例和全局状态
- Copy-pasted code (no need for abstraction)
  > **中文翻译**：复制粘贴的代码（无需抽象）
- Debug output left in place
  > **中文翻译**：保留调试输出
- Placeholder art and audio
  > **中文翻译**：占位美术和音频
- Quick-and-dirty solutions
  > **中文翻译**：快速粗糙的解决方案

## What's Still Required / 仍然必须遵守的规则

- Each prototype lives in its own subdirectory: `prototypes/[name]/`
  > **中文翻译**：每个原型位于自己的子目录中：`prototypes/[名称]/`
- Every prototype MUST have a `README.md` with:
  > **中文翻译**：每个原型必须有一个 `README.md`，包含：
  - What hypothesis is being tested
    > **中文翻译**：正在测试什么假设
  - How to run the prototype
    > **中文翻译**：如何运行原型
  - Current status (in-progress / concluded)
    > **中文翻译**：当前状态（进行中 / 已结束）
  - Findings (updated when prototype concludes)
    > **中文翻译**：发现（原型结束时更新）
- No production code may reference or import from `prototypes/`
  > **中文翻译**：生产代码不得引用或导入 `prototypes/` 中的内容
- Prototypes must not modify files outside `prototypes/`
  > **中文翻译**：原型不得修改 `prototypes/` 以外的文件
- Prototypes must not be deployed or shipped
  > **中文翻译**：原型不得被部署或发布

## When a Prototype Succeeds / 当原型验证成功时

If a prototype validates a concept and the feature moves to production:
> **中文翻译**：如果原型验证了一个概念且该功能进入生产阶段：

1. The prototype code is NOT migrated directly — it is rewritten to production standards
   > **中文翻译**：原型代码不会直接迁移 — 而是按照生产标准重写
2. The prototype `README.md` findings inform the production design document
   > **中文翻译**：原型 `README.md` 的发现将指导生产设计文档
3. The prototype directory is preserved for reference but never extended
   > **中文翻译**：原型目录保留作为参考但不再扩展

## Cleanup / 清理

Concluded prototypes should be archived or deleted after findings are captured.
Never let prototype code grow into production code through incremental "cleanup."

> **中文翻译**：已结束的原型在记录发现后应归档或删除。永远不要让原型代码通过增量"清理"变成生产代码。
