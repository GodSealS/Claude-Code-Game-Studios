---
name: cocos_editor
description: "Cocos Creator Editor Full-Feature Skill. Operate the Cocos Creator editor through the Cocos MCP Server
  for scene management, node operations, component management, prefab creation, asset management,
  UI layout, VFX creation, character creation, project building, and more.
  Trigger this Skill whenever the user needs to perform any visual operation in the Cocos Creator editor.
  Trigger scenarios include: creating UI interfaces, building scenes, creating VFX, creating prefabs,
  managing assets, configuring components, adjusting node hierarchies, building projects, debugging editor state, etc."
argument-hint: "[action description] --scene [scene name] --node [node name]"
user-invocable: false
allowed-tools: Read, Write, Edit, Bash, Glob, Grep, WebFetch, Task, mcp_get_tool_description, mcp_call_tool
---

# Cocos Editor MCP — Master Editor Operations Skill

## Overview

This Skill is the **single entry point** for all Cocos Creator editor operations via Cocos MCP Server.
It covers general-purpose editor operations (scenes, nodes, components, assets, build, debug). For
specialized workflows, see the **Workflow Routing** section below.

**Core Principle**: All visual operations on the Cocos Creator editor go through this Skill — never
simulate editor behavior at the code level.

---

## Workflow Routing

For complex multi-step tasks, **read the corresponding sub-workflow file on demand** before executing.
Load only what matches the user's intent — do NOT load all workflows.

| Trigger Keywords | Load This File |
|------------------|---------------|
| UI, interface, widget, layout, button, scroll, panel, dialog, HUD, canvas, label, progress bar, slider, toggle, popup, menu, health bar | `workflow-ui.md` |
| particle, effect, VFX, shader, material, fire, smoke, explosion, trail, dissolve, glow, frame animation, spell, magic | `workflow-vfx.md` |
| character, player, enemy, NPC, skeleton, spine, skinned mesh, animation clip, animator, rig, model, bone, avatar | `workflow-character.md` |
| prefab, template, reusable, instantiate, apply, revert, unlink, prefab edit | `workflow-prefab.md` |
| scene, level, world, environment, terrain, skybox, camera setup, light, build scene | `workflow-scene.md` |

**Routing rule**: check the user's request against the keyword table. If one or more categories match,
read those files with the `Read` tool. For mixed requests (e.g., "create a player UI"), load multiple
workflows. If no specific workflow matches, proceed with general operations below only.

---

## MCP Server Configuration

Ensure the Cocos MCP Server is running before use:

1. Plugin installed at `extensions/cocos-mcp-server/`
2. Start via editor menu: **Extensions > Cocos MCP Server**
3. Default port `3000`; verify with `server_info.getStatus`

---

## Tool Categories & Action Code System

All tools use `category_action` naming with `action` codes. Generic call format:

```json
{ "tool": "tool_name", "arguments": { "action": "action_code", "param": "value" } }
```

### 1. Scene Management `scene_*`

| Tool | action | Description |
|------|--------|-------------|
| `scene_management` | `getCurrent` / `open` / `save` / `new` / `close` / `list` | Full scene lifecycle |
| `scene_hierarchy` | `get` | Get scene hierarchy (with component info) |
| `scene_execution_control` | `execute` | Invoke component method / scene script |

### 2. Node Operations `node_*`

| Tool | action | Description |
|------|--------|-------------|
| `node_query` | `find` / `getInfo` / `detectType` | Find / inspect / detect 2D or 3D |
| `node_lifecycle` | `create` / `delete` / `instantiate` | Create / delete / instantiate prefab |
| `node_transform` | `setPosition` / `setRotation` / `setScale` / `setName` / `setActive` | Transform properties |
| `node_hierarchy` | `move` / `copy` / `paste` / `setParent` | Hierarchy manipulation |
| `node_clipboard` | `copy` / `paste` / `cut` | Clipboard operations |
| `node_property_management` | `reset` / `resetComponent` / `resetTransform` | Property reset |

