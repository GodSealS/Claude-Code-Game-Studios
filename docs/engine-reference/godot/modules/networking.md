# Godot Networking — Quick Reference / Godot网络模块


> **中文翻译**：本文档为Godot引擎参考文档。所有代码示例和技术术语保持英文原文。

Last verified: 2026-02-12 | Engine: Godot 4.6

<!-- 自 ~4.3 以来的变化（LLM 训练截止） -->
## What Changed Since ~4.3 (LLM Cutoff)

<!-- 中文翻译 -->
### 4.6 Changes
- **Networking section in breaking changes**: See the official migration guide for
  specifics at the 4.5→4.6 level

<!-- 中文翻译 -->
### 4.5 Changes
- **No major networking API breaks** — core multiplayer API remains stable

<!-- 当前 API 模式 -->
## Current API Patterns

<!-- 中文翻译 -->
### High-Level Multiplayer
```gdscript
# Server
func host_game(port: int = 9999) -> void:
    var peer := ENetMultiplayerPeer.new()
    peer.create_server(port)
    multiplayer.multiplayer_peer = peer
    multiplayer.peer_connected.connect(_on_peer_connected)
    multiplayer.peer_disconnected.connect(_on_peer_disconnected)

# Client
func join_game(address: String, port: int = 9999) -> void:
    var peer := ENetMultiplayerPeer.new()
    peer.create_client(address, port)
    multiplayer.multiplayer_peer = peer
```

<!-- 中文翻译 -->
### RPCs
```gdscript
# Server-authoritative pattern
@rpc("any_peer", "call_local", "reliable")
func request_action(action_data: Dictionary) -> void:
    if not multiplayer.is_server():
        return
    # Validate on server, then broadcast
    _execute_action.rpc(action_data)

@rpc("authority", "call_local", "reliable")
func _execute_action(action_data: Dictionary) -> void:
    # All peers execute the validated action
    pass
```

<!-- 中文翻译 -->
### MultiplayerSpawner and MultiplayerSynchronizer
```gdscript
# Use MultiplayerSpawner for automatic node replication
# Use MultiplayerSynchronizer for property synchronization

# MultiplayerSynchronizer setup:
# 1. Add as child of the node to sync
# 2. Configure replication properties in editor
# 3. Set visibility filters for relevancy
```

<!-- 中文翻译 -->
### SceneMultiplayer Configuration
```gdscript
func _ready() -> void:
    var scene_mp := multiplayer as SceneMultiplayer
    scene_mp.auth_callback = _authenticate_peer
    scene_mp.server_relay = false  # Direct peer connections

func _authenticate_peer(id: int, data: PackedByteArray) -> void:
    # Custom authentication logic
    pass
```

<!-- 常见错误 -->
## Common Mistakes
- Not using `"any_peer"` for client-to-server RPCs (defaults to authority only)
- Trusting client data without server-side validation
- Using `"unreliable"` for game state changes (use for position updates only)
- Not setting multiplayer authority (`set_multiplayer_authority()`) on spawned nodes
