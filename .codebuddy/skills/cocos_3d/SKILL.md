---
name: cocos_3d
description: Cocos Creator 3D rendering expert. Triggers when users need to handle MeshRenderer, SkinnedMeshRenderer, Model, 3D mesh rendering, skinned mesh, model loading and management. 当用户需要处理网格渲染、蒙皮网格、3D模型加载与管理等3D渲染相关功能时触发此 Skill。
---

# 3D - Cocos Creator 3D Rendering System / 3D渲染系统

## Overview / 概述

The Cocos Creator 3D rendering module (`cocos/3d`) provides 3D mesh rendering, skinned mesh, and model management functionality.

> **中文翻译**：Cocos Creator 3D渲染模块(`cocos/3d`)提供3D网格渲染、蒙皮网格和模型管理功能。

## Domain Knowledge / 领域知识

### Core Design Patterns / 核心设计模式
- **component-based** — 3D rendering components mounted on Nodes / 基于组件 — 3D渲染组件挂载在节点上
- **mesh-rendering** — Mesh rendering pipeline / 网格渲染管线

### Key Concepts / 关键概念
- `MeshRenderer` — Mesh renderer, draws static/dynamic 3D models / 网格渲染器，绘制静态/动态3D模型
- `SkinnedMeshRenderer` — Skinned mesh renderer, handles bone-driven deformation / 蒙皮网格渲染器，处理骨骼驱动变形
- `Model` — Model asset, contains mesh and materials / 模型资产，包含网格和材质

## Key APIs / 关键API

### Classes / 类
- `MeshRenderer` — Mesh renderer (Mesh, Materials, ShadowCastingMode) / 网格渲染器（网格、材质、阴影投射模式）
- `SkinnedMeshRenderer` — Skinned mesh renderer (Skeleton, BlendShapes) / 蒙皮网格渲染器（骨骼、混合形状）
- `Model` — Model asset / 模型资产

### Functions / 函数
- `updateBound()` — Update bounding box / 更新包围盒
- `updateMaterial()` — Update material / 更新材质

## Dependencies / 依赖
- Required modules: `core`, `rendering` / 必需模块：`core`、`rendering`

## Code Examples / 代码示例

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

## Usage Guide / 使用指南

### When to Use This Skill / 何时使用此技能
- Loading and rendering 3D models (glTF, FBX) / 加载和渲染3D模型（glTF、FBX）
- Configuring skinned mesh animation / 配置蒙皮网格动画
- Setting model materials and textures / 设置模型材质和纹理
- Optimizing 3D rendering performance / 优化3D渲染性能
- Handling LOD and occlusion culling / 处理LOD和遮挡剔除

### Best Practices / 最佳实践
1. Use `MeshRenderer` for static models, `SkinnedMeshRenderer` for skeletal animation models / 静态模型使用`MeshRenderer`，骨骼动画模型使用`SkinnedMeshRenderer`
2. Merge meshes with the same material (Mesh Combining) to reduce Draw Calls / 合并相同材质的网格以减少Draw Call
3. Use LOD (Level of Detail) to switch model detail based on distance / 使用LOD根据距离切换模型细节
4. Use GPU skeletal animation for skinned animation (enabled by default) / 使用GPU骨骼动画（默认启用）
5. Get material instances via `getMaterialInstance()` to avoid modifying shared materials / 通过`getMaterialInstance()`获取材质实例，避免修改共享材质

### Common Tasks / 常见任务
- Load and display 3D models / 加载和显示3D模型
- Configure materials and textures / 配置材质和纹理
- Implement skinned animation / 实现蒙皮动画
- Mesh merging and LOD / 网格合并和LOD
- 3D rendering performance optimization / 3D渲染性能优化