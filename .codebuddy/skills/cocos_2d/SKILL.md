---
name: cocos_2d
description: Cocos Creator 2D rendering expert. Triggers when users need to handle Sprite, Label, Mask, Graphics, UI components, 2D sprite rendering, text rendering, mask effects, 2D graphics drawing. 当用户需要处理精灵、文本、遮罩、2D图形绘制、UI组件等2D渲染相关功能时触发此 Skill。
---

# 2D - Cocos Creator 2D Rendering System / 2D渲染系统

## Overview / 概述

The Cocos Creator 2D rendering module (`cocos/2d`) provides sprite, text, mask, and 2D graphics drawing for UI rendering.

> **中文翻译**：Cocos Creator 2D渲染模块(`cocos/2d`)为UI渲染提供精灵、文本、遮罩和2D图形绘制功能。

## Domain Knowledge / 领域知识

### Core Design Patterns / 核心设计模式
- **component-based** — 2D rendering components mounted on Nodes / 基于组件 — 2D渲染组件挂载在节点上
- **ui-system** — UI system based on Canvas and Widget layout / UI系统 — 基于Canvas和Widget布局的UI系统

### Key Concepts / 关键概念
- `Sprite` — Sprite component, displays image assets / 精灵组件，显示图片资源
- `Label` — Text component, renders text content / 文本组件，渲染文本内容
- `Mask` — Mask component, clips child node rendering areas / 遮罩组件，裁剪子节点渲染区域
- `Graphics` — 2D graphics component, draws vector graphics / 2D图形组件，绘制矢量图形
- `UIComponent` — UI component base class / UI组件基类

## Key APIs / 关键API

### Classes / 类
- `Sprite` — Sprite (SpriteFrame, Type, SizeMode) / 精灵（精灵帧、类型、尺寸模式）
- `Label` — Text (String, Font, FontSize, Overflow) / 文本（字符串、字体、字号、溢出模式）
- `Mask` — Mask (Type, SpriteFrame) / 遮罩（类型、精灵帧）
- `Graphics` — 2D graphics drawing (moveTo, lineTo, fillRect, circle) / 2D图形绘制（移动到、画线到、填充矩形、圆形）
- `UIComponent` — UI component base class / UI组件基类

### Functions / 函数
- `updateVertexData()` — Update vertex data / 更新顶点数据
- `updateMaterial()` — Update material / 更新材质

## Dependencies / 依赖
- Required modules: `core`, `rendering` / 必需模块：`core`、`rendering`

## Code Examples / 代码示例

```typescript
import { Sprite, Label, Mask, Graphics, UIOpacity } from 'cc';

// Sprite
const sprite = node.addComponent(Sprite);
sprite.spriteFrame = this.spriteFrame;
sprite.type = Sprite.Type.SIMPLE;

// Label
const label = node.addComponent(Label);
label.string = 'Hello Cocos';
label.fontSize = 24;
label.overflow = Label.Overflow.CLAMP;

// Mask
const mask = node.addComponent(Mask);
mask.type = Mask.Type.RECT;

// 2D graphics drawing
const g = node.addComponent(Graphics);
g.fillColor = new Color(255, 0, 0, 255);
g.circle(0, 0, 50);
g.fill();
```

## Usage Guide / 使用指南

### When to Use This Skill / 何时使用此技能
- Creating UI interfaces (buttons, panels, lists) / 创建UI界面（按钮、面板、列表）
- Implementing sprite animations (SpriteSheet, atlas) / 实现精灵动画（精灵表、图集）
- Handling text display and localization / 处理文本显示和本地化
- Drawing 2D vector graphics / 绘制2D矢量图形
- Configuring masks and clipping effects / 配置遮罩和裁剪效果

### Best Practices / 最佳实践
1. Use SpriteAtlas for sprites to reduce Draw Calls / 使用SpriteAtlas减少Draw Call
2. Use BMFont or TTF caching for Labels to avoid frequent text texture rebuilding / 使用BMFont或TTF缓存避免频繁重建文本纹理
3. Be aware of vertex count limits when drawing complex shapes with Graphics / 使用Graphics绘制复杂形状时注意顶点数限制
4. Prefer RECT mask type; STENCIL type is more expensive / 优先使用RECT遮罩类型，STENCIL类型开销更大
5. Use Widget component on UI nodes for multi-resolution adaptation / 在UI节点上使用Widget组件进行多分辨率适配

### Common Tasks / 常见任务
- Create sprites and atlas animations / 创建精灵和图集动画
- Implement rich text and text effects / 实现富文本和文本特效
- Draw custom shapes with Graphics / 使用Graphics绘制自定义形状
- Configure UI masks and clipping / 配置UI遮罩和裁剪
- UI adaptation and multi-resolution support / UI适配和多分辨率支持