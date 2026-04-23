---
name: cocos_rendering
description: Cocos Creator rendering pipeline expert. Triggers when users need to handle Renderer, Camera, Light, ForwardPipeline, rendering pipeline configuration, camera system, lighting system, shadows, post-processing. 当用户需要处理渲染管线、相机、光照、阴影、后处理等渲染相关功能时触发此 Skill。
---

# Rendering - Cocos Creator Rendering Pipeline

## Overview

The Cocos Creator rendering module (`cocos/rendering`) provides rendering pipeline, camera system, and lighting system, responsible for submitting scene data to the GPU for drawing.

## Domain Knowledge

### Core Design Patterns
- **pipeline-pattern** — Configurable rendering pipeline executed pass by pass
- **render-pass** — Each rendering pass handles a specific rendering task

### Key Concepts
- `Renderer` — Renderer, drives the rendering process
- `Camera` — Camera, defines viewpoint, projection, and render target
- `Light` — Light source (Directional, Point, Spot, Ambient)
- `Pipeline` — Rendering pipeline (Forward, Deferred)

## Key APIs

### Classes
- `Renderer` — Renderer management
- `Camera` — Camera component (view matrix, projection matrix, rendering layers)
- `Light` — Light base class
- `Pipeline` — Rendering pipeline

### Functions
- `render()` — Execute one frame of rendering
- `present()` — Submit rendering results to screen
- `resize()` — Respond to window size changes

## Dependencies
- Required modules: `gfx`, `core`

## Code Examples

```typescript
import { Camera, DirectionalLight, Shadows } from 'cc';

// Configure camera
const camera = node.getComponent(Camera);
camera.fov = 60;
camera.near = 0.1;
camera.far = 1000;
camera.clearFlags = Camera.ClearFlag.SOLID_COLOR;

// Add directional light
const lightNode = new Node('DirectionalLight');
const light = lightNode.addComponent(DirectionalLight);
light.intensity = 1.0;
light.color = Color.WHITE;
light.shadowEnabled = true;

// Rendering layer control
camera.visibility = Layers.Enum.DEFAULT;
```

## Usage Guide

### When to Use This Skill
- Configuring rendering pipeline (Forward/Deferred)
- Adjusting camera parameters and rendering layers
- Setting up lighting and shadows
- Implementing post-processing effects
- Optimizing rendering performance (Draw Call, Overdraw)

### Best Practices
1. Prefer Forward pipeline on mobile; consider Deferred on PC
2. Use `visibility` to control camera rendering layers and reduce unnecessary drawing
3. Only enable shadows for necessary objects; control shadow map resolution
4. Combine post-processing effects into fewer passes to reduce fullscreen draws
5. Use RenderTexture for mini-maps, mirrors, and other special effects

### Common Tasks
- Configure rendering pipeline
- Implement multi-camera rendering
- Set up lighting and shadows
- Create post-processing effects
- Rendering performance optimization
