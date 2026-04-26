# Unity 6.3 — Addressables / UnityAddressables（可寻址资产）插件


> **中文翻译**：本文档为Unity引擎参考文档。所有代码示例和技术术语保持英文原文。

**Last verified:** 2026-02-13
**Status:** Production-Ready
**Package:** `com.unity.addressables` (Package Manager)

---

<!-- 概述 -->
## Overview

**Addressables** is Unity's advanced asset management system that replaces `Resources.Load()`
with async loading, remote content delivery, and better memory control.

**Use Addressables for:**
- Async asset loading (non-blocking)
- DLC and remote content
- Memory optimization (load/unload on demand)
- Asset dependency management
- Large projects with many assets

**DON'T use Addressables for:**
- Tiny projects (overhead not worth it)
- Assets needed immediately at startup (use direct references)

---

<!-- 安装 -->
## Installation

<!-- 中文翻译 -->
### Install via Package Manager

1. `Window > Package Manager`
2. Unity Registry > Search "Addressables"
3. Install `Addressables`

---

<!-- 核心概念 -->
## Core Concepts

<!-- 中文翻译 -->
### 1. **Addressable Assets**
- Assets marked as "Addressable" (assigned unique keys)
- Can be loaded by key at runtime

<!-- 中文翻译 -->
### 2. **Asset Groups**
- Organize assets (e.g., "UI", "Weapons", "Level1")
- Groups determine build settings (local vs remote)

<!-- 中文翻译 -->
### 3. **Async Loading**
- All loading is async (non-blocking)
- Returns `AsyncOperationHandle`

<!-- 中文翻译 -->
### 4. **Reference Counting**
- Addressables tracks asset usage
- Must manually release assets when done

---

<!-- 设置 -->
## Setup

<!-- 中文翻译 -->
### 1. Mark Assets as Addressable

1. Select asset in Project window
2. Inspector > Check "Addressable"
3. Assign key (e.g., "Enemies/Goblin")

**OR via script:**
```csharp
#if UNITY_EDITOR
using UnityEditor.AddressableAssets;
using UnityEditor.AddressableAssets.Settings;

AddressableAssetSettings.AddAssetEntry(guid, "MyAssetKey", "Default Local Group");
#endif
```

---

<!-- 中文翻译 -->
### 2. Create Groups

`Window > Asset Management > Addressables > Groups`

- **Default Local Group**: Bundled with build
- **Remote Group**: Hosted on server (CDN)

---

<!-- 中文翻译 -->
## Basic Loading

<!-- 中文翻译 -->
### Load Asset Async

```csharp
using UnityEngine.AddressableAssets;
using UnityEngine.ResourceManagement.AsyncOperations;

public class AssetLoader : MonoBehaviour {
    async void Start() {
        // ✅ Load asset asynchronously
        AsyncOperationHandle<GameObject> handle = Addressables.LoadAssetAsync<GameObject>("Enemies/Goblin");
        await handle.Task;

        if (handle.Status == AsyncOperationStatus.Succeeded) {
            GameObject prefab = handle.Result;
            Instantiate(prefab);
        } else {
            Debug.LogError("Failed to load asset");
        }

        // ⚠️ IMPORTANT: Release when done
        Addressables.Release(handle);
    }
}
```

---

<!-- 中文翻译 -->
### Load and Instantiate

```csharp
async void SpawnEnemy() {
    // ✅ Load and instantiate in one step
    AsyncOperationHandle<GameObject> handle = Addressables.InstantiateAsync("Enemies/Goblin");
    await handle.Task;

    GameObject enemy = handle.Result;
    // Use enemy...

    // ✅ Release when destroying
    Addressables.ReleaseInstance(enemy);
}
```

---

<!-- 中文翻译 -->
### Load Multiple Assets

```csharp
async void LoadAllWeapons() {
    // Load all assets with label "Weapons"
    AsyncOperationHandle<IList<GameObject>> handle = Addressables.LoadAssetsAsync<GameObject>("Weapons", null);
    await handle.Task;

    foreach (var weapon in handle.Result) {
        Debug.Log($"Loaded: {weapon.name}");
    }

    Addressables.Release(handle);
}
```

---

<!-- 中文翻译 -->
## Asset Labels (Tags)

<!-- 中文翻译 -->
### Assign Labels

1. `Window > Asset Management > Addressables > Groups`
2. Select asset > Inspector > Labels > Add label (e.g., "Level1", "UI")

<!-- 中文翻译 -->
### Load by Label

```csharp
// Load all assets with label "Level1"
Addressables.LoadAssetsAsync<GameObject>("Level1", null);
```

---

<!-- 中文翻译 -->
## Remote Content (DLC)

<!-- 中文翻译 -->
### Setup Remote Groups

1. Create new group: `Window > Addressables > Groups > Create New Group > Packed Assets`
2. Group Settings:
   - **Build Path**: `ServerData/[BuildTarget]`
   - **Load Path**: `http://yourcdn.com/content/[BuildTarget]`

<!-- 中文翻译 -->
### Build Remote Content

