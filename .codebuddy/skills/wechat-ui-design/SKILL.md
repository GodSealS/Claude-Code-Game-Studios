---
name: /wechat-ui-design
description: Design and implement UI for WeChat Mini Games using Figma/Sketch, Photoshop/Illustrator for assets, FairyGUI for layout and adaptive design, with data binding, screen management, and portrait-first mobile optimization. / 使用 Figma/Sketch 设计微信小游戏 UI，Photoshop/Illustrator 处理资产，FairyGUI 进行布局和自适应设计，包含数据绑定、屏幕管理和竖屏优先的移动端优化。
agent: wechat-ui-specialist
---

# /wechat-ui-design

Design and implement user interfaces for WeChat Mini Games following platform standards, with data binding, screen management, portrait-first layout, and performance optimization. / 为微信小游戏设计和实现用户界面，遵循平台标准，包含数据绑定、屏幕管理、竖屏优先布局和性能优化。

## When to Use / 何时使用

- Creating UI prototypes for a new WeChat Mini Game / 为新微信小游戏创建 UI 原型
- Designing visual assets and sprite sheets / 设计视觉资产和精灵图集
- Building adaptive UI layouts in FairyGUI with data binding / 在 FairyGUI 中构建具有数据绑定的自适应 UI 布局
- Implementing WeChat design system compliance / 实现微信设计系统合规性
- Setting up interaction feedback and animations / 设置交互反馈和动画
- Creating screen navigation stack / 创建屏幕导航堆栈
- Optimizing UI performance (virtual lists, object pooling) / 优化 UI 性能（虚拟列表、对象池）
- Implementing accessibility features / 实现可访问性功能

## What It Does / 功能

1. **Creates design structure** — Figma/Sketch project setup with design tokens / **创建设计结构** — 带有设计令牌的 Figma/Sketch 项目设置
2. **Produces assets** — Sliced images, sprite sheets, icons at multiple resolutions / **生成资产** — 切片图像、精灵图集、多分辨率图标
3. **Builds FairyGUI project** — Components, screens, adaptive layouts with data binding / **构建 FairyGUI 项目** — 组件、屏幕、具有数据绑定的自适应布局
4. **Defines interactions** — Button states, loading states, transitions, screen navigation / **定义交互** — 按钮状态、加载状态、过渡效果、屏幕导航
5. **Documents specs** — Style guide, naming conventions, export settings / **文档规范** — 风格指南、命名约定、导出设置
6. **Sets up data binding** — GameState → ViewModel → UI reactive pipeline / **设置数据绑定** — GameState → ViewModel → UI 响应式管道
7. **Creates screen manager** — Stack-based navigation with transitions and lifecycle / **创建屏幕管理器** — 基于堆栈的导航，具有过渡效果和生命周期

## Usage / 用法

```
/wechat-ui-design init [project-name]
/wechat-ui-design assets [screen-name]
/wechat-ui-design fairygui [package-name]
/wechat-ui-design binding [component-name]
/wechat-ui-design screen [screen-name]
```

## Example / 示例

```
/wechat-ui-design init "MyGame"
```

This will: / 这将：
- Create Figma/Sketch project structure / 创建 Figma/Sketch 项目结构
- Set up design tokens (colors, typography, spacing) / 设置设计令牌（颜色、排版、间距）
- Define component library (buttons, cards, icons) / 定义组件库（按钮、卡片、图标）
- Create screen templates (Home, Game, Shop, Settings) / 创建屏幕模板（主页、游戏、商店、设置）
- Set up WeChat design system compliance / 设置微信设计系统合规性
- Create data binding infrastructure / 创建数据绑定基础设施
- Set up screen navigation stack / 设置屏幕导航堆栈

## Output / 输出

Creates the following structure: / 创建以下结构：

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

## Design Standards Compliance / 设计标准合规性

- iOS Human Interface Guidelines (touch targets, typography, safe areas) / iOS 人机界面指南（触摸目标、排版、安全区域）
- WeChat Mini Game design standards (colors, patterns) / 微信小游戏设计标准（颜色、模式）
- Mobile-first responsive design / 移动优先的响应式设计
- **Portrait-first layout** — All screens designed for vertical orientation by default / **竖屏优先布局** — 所有屏幕默认设计为垂直方向
- **Touch targets** — Minimum 48x48dp for all interactive elements / **触摸目标** — 所有交互元素最小 48x48dp
- **Safe area** — Auto-adapt for notch, home indicator, and status bar / **安全区域** — 自动适配刘海屏、主页指示器和状态栏
- Accessibility considerations (contrast, touch targets, screen reader support) / 可访问性考虑（对比度、触摸目标、屏幕阅读器支持）

<!-- FairyGUI 功能 -->
## FairyGUI Features

- Auto-layout with anchors and stretch (portrait-optimized)
- Controller-based state management
- Virtual lists for performance (< 2ms CPU budget per frame)
- Transition animations
- Multi-resolution support
- **Data binding** — Reactive GameState → ViewModel → UI pipeline
- **Screen navigation** — Stack-based with push/pop and transitions
- **Object pooling** — Recycle UI elements instead of create/destroy

<!-- 数据绑定系统 -->
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

## Screen Management / 屏幕管理

```typescript
// Stack-based navigation / 基于堆栈的导航
screenManager.push('ShopScreen', { category: 'weapons' });
screenManager.pop(); // Return to previous screen / 返回上一个屏幕
screenManager.replace('GameOverScreen', { score: 1000 });

// Screen lifecycle / 屏幕生命周期
interface IScreen {
  onEnter(params?: Record<string, any>): void;
  onExit(): void;
  onPause(): void;  // When another screen pushed on top / 当另一个屏幕推到顶部时
  onResume(): void; // When top screen popped / 当顶部屏幕弹出时
}
```

## Performance Standards / 性能标准

| Metric | Budget | Notes |
|--------|--------|-------|
| UI CPU time per frame | < 2ms | Measured on mid-range device / 在中档设备上测量 |
| Virtual list item render | < 0.5ms | Per visible item / 每个可见项 |
| Screen transition | < 300ms | Including animation / 包括动画 |
| Texture memory (UI) | < 8MB | All UI atlases combined / 所有 UI 图集合计 |
| Draw calls per screen | < 10 | Batch by atlas / 按图集批处理 |