**Node creation params**:
```json
{ "name": "node_name", "parentUuid": "...", "nodeType": "2DNode | 3DNode", "components": ["cc.Sprite"] }
```

### 3. Component Management `component_*`

| Tool | action | Description |
|------|--------|-------------|
| `component_manage` | `add` / `remove` | Add / remove built-in components |
| `component_script` | `attach` / `detach` | Attach / detach custom scripts |
| `component_query` | `list` / `getInfo` / `availableTypes` | Query components |
| `set_component_property` | `set` / `batchSet` | Set single / batch properties |

**Common built-in components**:
`cc.Sprite`, `cc.Label`, `cc.Button`, `cc.Layout`, `cc.Widget`, `cc.Mask`, `cc.Graphics`,
`cc.ScrollView`, `cc.EditBox`, `cc.Toggle`, `cc.Slider`, `cc.ProgressBar`, `cc.RichText`,
`cc.UIOpacity`, `cc.ParticleSystem`, `cc.ParticleSystem2D`,
`cc.MeshRenderer`, `cc.SkinnedMeshRenderer`, `cc.ModelRenderer`,
`cc.SkeletalAnimation`, `cc.Animation`, `cc.Animator`,
`cc.RigidBody`, `cc.RigidBody2D`, `cc.BoxCollider`, `cc.BoxCollider2D`,
`cc.SphereCollider`, `cc.CapsuleCollider`, `cc.CharacterController`,
`cc.Camera`, `cc.Canvas`, `cc.DirectionalLight`, `cc.SpotLight`, `cc.PointLight`,
`cc.AudioSource`, `cc.BlockInputEvents`, `cc.sp.Skeleton`

### 4. Prefab Operations `prefab_*`

| Tool | action | Description |
|------|--------|-------------|
| `prefab_browse` | `list` / `getInfo` / `validate` | Browse / inspect / validate |
| `prefab_lifecycle` | `create` / `delete` | Create from node / delete prefab |
| `prefab_instance` | `instantiate` / `unlink` / `apply` / `revert` | Instance lifecycle |
| `prefab_edit` | `enter` / `exit` / `save` / `test` | Edit mode operations |

**Basic flow**: build node in scene → `prefab_lifecycle.create` → save to `assets/prefabs/` →
delete scene node → use `prefab_instance.instantiate` to spawn.

### 5. Asset Management `asset_*`

| Tool | action | Description |
|------|--------|-------------|
| `asset_operates` | `create` / `copy` / `move` / `delete` / `save` / `reimport` | CRUD |
| `asset_query` | `list` / `getInfo` / `queryByType` | Query by type / folder |
| `asset_manage` | `import` / `deleteBatch` / `saveMeta` / `getUrl` | Batch ops |
| `asset_analyze` | `getDependencies` / `exportManifest` | Dependencies |
| `asset_system` | `refresh` / `status` | Refresh / DB status |

**Common paths**: `textures/`, `atlas/`, `prefabs/`, `animation/`, `materials/`, `shaders/`,
`audio/`, `scene/`, `scripts/`, `fonts/`, `spine/`

### 6. Project Control `project_*`

| Tool | action | Description |
|------|--------|-------------|
| `project_manage` | `run` / `build` / `getInfo` / `getSettings` | Run / build / info |
| `project_build_system` | `control` / `status` / `preview` | Build panel / preview |

### 7. Debug Tools `debug_*`

| Tool | action | Description |
|------|--------|-------------|
| `debug_console` | `get` / `clear` | Console logs |
| `debug_logs` | `read` / `search` / `analyze` | Log file analysis |
| `debug_system` | `getInfo` / `performance` / `env` | System info |

### 8. Preferences `preferences_*`

| Tool | action | Description |
|------|--------|-------------|
| `preferences_manage` | `get` / `set` | Editor preferences |
| `preferences_global` | `get` / `set` | Global config |

### 9. Scene View `scene_view_*`

| Tool | action | Description |
|------|--------|-------------|
| `scene_view_control` | `setGizmo` / `setCoord` / `setViewMode` | Gizmo / coord / view |
| `scene_view_tools` | manage | Tool configuration |

