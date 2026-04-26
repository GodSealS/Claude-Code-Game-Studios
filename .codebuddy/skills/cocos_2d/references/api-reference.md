# 2D Module - API Reference

<!-- 模块信息 -->
## Module Info
- **Path**: `cocos/2d`
- **Language**: TypeScript
- **Files**: ~86 TS files

<!-- 导出 API -->
## Exported APIs

| Class | Description |
|-------|-------------|
| `Sprite` | Sprite component, displays images |
| `Label` | Text component, renders text |
| `Mask` | Mask component, clips rendering area |
| `Graphics` | 2D graphics drawing component |
| `UIComponent` | UI component base class |

<!-- 公共函数 -->
## Public Functions

| Function | Description |
|----------|-------------|
| `updateVertexData()` | Update rendering vertex data |
| `updateMaterial()` | Update rendering material |

<!-- 依赖 -->
## Dependencies
- `core` — Component base class, Node
- `rendering` — Rendering pipeline

<!-- 设计模式 -->
## Design Patterns

| Pattern | Use Case |
|---------|----------|
| component-based | Sprite/Label/Mask as Components |
| ui-system | Canvas + Widget layout system |

<!-- 命名约定 -->
## Naming Conventions
- Classes: PascalCase (e.g., `Sprite`)
- Functions: camelCase (e.g., `updateVertexData`)
- Constants: UPPER_CASE
