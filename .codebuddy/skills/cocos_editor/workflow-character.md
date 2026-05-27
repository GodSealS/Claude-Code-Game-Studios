# Character Creation Workflow

## Character Creation Process

```
Prepare assets → Create prefab structure → Attach render components → Configure animation →
Add physics / collision → Add scripts → Save prefab → Instantiate and test in scene
```

## Step 1: Create Character Root Node

```json
// 3D character
{ "tool": "node_lifecycle", "arguments": { "action": "create", "name": "Player", "nodeType": "3DNode", "parentUuid": "scene" } }

// 2D character
{ "tool": "node_lifecycle", "arguments": { "action": "create", "name": "Player", "nodeType": "2DNode", "parentUuid": "scene" } }
```

## Step 2: 3D Character Configuration

**Load model and set materials**:
```json
[
  { "tool": "component_manage", "arguments": { "action": "add", "nodeUuid": "...", "componentType": "cc.MeshRenderer" } },
  { "tool": "set_component_property", "arguments": { "action": "set", "nodeUuid": "...", "componentType": "cc.MeshRenderer", "property": "mesh", "value": "uuid-of-model-mesh" } },
  { "tool": "set_component_property", "arguments": { "action": "set", "nodeUuid": "...", "componentType": "cc.MeshRenderer", "property": "materials", "value": ["uuid-of-material"] } }
]
```

## Step 3: Character Animation

**Skeletal animation (SkinnedMeshRenderer + SkeletalAnimation)**:
```json
[
  { "tool": "component_manage", "arguments": { "action": "add", "nodeUuid": "...", "componentType": "cc.SkinnedMeshRenderer" } },
  { "tool": "component_manage", "arguments": { "action": "add", "nodeUuid": "...", "componentType": "cc.SkeletalAnimation" } },
  { "tool": "set_component_property", "arguments": { "action": "set", "nodeUuid": "...", "componentType": "cc.SkeletalAnimation", "property": "defaultClip", "value": "uuid-of-idle-clip" } }
]
```

**Spine animation (2D characters)**:
```json
[
  { "tool": "component_manage", "arguments": { "action": "add", "nodeUuid": "...", "componentType": "cc.sp.Skeleton" } },
  { "tool": "set_component_property", "arguments": { "action": "batchSet", "nodeUuid": "...", "componentType": "cc.sp.Skeleton", "properties": { "skeletonData": "uuid-of-spine-data", "defaultAnimation": "idle", "loop": true } } }
]
```

**Animation / Animator controller (simple animation)**:
```json
[
  { "tool": "component_manage", "arguments": { "action": "add", "nodeUuid": "...", "componentType": "cc.Animation" } },
  { "tool": "set_component_property", "arguments": { "action": "set", "nodeUuid": "...", "componentType": "cc.Animation", "property": "playOnLoad", "value": true } }
]
```

## Step 4: Physics & Collision

**3D Physics**:
```json
[
  { "tool": "component_manage", "arguments": { "action": "add", "nodeUuid": "...", "componentType": "cc.RigidBody" } },
  { "tool": "set_component_property", "arguments": { "action": "batchSet", "nodeUuid": "...", "componentType": "cc.RigidBody", "properties": { "type": "DYNAMIC", "mass": 80, "linearDamping": 5, "angularDamping": 10 } } },
  { "tool": "component_manage", "arguments": { "action": "add", "nodeUuid": "...", "componentType": "cc.CapsuleCollider" } },
  { "tool": "set_component_property", "arguments": { "action": "batchSet", "nodeUuid": "...", "componentType": "cc.CapsuleCollider", "properties": { "radius": 0.5, "cylinderHeight": 1.8, "direction": "Y_AXIS" } } }
]
```

**Character Controller (CharacterController)**:
```json
[
  { "tool": "component_manage", "arguments": { "action": "add", "nodeUuid": "...", "componentType": "cc.CharacterController" } },
  { "tool": "set_component_property", "arguments": { "action": "batchSet", "nodeUuid": "...", "componentType": "cc.CharacterController", "properties": { "stepOffset": 0.35, "slopeLimit": 45, "minMoveDistance": 0.001, "center": { "x": 0, "y": 1, "z": 0 }, "radius": 0.5, "height": 2 } } }
]
```

**2D Physics**:
```json
[
  { "tool": "component_manage", "arguments": { "action": "add", "nodeUuid": "...", "componentType": "cc.RigidBody2D" } },
  { "tool": "set_component_property", "arguments": { "action": "batchSet", "nodeUuid": "...", "componentType": "cc.RigidBody2D", "properties": { "type": "DYNAMIC", "linearDamping": 5, "fixedRotation": true } } },
  { "tool": "component_manage", "arguments": { "action": "add", "nodeUuid": "...", "componentType": "cc.BoxCollider2D" } }
]
```

## Step 5: Standard Character Prefab Structure

```
Player (prefab root node)
├── Model (cc.MeshRenderer / cc.SkinnedMeshRenderer)
├── Animation (cc.SkeletalAnimation / cc.Animation)
├── Collision (child node)
│   ├── BodyCollider (cc.CapsuleCollider)
│   ├── HeadCheck (cc.SphereCollider, isTrigger=true)
│   └── FootCheck (cc.BoxCollider, isTrigger=true)
├── WeaponMount (attachment point)
│   └── Weapon (weapon prefab instance)
├── VFX (effect attachment points)
│   ├── HitEffect
│   ├── SkillEffect
│   └── TrailEffect
├── UI (overhead health bar / name)
│   └── HeadUI (cc.Widget, 3D→2D mapping)
└── Audio (cc.AudioSource)
```

## Step 6: Save as Prefab

```json
{ "tool": "prefab_lifecycle", "arguments": { "action": "create", "nodeUuid": "playerNodeUuid", "path": "assets/prefabs/characters/Player.prefab" } }
```

## Character Creation Common Issues

| Issue | Solution |
|-------|----------|
| Skeletal animation not showing | Verify that SkinnedMeshRenderer `skeleton` and `mesh` match |
| Animation playback abnormal | Confirm `useBakedAnimation` is set correctly (false for real-time) |
| Collision penetration | Increase physics frame rate `PhysicsSystem.fixedTimeStep`, or use Continuous collision detection |
| Model material missing | Enable "Extract Materials" on model import, manage materials separately |
| Spine facing wrong direction | Set scale.x = -1 to flip character orientation |
