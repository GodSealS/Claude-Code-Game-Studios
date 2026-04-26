# Agent Test Spec: wechat-ui-specialist

## Agent Summary / 代理摘要
Domain: WeChat Mini Game UI design and implementation using FairyGUI, responsive data binding (GameState → ViewModel → UI), screen management stack (push/pop/replace), adaptive layouts for portrait-first design, and WeChat-specific UI patterns.
Does NOT own: Gameplay implementation (wechat-minigame-specialist), shader code (wechat-shader-specialist), architecture decisions (wechat-specialist).
Model tier: DeepSeek-V3.2 (default for implementation specialists).
No gate IDs assigned.

---

<!-- 静态断言（结构） -->
## Static Assertions (Structural)

- [ ] `description:` field is present and domain-specific (references FairyGUI, data binding, screen management, adaptive layouts)
- [ ] `allowed-tools:` list includes Read, Write, Edit, Bash, Glob, Grep
- [ ] Model tier is DeepSeek-V3.2 (default for specialists)
- [ ] Agent definition does not claim authority over gameplay or rendering
- [ ] Agent references WeChat-specific UI constraints (portrait-first, touch targets, safe area)

---

## Test Cases / 测试用例

<!-- 中文翻译 -->
### Case 1: In-domain request — FairyGUI component creation
**Input:** "Create a responsive button component in FairyGUI that changes state on touch."
**Expected behavior:**
- Provides complete FairyGUI component definition:
  ```xml
  <!-- Main component XML -->
  <component name="ResponsiveButton" extends="GButton">
    <controller name="state" pages="normal,pressed,disabled">
      <page name="normal"/>
      <page name="pressed"/>
      <page name="disabled"/>
    </controller>
    
    <displayList>
      <image name="bg" src="btn_bg_normal" fill="Scale"/>
      <text name="label" text="Button" fontSize="28" color="#FFFFFF"/>
    </displayList>
    
    <relations>
      <relation target="bg" sideRelation="width,height"/>
      <relation target="label" sideRelation="center,both"/>
    </relations>
  </component>
  ```
- Includes TypeScript controller class:
  ```typescript
  class ResponsiveButton extends fgui.GButton {
    constructor() {
      super();
      this.on(fgui.Event.TOUCH_BEGIN, this.onTouchBegin, this);
      this.on(fgui.Event.TOUCH_END, this.onTouchEnd, this);
    }
    
    private onTouchBegin(): void {
      this.selected = true;
      this.getController('state').selectedPage = 'pressed';
    }
    
    private onTouchEnd(): void {
      this.selected = false;
      this.getController('state').selectedPage = 'normal';
    }
  }
  ```
- Notes WeChat-specific considerations: touch target size (48x48dp), feedback timing
- Emphasizes responsive design for portrait mode (750x1334px reference)

<!-- 中文翻译 -->
### Case 2: Data binding pattern with GameState
**Input:** "Implement a health bar that updates when player health changes in GameState."
**Expected behavior:**
- Provides MVVM-style data binding implementation:
  ```typescript
  // ViewModel that observes GameState
  class HealthViewModel {
    private health: number = 100;
    private listeners: Set<(health: number) => void> = new Set();
    
    constructor() {
      // Subscribe to GameState changes
      GameState.instance.onHealthChanged((health) => {
        this.health = health;
        this.notifyListeners();
      });
    }
    
    getHealth(): number { return this.health; }
    
    addListener(listener: (health: number) => void): () => void {
      this.listeners.add(listener);
      return () => this.listeners.delete(listener);
    }
    
    private notifyListeners(): void {
      this.listeners.forEach(listener => listener(this.health));
    }
  }
  
  // UI Component that binds to ViewModel
  class HealthBar extends fgui.GComponent {
    private bar: fgui.GProgressBar;
    private viewModel: HealthViewModel;
    
    constructor(viewModel: HealthViewModel) {
      super();
      this.viewModel = viewModel;
      
      // Create UI elements
      this.bar = new fgui.GProgressBar();
      this.bar.max = 100;
      this.bar.value = this.viewModel.getHealth();
      this.addChild(this.bar);
      
      // Subscribe to viewModel changes
      this.viewModel.addListener((health) => {
        this.bar.value = health;
        // Visual feedback (color change, pulse animation)
        this.updateBarColor(health);
      });
    }
    
    private updateBarColor(health: number): void {
      if (health < 30) {
        this.bar.color = '#FF4444';
      } else if (health < 70) {
        this.bar.color = '#FFAA44';
      } else {
        this.bar.color = '#44AA44';
      }
    }
  }
  ```
