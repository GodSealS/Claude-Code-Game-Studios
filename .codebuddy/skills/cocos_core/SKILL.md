---
name: cocos_core
description: "Cocos Creator core engine expert. Triggers when users need to handle Component, Node, Director, Game, Scene, ECS architecture, scene graph, lifecycle management, event system, object pool. 当用户需要处理组件、节点、场景图、生命周期管理、事件系统、对象池等核心功能时触发此 Skill。"
user-invocable: false
allowed-tools: Read, Grep
argument-hint: ""
---

# Core - Cocos Creator Core Engine

> **READY**: Skill loaded — provides Cocos Creator core engine domain knowledge.

## Overview

The Cocos Creator core module (`cocos/core`) is the foundation of the entire engine, providing ECS component system, scene graph management, lifecycle control, event mechanisms, object pooling, and game state orchestration.

## Domain Knowledge

### Core Design Patterns
- **ecs-pattern** — Entity-Component-System architecture, Node as Entity, Component as behavior unit
- **object-pool** — Object pool pattern, reusing frequently created/destroyed objects
- **event-emitter** — Event emitter for decoupled inter-module communication
- **state-machine** — Finite state machine for managing game phases (menu, playing, paused)

### Key Concepts
- `Component` — Base class for all components, mounted on Nodes to provide behavior
- `Node` — Scene node, the basic unit of the scene tree
- `Director` — Game director, manages main loop and scene transitions
- `Game` — Game entry point, initializes engine and drives main loop
- `Scene` — Scene root node, hosts all game objects
- `EventTarget` — Event emitter base for pub/sub communication

## Key APIs

### Classes
- `Component` — Component base class (`onLoad`, `start`, `update`, `onDestroy`)
- `Node` — Scene node (`addChild`, `removeChild`, `getComponent`)
- `Director` — Game director (`loadScene`, `preloadScene`, `getScene`)
- `Game` — Game instance (`run`, `pause`, `resume`)
- `Scene` — Scene container
- `NodePool` — Object pool for Node reuse
- `EventTarget` — Event emitter for decoupled communication

### Functions
- `find(path)` — Find a node by path (returns Node | null)
- `isValid(obj)` — Check if an object is valid (not destroyed)
- `destroy(obj)` — Destroy an object and release resources
- `director.loadScene(name)` — Switch to named scene
- `director.preloadScene(name, onProgress, onLoaded)` — Async preload scene

## Dependencies
- No external dependencies; this is the foundation for all other modules

## Code Examples

### Component lifecycle
```typescript
import { _decorator, Component, Node, director, find } from 'cc';
const { ccclass, property } = _decorator;

@ccclass('PlayerController')
export class PlayerController extends Component {
    @property(Node)
    targetNode: Node | null = null;

    onLoad() {
        // Initialize when component loads — resources, references
        console.log('Component loaded');
    }

    start() {
        // Called before first frame update — other components ready
        console.log('Component started');
    }

    update(deltaTime: number) {
        // Per-frame update — keep lightweight
    }

    onDestroy() {
        // Cleanup: unregister events, release pools, null references
        console.log('Component destroyed');
    }
}

// Scene transition
director.loadScene('main-menu');
```

### Event communication system
```typescript
import { EventTarget } from 'cc';

// Typed event definitions
interface GameEvents {
    'score-changed': (newScore: number) => void;
    'player-died': (playerId: string) => void;
    'level-complete': () => void;
}

// Singleton event bus
class EventBus extends EventTarget {
    private static _instance: EventBus;

    static get instance(): EventBus {
        if (!this._instance) {
            this._instance = new EventBus();
        }
        return this._instance;
    }
}

// Publisher (e.g., score manager)
EventBus.instance.emit('score-changed', 100);

// Subscriber (e.g., UI controller)
const onScoreChanged = (score: number) => {
    console.log(`Score updated: ${score}`);
};
EventBus.instance.on('score-changed', onScoreChanged, this);

// Cleanup in onDestroy to prevent memory leaks
// onDestroy() {
//     EventBus.instance.off('score-changed', onScoreChanged, this);
// }

// Component-local events
class MyComponent extends Component {
    onLoad() {
        this.node.on('custom-event', this.onCustomEvent, this);
    }
    onDestroy() {
        this.node.off('custom-event', this.onCustomEvent, this);  // cleanup!
    }
    private onCustomEvent() { /* ... */ }
}
```

