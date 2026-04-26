---
name: cocos_3d
description: Cocos Creator 3D rendering expert. Triggers when users need to handle MeshRenderer, SkinnedMeshRenderer, Model, 3D mesh rendering, skinned mesh, model loading and management. 当用户需要处理网格渲染、蒙皮网格、3D模型加载与管理等3D渲染相关功能时触发此 Skill。
---

# 3D - Cocos Creator 3D Rendering System

## Overview

The Cocos Creator 3D rendering module (`cocos/3d`) provides 3D mesh rendering, skinned mesh, and model management functionality.

## Domain Knowledge

### Core Design Patterns
- **component-based** — 3D rendering components mounted on Nodes
- **mesh-rendering** — Mesh rendering pipeline

### Key Concepts
- `MeshRenderer` — Mesh renderer, draws static/dynamic 3D models
- `SkinnedMeshRenderer` — Skinned mesh renderer, handles bone-driven deformation
- `Model` — Model asset, contains mesh and materials

## Key APIs

### Classes
- `MeshRenderer` — Mesh renderer (Mesh, Materials, ShadowCastingMode)
- `SkinnedMeshRenderer` — Skinned mesh renderer (Skeleton, BlendShapes)
- `Model` — Model asset

### Functions
- `updateBound()` — Update bounding box
- `updateMaterial()` — Update material

## Dependencies
- Required modules: `core`, `rendering`

## Code Examples

```typescript
import { MeshRenderer, SkinnedMeshRenderer, Model } from 'cc';

// Add mesh renderer
const renderer = node.addComponent(MeshRenderer);
renderer.mesh = this.meshAsset;
renderer.setMaterial(this.material, 0);

// Skinned mesh
const skinnedRenderer = node.addComponent(SkinnedMeshRenderer);
skinnedRenderer.mesh = this.skinnedMesh;
skinnedRenderer.skeleton = this.skeletonAsset;

// Update bounding box
renderer.updateBound();

// Shadow settings
renderer.shadowCastingMode = Model.ShadowCastingMode.ON;
```

## Usage Guide

### When to Use This Skill
- Loading and rendering 3D models (glTF, FBX)
- Configuring skinned mesh animation
- Setting model materials and textures
- Optimizing 3D rendering performance
- Handling LOD and occlusion culling

### Best Practices
1. Use `MeshRenderer` for static models, `SkinnedMeshRenderer` for skeletal animation models
2. Merge meshes with the same material (Mesh Combining) to reduce Draw Calls
3. Use LOD (Level of Detail) to switch model detail based on distance
4. Use GPU skeletal animation for skinned animation (enabled by default)
5. Get material instances via `getMaterialInstance()` to avoid modifying shared materials

### Common Tasks
- Load and display 3D models
- Configure materials and textures
- Implement skinned animation
- Mesh merging and LOD
- 3D rendering performance optimization
