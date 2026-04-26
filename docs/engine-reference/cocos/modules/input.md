# Cocos Creator — Input Module / Cocos Creator输入模块


> **中文翻译**：本文档为Cocos Creator引擎参考文档。所有代码示例和技术术语保持英文原文。

Last verified: 2026-04-25

<!-- 核心类型 -->
## Core Types

| Type | Purpose |
|------|---------|
| `input` | Global input singleton (`Input` class instance) |
| `EventTouch` | Touch/mouse event data |
| `EventKeyboard` | Keyboard event data |
| `EventMouse` | Mouse-specific event data |
| `EventAcceleration` | Device accelerometer |

<!-- 常见操作 -->
## Common Operations

```typescript
import { input, Input, EventTouch, EventKeyboard, KeyCode } from 'cc';

onLoad() {
    // Touch / Mouse
    input.on(Input.EventType.TOUCH_START, this.onTouchStart, this);
    input.on(Input.EventType.TOUCH_MOVE, this.onTouchMove, this);
    input.on(Input.EventType.TOUCH_END, this.onTouchEnd, this);

    // Keyboard
    input.on(Input.EventType.KEY_DOWN, this.onKeyDown, this);
    input.on(Input.EventType.KEY_UP, this.onKeyUp, this);
}

onDestroy() {
    // ALWAYS unregister to prevent memory leaks
    input.off(Input.EventType.TOUCH_START, this.onTouchStart, this);
    input.off(Input.EventType.KEY_DOWN, this.onKeyDown, this);
}

onTouchStart(event: EventTouch) {
    const location = event.getLocation(); // Vec2 in screen coords
    const uiLocation = event.getUILocation(); // Vec2 in UI coords
}

onKeyDown(event: EventKeyboard) {
    if (event.keyCode === KeyCode.SPACE) {
        // Jump
    }
}
```

<!-- 中文翻译 -->
## Multi-Touch

```typescript
input.on(Input.EventType.TOUCH_START, (event: EventTouch) => {
    const touchId = event.getID(); // Unique per finger
    const location = event.getLocation();
}, this);
```

<!-- 陷阱 -->
## Pitfalls

- WRONG: Using `event.getLocation()` for UI hit testing
- RIGHT: Use `event.getUILocation()` for Canvas-aligned coordinates
- WRONG: Forgetting `off()` in `onDestroy()`
- RIGHT: Always pair `on()` with `off()`
