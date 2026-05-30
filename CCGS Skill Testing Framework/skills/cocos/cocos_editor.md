# Skill Test Spec: /cocos_editor

> **Category**: engine | **Priority**: high | **Type**: editor-tool
> **Loaded by**: `cocos-specialist` via `UseSkill("cocos_editor")`
> **Spec written**: 2026-05-30

## Skill Summary

Cocos Creator Editor Full-Feature Skill. Operates the Cocos Creator editor through the Cocos MCP Server for scene management, node operations, component management, prefab creation, asset management, UI layout, VFX creation, character creation, and project building. Routes specialized multi-step tasks to 5 workflow sub-files (UI, VFX, character, prefab, scene). This skill is unique among Cocos skills — it invokes MCP tool calls (not code-level patterns) and has Write/Edit permissions for updating workflow sub-files.

---

## Static Assertions

Editor skills write MCP command files and workflow sub-files. Required frontmatter: `name`, `description`, `allowed-tools`. Optional: `argument-hint`, `user-invocable`.

- [ ] Frontmatter has `name`, `description`, `allowed-tools` (3 required; `argument-hint`/`user-invocable` optional)
- [ ] 2+ phase headings found
- [ ] At least one verdict keyword present (`COMPLETE`, `BLOCKED`, `READY`)
- [ ] `allowed-tools` includes `mcp_get_tool_description` and `mcp_call_tool` (required for MCP operations)
- [ ] `"May I write"` language present in the Operation Execution Guidelines section (since Write/Edit is in allowed-tools)
- [ ] **Workflow Routing table** present with keyword → sub-file mapping for all 5 workflows
- [ ] **Tool Categories** section covers all 12 MCP tool categories with action codes
- [ ] **Error Handling table** present with common errors and recovery steps
- [ ] **Verdict section** defines COMPLETE / BLOCKED / READY semantics
- [ ] **Recommended Next Steps** section present with cross-skill handoff guidance

---

## Test Cases

### Case 1: Happy Path — MCP connection and scene query

**Fixture:**
- Cocos MCP Server plugin installed and running
- A scene is open in the Cocos Creator editor
- Skill is loaded by `cocos-specialist` via `UseSkill("cocos_editor")`

**Expected behavior:**
1. Skill first calls `server_info.getStatus` to verify MCP connection
2. Calls `scene_hierarchy.get` with `includeComponents: true` to read current state
3. Returns scene node tree with component information
4. Uses `mcp_get_tool_description` before each new tool type

**Assertions:**
- [ ] Skill provides MCP connection verification step
- [ ] Scene query operations follow the "verify → query → act → verify" sequence
- [ ] Tool calls use the `category_action` naming convention shown in SKILL.md

**Case Verdict**: PASS / FAIL

---

### Case 2: Workflow Routing — keyword match triggers sub-file load

**Fixture:**
- User request: "Create a game HUD with health bar, minimap, and action buttons"
- Keywords: "HUD", "health bar", "button" → matches `workflow-ui.md`

**Expected behavior:**
1. Skill checks the user's request against the Workflow Routing keyword table
2. Identifies UI keywords (HUD, health bar, button) → loads `workflow-ui.md`
3. Does NOT load unrelated workflows (character, VFX, etc.)
4. Follows the `workflow-ui.md` recipe step by step

**Assertions:**
- [ ] Skill reads `workflow-ui.md` with the `Read` tool based on keyword match
- [ ] Skill does not load all 5 workflow files — only the matching one(s)
- [ ] Workflow routing rule is followed: "check the user's request against the keyword table"

**Case Verdict**: PASS / FAIL

---

### Case 3: Multi-workflow — mixed domain request

**Fixture:**
- User request: "Create a player character with HP bar overhead UI"
- Keywords: "player", "character" → `workflow-character.md`; "UI", "HP bar" → `workflow-ui.md`

**Expected behavior:**
1. Skill detects both character and UI keywords
2. Loads both `workflow-character.md` and `workflow-ui.md`
3. Coordinates across workflows: creates character first, then adds overhead UI as child node
4. Uses prefab workflow to save the complete result

**Assertions:**
- [ ] Multiple workflows are loaded when keywords span categories
- [ ] Workflows are coordinated in logical order (character → UI attachment)
- [ ] Independent operations are batched (parallel MCP calls)
- [ ] Dependent operations are sequential (character node UUID → UI parent UUID)

**Case Verdict**: PASS / FAIL

---

### Case 4: UI Creation Workflow — end-to-end

**Fixture:**
- Canvas exists in scene
- User request: "Create a settings dialog with volume slider, music toggle, and close button"

**Expected behavior:**
1. Loads `workflow-ui.md`
2. Follows the 5-step flow: Canvas → Widget → Layout → Components → Script
3. Creates dialog panel node with Widget (centered)
4. Creates Toggle for music, Slider for volume, Button for close
5. Configures each component with appropriate properties via `set_component_property`
6. Adds Widget alignment to each child for multi-resolution support

**Assertions:**
- [ ] Workflow follows the standard 5-step sequence from `workflow-ui.md`
- [ ] All UI components created via `node_lifecycle.create` with `nodeType: "2DNode"`
- [ ] Widget alignment matches the scheme table (dialog → HorizontalCenter + VerticalCenter)
- [ ] Component properties are configured with `batchSet` where possible
- [ ] Layout types match the use-case table (no layout needed for manual-placement dialog)

