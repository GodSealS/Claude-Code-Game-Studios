---
name: cocos_3d
description: "Cocos Creator 3D rendering expert. Triggers when users need to handle MeshRenderer, SkinnedMeshRenderer, Model, 3D mesh rendering, skinned mesh, model loading and management. 当用户需要处理网格渲染、蒙皮网格、3D模型加载与管理等3D渲染相关功能时触发此 Skill。"
user-invocable: false
allowed-tools: Read, Grep
argument-hint: ""
---


# 3D - Cocos Creator 3D Rendering System

> **READY**: Skill loaded — provides Cocos Creator 3D rendering domain knowledge.

## Overview

The Cocos Creator 3D rendering module (`cocos/3d`) provides 3D mesh rendering, skinned mesh, model loading, material configuration, and model management functionality.

## Domain Knowledge

### Core Design Patterns
- **component-based** — 3D rendering components mounted on Nodes
- **mesh-rendering** — Mesh rendering pipeline (MeshRenderer + Material)
- **async-loading** — Model assets loaded asynchronously via `resources.load` or asset bundles
- **skeleton-driven** — Skinned meshes driven by skeleton bone hierarchies

### Key Concepts
- `MeshRenderer` — Mesh renderer, draws static/dynamic 3D models
- `SkinnedMeshRenderer` — Skinned mesh renderer, handles bone-driven deformation
- `Model` — Model asset, contains mesh and materials
- `Skeleton` — Skeleton asset, defines bone hierarchy for skinning

## Key APIs

### Classes
- `MeshRenderer` — Mesh renderer (Mesh, Materials, ShadowCastingMode)
- `SkinnedMeshRenderer` — Skinned mesh renderer (Skeleton, BlendShapes)
- `Model` — Model asset
- `SkeletonAnimationState` — Skeleton animation playback state

### Functions
- `updateBound()` — Update bounding box
- `updateMaterial()` — Update material
- `setMaterial(material, index)` — Set material at sub-mesh index

## Dependencies
- Required modules: `core`, `rendering`
- Related runtime: `cc.resources` (asset loading), `cc.assetManager` (bundle management)

## Code Examples

### Async model loading (glTF)
```typescript
import { _decorator, Component, MeshRenderer, resources, Mesh, Material } from 'cc';
const { ccclass, property } = _decorator;

@ccclass('ModelLoader')
export class ModelLoader extends Component {
    @property(Mesh)
    public fallbackMesh: Mesh | null = null;

    start() {
        this.loadModel('models/character');
    }

    loadModel(path: string) {
        resources.load(path, (err, prefab) => {
            if (err) {
                console.error(`Failed to load model at ${path}:`, err);
                // Fallback: use a default mesh if available
                if (this.fallbackMesh) {
                    const renderer = this.node.addComponent(MeshRenderer);
                    renderer.mesh = this.fallbackMesh;
                }
                return;
            }
            const modelNode = cc.instantiate(prefab);
            this.node.addChild(modelNode);

            const renderer = modelNode.getComponent(MeshRenderer);
            if (renderer) {
                renderer.updateBound();
            }
        });
    }
}
```

### Basic mesh renderer setup
```typescript
import { MeshRenderer, SkinnedMeshRenderer, Model } from 'cc';

// Add mesh renderer
const renderer = node.addComponent(MeshRenderer);
renderer.mesh = this.meshAsset;
renderer.setMaterial(this.material, 0);

// Shadow settings
renderer.shadowCastingMode = Model.ShadowCastingMode.ON;
```

