# Scene Building Workflow

## Typical Game Scene Structure

```
SceneRoot
├── DirectionalLight (main directional light) / PointLight
├── MainCamera (cc.Camera)
│   ├── Component: cc.Camera
│   └── Settings: projection, fov, clearFlags, visibility
├── Environment
│   ├── Terrain
│   ├── Skybox
│   └── StaticProps
├── Gameplay
│   ├── Player (player prefab instance)
│   ├── Enemies (enemy container)
│   │   └── Enemy × N (enemy prefab instances)
│   ├── Projectiles (projectile container)
│   ├── Pickups (pickup container)
│   └── Triggers (trigger zones)
├── UI (cc.Canvas)
│   ├── HUD
│   ├── Menus
│   └── Popups
└── Managers (manager singleton nodes)
    ├── GameManager
    ├── AudioManager
    └── PoolManager
```

## Scene Operations

```json
// Create new scene
{ "tool": "scene_management", "arguments": { "action": "new", "name": "Level_01" } }

// Open existing scene
{ "tool": "scene_management", "arguments": { "action": "open", "path": "assets/scene/Level_01.scene" } }

// List all scenes
{ "tool": "scene_management", "arguments": { "action": "list" } }

// Save scene
{ "tool": "scene_management", "arguments": { "action": "save" } }

// Get scene hierarchy (with component info for analysis)
{ "tool": "scene_hierarchy", "arguments": { "action": "get", "includeComponents": true } }
```