### Object pooling (NodePool)
```typescript
import { NodePool, Prefab, instantiate } from 'cc';

class BulletPool {
    private pool = new NodePool();
    private prefab: Prefab;
    private maxSize: number = 50;

    constructor(prefab: Prefab) {
        this.prefab = prefab;
        this.preheat(10);  // Pre-allocate for smooth start
    }

    // Pre-allocate pool entries
    private preheat(count: number): void {
        for (let i = 0; i < count; i++) {
            const node = instantiate(this.prefab);
            this.pool.put(node);
        }
    }

    // Get a node from pool (or create if empty)
    get(): Node {
        if (this.pool.size() > 0) {
            return this.pool.get();
        }
        return instantiate(this.prefab);
    }

    // Return node to pool for reuse
    put(node: Node): void {
        if (this.pool.size() >= this.maxSize) {
            node.destroy();  // Cap pool size, destroy excess
            return;
        }
        node.removeFromParent();  // Detach from scene
        this.pool.put(node);
    }

    // Clear entire pool (e.g., on scene change)
    clear(): void {
        this.pool.clear();
    }
}
```

### Scene graph navigation & async loading
```typescript
import { find, director, Node, Scene } from 'cc';

// 1. Find node by path — always check for null
const playerNode = find('Canvas/GameWorld/Player');
if (playerNode) {
    const controller = playerNode.getComponent(PlayerController);
    if (controller) {
        controller.Activate();
    }
}

// 2. Access current scene root
const currentScene = director.getScene();
if (currentScene) {
    const childNodes = currentScene.children;
}

// 3. Async scene preloading (load in background, then switch)
director.preloadScene(
    'battle-scene',
    (completed: number, total: number) => {
        // Progress callback: completed/total assets loaded
        console.log(`Loading: ${(completed / total * 100).toFixed(0)}%`);
    },
    (err: Error | null) => {
        if (err) {
            console.error('Scene preload failed:', err);
            return;
        }
        // Scene is loaded and cached — switch instantly
        director.loadScene('battle-scene');
    }
);
```

### Game state machine
```typescript
import { director, Game, game } from 'cc';

enum GameState {
    Menu,
    Playing,
    Paused,
    GameOver
}

class GameStateManager {
    private currentState: GameState = GameState.Menu;

    transition(newState: GameState): void {
        this.exitState(this.currentState);
        this.currentState = newState;
        this.enterState(newState);
    }

    private enterState(state: GameState): void {
        switch (state) {
            case GameState.Menu:
                director.loadScene('menu-scene');
                break;
            case GameState.Playing:
                director.loadScene('game-scene');
                game.resume();
                break;
            case GameState.Paused:
                game.pause();       // Pauses engine main loop
                // Show pause UI overlay
                break;
            case GameState.GameOver:
                game.pause();
                director.loadScene('gameover-scene');
                break;
        }
    }

    private exitState(state: GameState): void {
        switch (state) {
            case GameState.Paused:
                game.resume();      // Resume engine before leaving pause
                break;
            // ... other cleanup
        }
    }

    getCurrent(): GameState { return this.currentState; }
}
```

## Usage Guide

### When to Use This Skill
- Creating custom Components with lifecycle methods
- Managing scene node trees and parent-child relationships
- Handling engine lifecycle callbacks (onLoad, start, update, onDestroy)
- Implementing inter-module event communication
- Using object pools (NodePool) for performance optimization
- Managing game states (menu, playing, paused) via FSM + Game.pause/resume

### Best Practices
1. Keep component logic within `onLoad`/`start`/`update` lifecycle methods
2. Use `isValid()` to check node references, avoiding access to destroyed objects
3. Use object pools (`NodePool`) for frequently created/destroyed objects — preheat pools on scene load
4. Register event listeners in `onLoad`, unregister in `onDestroy` with matching `.off()` calls
5. Avoid heavy computation in `update`; use schedulers or async operations
6. Always null-check results from `find()` — it returns `Node | null`
7. Use `preloadScene` for large scenes to avoid frame drops during loading

### Common Tasks
- Create custom component classes with `@ccclass` / `@property`
- Manage node parent-child relationships (`addChild`, `removeChild`)
- Implement scene transition logic (`loadScene`, `preloadScene`)
- Use event system (`EventTarget`) for decoupled communication
- Implement object pool reuse via `NodePool` with capacity limits
- Build game state machines integrating `Game.pause`/`resume`

## Related Skills
- `cocos_animation` — Animation component lifecycle, event-driven animation callbacks
- `cocos_2d` — 2D component patterns (Sprite, Label extend Component)
- `cocos_3d` — 3D component patterns (MeshRenderer, SkinnedMeshRenderer)
- `cocos_ui` — UI component lifecycle, Button events, Widget layout

## Recommended Next Steps
1. Verify Cocos Creator version via `docs/engine-reference/cocos/VERSION.md`
2. For 2D game object components, load `cocos_2d` for Sprite/Label rendering
3. For UI-specific lifecycle patterns, load `cocos_ui` for Button, ScrollView, and event handling
4. For animation-driven lifecycle (e.g., state machine → animation), load `cocos_animation`
