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

## Cross-Version Patterns to Watch

| Pattern | Affected Versions | Mitigation |
|---------|-------------------|------------|
| `@property` decorator changes | 3.7+ | Use `type` parameter explicitly; avoid implicit type inference |
| Physics API sync → async | 3.6+ | Use `PhysicsSystem.instance.raycast()` return patterns carefully |
| UI coordinate system | 3.8+ | `Widget` alignment behaviors slightly changed for nested canvases |
