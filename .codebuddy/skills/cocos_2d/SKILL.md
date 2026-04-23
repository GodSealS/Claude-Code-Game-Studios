---
name: cocos_2d
description: Cocos Creator 2D rendering expert. Triggers when users need to handle Sprite, Label, Mask, Graphics, UI components, 2D sprite rendering, text rendering, mask effects, 2D graphics drawing. 当用户需要处理精灵、文本、遮罩、2D图形绘制、UI组件等2D渲染相关功能时触发此 Skill。
---

# 2D - Cocos Creator 2D Rendering System

## Overview

The Cocos Creator 2D rendering module (`cocos/2d`) provides sprite, text, mask, and 2D graphics drawing for UI rendering.

## Domain Knowledge

### Core Design Patterns
- **component-based** — 2D rendering components mounted on Nodes
- **ui-system** — UI system based on Canvas and Widget layout

### Key Concepts
- `Sprite` — Sprite component, displays image assets
- `Label` — Text component, renders text content
- `Mask` — Mask component, clips child node rendering areas
- `Graphics` — 2D graphics component, draws vector graphics
- `UIComponent` — UI component base class

## Key APIs

### Classes
- `Sprite` — Sprite (SpriteFrame, Type, SizeMode)
- `Label` — Text (String, Font, FontSize, Overflow)
- `Mask` — Mask (Type, SpriteFrame)
- `Graphics` — 2D graphics drawing (moveTo, lineTo, fillRect, circle)
- `UIComponent` — UI component base class

### Functions
- `updateVertexData()` — Update vertex data
- `updateMaterial()` — Update material

## Dependencies
- Required modules: `core`, `rendering`

## Code Examples

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

## Usage Guide

### When to Use This Skill
- Creating UI interfaces (buttons, panels, lists)
- Implementing sprite animations (SpriteSheet, atlas)
- Handling text display and localization
- Drawing 2D vector graphics
- Configuring masks and clipping effects

### Best Practices
1. Use SpriteAtlas for sprites to reduce Draw Calls
2. Use BMFont or TTF caching for Labels to avoid frequent text texture rebuilding
3. Be aware of vertex count limits when drawing complex shapes with Graphics
4. Prefer RECT mask type; STENCIL type is more expensive
5. Use Widget component on UI nodes for multi-resolution adaptation

### Common Tasks
- Create sprites and atlas animations
- Implement rich text and text effects
- Draw custom shapes with Graphics
- Configure UI masks and clipping
- UI adaptation and multi-resolution support
