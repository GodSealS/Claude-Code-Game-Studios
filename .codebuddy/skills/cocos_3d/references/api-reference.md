# 3D Module - API Reference

<!-- 模块信息 -->
## Module Info
- **Path**: `cocos/3d`
- **Language**: TypeScript
- **Files**: ~55 TS files

<!-- 导出 API -->
## Exported APIs

| Class | Description |
|-------|-------------|
| `MeshRenderer` | Mesh renderer, draws 3D models |
| `SkinnedMeshRenderer` | Skinned mesh renderer, skeletal animation |
| `Model` | Model asset |

<!-- 公共函数 -->
## Public Functions

| Function | Description |
|----------|-------------|
| `updateBound()` | Update model bounding box |
| `updateMaterial()` | Update rendering material |

<!-- 依赖 -->
## Dependencies
- `core` — Component base class, Node
- `rendering` — Rendering pipeline

<!-- 设计模式 -->
## Design Patterns

| Pattern | Use Case |
|---------|----------|
| component-based | MeshRenderer as a Component |
| mesh-rendering | Mesh submission pipeline |

<!-- 命名约定 -->
## Naming Conventions
- Classes: PascalCase (e.g., `MeshRenderer`)
- Functions: camelCase (e.g., `updateBound`)
- Constants: UPPER_CASE