- Emphasizes unidirectional data flow: GameState → ViewModel → UI
- Notes performance considerations: avoid frequent updates, batch UI changes

<!-- 中文翻译 -->
### Case 3: Screen management stack
**Input:** "Implement a screen manager that handles navigation between game screens (menu, gameplay, settings)."
**Expected behavior:**
- Provides Android Activity-style screen management:
  ```typescript
  type ScreenId = 'menu' | 'gameplay' | 'settings' | 'pause' | 'gameover';
  
  class ScreenManager {
    private stack: ScreenId[] = ['menu'];
    private screens: Map<ScreenId, Screen> = new Map();
    
    push(screen: ScreenId, transition?: string): void {
      // Hide current screen
      const current = this.stack[this.stack.length - 1];
      this.screens.get(current)?.onHide();
      
      // Push new screen
      this.stack.push(screen);
      
      // Show new screen with transition
      this.showScreen(screen, transition || 'fade_in');
    }
    
    pop(transition?: string): void {
      if (this.stack.length <= 1) return;
      
      // Hide current screen
      const current = this.stack.pop()!;
      this.screens.get(current)?.onHide();
      
      // Show previous screen
      const previous = this.stack[this.stack.length - 1];
      this.showScreen(previous, transition || 'fade_out');
    }
    
    replace(screen: ScreenId, transition?: string): void {
      const current = this.stack.pop();
      current && this.screens.get(current)?.onHide();
      
      this.stack.push(screen);
      this.showScreen(screen, transition || 'fade_in');
    }
    
    private showScreen(screen: ScreenId, transition: string): void {
      const screenObj = this.screens.get(screen) || this.createScreen(screen);
      screenObj.onShow(transition);
    }
    
    private createScreen(screen: ScreenId): Screen {
      let screenObj: Screen;
      switch (screen) {
        case 'menu': screenObj = new MenuScreen(); break;
        case 'gameplay': screenObj = new GameplayScreen(); break;
        case 'settings': screenObj = new SettingsScreen(); break;
        default: throw new Error(`Unknown screen: ${screen}`);
      }
      
      screenObj.onCreate();
      this.screens.set(screen, screenObj);
      return screenObj;
    }
  }
  
  interface Screen {
    onCreate(): void;
    onShow(transition: string): void;
    onHide(): void;
    onDestroy(): void;
  }
  ```
- Includes lifecycle management: onCreate, onShow, onHide, onDestroy
- Notes memory management: screens should release resources onHide/destroy
- Considers WeChat-specific navigation patterns (back button, swipe gestures)

<!-- 中文翻译 -->
### Case 4: Portrait-first design system
**Input:** "Design a UI layout for WeChat Mini Games that works in portrait mode on various screen sizes."
**Expected behavior:**
- Provides portrait-first design system:
  ```typescript
  class PortraitLayoutSystem {
    private designWidth: number = 750;
    private designHeight: number = 1334;
    
    // Screen zones (for safe area handling)
    readonly zones = {
      statusBar: { top: 0, height: 40 }, // iPhone notch area
      content: { top: 40, bottom: 100 }, // Main content
      action: { bottom: 0, height: 100 } // Touch actions
    };
    
    // Scale factor for different screen sizes
    getScaleFactor(screenWidth: number, screenHeight: number): number {
      return Math.min(
        screenWidth / this.designWidth,
        screenHeight / this.designHeight
      );
    }
    
    // Create safe area-inset UI
    createSafeAreaContainer(): fgui.GComponent {
      const container = new fgui.GComponent();
      
      // Respect safe area (notch handling)
      const { safeArea } = wx.getSystemInfoSync();
      const safeTop = safeArea.top;
      const safeBottom = screenHeight - safeArea.bottom;
      
      container.setPosition(0, safeTop);
      container.setSize(screenWidth, screenHeight - safeTop - safeBottom);
      
      return container;
    }
    
    // Minimum touch target size (48dp standard)
    ensureTouchTarget(element: fgui.GObject, scaleFactor: number): void {
      const minSize = 48 * scaleFactor;
      if (element.width < minSize) element.width = minSize;
      if (element.height < minSize) element.height = minSize;
    }
  }
  ```
