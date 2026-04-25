# Cocos Creator — Input Module

Last verified: 2026-04-25

## Core Types

| Type | Purpose |
|------|---------|
| `input` | Global input singleton (`Input` class instance) |
| `EventTouch` | Touch/mouse event data |
| `EventKeyboard` | Keyboard event data |
| `EventMouse` | Mouse-specific event data |
| `EventAcceleration` | Device accelerometer |

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

## Multi-Touch

```typescript
input.on(Input.EventType.TOUCH_START, (event: EventTouch) => {
    const touchId = event.getID(); // Unique per finger
    const location = event.getLocation();
}, this);
```

## Pitfalls

- WRONG: Using `event.getLocation()` for UI hit testing
- RIGHT: Use `event.getUILocation()` for Canvas-aligned coordinates
- WRONG: Forgetting `off()` in `onDestroy()`
- RIGHT: Always pair `on()` with `off()`
