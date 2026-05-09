# Cocos Creator — Breaking Changes

Last verified: 2026-04-25

## 3.6 → 3.7

### Rendering Pipeline
- **Change**: Introduction of Custom Render Pipeline (CRP) as experimental
- **Impact**: Projects using built-in forward pipeline remain compatible, but advanced rendering features now require CRP setup
- **Migration**: Enable CRP in Project Settings → Rendering

### Asset Bundle
- **Change**: Asset bundle format version increment
- **Impact**: Old bundles may need rebuild
- **Migration**: Rebuild all asset bundles after upgrade

## 3.7 → 3.8

### Custom Render Pipeline (Stable)
- **Change**: CRP moves from experimental to stable; built-in post-processing framework added
- **Impact**: Projects using custom render pipelines need to update to new CRP API
- **Migration**: Review `rendering.renderPipeline` setting; update custom pipeline assets

### Deferred Rendering
- **Change**: Deferred rendering pipeline introduced for 3D
- **Impact**: New option for high-end 3D projects; not default
- **Migration**: Opt-in via Project Settings; requires compatible hardware

### Material System
- **Change**: Material inspector and shader graph updates
- **Impact**: Some custom shaders may show different inspector layout
- **Migration**: Re-save custom effect assets in editor

## 3.8.2 → 3.8.3

### Asset Management
- **Change**: Asset bundle loading API refinements
- **Impact**: `assetManager.loadBundle()` behavior more strict
- **Migration**: Ensure bundle names match configuration exactly

## 3.8.3 → 3.8.5

### Package Size Optimization
- **Change**: Default project templates restructured for smaller builds
- **Impact**: New projects default to smaller package sizes
- **Migration**: Existing projects can opt into optimizations via Build Panel settings
- **Details**:
  - 2D empty project: ~360KB reduction
  - 3D empty project: ~384KB reduction
  - WeChat Mini Game 2D: ~160KB reduction with compressed engine internal properties

## 3.8.5 → 3.8.6

### Package Size & Internal Property Compression
- **Change**: Added "Compress Engine Internal Properties" option
- **Impact**: Enabling reduces package size by ~160KB
- **Migration**: Enable in Build Panel settings; test thoroughly after enabling

### RichText, Mask, Graphics Performance
- **Change**: RichText/Mask/Graphics rendering optimized for better performance
- **Impact**: No breaking behavior changes, but rendering results may look slightly different
- **Migration**: Visually verify text and mask rendering after upgrade

## 3.8.6 → 3.8.7

### Asset File Extension Change
- **Change**: Built asset file suffix changed from `.cconb` to `.bin`
- **Impact**: Server/CDN configurations that filter by `.cconb` extension will fail
- **Migration**: Update server config to allow `.bin` files; clear CDN cache

### 3D Animation Pre-baked Optimization
- **Change**: Pre-baked skeletal animation no longer computes bone node Transforms
- **Impact**: Up to 57.85% more animated models on-screen (avg), up to 124.49% max
- **Migration**: No migration needed — applies automatically to pre-baked animations

### Sorting2D Component (New)
- **Change**: New `Sorting2D` component for custom 2D render order without node hierarchy changes
- **Impact**: No breaking change — optional new component
- **Migration**: Use `Sorting2D` when you need render order that differs from node hierarchy

### AnimationClip Auto-Merge
- **Change**: Build option to auto-merge AnimationClip files smaller than 16KB
- **Impact**: Reduces file count, improves load speed
- **Migration**: Disabled by default; opt-in via Build Panel → Animation Clip Merge

## 3.8.7 → 3.8.8

### Stability & Bug Fixes
- **Change**: No major new features — focused on bug fixes, performance, and stability
- **Impact**: LTS final version; recommended for production use
- **Migration**: Direct upgrade from any 3.8.x version

### Google Play 16KB Alignment
- **Change**: NDK and dependency libraries updated for Google Play 16KB alignment requirement
- **Impact**: Android builds targeting Google Play must use updated NDK
- **Migration**: Follow official 16KB alignment migration guide provided by Cocos team

## Cross-Version Patterns to Watch

| Pattern | Affected Versions | Mitigation |
|---------|-------------------|------------|
| `@property` decorator changes | 3.7+ | Use `type` parameter explicitly; avoid implicit type inference |
| Physics API sync → async | 3.6+ | Use `PhysicsSystem.instance.raycast()` return patterns carefully |
| UI coordinate system | 3.8+ | `Widget` alignment behaviors slightly changed for nested canvases |
