# Unity 6.3 — Networking Module Reference / Unity网络模块


> **中文翻译**：本文档为Unity引擎参考文档。所有代码示例和技术术语保持英文原文。

**Last verified:** 2026-02-13
**Knowledge Gap:** Unity 6 uses Netcode for GameObjects (UNet deprecated)

---

<!-- 概述 -->
## Overview

Unity 6 networking options:
- **Netcode for GameObjects** (RECOMMENDED): Official Unity multiplayer framework
- **Mirror**: Community-driven (UNet successor)
- **Photon**: Third-party service (PUN2)
- **Custom**: Low-level sockets

**UNet (Legacy)**: Deprecated, do not use.

---

<!-- 中文翻译 -->
## Netcode for GameObjects

<!-- 安装 -->
### Installation
1. `Window > Package Manager`
2. Search "Netcode for GameObjects"
3. Install `com.unity.netcode.gameobjects`

---

<!-- 中文翻译 -->
## Basic Setup

<!-- 中文翻译 -->
### NetworkManager

```csharp
// Add to scene: GameObject > Add Component > NetworkManager

// Or create custom NetworkManager:
using Unity.Netcode;

public class CustomNetworkManager : MonoBehaviour {
    void Start() {
        NetworkManager.Singleton.StartHost(); // Server + client
        // OR
        NetworkManager.Singleton.StartServer(); // Dedicated server
        // OR
        NetworkManager.Singleton.StartClient(); // Client only
    }
}
```

---

<!-- 中文翻译 -->
## NetworkObject (Networked GameObjects)

<!-- 中文翻译 -->
### Mark GameObject as Networked

1. Add `NetworkObject` component to GameObject
2. Must be in root of prefab (not nested)
3. Register prefab in `NetworkManager > NetworkPrefabs List`

<!-- 中文翻译 -->
### Spawn Network Objects

```csharp
using Unity.Netcode;

public class GameManager : NetworkBehaviour {
    public GameObject playerPrefab;

    [ServerRpc(RequireOwnership = false)]
    public void SpawnPlayerServerRpc(ulong clientId) {
        GameObject player = Instantiate(playerPrefab);
        player.GetComponent<NetworkObject>().SpawnAsPlayerObject(clientId);
    }
}
```

---

<!-- 中文翻译 -->
## NetworkBehaviour (Networked Scripts)

<!-- 中文翻译 -->
### NetworkBehaviour Base Class

```csharp
using Unity.Netcode;

public class Player : NetworkBehaviour {
    // Called when spawned on network
    public override void OnNetworkSpawn() {
        if (IsOwner) {
            // Only run on owner's client
            GetComponent<Camera>().enabled = true;
        }
    }

    void Update() {
        if (!IsOwner) return; // Only owner can control

        // Handle input
        if (Input.GetKey(KeyCode.W)) {
            MoveServerRpc(Vector3.forward);
        }
    }

    [ServerRpc]
    void MoveServerRpc(Vector3 direction) {
        // Runs on server
        transform.position += direction * Time.deltaTime;
    }
}
```

---

<!-- 中文翻译 -->
## Network Variables (Synchronized State)

<!-- 中文翻译 -->
### NetworkVariable<T>

```csharp
using Unity.Netcode;

public class Player : NetworkBehaviour {
    // ✅ Auto-synced across clients
    private NetworkVariable<int> health = new NetworkVariable<int>(100);

    public override void OnNetworkSpawn() {
        // Subscribe to value changes
        health.OnValueChanged += OnHealthChanged;
    }

    void OnHealthChanged(int oldValue, int newValue) {
        Debug.Log($"Health changed: {oldValue} -> {newValue}");
        UpdateHealthUI(newValue);
    }

    [ServerRpc]
    public void TakeDamageServerRpc(int damage) {
        // Only server can modify NetworkVariable
        health.Value -= damage;
    }
}
```

<!-- 中文翻译 -->
### NetworkVariable Permissions

```csharp
// Server can write, clients read-only (default)
private NetworkVariable<int> score = new NetworkVariable<int>();

// Owner can write
private NetworkVariable<int> ammo = new NetworkVariable<int>(
    default,
    NetworkVariableReadPermission.Everyone,
    NetworkVariableWritePermission.Owner
);
```

---

<!-- 中文翻译 -->
## RPCs (Remote Procedure Calls)

<!-- 中文翻译 -->
### ServerRpc (Client → Server)

```csharp
// Client calls, server executes
[ServerRpc]
void FireWeaponServerRpc() {
    // Runs on server
    Debug.Log("Server: Weapon fired");
}

// Call from client:
if (IsOwner && Input.GetKeyDown(KeyCode.Space)) {
    FireWeaponServerRpc();
}
```

