---
name: cocos_rendering
description: Cocos Creator rendering pipeline expert. Triggers when users need to handle Renderer, Camera, Light, ForwardPipeline, rendering pipeline configuration, camera system, lighting system, shadows, post-processing. 当用户需要处理渲染管线、相机、光照、阴影、后处理等渲染相关功能时触发此 Skill。
---

# Rendering - Cocos Creator Rendering Pipeline / 渲染管线

## Overview / 概述

The Cocos Creator rendering module (`cocos/rendering`) provides rendering pipeline, camera system, and lighting system, responsible for submitting scene data to the GPU for drawing.

> **中文翻译**：Cocos Creator渲染模块(`cocos/rendering`)提供渲染管线、相机系统和光照系统，负责将场景数据提交给GPU进行绘制。

## Domain Knowledge / 领域知识

### Core Design Patterns / 核心设计模式
- **pipeline-pattern** — Configurable rendering pipeline executed pass by pass / 管线模式 — 可配置的渲染管线，逐Pass执行
- **render-pass** — Each rendering pass handles a specific rendering task / 渲染Pass — 每个渲染Pass处理特定的渲染任务

### Key Concepts / 关键概念
- `Renderer` — Renderer, drives the rendering process / 渲染器，驱动渲染过程
- `Camera` — Camera, defines viewpoint, projection, and render target / 相机，定义视点、投影和渲染目标
- `Light` — Light source (Directional, Point, Spot, Ambient) / 光源（方向光、点光源、聚光灯、环境光）
- `Pipeline` — Rendering pipeline (Forward, Deferred) / 渲染管线（前向、延迟）

## Key APIs / 关键API

### Classes / 类
- `Renderer` — Renderer management / 渲染器管理
- `Camera` — Camera component (view matrix, projection matrix, rendering layers) / 相机组件（视图矩阵、投影矩阵、渲染层）
- `Light` — Light base class / 光源基类
- `Pipeline` — Rendering pipeline / 渲染管线

### Functions / 函数
- `render()` — Execute one frame of rendering / 执行一帧渲染
- `present()` — Submit rendering results to screen / 将渲染结果提交到屏幕
- `resize()` — Respond to window size changes / 响应窗口尺寸变化

## Dependencies / 依赖
- Required modules: `gfx`, `core` / 必需模块：`gfx`、`core`

## Code Examples / 代码示例

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

## Usage Guide / 使用指南

### When to Use This Skill / 何时使用此技能
- Configuring rendering pipeline (Forward/Deferred) / 配置渲染管线（前向/延迟）
- Adjusting camera parameters and rendering layers / 调整相机参数和渲染层
- Setting up lighting and shadows / 设置光照和阴影
- Implementing post-processing effects / 实现后处理效果
- Optimizing rendering performance (Draw Call, Overdraw) / 优化渲染性能（Draw Call、Overdraw）

### Best Practices / 最佳实践
1. Prefer Forward pipeline on mobile; consider Deferred on PC / 移动端优先使用前向管线；PC端可考虑延迟管线
2. Use `visibility` to control camera rendering layers and reduce unnecessary drawing / 使用`visibility`控制相机渲染层，减少不必要的绘制
3. Only enable shadows for necessary objects; control shadow map resolution / 只为必要对象启用阴影；控制阴影贴图分辨率
4. Combine post-processing effects into fewer passes to reduce fullscreen draws / 将后处理效果合并到更少的Pass中以减少全屏绘制
5. Use RenderTexture for mini-maps, mirrors, and other special effects / 使用RenderTexture实现小地图、镜子等特效

### Common Tasks / 常见任务
- Configure rendering pipeline / 配置渲染管线
- Implement multi-camera rendering / 实现多相机渲染
- Set up lighting and shadows / 设置光照和阴影
- Create post-processing effects / 创建后处理效果
- Rendering performance optimization / 渲染性能优化
```