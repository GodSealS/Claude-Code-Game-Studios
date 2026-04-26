# Cocos Creator — Audio Module / Cocos Creator音频模块


> **中文翻译**：本文档为Cocos Creator引擎参考文档。所有代码示例和技术术语保持英文原文。

Last verified: 2026-04-25

<!-- 核心类型 -->
## Core Types

| Type | Purpose |
|------|---------|
| `AudioSource` | Component that plays `AudioClip`s |
| `AudioClip` | Audio asset (mp3, ogg, wav) |
| `AudioManager` (custom) | Common pattern for BGM/SFX management |

<!-- 常见操作 -->
## Common Operations

```typescript
import { AudioSource, AudioClip } from 'cc';

// Play one-shot SFX
this.getComponent(AudioSource).playOneShot(this.explosionClip);

// Loop BGM
const bgm = this.node.getComponent(AudioSource);
bgm.clip = this.bgmClip;
bgm.loop = true;
bgm.play();

// Volume control
bgm.volume = 0.5; // 0.0 - 1.0
```

<!-- 中文翻译 -->
## WeChat Mini Game Notes

- WebAudio context may suspend; resume on first user touch
- Prefer short clips for SFX; streaming for long BGM
- `AudioSource` component handles platform differences

<!-- 陷阱 -->
## Pitfalls

- WRONG: Creating `AudioSource` per SFX
- RIGHT: Pool `AudioSource` components or use `playOneShot()`
- WRONG: Loading large audio via `resources.load()`
- RIGHT: Use asset bundles; compress to .ogg where possible
