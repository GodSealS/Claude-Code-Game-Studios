# UI Creation Workflow

## Overall Flow

```
Determine design resolution → Create Canvas → Add Widget adaptation layer → Layout containers →
Add UI components → Set styles / properties → Script interaction → Multi-resolution testing
```

## Step 1: Create Design Resolution Canvas

```json
// Get project settings
{ "tool": "project_manage", "arguments": { "action": "getSettings" } }

// Get scene hierarchy
{ "tool": "scene_hierarchy", "arguments": { "action": "get", "includeComponents": true } }

// Create Canvas node (usually pre-existing in scene)
{ "tool": "node_lifecycle", "arguments": { "action": "create", "name": "GameCanvas", "nodeType": "2DNode", "parentUuid": "scene-root" } }
{ "tool": "component_manage", "arguments": { "action": "add", "nodeUuid": "...", "componentType": "cc.Canvas" } }
```

## Step 2: Design Resolution & Widget Adaptation

**Core adaptation principles**:
- Set **design resolution** (e.g., 1920×1080) → Project Settings `Fit Height` or `Fit Width`
- Add `cc.Widget` component to all UI root nodes for alignment
- Use nested Widgets for relative layout

**Widget alignment schemes**:
| UI Position | Widget Settings |
|-------------|----------------|
| Top status bar | Top=0, enable Top + Left + Right |
| Bottom navigation bar | Bottom=0, enable Bottom + Left + Right |
| Centered dialog | No margin, enable HorizontalCenter + VerticalCenter |
| Top-left back button | Top=20, Left=20, enable Top + Left |
| Bottom-right action button | Bottom=20, Right=20, enable Bottom + Right |
| Fullscreen overlay | Top=0, Bottom=0, Left=0, Right=0 |

**Widget setup example**:
```json
{ "tool": "component_manage", "arguments": { "action": "add", "nodeUuid": "uiNode", "componentType": "cc.Widget" } }
{ "tool": "set_component_property", "arguments": {
  "action": "batchSet",
  "nodeUuid": "uiNode",
  "componentType": "cc.Widget",
  "properties": {
    "isAlignTop": true, "top": 0,
    "isAlignLeft": true, "left": 0,
    "isAlignRight": true, "right": 0
  }
}}
```

## Step 3: Layout Auto-Layout

**Layout type selection**:
| Use Case | Layout Type | Common Config |
|----------|------------|---------------|
| Horizontal list | HORIZONTAL | SpacingX=10, Padding=15 |
| Vertical list | VERTICAL | SpacingY=10, Padding=15 |
| Grid layout | GRID | StartAxis, CellSize, Spacing |
| Manual placement | NONE | Position children manually |

**Create a list container with Layout**:
```json
// 1. Create container node
{ "tool": "node_lifecycle", "arguments": { "action": "create", "name": "ItemList", "nodeType": "2DNode", "parentUuid": "parent" } }

// 2. Add Layout + Widget
{ "tool": "component_manage", "arguments": { "action": "add", "nodeUuid": "...", "componentType": "cc.Layout" } }
{ "tool": "set_component_property", "arguments": {
  "action": "set",
  "nodeUuid": "...",
  "componentType": "cc.Layout",
  "property": "type",
  "value": "VERTICAL"
}}
{ "tool": "set_component_property", "arguments": {
  "action": "batchSet",
  "nodeUuid": "...",
  "componentType": "cc.Layout",
  "properties": { "spacingY": 10, "paddingLeft": 20, "paddingRight": 20, "paddingTop": 10, "paddingBottom": 10 }
}}
```

## Step 4: UI Component Creation & Configuration

**Common UI component quick reference**:

