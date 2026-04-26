# 2D Module - API Reference

## Module Info
- **Path**: `cocos/2d`
- **Language**: TypeScript
- **Files**: ~86 TS files

## Exported APIs

| Class | Description |
|-------|-------------|
| `Sprite` | Sprite component, displays images |
| `Label` | Text component, renders text |
| `Mask` | Mask component, clips rendering area |
| `Graphics` | 2D graphics drawing component |
| `UIComponent` | UI component base class |

## Public Functions

| Function | Description |
|----------|-------------|
| `updateVertexData()` | Update rendering vertex data |
| `updateMaterial()` | Update rendering material |

## Dependencies
- `core` — Component base class, Node
- `rendering` — Rendering pipeline

## Design Patterns

| Pattern | Use Case |
|---------|----------|
| component-based | Sprite/Label/Mask as Components |
| ui-system | Canvas + Widget layout system |

## Naming Conventions
- Classes: PascalCase (e.g., `Sprite`)
- Functions: camelCase (e.g., `updateVertexData`)
- Constants: UPPER_CASE
