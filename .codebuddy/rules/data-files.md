---
paths:
  - "assets/data/**"
---

# Data File Rules / 数据文件规则

- All JSON files must be valid JSON — broken JSON blocks the entire build pipeline / 所有 JSON 文件必须是有效的 JSON — 损坏的 JSON 会阻塞整个构建管线
- File naming: lowercase with underscores only, following `[system]_[name].json` pattern / 文件命名：仅使用小写字母和下划线，遵循 `[系统]_[名称].json` 模式
- Every data file must have a documented schema (either JSON Schema or documented in the corresponding design doc) / 每个数据文件必须有文档化的模式（JSON Schema 或在对应设计文档中记录）
- Numeric values must include comments or companion docs explaining what the numbers mean / 数值必须包含注释或配套文档解释数字含义
- Use consistent key naming: camelCase for keys within JSON files / 使用一致的键名命名：JSON 文件内的键使用 camelCase
- No orphaned data entries — every entry must be referenced by code or another data file / 不得有孤立数据条目 — 每个条目必须被代码或其他数据文件引用
- Version data files when making breaking schema changes / 进行破坏性模式更改时必须对数据文件进行版本控制
- Include sensible defaults for all optional fields / 为所有可选字段包含合理的默认值

## Examples / 示例

**Correct** naming and structure (`combat_enemies.json`) / **正确**的命名和结构（`combat_enemies.json`）：

```json
{
  "goblin": {
    "baseHealth": 50,
    "baseDamage": 8,
    "moveSpeed": 3.5,
    "lootTable": "loot_goblin_common"
  },
  "goblin_chief": {
    "baseHealth": 150,
    "baseDamage": 20,
    "moveSpeed": 2.8,
    "lootTable": "loot_goblin_rare"
  }
}
```

**Incorrect** (`EnemyData.json`) / **错误**（`EnemyData.json`）：

```json
{
  "Goblin": { "hp": 50 }
}
```

Violations: uppercase filename, uppercase key, no `[system]_[name]` pattern, missing required fields. / 违规项：大写文件名、大写键名、不符合 `[系统]_[名称]` 模式、缺少必填字段。