1. `Window > Asset Management > Addressables > Build > New Build > Default Build Script`
2. Upload `ServerData/` folder to CDN
3. Game loads assets from remote server

---

<!-- 中文翻译 -->
## Preloading / Caching

<!-- 中文翻译 -->
### Download Dependencies

```csharp
async void PreloadLevel() {
    // Download all assets in group without loading into memory
    AsyncOperationHandle handle = Addressables.DownloadDependenciesAsync("Level1");
    await handle.Task;

    // Now "Level1" assets are cached, load instantly
    Addressables.Release(handle);
}
```

<!-- 中文翻译 -->
### Check Download Size

```csharp
async void CheckDownloadSize() {
    AsyncOperationHandle<long> handle = Addressables.GetDownloadSizeAsync("Level1");
    await handle.Task;

    long sizeInBytes = handle.Result;
    Debug.Log($"Download size: {sizeInBytes / (1024 * 1024)} MB");

    Addressables.Release(handle);
}
```

---

<!-- 内存管理 -->
## Memory Management

<!-- 中文翻译 -->
### Release Assets

```csharp
// ✅ Always release when done
Addressables.Release(handle);

// ✅ For instantiated objects
Addressables.ReleaseInstance(gameObject);
```

<!-- 中文翻译 -->
### Check Reference Count

```csharp
// Addressables uses reference counting
// Asset is unloaded when refCount == 0
```

---

<!-- 中文翻译 -->
## Asset References (Inspector-Assigned)

<!-- 中文翻译 -->
### Use AssetReference

```csharp
using UnityEngine.AddressableAssets;

public class EnemySpawner : MonoBehaviour {
    // ✅ Assign in Inspector (drag & drop)
    public AssetReference enemyPrefab;

    async void SpawnEnemy() {
        AsyncOperationHandle<GameObject> handle = enemyPrefab.InstantiateAsync();
        await handle.Task;

        GameObject enemy = handle.Result;
        // Use enemy...

        enemyPrefab.ReleaseInstance(enemy);
    }
}
```

---

<!-- 中文翻译 -->
## Scenes

<!-- 中文翻译 -->
### Load Addressable Scene

```csharp
using UnityEngine.SceneManagement;

async void LoadScene() {
    AsyncOperationHandle<SceneInstance> handle = Addressables.LoadSceneAsync("MainMenu", LoadSceneMode.Additive);
    await handle.Task;

    SceneInstance sceneInstance = handle.Result;
    // Scene loaded

    // Unload scene
    await Addressables.UnloadSceneAsync(handle).Task;
}
```

---

<!-- 常见模式 -->
## Common Patterns

<!-- 中文翻译 -->
### Lazy Loading (Load on Demand)

```csharp
Dictionary<string, AsyncOperationHandle<GameObject>> loadedAssets = new();

async Task<GameObject> GetAsset(string key) {
    if (!loadedAssets.ContainsKey(key)) {
        var handle = Addressables.LoadAssetAsync<GameObject>(key);
        await handle.Task;
        loadedAssets[key] = handle;
    }
    return loadedAssets[key].Result;
}
```

---

<!-- 中文翻译 -->
### Cleanup on Scene Unload

```csharp
void OnDestroy() {
    // Release all handles
    foreach (var handle in loadedAssets.Values) {
        Addressables.Release(handle);
    }
    loadedAssets.Clear();
}
```

---

<!-- 中文翻译 -->
## Content Catalog Updates (Live Updates)

<!-- 中文翻译 -->
### Check for Catalog Updates

```csharp
async void CheckForUpdates() {
    AsyncOperationHandle<List<string>> handle = Addressables.CheckForCatalogUpdates();
    await handle.Task;

    if (handle.Result.Count > 0) {
        Debug.Log("Updates available");
        await Addressables.UpdateCatalogs(handle.Result).Task;
    }

    Addressables.Release(handle);
}
```

---

<!-- 性能提示 -->
## Performance Tips

- **Preload** frequently used assets at startup
- **Release** assets immediately when not needed
- Use **labels** to batch-load related assets
- **Cache** remote content for offline use

---

<!-- 调试 -->
## Debugging

<!-- 中文翻译 -->
### Addressables Event Viewer

`Window > Asset Management > Addressables > Event Viewer`

- Shows all load/release operations
- Memory usage per asset
- Reference counts

<!-- 中文翻译 -->
### Addressables Profiler

`Window > Asset Management > Addressables > Profiler`

- Real-time asset usage
- Bundle loading stats

---

<!-- 中文翻译 -->
## Migration from Resources

```csharp
// ❌ OLD: Resources.Load (synchronous, blocks frame)
GameObject prefab = Resources.Load<GameObject>("Enemies/Goblin");

// ✅ NEW: Addressables (async, non-blocking)
var handle = await Addressables.LoadAssetAsync<GameObject>("Enemies/Goblin").Task;
GameObject prefab = handle.Result;
```

---

<!-- 来源 -->
## Sources
- https://docs.unity3d.com/Packages/com.unity.addressables@2.0/manual/index.html
- https://learn.unity.com/tutorial/addressables
