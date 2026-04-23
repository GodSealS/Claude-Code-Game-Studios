# 3D Module - API Reference

## Module Info
- **Path**: `cocos/3d`
- **Language**: TypeScript
- **Files**: ~55 TS files

## Exported APIs

| Class | Description |
|-------|-------------|
| `MeshRenderer` | Mesh renderer, draws 3D models |
| `SkinnedMeshRenderer` | Skinned mesh renderer, skeletal animation |
| `Model` | Model asset |

## Public Functions

| Function | Description |
|----------|-------------|
| `updateBound()` | Update model bounding box |
| `updateMaterial()` | Update rendering material |

## Dependencies
- `core` — Component base class, Node
- `rendering` — Rendering pipeline

## Design Patterns

| Pattern | Use Case |
|---------|----------|
| component-based | MeshRenderer as a Component |
| mesh-rendering | Mesh submission pipeline |

## Naming Conventions
- Classes: PascalCase (e.g., `MeshRenderer`)
- Functions: camelCase (e.g., `updateBound`)
- Constants: UPPER_CASE