**Button**:
```json
[
  { "tool": "node_lifecycle", "arguments": { "action": "create", "name": "BtnStart", "nodeType": "2DNode", "parentUuid": "parent", "components": ["cc.Button"] } },
  { "tool": "set_component_property", "arguments": { "action": "batchSet", "nodeUuid": "...", "componentType": "cc.Button", "properties": { "interactable": true, "transition": "SCALE", "zoomScale": 0.95 } } },
  // Add Label child to button
  { "tool": "node_lifecycle", "arguments": { "action": "create", "name": "Label", "nodeType": "2DNode", "parentUuid": "...", "components": ["cc.Label"] } },
  { "tool": "set_component_property", "arguments": { "action": "batchSet", "nodeUuid": "...", "componentType": "cc.Label", "properties": { "string": "Start Game", "fontSize": 36, "color": { "r": 255, "g": 255, "b": 255, "a": 255 } } } }
]
```

**ScrollView**:
```json
[
  { "tool": "node_lifecycle", "arguments": { "action": "create", "name": "ScrollView", "nodeType": "2DNode", "parentUuid": "parent", "components": ["cc.ScrollView"] } },
  { "tool": "set_component_property", "arguments": { "action": "batchSet", "nodeUuid": "...", "componentType": "cc.ScrollView", "properties": { "horizontal": false, "vertical": true, "inertia": true, "elastic": true, "brake": 0.75 } } }
  // ScrollView auto-creates view/content child structure
]
```

**ProgressBar (Health/Progress bar)**:
```json
[
  { "tool": "node_lifecycle", "arguments": { "action": "create", "name": "HealthBar", "nodeType": "2DNode", "parentUuid": "parent", "components": ["cc.ProgressBar"] } },
  { "tool": "set_component_property", "arguments": { "action": "batchSet", "nodeUuid": "...", "componentType": "cc.ProgressBar", "properties": { "progress": 1.0, "mode": "HORIZONTAL", "reverse": false } } }
]
```

**Toggle (Switch / Checkbox)**:
```json
[
  { "tool": "node_lifecycle", "arguments": { "action": "create", "name": "ToggleMusic", "nodeType": "2DNode", "parentUuid": "parent", "components": ["cc.Toggle"] } },
  { "tool": "set_component_property", "arguments": { "action": "set", "nodeUuid": "...", "componentType": "cc.Toggle", "property": "isChecked", "value": true } }
]
```

**Slider**:
```json
[
  { "tool": "node_lifecycle", "arguments": { "action": "create", "name": "VolumeSlider", "nodeType": "2DNode", "parentUuid": "parent", "components": ["cc.Slider"] } },
  { "tool": "set_component_property", "arguments": { "action": "batchSet", "nodeUuid": "...", "componentType": "cc.Slider", "properties": { "progress": 0.8, "direction": "LeftToRight" } } }
]
```

## Step 5: UI Hierarchy Best Practices

```
Canvas (cc.Canvas)
├── Background (cc.Sprite + cc.Widget: fullscreen)
├── UIRoot (cc.Widget: fullscreen)
│   ├── TopBar (cc.Widget: top-aligned)
│   │   ├── BtnBack (cc.Button + cc.Widget: top-left)
│   │   ├── Title (cc.Label + cc.Widget: centered)
│   │   └── BtnSettings (cc.Button + cc.Widget: top-right)
│   ├── MiddleArea
│   │   └── ContentList (cc.Layout: VERTICAL)
│   │       └── Item (prefab) × N
│   ├── BottomBar (cc.Widget: bottom-aligned)
│   │   └── TabButtons (cc.Layout: HORIZONTAL)
│   └── PopupLayer (fullscreen overlay)
│       └── DialogPanel (cc.Widget: centered)
└── DebugInfo (cc.Label, dev debugging)
```

## UI Common Issues & Solutions

| Issue | Cause | Solution |
|-------|-------|----------|
| UI offsets on different screens | No Widget used | Add Widget to root node and set alignment |
| Scroll list not displaying | Content node missing Layout | Add Layout component to content |
| Button clicks not responding | Missing BlockInputEvents | Add BlockInputEvents under Canvas |
| Blurry text | Font size too small / non-integer | Use integer fontSize, use BMFont |
| High DrawCall count | Atlases not merged | Use SpriteAtlas for batching |
