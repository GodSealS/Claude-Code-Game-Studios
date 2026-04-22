---
name: setup-wechat-minigame
description: "Initializes a WeChat Mini Game project structure, configures platform-specific settings, and sets up the development environment. / 初始化微信小游戏项目结构，配置平台特定设置，并搭建开发环境。"
argument-hint: "[game-name]"
user-invocable: true
allowed-tools: Read, Glob, Grep, Write, Edit, AskUserQuestion
---

# WeChat Mini Game Project Setup

This skill initializes a complete WeChat Mini Game project structure. It creates all necessary configuration files, directory structure, and boilerplate code.

---

## Phase 1: Validate and Gather Information

### Check Existing Setup

First, check if a WeChat Mini Game project already exists:

```bash
# Check for existing WeChat Mini Game files
Glob("miniprogram/game.json")
Glob("miniprogram/app.json")
Glob("src/wechat/**/*")
```

If WeChat Mini Game files exist, inform the user and offer to:
- Update existing configuration
- Migrate from another engine/framework
- Start fresh (backup existing first)

### Ask User Questions

Use `AskUserQuestion` to gather required information:

**Prompt**: "Let's set up your WeChat Mini Game project. I need a few details:"

**Questions**:

1. **Game Engine/Framework**:
   - `Pure WeChat API` — Use raw WeChat Mini Game APIs (Canvas 2D/WebGL)
   - `Cocos Creator` — Use Cocos Creator with WeChat adapter
   - `LayaAir` — Use LayaAir Engine
   - `Phaser` — Use Phaser with WeChat plugin
   - `Unity (WebGL)` — Export Unity WebGL for WeChat
   - `Godot (Web Export)` — Export Godot HTML5 for WeChat

2. **Language**:
   - `JavaScript (ES6+)`
   - `TypeScript` (recommended)

3. **Cloud Base (Backend)**:
   - `Yes` — Enable WeChat Cloud Base (serverless database + functions)
   - `No` — Use external backend or no backend

4. **Game Name**: (text input)
   - Must be unique in WeChat ecosystem
   - 4-30 characters recommended

5. **Orientation**:
   - `Portrait` — Vertical (most common for mobile games)
   - `Landscape` — Horizontal

---

## Phase 2: Create Project Structure

### Directory Structure

Create the following directory structure:

```
miniprogram/                    # WeChat Mini Game root
├── game.js                     # Entry point
├── game.json                   # Game config
├── app.json                    # App config (subpackages, permissions)
├── project.config.json         # WeChat DevTools config
├── js/
│   ├── main.js                 # Main game class
│   ├── Game.js                 # Core game logic
│   ├── scenes/                 # Game scenes
│   │   ├── BootScene.js
│   │   ├── MenuScene.js
│   │   └── GameScene.js
│   ├── managers/               # Game managers
│   │   ├── AudioManager.js
│   │   ├── InputManager.js
│   │   └── StorageManager.js
│   ├── utils/                  # Utilities
│   │   ├── constants.js
│   │   └── helpers.js
│   └── libs/                   # Third-party libraries
├── images/                     # Image assets
├── audio/                      # Audio assets
├── subpackages/                # Dynamic subpackages (empty initially)
└── open-data/                  # Open data context (leaderboards)
    └── index.js

cloudbase/                      # Cloud Base (if enabled)
└── cloudfunctions/
    └── config.json
```

### Configuration Files

#### game.json

```json
{
  "deviceOrientation": "{{orientation}}",
  "showStatusBar": false,
  "networkTimeout": {
    "request": 5000,
    "connectSocket": 5000,
    "uploadFile": 5000,
    "downloadFile": 5000
  },
  "subpackages": [],
  "plugins": {},
  "openDataContext": "open-data"
}
```

#### app.json

```json
{
  "pages": [],
  "window": {
    "backgroundColor": "#000000"
  },
  "subpackages": [
    {
      "name": "levelPack1",
      "root": "subpackages/levelPack1/"
    }
  ],
  "permission": {
    "scope.writePhotosAlbum": {
      "desc": "用于保存游戏截图到相册"
    }
  },
  "requiredBackgroundModes": ["audio"]
}
```

#### project.config.json

