---
name: cocos_core
description: Cocos Creator core engine expert. Triggers when users need to handle Component, Node, Director, Game, Scene, ECS architecture, scene graph, lifecycle management, event system, object pool. 当用户需要处理组件、节点、场景图、生命周期管理、事件系统、对象池等核心功能时触发此 Skill。
---

# Core - Cocos Creator Core Engine

## Overview

The Cocos Creator core module (`cocos/core`) is the foundation of the entire engine, providing ECS component system, scene graph management, lifecycle control, and event mechanisms.

## Domain Knowledge

### Core Design Patterns
- **ecs-pattern** — Entity-Component-System architecture, Node as Entity, Component as behavior unit
- **object-pool** — Object pool pattern, reusing frequently created/destroyed objects
- **event-emitter** — Event emitter for decoupled inter-module communication

### Key Concepts
- `Component` — Base class for all components, mounted on Nodes to provide behavior
- `Node` — Scene node, the basic unit of the scene tree
- `Director` — Game director, manages main loop and scene transitions
- `Game` — Game entry point, initializes engine and drives main loop
- `Scene` — Scene root node, hosts all game objects

## Key APIs

### Classes
- `Component` — Component base class (`onLoad`, `start`, `update`, `onDestroy`)
- `Node` — Scene node (`addChild`, `removeChild`, `getComponent`)
- `Director` — Game director (`loadScene`, `preloadScene`)
- `Game` — Game instance (`run`, `pause`, `resume`)
- `Scene` — Scene container

### Functions
- `find()` — Find a node by path
- `isValid()` — Check if an object is valid (not destroyed)
- `destroy()` — Destroy an object and release resources

## Dependencies
- No external dependencies; this is the foundation for all other modules

## Code Examples

```typescript
import { _decorator, Component, Node, director, find } from 'cc';
const { ccclass, property } = _decorator;

@ccclass('PlayerController')
export class PlayerController extends Component {
    @property(Node)
    targetNode: Node = null;

    onLoad() {
        // Initialize when component loads
    }

    start() {
        // Called before first frame update
    }

    update(deltaTime: number) {
        // Per-frame update
    }

    onDestroy() {
        // Cleanup when component is destroyed
    }
}

// Scene transition
director.loadScene('main-menu');

// Find node by path
const node = find('Canvas/Player');
```

## Usage Guide

### When to Use This Skill
- Creating custom Components
- Managing scene node trees
- Handling engine lifecycle callbacks
- Implementing inter-module event communication
- Using object pools for performance optimization

### Best Practices
1. Keep component logic within `onLoad`/`start`/`update` lifecycle methods
2. Use `isValid()` to check node references, avoiding access to destroyed objects
3. Use object pools (`NodePool`) for frequently created/destroyed objects
4. Register event listeners in `onLoad`, unregister in `onDestroy`
5. Avoid heavy computation in `update`; use schedulers or async operations

### Common Tasks
- Create custom component classes
- Manage node parent-child relationships
- Implement scene transition logic
- Use event system for communication
- Implement object pool reuse