### 10. Validation `validation_*`

| Tool | action | Description |
|------|--------|-------------|
| `validation_scene` | `validate` | Scene integrity check |
| `validation_asset` | `validate` | Asset reference integrity |

### 11. Reference Images `reference_image_*`

| Tool | action | Description |
|------|--------|-------------|
| `reference_image_manage` | `add` / `delete` | Add / delete reference |
| `reference_image_view` | `control` | Display control |

### 12. Server & Broadcast `server_*` / `broadcast_*`

| Tool | action | Description |
|------|--------|-------------|
| `server_info` | `getStatus` / `getProject` / `getEnv` | Status / project / env |
| `broadcast_message` | `listen` / `broadcast` | Message relay |

---

## Project Build Workflow

```json
{ "tool": "project_manage", "arguments": { "action": "getInfo" } }
{ "tool": "project_manage", "arguments": { "action": "build", "platform": "web-mobile", "debug": false } }
{ "tool": "project_manage", "arguments": { "action": "build", "platform": "wechatgame", "debug": false } }
{ "tool": "project_build_system", "arguments": { "action": "status" } }
{ "tool": "project_build_system", "arguments": { "action": "preview", "platform": "web-mobile" } }
{ "tool": "project_manage", "arguments": { "action": "run" } }
```

---

## Operation Execution Guidelines

### Required Call Sequence

1. **Verify connection first**: `{ "tool": "server_info", "arguments": { "action": "getStatus" } }`
2. **Get state before modifying**: call `scene_hierarchy.get` before scene edits
3. **Verify after operations**: call the matching query tool to confirm
4. **Batch optimization**: independent creates in parallel; dependent ops sequential; use `batchSet`
5. **Write protocol**: this skill never directly modifies project `.scene` or `.prefab` files.
   All entity creation/modification goes through MCP Server tool calls. May I write to
   workflow sub-files or reference documents when updating them.

### Error Handling

| Error | Handling |
|-------|----------|
| Server not connected | Prompt user to start the Cocos MCP Server plugin |
| Node not found | `node_query.find` to confirm UUID first |
| Prefab reference lost | `validation_asset.validate` |
| Build failure | `debug_console.get` with type=error |
| Component add failed | `component_query.availableTypes` |

### Debugging Flow

```json
{ "tool": "debug_console", "arguments": { "action": "get", "type": "error", "limit": 50 } }
{ "tool": "validation_scene", "arguments": { "action": "validate" } }
{ "tool": "validation_asset", "arguments": { "action": "validate" } }
{ "tool": "debug_system", "arguments": { "action": "performance" } }
```

---

## Dependencies

- **Cocos MCP Server Plugin**: Must be installed and running in Cocos Creator editor
- **Cocos Creator 3.8.6+**: Minimum version required
- **Related Skills**: `cocos_core`, `cocos_2d`, `cocos_3d`, `cocos_animation`, `cocos_physics`, `cocos_physics-2d`, `cocos_rendering` (code-level engine knowledge)

## Usage Guide

### When to Use This Skill

- Create / open / save scenes, manage nodes and components
- Import / query / move / delete project assets
- Build, run, and preview the project
- Debug editor state, console logs, performance
- Validate scene / asset integrity
- Any specialized workflow → see **Workflow Routing** at the top of this file

### Key Constraints

1. **All editor ops through MCP** — never directly modify `.scene` / `.prefab` files
2. **Query before mutating** — avoid overwriting existing config
3. **UUID references** — use UUID, not path names
4. **Save after edits** — `scene_management.save`
5. **Add first, configure second** — components before properties

### Verdict

- **COMPLETE** — all requested editor operations executed successfully
- **BLOCKED** — Cocos MCP Server not connected or unreachable
- **READY** — workflow sub-file loaded, ready to execute the recipe steps

### Recommended Next Steps

- After creating UI → `cocos_2d` skill for interaction scripts
- After creating character → `cocos_animation` skill for animation logic
- After creating VFX → `cocos_rendering` skill for rendering optimization
- After creating physics entities → `cocos_physics` / `cocos_physics-2d` skill
