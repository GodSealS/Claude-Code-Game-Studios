---
name: /wechat-ui-design
description: Design and implement UI for WeChat Mini Games using Figma/Sketch, Photoshop/Illustrator for assets, FairyGUI for layout and adaptive design, with data binding, screen management, and portrait-first mobile optimization. / 使用 Figma/Sketch 设计微信小游戏 UI，Photoshop/Illustrator 处理资产，FairyGUI 进行布局和自适应设计，包含数据绑定、屏幕管理和竖屏优先的移动端优化。
agent: wechat-ui-specialist
---

# /wechat-ui-design

Design and implement user interfaces for WeChat Mini Games following platform standards, with data binding, screen management, portrait-first layout, and performance optimization.

## When to Use

- Creating UI prototypes for a new WeChat Mini Game
- Designing visual assets and sprite sheets
- Building adaptive UI layouts in FairyGUI with data binding
- Implementing WeChat design system compliance
- Setting up interaction feedback and animations
- Creating screen navigation stack
- Optimizing UI performance (virtual lists, object pooling)
- Implementing accessibility features

## What It Does

1. **Creates design structure** — Figma/Sketch project setup with design tokens
2. **Produces assets** — Sliced images, sprite sheets, icons at multiple resolutions
3. **Builds FairyGUI project** — Components, screens, adaptive layouts with data binding
4. **Defines interactions** — Button states, loading states, transitions, screen navigation
5. **Documents specs** — Style guide, naming conventions, export settings
6. **Sets up data binding** — GameState → ViewModel → UI reactive pipeline
7. **Creates screen manager** — Stack-based navigation with transitions and lifecycle

## Usage

```
/wechat-ui-design init [project-name]
/wechat-ui-design assets [screen-name]
/wechat-ui-design fairygui [package-name]
/wechat-ui-design binding [component-name]
/wechat-ui-design screen [screen-name]
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
- Create data binding infrastructure
- Set up screen navigation stack

## Output

Creates the following structure:

```
ui-design/
├── figma/
│   ├── design-tokens.json    # Colors, typography, spacing
│   ├── components.fig        # Reusable UI components
│   └── screens.fig           # Screen layouts (portrait-first)
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
├── binding/
│   ├── ViewModel.ts          # Base ViewModel class
│   ├── DataBinding.ts        # Reactive data binding system
│   └── GameViewModel.ts     # Game-specific ViewModel
├── screens/
│   ├── ScreenManager.ts      # Stack-based screen navigation
│   ├── ScreenBase.ts         # Base screen with lifecycle
│   └── transitions/          # Screen transition effects
└── docs/
    ├── style-guide.md        # Visual design documentation
    ├── naming-conventions.md # Asset and component naming
    └── accessibility.md      # Accessibility compliance guide
```

## Design Standards Compliance

- iOS Human Interface Guidelines (touch targets, typography, safe areas)
- WeChat Mini Game design standards (colors, patterns)
- Mobile-first responsive design
- **Portrait-first layout** — All screens designed for vertical orientation by default
- **Touch targets** — Minimum 48x48dp for all interactive elements
- **Safe area** — Auto-adapt for notch, home indicator, and status bar
- Accessibility considerations (contrast, touch targets, screen reader support)

## FairyGUI Features

- Auto-layout with anchors and stretch (portrait-optimized)
- Controller-based state management
- Virtual lists for performance (< 2ms CPU budget per frame)
- Transition animations
- Multi-resolution support
- **Data binding** — Reactive GameState → ViewModel → UI pipeline
- **Screen navigation** — Stack-based with push/pop and transitions
- **Object pooling** — Recycle UI elements instead of create/destroy

## Data Binding System

```typescript
// Reactive data binding pattern
class GameViewModel extends ViewModel {
  @observable score: number = 0;
  @observable health: number = 100;
  @observable level: string = '1-1';
}

// Bind to FairyGUI component
viewModel.bind(scoreText, 'score', (v: number) => v.toString());
viewModel.bind(healthBar, 'health', (v: number) => v / 100);
```

## Screen Management

```typescript
// Stack-based navigation
screenManager.push('ShopScreen', { category: 'weapons' });
screenManager.pop(); // Return to previous screen
screenManager.replace('GameOverScreen', { score: 1000 });

// Screen lifecycle
interface IScreen {
  onEnter(params?: Record<string, any>): void;
  onExit(): void;
  onPause(): void;  // When another screen pushed on top
  onResume(): void; // When top screen popped
}
```

## Performance Standards

| Metric | Budget | Notes |
|--------|--------|-------|
| UI CPU time per frame | < 2ms | Measured on mid-range device |
| Virtual list item render | < 0.5ms | Per visible item |
| Screen transition | < 300ms | Including animation |
| Texture memory (UI) | < 8MB | All UI atlases combined |
| Draw calls per screen | < 10 | Batch by atlas |
