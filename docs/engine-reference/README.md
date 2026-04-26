# Engine Reference Documentation / 引擎参考文档

This directory contains curated, version-pinned documentation snapshots for the
game engine(s) used in this project. These files exist because **LLM knowledge
has a cutoff date** and game engines update frequently.

> **中文翻译**：此目录包含项目所使用游戏引擎的版本锁定文档快照。这些文件的存在是因为 **LLM 知识有截止日期**，而游戏引擎更新频繁。

<!-- 中文翻译 -->
## Why This Exists

Claude's training data has a knowledge cutoff (currently May 2025). Game engines
like Godot, Unity, Unreal, and Cocos Creator ship updates that introduce breaking API changes,
new features, and deprecated patterns. Without these reference files, agents will
suggest outdated code.

<!-- 中文翻译 -->
## Structure

Each engine gets its own directory:

```
<engine>/
├── VERSION.md              # Pinned version, verification date, knowledge gap window
├── breaking-changes.md     # API changes between versions, organized by risk level
├── deprecated-apis.md      # "Don't use X → Use Y" lookup tables
├── current-best-practices.md  # New practices not in model training data
└── modules/                # Per-subsystem quick references (~150 lines max each)
    ├── rendering.md
    ├── physics.md
    └── ...
```

<!-- 中文翻译 -->
## How Agents Use These Files

Engine-specialist agents are instructed to:

1. Read `VERSION.md` to confirm the current engine version
2. Check `deprecated-apis.md` before suggesting any engine API
3. Consult `breaking-changes.md` for version-specific concerns
4. Read relevant `modules/*.md` for subsystem-specific work

<!-- 中文翻译 -->
## Maintenance

<!-- 中文翻译 -->
### When to Update

- After upgrading the engine version
- When the LLM model is updated (new knowledge cutoff)
- After running `/refresh-docs` (if available)
- When you discover an API the model gets wrong

<!-- 中文翻译 -->
### How to Update

1. Update `VERSION.md` with the new engine version and date
2. Add new entries to `breaking-changes.md` for the version transition
3. Move newly deprecated APIs into `deprecated-apis.md`
4. Update `current-best-practices.md` with new patterns
5. Update relevant `modules/*.md` with API changes
6. Set "Last verified" dates on all modified files

<!-- 中文翻译 -->
### Quality Rules

- Every file must have a "Last verified: YYYY-MM-DD" date
- Keep module files under 150 lines (context budget)
- Include code examples showing correct/incorrect patterns
- Link to official documentation URLs for verification
- Only document things that differ from the model's training data