```json
{
  "description": "{{gameName}} WeChat Mini Game",
  "packOptions": {
    "ignore": [
      {
        "type": "file",
        "value": ".eslintrc.js"
      },
      {
        "type": "folder",
        "value": "node_modules"
      }
    ]
  },
  "setting": {
    "urlCheck": false,
    "es6": true,
    "enhance": true,
    "postcss": true,
    "preloadBackgroundData": false,
    "minified": true,
    "newFeature": false,
    "coverView": true,
    "nodeModules": false,
    "autoAudits": false,
    "showShadowRootInWxmlPanel": true,
    "scopeDataCheck": false,
    "uglifyFileName": false,
    "checkInvalidKey": true,
    "checkSiteMap": true,
    "uploadWithSourceMap": true,
    "compileHotReLoad": false,
    "lazyloadPlaceholderEnable": false,
    "useMultiFrameRuntime": true,
    "useApiHook": true,
    "useApiHostProcess": true,
    "babelSetting": {
      "ignore": [],
      "disablePlugins": [],
      "outputPath": ""
    },
    "enableEngineNative": false,
    "useIsolateContext": true,
    "userConfirmedBundleSwitch": false,
    "packNpmManually": false,
    "packNpmRelationList": [],
    "minifyWXSS": true,
    "disableUseStrict": false,
    "minifyWXML": true,
    "showES6CompileOption": false,
    "useCompilerPlugins": false
  },
  "compileType": "game",
  "libVersion": "2.19.4",
  "appid": "{{todo: replace with actual appid}}",
  "projectname": "{{gameName}}",
  "condition": {}
}
```

### Core Game Files

#### game.js (Entry Point)

```javascript
import './js/libs/weapp-adapter';
import Game from './js/Game';

// Initialize game when WeChat runtime is ready
wx.onShow(() => {
  console.log('Game shown');
});

wx.onHide(() => {
  console.log('Game hidden');
});

wx.onError((error) => {
  console.error('WeChat error:', error);
});

// Start the game
const game = new Game();
game.start();
```

#### js/Game.js (Core Game Class)

```javascript
import BootScene from './scenes/BootScene';
import MenuScene from './scenes/MenuScene';
import GameScene from './scenes/GameScene';

export default class Game {
  constructor() {
    // Get system info
    this.systemInfo = wx.getSystemInfoSync();
    console.log('System info:', this.systemInfo);
    
    // Create canvas
    this.canvas = wx.createCanvas();
    this.ctx = this.canvas.getContext('2d');
    
    // Set canvas size
    this.canvas.width = this.systemInfo.windowWidth;
    this.canvas.height = this.systemInfo.windowHeight;
    
    // Game state
    this.scenes = new Map();
    this.currentScene = null;
    this.isRunning = false;
    
    // Initialize scenes
    this.initScenes();
    
    // Bind event handlers
    this.bindEvents();
  }
  
  initScenes() {
    this.scenes.set('boot', new BootScene(this));
    this.scenes.set('menu', new MenuScene(this));
    this.scenes.set('game', new GameScene(this));
  }
  
  bindEvents() {
    // Touch events
    wx.onTouchStart((e) => {
      if (this.currentScene?.onTouchStart) {
        this.currentScene.onTouchStart(e);
      }
    });
    
    wx.onTouchMove((e) => {
      if (this.currentScene?.onTouchMove) {
        this.currentScene.onTouchMove(e);
      }
    });
    
    wx.onTouchEnd((e) => {
      if (this.currentScene?.onTouchEnd) {
        this.currentScene.onTouchEnd(e);
      }
    });
    
    // Lifecycle events
    wx.onShow(() => {
      this.resume();
    });
    
    wx.onHide(() => {
      this.pause();
    });
  }
  
  start() {
    this.isRunning = true;
    this.switchScene('boot');
    this.gameLoop();
  }
  
  gameLoop() {
    if (!this.isRunning) return;
    
    // Update
    if (this.currentScene?.update) {
      this.currentScene.update();
    }
    
    // Render
    if (this.currentScene?.render) {
      this.ctx.clearRect(0, 0, this.canvas.width, this.canvas.height);
      this.currentScene.render(this.ctx);
    }
    
    requestAnimationFrame(() => this.gameLoop());
  }
  
  switchScene(sceneName) {
    if (this.currentScene?.exit) {
      this.currentScene.exit();
    }
    
    this.currentScene = this.scenes.get(sceneName);
    
    if (this.currentScene?.enter) {
      this.currentScene.enter();
    }
  }
  
  pause() {
    this.isRunning = false;
  }
  
  resume() {
    if (!this.isRunning) {
      this.isRunning = true;
      this.gameLoop();
    }
  }
}
```

#### js/scenes/BootScene.js