- Defines design canvas: 750x1334px (@2x resolution)
- Includes safe area handling for notched phones
- Emphasizes minimum touch target size (48dp for accessibility)
- Provides responsive scaling patterns

<!-- 中文翻译 -->
### Case 5: Cross-platform input handling
**Input:** "Handle both touch and keyboard input for PC WeChat and mobile WeChat."
**Expected behavior:**
- Provides unified input handling for WeChat Mini Games:
  ```typescript
  class UnifiedInputHandler {
    private touchEnabled: boolean = true;
    private keyboardEnabled: boolean = false;
    
    constructor() {
      // Detect platform
      const { platform } = wx.getSystemInfoSync();
      this.keyboardEnabled = platform === 'windows' || platform === 'mac';
      
      // Touch events
      wx.onTouchStart((e) => this.handleTouchStart(e));
      wx.onTouchMove((e) => this.handleTouchMove(e));
      wx.onTouchEnd((e) => this.handleTouchEnd(e));
      
      // Keyboard events (PC WeChat)
      if (this.keyboardEnabled) {
        wx.onKeyDown((e) => this.handleKeyDown(e));
        wx.onKeyUp((e) => this.handleKeyUp(e));
      }
    }
    
    // Convert touch to normalized coordinates
    private normalizeTouch(touch: any, canvas: any): { x: number, y: number } {
      const rect = canvas.getBoundingClientRect();
      const scale = canvas.width / rect.width;
      
      return {
        x: (touch.clientX - rect.left) * scale,
        y: (touch.clientY - rect.top) * scale
      };
    }
    
    // Map keyboard keys to virtual buttons
    private mapKeyToVirtualButton(keyCode: number): string | null {
      const mapping = {
        87: 'up',    // W
        65: 'left',  // A
        83: 'down',  // S
        68: 'right', // D
        32: 'jump',  // Space
        13: 'select' // Enter
      };
      
      return mapping[keyCode] || null;
    }
  }
  ```
- Handles both touch (mobile) and keyboard (PC WeChat) input
- Provides normalized coordinate system independent of screen resolution
- Includes virtual button mapping for cross-platform consistency
- Notes performance: minimize event handlers, use event pooling

<!-- 中文翻译 -->
### Case 6: UI performance standards
**Input:** "Our UI is causing frame drops. How do we optimize it for WeChat Mini Games?"
**Expected behavior:**
- Provides WeChat-specific UI optimization strategies:
  1. **FairyGUI optimizations:**
     - Use `fgui.UIPackage.addPackage()` for lazy loading
     - Reuse UI components with `fgui.GComponent.pool`
     - Minimize dynamic creation/destruction
  2. **Rendering optimizations:**
     - Reduce overdraw: disable transparent backgrounds when not needed
     - Batch draw calls: group UI elements by material/texture
     - Use `fgui.GObject.cacheAsBitmap` for complex static UI
  3. **JavaScript optimizations:**
     - Throttle UI updates: batch changes per frame
     - Use event delegation instead of individual event handlers
     - Avoid frequent layout recalculations
  4. **Memory management:**
     - Unload unused UI packages when changing screens
     - Pool frequently used UI elements
     - Monitor with `wx.getPerformance()` for memory leaks
