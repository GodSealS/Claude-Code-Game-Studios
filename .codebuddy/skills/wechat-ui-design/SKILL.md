---
name: /wechat-ui-design
description: Design and implement UI for WeChat Mini Games using Figma/Sketch, Photoshop/Illustrator for assets, and FairyGUI for layout and adaptive design.
agent: wechat-ui-specialist
---

# /wechat-ui-design

Design and implement user interfaces for WeChat Mini Games following platform standards and best practices.

## When to Use

- Creating UI prototypes for a new WeChat Mini Game
- Designing visual assets and sprite sheets
- Building adaptive UI layouts in FairyGUI
- Implementing WeChat design system compliance
- Setting up interaction feedback and animations

## What It Does

1. **Creates design structure** — Figma/Sketch project setup with design tokens
2. **Produces assets** — Sliced images, sprite sheets, icons at multiple resolutions
3. **Builds FairyGUI project** — Components, screens, adaptive layouts
4. **Defines interactions** — Button states, loading states, transitions
5. **Documents specs** — Style guide, naming conventions, export settings

## Usage

```
/wechat-ui-design init [project-name]
/wechat-ui-design assets [screen-name]
/wechat-ui-design fairygui [package-name]
```

## Example

```
/wechat-ui-design init "MyGame"
```

This will:
- Create Figma/Sketch project structure
- Set up design tokens (colors, typography, spacing)
- Define component library (buttons, cards, icons)
- Create screen templates (Home, Game, Shop, Settings)
- Set up WeChat design system compliance

## Output

Creates the following structure:

```
ui-design/
├── figma/
│   ├── design-tokens.json    # Colors, typography, spacing
│   ├── components.fig        # Reusable UI components
│   └── screens.fig           # Screen layouts
├── assets/
│   ├── sliced/               # Individual UI elements
│   │   ├── btn_primary_normal@2x.png
│   │   ├── btn_primary_pressed@2x.png
│   │   └── ...
│   └── spritesheets/         # Texture atlases
│       ├── ui_main.json
│       └── ui_main.png
├── fairygui/
│   ├── assets/
│   │   ├── images/           # Raw assets for FairyGUI
│   │   ├── components/       # Reusable components
│   │   └── packages/         # Organized by feature
│   └── output/               # Compiled packages
│       ├── UI_Main.bin
│       └── UI_Main_atlas0.png
└── docs/
    ├── style-guide.md        # Visual design documentation
    └── naming-conventions.md # Asset and component naming
```

## Design Standards Compliance

- iOS Human Interface Guidelines (touch targets, typography, safe areas)
- WeChat Mini Game design standards (colors, patterns)
- Mobile-first responsive design
- Accessibility considerations (contrast, touch targets)

## FairyGUI Features

- Auto-layout with anchors and stretch
- Controller-based state management
- Virtual lists for performance
- Transition animations
- Multi-resolution support