```javascript
export default class BootScene {
  constructor(game) {
    this.game = game;
    this.progress = 0;
  }
  
  enter() {
    console.log('BootScene entered');
    this.loadAssets();
  }
  
  async loadAssets() {
    // Simulate asset loading
    const assets = [
      'images/logo.png',
      'audio/bgm.mp3'
    ];
    
    for (let i = 0; i < assets.length; i++) {
      await this.loadAsset(assets[i]);
      this.progress = (i + 1) / assets.length;
    }
    
    // Go to menu when done
    this.game.switchScene('menu');
  }
  
  loadAsset(path) {
    return new Promise((resolve) => {
      // Simulate loading delay
      setTimeout(resolve, 100);
    });
  }
  
  render(ctx) {
    const { width, height } = this.game.canvas;
    
    // Background
    ctx.fillStyle = '#000000';
    ctx.fillRect(0, 0, width, height);
    
    // Loading text
    ctx.fillStyle = '#FFFFFF';
    ctx.font = '24px Arial';
    ctx.textAlign = 'center';
    ctx.fillText('Loading...', width / 2, height / 2 - 20);
    
    // Progress bar
    const barWidth = 200;
    const barHeight = 20;
    const x = (width - barWidth) / 2;
    const y = height / 2 + 20;
    
    ctx.strokeStyle = '#FFFFFF';
    ctx.strokeRect(x, y, barWidth, barHeight);
    
    ctx.fillStyle = '#00FF00';
    ctx.fillRect(x + 2, y + 2, (barWidth - 4) * this.progress, barHeight - 4);
    
    // Percentage
    ctx.fillStyle = '#FFFFFF';
    ctx.fillText(`${Math.floor(this.progress * 100)}%`, width / 2, y + barHeight + 30);
  }
}
```

#### js/scenes/MenuScene.js

```javascript
export default class MenuScene {
  constructor(game) {
    this.game = game;
    this.buttons = [
      { text: 'Start Game', y: 0.5, action: () => this.startGame() },
      { text: 'Leaderboard', y: 0.6, action: () => this.showLeaderboard() },
      { text: 'Share', y: 0.7, action: () => this.share() }
    ];
  }
  
  enter() {
    console.log('MenuScene entered');
  }
  
  startGame() {
    this.game.switchScene('game');
  }
  
  showLeaderboard() {
    wx.openCustomerServiceConversation({});
  }
  
  share() {
    wx.shareAppMessage({
      title: 'Play this awesome game!',
      imageUrl: ''
    });
  }
  
  onTouchStart(e) {
    const touch = e.touches[0];
    const { width, height } = this.game.canvas;
    
    this.buttons.forEach(button => {
      const bx = width / 2 - 100;
      const by = height * button.y - 25;
      const bw = 200;
      const bh = 50;
      
      if (touch.clientX >= bx && touch.clientX <= bx + bw &&
          touch.clientY >= by && touch.clientY <= by + bh) {
        button.action();
      }
    });
  }
  
  render(ctx) {
    const { width, height } = this.game.canvas;
    
    // Background
    ctx.fillStyle = '#1a1a2e';
    ctx.fillRect(0, 0, width, height);
    
    // Title
    ctx.fillStyle = '#FFFFFF';
    ctx.font = 'bold 36px Arial';
    ctx.textAlign = 'center';
    ctx.fillText('{{gameName}}', width / 2, height * 0.25);
    
    // Buttons
    this.buttons.forEach(button => {
      const bx = width / 2 - 100;
      const by = height * button.y - 25;
      const bw = 200;
      const bh = 50;
      
      // Button background
      ctx.fillStyle = '#16213e';
      ctx.fillRect(bx, by, bw, bh);
      
      // Button border
      ctx.strokeStyle = '#e94560';
      ctx.lineWidth = 2;
      ctx.strokeRect(bx, by, bw, bh);
      
      // Button text
      ctx.fillStyle = '#FFFFFF';
      ctx.font = '20px Arial';
      ctx.textAlign = 'center';
      ctx.textBaseline = 'middle';
      ctx.fillText(button.text, width / 2, height * button.y);
    });
  }
}
```

#### js/scenes/GameScene.js

