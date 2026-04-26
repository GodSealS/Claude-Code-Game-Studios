# Cocos Creator — UI Module / Cocos CreatorUI模块


> **中文翻译**：本文档为Cocos Creator引擎参考文档。所有代码示例和技术术语保持英文原文。

Last verified: 2026-04-25

<!-- 核心类型 -->
## Core Types

| Type | Purpose |
|------|---------|
| `Canvas` | Root UI container; required for all UI |
| `UITransform` | Position, size, anchor of UI elements |
| `Widget` | Layout alignment (left, right, top, bottom, center) |
| `Sprite` | 2D image rendering |
| `Label` | Text rendering (system font or BitmapFont) |
| `Button` | Clickable button component |
| `Layout` | Auto-arrangement of children (horizontal, vertical, grid) |
| `ScrollView` | Scrollable content area |
| `EditBox` | Text input field |
| `ProgressBar` | Fill-based progress indicator |
| `RichText` | Styled text with tags |
| `PageView` | Swipeable page container |

<!-- 中文翻译 -->
## Canvas Setup

```typescript
// Canvas required on root UI node
// RenderMode: SCREEN_SPACE (overlay) or WORLD_SPACE (in-scene)
```

<!-- 中文翻译 -->
## Responsive Layout with Widget

```typescript
// CORRECT — anchor to screen edges for responsive UI
const widget = this.node.getComponent(Widget);
widget.isAlignLeft = true;
widget.isAlignRight = true;
widget.isAlignTop = true;
widget.isAlignBottom = true;
widget.left = 20;
widget.right = 20;
widget.top = 20;
widget.bottom = 20;
widget.updateAlignment(); // Apply
```

<!-- 中文翻译 -->
## Button with Callback

```typescript
import { Button } from 'cc';

const btn = this.node.getComponent(Button);
btn.node.on(Button.EventType.CLICK, this.onBtnClick, this);

onBtnClick() {
    // Handle click
}
```

<!-- 中文翻译 -->
## Multi-Resolution Adaptation

```typescript
// In Canvas component
const canvas = this.node.getComponent(Canvas);
canvas.designResolution = new Size(1280, 720);
canvas.fitHeight = true;  // or fitWidth
```

<!-- 陷阱 -->
## Pitfalls

- WRONG: Putting UI elements without Canvas parent
- RIGHT: All UI nodes must be under a Canvas
- WRONG: Using world-space coordinates for UI positioning
- RIGHT: Use `UITransform` and `Widget` for UI layout
- WRONG: Updating `Label.string` every frame with dynamic values
- RIGHT: Only update when value changes; cache string values