<!-- 中文翻译 -->
### ClientRpc (Server → All Clients)

```csharp
// Server calls, all clients execute
[ClientRpc]
void PlayExplosionClientRpc(Vector3 position) {
    // Runs on all clients
    Instantiate(explosionPrefab, position, Quaternion.identity);
}

// Call from server:
[ServerRpc]
void ExplodeServerRpc(Vector3 position) {
    // Server logic
    DealDamageToNearbyPlayers(position);

    // Notify all clients
    PlayExplosionClientRpc(position);
}
```

<!-- 中文翻译 -->
### RPC Parameters

```csharp
// ✅ Supported: Primitives, structs, strings, arrays
[ServerRpc]
void SetNameServerRpc(string playerName) { }

[ClientRpc]
void UpdateScoresClientRpc(int[] scores) { }

// ❌ Not supported: MonoBehaviour, GameObject (use NetworkObjectReference)
```

---

<!-- 中文翻译 -->
## Network Ownership

<!-- 中文翻译 -->
### Check Ownership

```csharp
if (IsOwner) {
    // This client owns this NetworkObject
}

if (IsServer) {
    // Running on server
}

if (IsClient) {
    // Running on client
}

if (IsLocalPlayer) {
    // This is the local player object
}
```

<!-- 中文翻译 -->
### Transfer Ownership

```csharp
// Server transfers ownership
NetworkObject netObj = GetComponent<NetworkObject>();
netObj.ChangeOwnership(newOwnerClientId);
```

---

<!-- 中文翻译 -->
## NetworkObjectReference (Pass GameObjects in RPCs)

```csharp
using Unity.Netcode;

[ServerRpc]
void AttackTargetServerRpc(NetworkObjectReference targetRef) {
    if (targetRef.TryGet(out NetworkObject target)) {
        // Got the target object
        target.GetComponent<Health>().TakeDamage(10);
    }
}

// Call:
NetworkObject targetNetObj = target.GetComponent<NetworkObject>();
AttackTargetServerRpc(targetNetObj);
```

---

<!-- 中文翻译 -->
## Client-Server Architecture

<!-- 中文翻译 -->
### Server-Authoritative Pattern (RECOMMENDED)

```csharp
public class Player : NetworkBehaviour {
    private NetworkVariable<Vector3> position = new NetworkVariable<Vector3>();

    void Update() {
        if (IsOwner) {
            // Client: Send input to server
            Vector3 input = new Vector3(Input.GetAxis("Horizontal"), 0, Input.GetAxis("Vertical"));
            MoveServerRpc(input);
        }

        // All clients: Sync to networked position
        transform.position = position.Value;
    }

    [ServerRpc]
    void MoveServerRpc(Vector3 input) {
        // Server: Validate and apply movement
        position.Value += input * Time.deltaTime * moveSpeed;
    }
}
```

---

<!-- 中文翻译 -->
## Network Transport

<!-- 中文翻译 -->
### Unity Transport (Default)

```csharp
// Configured in NetworkManager:
// - Transport: Unity Transport
// - Address: 127.0.0.1 (localhost) or server IP
// - Port: 7777 (default)
```

<!-- 中文翻译 -->
### Connection Events

```csharp
void Start() {
    NetworkManager.Singleton.OnClientConnectedCallback += OnClientConnected;
    NetworkManager.Singleton.OnClientDisconnectCallback += OnClientDisconnected;
}

void OnClientConnected(ulong clientId) {
    Debug.Log($"Client {clientId} connected");
}

void OnClientDisconnected(ulong clientId) {
    Debug.Log($"Client {clientId} disconnected");
}
```

---

<!-- 性能提示 -->
## Performance Tips

<!-- 中文翻译 -->
### Reduce Network Traffic
- Use `NetworkVariable` for state that changes infrequently
- Batch multiple changes before syncing
- Use delta compression for large data

<!-- 中文翻译 -->
### Prediction & Reconciliation
- Run movement locally for responsiveness
- Reconcile with server authoritative state
- Use interpolation for smooth movement

---

<!-- 调试 -->
## Debugging

<!-- 中文翻译 -->
### Network Profiler
- `Window > Analysis > Network Profiler`
- Monitor bandwidth, RPC calls, variable updates

<!-- 中文翻译 -->
### Network Simulator (Test Latency/Packet Loss)
- `NetworkManager > Network Simulator`
- Add artificial lag and packet loss for testing

---

<!-- 来源 -->
## Sources
- https://docs-multiplayer.unity3d.com/netcode/current/about/
- https://docs-multiplayer.unity3d.com/netcode/current/learn/bossroom/