**Case Verdict**: PASS / FAIL

---

### Case 5: VFX Creation — particle system with recipe

**Fixture:**
- User request: "Create a fire particle effect for a campfire"

**Expected behavior:**
1. Loads `workflow-vfx.md`
2. Creates a 3D node with `cc.ParticleSystem` component
3. Applies the Fire recipe: Cone shape, red→orange→yellow gradient, speed 50-150, gravityModifier -20
4. Configures via `batchSet` for efficiency
5. Saves as prefab in `assets/prefabs/effects/FireEffect.prefab`

**Assertions:**
- [ ] Skill uses the Fire recipe parameters from `workflow-vfx.md`
- [ ] Particle system properties are set via `batchSet` (not individual `set` calls)
- [ ] Effect is saved as a reusable prefab
- [ ] Shape, color, lifetime, and emission properties are all configured

**Case Verdict**: PASS / FAIL

---

### Case 6: Character Creation — skeletal animation

**Fixture:**
- 3D model (glTF/FBX) imported into project assets
- User request: "Set up a 3D enemy character with skeletal animation and capsule collider"

**Expected behavior:**
1. Loads `workflow-character.md`
2. Follows the 6-step process: root node → renderer → animation → physics → structure → prefab
3. Creates 3D node with `cc.SkinnedMeshRenderer` + `cc.SkeletalAnimation`
4. Adds `cc.RigidBody` (DYNAMIC) + `cc.CapsuleCollider`
5. Follows standard character hierarchy: Model, Animation, Collision, WeaponMount, VFX, UI, Audio
6. Saves as prefab: `assets/prefabs/characters/Enemy.prefab`

**Assertions:**
- [ ] Follows the 6-step Character Creation Process from `workflow-character.md`
- [ ] Uses `cc.SkinnedMeshRenderer` (not MeshRenderer) for skeletal characters
- [ ] RigidBody configured with type=DYNAMIC, mass, and damping
- [ ] CapsuleCollider configured with radius, cylinderHeight, direction
- [ ] Standard character hierarchy includes all 7 sub-node categories

**Case Verdict**: PASS / FAIL

---

### Case 7: Error Handling — MCP server not connected

**Fixture:**
- Cocos MCP Server is NOT running
- User request: "Create a UI button"

**Expected behavior:**
1. Skill calls `server_info.getStatus` → MCP call fails or returns error
2. Skill does NOT proceed with further MCP calls
3. Skill reports BLOCKED verdict
4. Skill instructs user to start the Cocos MCP Server plugin (Extensions > Cocos MCP Server)

**Assertions:**
- [ ] BLOCKED verdict is returned when MCP server is unreachable
- [ ] Error message matches the Error Handling table: "Prompt user to start the Cocos MCP Server plugin"
- [ ] No partial operations are attempted after connection failure
- [ ] Skill exits cleanly without crashing or hanging

**Case Verdict**: PASS / FAIL

---

### Case 8: Build and Preview Workflow

**Fixture:**
- Project assets are complete and validated
- User request: "Build the project for web-mobile and preview it"

**Expected behavior:**
1. Calls `project_manage.getInfo` to confirm project state
2. Calls `project_manage.build` with platform=web-mobile
3. Calls `project_build_system.status` to monitor build progress
4. Calls `project_build_system.preview` to launch preview

**Assertions:**
- [ ] Build workflow follows the JSON sequence in the "Project Build Workflow" section
- [ ] Platform is specified in the `build` call
- [ ] Build status is checked before launching preview
- [ ] On build failure, checks `debug_console.get` with type=error per Error Handling table

**Case Verdict**: PASS / FAIL

---

## Protocol Compliance

- [ ] `allowed-tools` includes `mcp_get_tool_description`, `mcp_call_tool` for MCP operations
- [ ] `"May I write"` language present for workflow sub-file updates (Write/Edit in allowed-tools)
- [ ] All editor operations go through MCP Server — never directly modify `.scene` / `.prefab` files
- [ ] Connection verification (`server_info.getStatus`) precedes all editor operations
- [ ] State is queried (e.g., `scene_hierarchy.get`) before mutations
- [ ] Operations are verified after execution (matching query tool)
- [ ] Verdict returned for every operation: COMPLETE / BLOCKED / READY
- [ ] Recommended Next Steps provide cross-skill handoff (cocos_2d, cocos_animation, cocos_rendering)

---

## Workflow Sub-File Coverage

Each of the 5 workflow sub-files must meet these minimums:

| Workflow File | Min. Steps | Has JSON Examples | Has Best Practices / Issues Table |
|---------------|-----------|-------------------|----------------------------------|
| `workflow-ui.md` | 5 steps | ✅ required | ✅ required |
| `workflow-vfx.md` | 3 effect types | ✅ required | ✅ required |
| `workflow-character.md` | 6 steps | ✅ required | ✅ required |
| `workflow-prefab.md` | 7 operations | ✅ required | ✅ required |
| `workflow-scene.md` | Scene structure + 5 ops | ✅ required | — (scene structure is self-documenting) |
