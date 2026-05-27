# Prefab Creation Workflow

## Standard Prefab Creation Flow

```
Build complete node structure in scene → Add all needed components → Configure component properties →
Set child node hierarchy → Verify functionality → Create prefab → Remove temporary scene node →
Use via dynamic script instantiation
```

## Prefab Operation Quick Reference

```json
// 1. List all prefabs
{ "tool": "prefab_browse", "arguments": { "action": "list", "folder": "assets/prefabs/" } }

// 2. Create from scene node
{ "tool": "prefab_lifecycle", "arguments": { "action": "create", "nodeUuid": "scene-node-uuid", "path": "assets/prefabs/MyPrefab.prefab" } }

// 3. Instantiate into scene
{ "tool": "prefab_instance", "arguments": { "action": "instantiate", "prefabUuid": "prefab-uuid", "parentUuid": "parent-node-uuid" } }

// 4. Edit prefab
{ "tool": "prefab_edit", "arguments": { "action": "enter", "prefabUuid": "prefab-uuid" } }
// ... make edits in edit mode ...
{ "tool": "prefab_edit", "arguments": { "action": "exit", "save": true } }

// 5. Unlink instance (convert to regular node)
{ "tool": "prefab_instance", "arguments": { "action": "unlink", "nodeUuid": "instance-uuid" } }

// 6. Apply instance changes to prefab
{ "tool": "prefab_instance", "arguments": { "action": "apply", "nodeUuid": "instance-uuid" } }

// 7. Revert instance to original prefab
{ "tool": "prefab_instance", "arguments": { "action": "revert", "nodeUuid": "instance-uuid" } }
```

## Prefab Directory Convention

```
assets/prefabs/
├── characters/       # Character prefabs
│   ├── Player.prefab
│   ├── Enemy_Fire.prefab
│   ├── Enemy_Water.prefab
│   └── NPC_Merchant.prefab
├── ui/               # UI prefabs
│   ├── Button_Primary.prefab
│   ├── Dialog_Confirm.prefab
│   ├── ItemSlot.prefab
│   └── Toast.prefab
├── effects/          # VFX prefabs
│   ├── FireParticle.prefab
│   ├── Explosion.prefab
│   └── MagicCircle.prefab
├── projectiles/      # Projectile prefabs
│   ├── Arrow.prefab
│   └── FireBall.prefab
├── pickups/          # Pickup prefabs
│   ├── Coin.prefab
│   └── HealthPack.prefab
└── environment/      # Environment prefabs
    ├── Platform.prefab
    └── DestructibleCrate.prefab
```

## Prefab Best Practices

1. **Single responsibility**: Each prefab does one thing only
2. **Clear layering**: Split complex prefabs into layers; the root node only handles position and lifecycle
3. **Reserved properties**: Use `@property` in custom scripts to expose configurable fields for post-instantiation tweaks
4. **Avoid deep nesting**: Prefab nesting should not exceed 3 levels
5. **Separate VFX from logic**: Visual effects become their own VFX prefabs, triggered by script
6. **Use variants**: Similar enemy types share one prefab, differentiated via property configuration