- Includes performance budget: UI < 2ms CPU time per frame on mid-range devices
- Recommends profiling tools: WeChat DevTools Performance panel

<!-- 中文翻译 -->
### Case 7: Accessibility design
**Input:** "Make our UI accessible for visually impaired users."
**Expected behavior:**
- Provides WeChat Mini Game accessibility guidelines:
  1. **Touch target size:** Minimum 48dp x 48dp
  2. **Contrast ratio:** 4.5:1 for normal text, 3:1 for large text
  3. **Color independence:** Information not conveyed by color alone
  4. **Screen reader compatibility:** Semantic UI structure for assistive technologies
  5. **Focus indicators:** Visible focus for keyboard navigation
- Includes implementation patterns:
  ```typescript
  class AccessibleButton extends fgui.GButton {
    constructor() {
      super();
      this.touchable = true;
      
      // Ensure minimum touch target
      if (this.width < 96 || this.height < 96) {
        this.setSize(Math.max(this.width, 96), Math.max(this.height, 96));
      }
      
      // High contrast mode support
      wx.onThemeChange(() => {
        this.updateContrastColors();
      });
    }
    
    private updateContrastColors(): void {
      const { theme } = wx.getSystemInfoSync();
      if (theme === 'dark') {
        this.color = '#FFFFFF';
        this.strokeColor = '#000000';
      } else {
        this.color = '#000000';
        this.strokeColor = '#FFFFFF';
      }
    }
  }
  ```
- Notes regulatory requirements for Chinese market (残疾人保障法)
- Emphasizes inclusive design as a core principle

<!-- 中文翻译 -->
### Case 8: Figma/Sketch to FairyGUI workflow
**Input:** "How do we convert our Figma designs to FairyGUI components?"
**Expected behavior:**
- Provides design-to-code workflow for WeChat Mini Games:
  1. **Export assets:** Use Figma/Sketch export with @2x resolution (750px width reference)
  2. **Sprite packing:** Use TexturePacker with FairyGUI plugin
  3. **Component mapping:**
     - Figma frames → FairyGUI components
     - Figma auto-layout → FairyGUI relations
     - Figma components → FairyGUI movieclips/animations
  4. **FairyGUI plugin integration:**
     - Export directly to .fgui/.bin format
     - Maintain design token consistency (colors, typography, spacing)
  5. **Handoff process:**
     - Design system alignment (design tokens → CSS variables → FairyGUI properties)
     - Responsive breakpoints mapping (mobile → desktop)
     - Interaction state mapping (hover, active, disabled)
- Includes best practices for designer-developer collaboration:
  - Shared component library between Figma and FairyGUI
  - Automated export pipelines
  - Design token synchronization

---

## Protocol Compliance / 协议合规

- [ ] Stays within declared domain (FairyGUI, data binding, screen management, adaptive layouts)
- [ ] Redirects gameplay implementation to wechat-minigame-specialist
- [ ] Redirects shader requests to wechat-shader-specialist
- [ ] Redirects architecture decisions to wechat-specialist
- [ ] Enforces portrait-first design principles for WeChat Mini Games
- [ ] Implements unidirectional data flow (GameState → ViewModel → UI)
- [ ] Considers touch target accessibility (48dp minimum)
- [ ] Provides concrete FairyGUI code examples with TypeScript integration

---

<!-- 覆盖说明 -->
## Coverage Notes

- FairyGUI component creation (Case 1) demonstrates practical UI implementation skills
- Data binding (Case 2) shows understanding of MVVM patterns in WeChat environment
- Screen management (Case 3) validates complex UI navigation implementation
- Portrait-first design (Case 4) covers WeChat-specific layout constraints
- Cross-platform input (Case 5) handles PC vs mobile WeChat differences
- Performance optimization (Case 6) confirms mobile UI performance awareness
- Accessibility (Case 7) demonstrates inclusive design principles
- Design-to-code workflow (Case 8) bridges design and development processes

<!-- 中文翻译标记 / Chinese translation marker -->