### Skinned mesh with animation
```typescript
import { SkinnedMeshRenderer, SkeletalAnimation, Skeleton } from 'cc';

// Skinned mesh setup
const skinnedRenderer = node.addComponent(SkinnedMeshRenderer);
skinnedRenderer.mesh = this.skinnedMesh;
skinnedRenderer.skeleton = this.skeletonAsset;

// Skeletal animation playback
const skeletalAnim = node.addComponent(SkeletalAnimation);
skeletalAnim.play('Idle');  // Play idle animation

// Cross-fade between animation clips
skeletalAnim.crossFade('Walk', 0.3);  // Blend to Walk over 0.3 seconds

// Bone count recommendations:
// - < 30 bones: mobile-friendly, GPU skinning efficient
// - 30-60 bones: moderate, verify on low-end devices
// - > 60 bones: consider bone reduction or baked animation
```

### Material customization
```typescript
import { MeshRenderer, Material, Color } from 'cc';

// Get material instance (avoids modifying shared materials)
const renderer = node.getComponent(MeshRenderer);
const matInstance = renderer.getMaterialInstance(0);

if (matInstance) {
    // Custom material properties
    matInstance.setProperty('mainColor', new Color(255, 128, 64, 255));
    matInstance.setProperty('roughness', 0.3);
    matInstance.setProperty('metallic', 0.8);
}

// For advanced shader customization (toon shading, custom effects),
// see cocos_rendering Skill — it covers Effect assets, shader variants,
// and custom pipeline states.
```

### Update bounding box
```typescript
renderer.updateBound();
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
4. Use GPU skeletal animation for skinned animation (enabled by default); keep bone count ≤ 60 for mobile targets
5. Get material instances via `getMaterialInstance()` to avoid modifying shared materials
6. Monitor 3D draw calls, triangles, and GPU time via Cocos Creator's **built-in profiler** (F12 or `cc.profiler`) — check the "Renderer" and "Model" panels
7. Leverage frustum culling (automatic in Cocos Creator) and use **Render Layers** to exclude invisible objects from camera rendering
8. For custom shaders and advanced material effects, defer to `cocos_rendering` Skill

### Common Tasks
- Load and display 3D models
- Configure materials and textures
- Implement skinned animation with cross-fade blending
- Mesh merging and LOD
- 3D rendering performance optimization

## Model Import Pipeline

### Export settings (Blender → Cocos Creator)
1. **Format**: Prefer **glTF 2.0** (`.gltf`/`.glb`) for best compatibility; FBX also supported
2. **Mesh**: Apply modifiers, triangulate faces before export
3. **Skeleton**: Ensure armature follows standard bone naming; check bone count ≤ 60 for mobile
4. **Materials**: Use Principled BSDF → gets mapped to Cocos standard PBR material
5. **Scale**: Confirm export scale matches Cocos Creator units (1 unit = 1 meter recommended)

### Texture compression by platform
| Platform | Diffuse/Normal | Metallic/Roughness |
|----------|---------------|-------------------|
| **Web/Mac/Windows** | PNG, JPG | PNG, JPG |
| **iOS** | ASTC 6×6 or 8×8 | ASTC 8×8 |
| **Android** | ETC2 / ASTC | ETC2 / ASTC |
| **Mini-game** | JPG (small size) | JPG |

### Post-import validation
- Check mesh triangle count in Cocos Creator Inspector
- Verify material slots were correctly assigned
- Test skeleton with a simple idle animation first
- Check for flipped normals or UV issues in scene view

## Related Skills
- `cocos_core` — Component, Node, Scene, lifecycle management
- `cocos_rendering` — Effect shaders, materials, custom render passes, GFX layer
- `cocos_animation` — AnimationClip, AnimationState, skeletal animation, state machines
- `cocos_2d` — Sprite, Label, UI components, 2D rendering patterns

## Recommended Next Steps
1. Verify the Cocos Creator version via `docs/engine-reference/cocos/VERSION.md`
2. For custom shaders and material effects, load `cocos_rendering` for Effect asset authoring
3. For complex character animation, load `cocos_animation` for AnimationState, state machines, and cross-fade blending
4. For UI overlays in 3D scenes, load `cocos_2d` and `cocos_ui` for Canvas and HUD patterns