```javascript
export default class GameScene {
  constructor(game) {
    this.game = game;
    this.score = 0;
    this.player = { x: 100, y: 100, size: 30 };
    this.isPlaying = false;
  }
  
  enter() {
    console.log('GameScene entered');
    this.score = 0;
    this.isPlaying = true;
  }
  
  exit() {
    this.isPlaying = false;
    this.saveScore();
  }
  
  saveScore() {
    try {
      const highScore = wx.getStorageSync('highScore') || 0;
      if (this.score > highScore) {
        wx.setStorageSync('highScore', this.score);
      }
    } catch (e) {
      console.error('Failed to save score:', e);
    }
  }
  
  update() {
    if (!this.isPlaying) return;
    
    // Game logic here
    this.score += 1;
  }
  
  onTouchStart(e) {
    const touch = e.touches[0];
    this.player.x = touch.clientX;
    this.player.y = touch.clientY;
  }
  
  onTouchMove(e) {
    const touch = e.touches[0];
    this.player.x = touch.clientX;
    this.player.y = touch.clientY;
  }
  
  render(ctx) {
    const { width, height } = this.game.canvas;
    
    // Background
    ctx.fillStyle = '#0f3460';
    ctx.fillRect(0, 0, width, height);
    
    // Player
    ctx.fillStyle = '#e94560';
    ctx.beginPath();
    ctx.arc(this.player.x, this.player.y, this.player.size, 0, Math.PI * 2);
    ctx.fill();
    
    // Score
    ctx.fillStyle = '#FFFFFF';
    ctx.font = '24px Arial';
    ctx.textAlign = 'left';
    ctx.fillText(`Score: ${this.score}`, 20, 40);
    
    // Back button
    ctx.fillStyle = '#16213e';
    ctx.fillRect(width - 80, 10, 70, 30);
    ctx.fillStyle = '#FFFFFF';
    ctx.font = '14px Arial';
    ctx.textAlign = 'center';
    ctx.fillText('Menu', width - 45, 30);
  }
}
```

---

## Phase 3: Cloud Base Setup (If Enabled)

If user chose Cloud Base, create:

### cloudbase/cloudfunctions/config.json

```json
{
  "permissions": {
    "openapi": [
      "wxacode.get",
      "wxacode.createQRCode"
    ]
  }
}
```

### cloudbase/cloudfunctions/login/index.js

```javascript
const cloud = require('wx-server-sdk');
cloud.init({ env: cloud.DYNAMIC_CURRENT_ENV });

exports.main = async (event, context) => {
  const wxContext = cloud.getWXContext();
  
  return {
    event,
    openid: wxContext.OPENID,
    appid: wxContext.APPID,
    unionid: wxContext.UNIONID,
    env: wxContext.ENV,
  };
};
```

### cloudbase/cloudfunctions/login/config.json

```json
{
  "permissions": {
    "openapi": []
  }
}
```

---

## Phase 4: Update Technical Preferences

Update `.codebuddy/docs/technical-preferences.md`:

```markdown
## Engine Configuration

**Engine**: WeChat Mini Game (微信小游戏)
**Language**: {{language}}
**Framework**: {{framework}}
**Backend**: {{cloudBase ? 'WeChat Cloud Base' : 'None/External'}}
```

---

## Phase 5: Documentation

Create `miniprogram/README.md`:

```markdown
# {{gameName}} WeChat Mini Game

## Development

1. Open WeChat DevTools
2. Import project from `miniprogram/` folder
3. Set AppID (or use test account)
4. Click "Compile"

## Project Structure

- `game.js` — Entry point
- `js/Game.js` — Core game class
- `js/scenes/` — Game scenes
- `js/managers/` — Game managers
- `subpackages/` — Dynamic loaded content

## Build

Run `/wechat-build` to package for release.

## Cloud Base

{{if cloudBase}}
Deploy functions: `wxcloud functions deploy --all`
{{else}}
Cloud Base not enabled.
{{end}}
```

---

## Phase 6: Summary

Show the user what was created:

```
✅ WeChat Mini Game project initialized!

📁 Created files:
   miniprogram/
   ├── game.js
   ├── game.json
   ├── app.json
   ├── project.config.json
   ├── js/
   │   ├── Game.js
   │   └── scenes/
   │       ├── BootScene.js
   │       ├── MenuScene.js
   │       └── GameScene.js
   └── open-data/
       └── index.js

{{if cloudBase}}
☁️ Cloud Base setup:
   cloudbase/
   └── cloudfunctions/
       └── login/
{{end}}

📝 Next steps:
   1. Open WeChat DevTools and import `miniprogram/` folder
   2. Configure your AppID in `project.config.json`
   3. Run `/wechat-build` when ready to test on device
   4. Use `/dev-story` to implement game features
```

---

## Edge Cases

- **Existing project**: Offer to backup and overwrite, or update config only
- **Migration from another engine**: Create adapter layer in `js/libs/`
- **TypeScript requested**: Add `tsconfig.json` and create `.ts` files instead
