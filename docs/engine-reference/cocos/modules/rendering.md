# Cocos Creator — Rendering Module

Last verified: 2026-04-25

## Core Types

| Type | Purpose |
|------|---------|
| `Camera` | Scene capture and projection |
| `MeshRenderer` | 3D mesh rendering component |
| `ModelComponent` | Legacy name; now `MeshRenderer` |
| `ForwardPipeline` | Default forward rendering pipeline |
| `DeferredPipeline` | Deferred rendering (3.8+, desktop) |
| `Custom Render Pipeline` | Visual node-based pipeline editor |

## Camera Setup

```typescript
import { Camera, Vec3 } from 'cc';

const camera = this.getComponent(Camera);
camera.projection = Camera.ProjectionType.PERSPECTIVE;
camera.fov = 60;
camera.near = 0.1;
camera.far = 1000;

// Screen to world ray
const ray = camera.screenPointToRay(screenX, screenY);
```

## Rendering Pipeline (3.8+)

```typescript
// Access pipeline settings
const pipeline = director.root.pipeline;

// Bloom, FXAA, color grading via CRP asset in editor
// Code access limited; prefer editor configuration
```

## Post-Processing (CRP)

Enable in Project Settings → Rendering → Render Pipeline:
- **Bloom**: Glow effect for bright areas
- **FXAA**: Fast anti-aliasing
- **Color Grading**: LUT-based color correction
- **Vignette**: Edge darkening

## Draw Call Optimization

| Technique | When to Use |
|-----------|-------------|
| Static Batching | Non-moving meshes sharing material |
| GPU Instancing | Many identical meshes (grass, particles) |
| LOD Groups | 3D models at varying distances |
| Occlusion Culling | Complex indoor scenes |

## Pitfalls

- WRONG: Creating materials at runtime frequently
- RIGHT: Pre-create and pool materials; modify properties instead
- WRONG: Using real-time lights for everything
- RIGHT: Bake static lighting; use real-time only for dynamic objects
