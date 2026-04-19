# 微信小游戏开发指南

本指南介绍如何在 Claude Code Game Studios 架构下开发微信小游戏（WeChat Mini Games）。

---

## 目录

1. [微信小游戏概述](#微信小游戏概述)
2. [技术栈选择](#技术栈选择)
3. [项目初始化](#项目初始化)
4. [核心概念](#核心概念)
5. [开发工作流程](#开发工作流程)
6. [平台特性](#平台特性)
7. [高级功能](#高级功能)
8. [发布流程](#发布流程)
9. [常见问题](#常见问题)

---

## 微信小游戏概述

微信小游戏是在微信生态内运行的轻量级游戏平台，具有以下特点：

| 特性 | 说明 |
|------|------|
| **包体限制** | 主包 4MB 硬性限制，可使用分包扩展 |
| **运行环境** | JavaScript 运行时，无 DOM/BOM API |
| **用户基数** | 10亿+ 微信用户，社交传播能力强 |
| **开发语言** | JavaScript / TypeScript |
| **渲染方式** | Canvas 2D / WebGL 1.0 / WebGL 2.0 |
| **物理引擎** | 支持 Box2D、Bullet、JoltPhysics (WASM) |
| **骨骼动画** | 支持 Spine、DragonBones 运行时 |
| **后端选项** | 微信云开发（Cloud Base）或自建服务器 |
| **合规要求** | 实名制、防沉迷系统 |

---

## 技术栈选择

### 方案对比

| 方案 | 优点 | 缺点 | 适用场景 |
|------|------|------|----------|
| **原生 WeChat API** | 包体最小，完全控制 | 从零开发，工作量大 | 超休闲游戏，技术团队强 |
| **Cocos Creator** | 成熟引擎，WeChat 适配好 | 引擎体积较大 | 2D 游戏，复杂项目 |
| **LayaAir** | 轻量级，性能好 | 社区相对较小 | 2D/3D 游戏 |
| **Phaser** | 开源，文档丰富 | 需适配 WeChat | 2D 游戏，Web 背景团队 |
| **Unity WebGL** | 强大的 3D 能力 | 包体大，加载慢 | 3D 游戏，有 Unity 经验 |
| **Godot Web** | 开源免费，导出方便 | WeChat 适配需测试 | 2D/3D 游戏，开源偏好 |

### 推荐选择

- **初学者/超休闲游戏** → 原生 WeChat API
- **中等复杂度 2D 游戏** → Cocos Creator
- **重度 3D 游戏** → Unity WebGL（需严格控制包体）

---

## 项目初始化

### 使用 Skill 初始化

运行 setup skill 自动创建项目：

```
/setup-wechat-minigame
```

根据提示选择：
1. 游戏引擎/框架
2. 开发语言（JavaScript/TypeScript）
3. 是否启用云开发
4. 游戏名称
5. 屏幕方向

### 手动初始化

如果需要手动创建，项目结构如下：

```
miniprogram/
├── game.js              # 入口文件
├── game.json            # 游戏配置
├── app.json             # 应用配置（分包、权限）
├── project.config.json  # 微信开发者工具配置
├── js/
│   ├── main.js          # 主逻辑
│   ├── scenes/          # 场景
│   └── utils/           # 工具函数
├── images/              # 图片资源
├── audio/               # 音频资源
└── subpackages/         # 分包目录
```

---

## 核心概念

### 1. 包体管理（4MB 限制）

微信小游戏主包有 **4MB** 硬性限制。管理策略：

```javascript
// game.json - 配置分包
{
  "subpackages": [
    {
      "name": "levelPack1",
      "root": "subpackages/levelPack1/"
    },
    {
      "name": "skins",
      "root": "subpackages/skins/"
    }
  ]
}
```

分包加载：

```javascript
wx.loadSubpackage({
  name: 'levelPack1',
  success: () => {
    console.log('分包加载成功');
  }
});
```

**包体优化建议**：
- 图片使用 WebP 格式
- 音频压缩（MP3 比 WAV 小 10 倍）
- 删除未使用的资源
- 使用纹理图集（Texture Atlas）

### 2. 生命周期

```javascript
// 游戏启动
wx.onShow((res) => {
  console.log('游戏显示', res);
  game.resume();
});

// 游戏隐藏（切换到聊天等）
wx.onHide(() => {
  console.log('游戏隐藏');
  game.pause();
});

// 错误处理
wx.onError((error) => {
  console.error('游戏错误:', error);
});
```

### 3. 渲染与 Canvas

```javascript
// 创建 Canvas
const canvas = wx.createCanvas();
const ctx = canvas.getContext('2d');

// 获取屏幕尺寸
const { windowWidth, windowHeight } = wx.getSystemInfoSync();
canvas.width = windowWidth;
canvas.height = windowHeight;

// 游戏循环
function gameLoop() {
  ctx.clearRect(0, 0, canvas.width, canvas.height);
  // 更新和渲染...
  requestAnimationFrame(gameLoop);
}
gameLoop();
```

### 4. 触摸输入

```javascript
wx.onTouchStart((e) => {
  const touch = e.touches[0];
  console.log('触摸开始:', touch.clientX, touch.clientY);
});

wx.onTouchMove((e) => {
  const touch = e.touches[0];
  console.log('触摸移动:', touch.clientX, touch.clientY);
});

wx.onTouchEnd((e) => {
  console.log('触摸结束');
});
```

### 5. 音频管理

```javascript
// 背景音乐
const bgm = wx.createInnerAudioContext();
bgm.src = 'audio/bgm.mp3';
bgm.loop = true;
bgm.play();

// 音效
const sfx = wx.createInnerAudioContext();
sfx.src = 'audio/jump.mp3';
sfx.play();
```

### 6. 本地存储

```javascript
// 同步存储（推荐小游戏使用）
wx.setStorageSync('highScore', 1000);
const highScore = wx.getStorageSync('highScore');

// 存储限制：10MB
```

### 7. 社交功能

```javascript
// 分享
wx.shareAppMessage({
  title: '我得了 1000 分！来挑战我吧！',
  imageUrl: canvas.toTempFilePathSync(),
  query: 'inviterId=123&score=1000'
});

// 获取启动参数（从分享进入）
const { query } = wx.getLaunchOptionsSync();
console.log('分享者ID:', query.inviterId);
```

---

## 开发工作流程

### 标准流程

```mermaid
graph TD
    A[概念阶段] --> B[原型开发]
    B --> C[/setup-wechat-minigame]
    C --> D[核心玩法实现]
    D --> E[平台特性集成]
    E --> F[/wechat-build]
    F --> G[真机测试]
    G --> H[优化调优]
    H --> I[提交审核]
    I --> J[发布上线]
```

### Agent 协作

微信小游戏开发涉及的 Agent：

| Agent | 职责 | 使用场景 |
|-------|------|----------|
| `wechat-minigame-specialist` | 平台 API、包体优化、物理引擎、WASM、骨骼动画 | 核心游戏逻辑开发 |
| `wechat-cloudbase-specialist` | 云开发后端、数据库、云函数 | 需要后端服务时 |
| `wechat-shader-specialist` | WebGL Shader、Shader 转换 | 自定义渲染效果 |
| `wechat-ui-specialist` | UI 设计、FairyGUI、资产制作 | 界面设计和实现 |
| `frontend-programmer` | JavaScript/TypeScript 实现 | 通用前端逻辑 |
| `ui-designer` | 移动端 UI 设计 | UI 视觉设计 |
| `live-ops-designer` | 社交功能、排行榜 | 运营功能 |

**工作流示例**：
```
# 1. 初始化项目
/setup-wechat-minigame

# 2. 设计 UI
/wechat-ui-design init "MyGame"

# 3. 开发 Shader（如需要）
/wechat-shader setup webgl2

# 4. 实现功能
/dev-story

# 5. 构建发布
/wechat-build
```

### Skill 使用时机

| 阶段 | 使用 Skill | 说明 |
|------|-----------|------|
| 初始化 | `/setup-wechat-minigame` | 创建项目结构 |
| Shader | `/wechat-shader` | WebGL Shader 开发和转换 |
| UI 设计 | `/wechat-ui-design` | UI 原型、资产制作、FairyGUI |
| 开发 | `/dev-story` | 实现具体功能 |
| 构建 | `/wechat-build` | 打包、检查、生成清单 |
| 测试 | `/qa-plan` | 测试计划 |
| 发布 | `/launch-checklist` | 发布前检查 |

---

## 高级功能

### 1. 物理引擎集成

微信小游戏支持通过 WebAssembly 集成物理引擎：

| 引擎 | 类型 | WASM 大小 | 适用场景 |
|------|------|-----------|----------|
| Box2D | 2D 物理 | ~500KB | 平台游戏、物理解谜 |
| Bullet | 3D 物理 | ~1.5MB | 3D 游戏、复杂碰撞 |
| JoltPhysics | 3D 物理 | ~800KB | 高性能 3D 游戏 |

使用 Skill 集成物理引擎：
```
/wechat-shader setup wasm
```

详细集成代码参考：[wechat-minigame-specialist](../../.codebuddy/agents/wechat-minigame-specialist.md) 中的物理引擎章节。

### 2. WebAssembly (WASM) 第三方库

可以嵌入 WASM 模块扩展功能：
- FFmpeg - 视频处理
- Lua 运行时 - 脚本系统
- Protobuf - 高效网络通信
- 自定义算法库

### 3. Spine/DragonBones 骨骼动画

支持流行的骨骼动画格式：

**Spine 运行时**：
- 支持 Spine 3.8+ 格式
- 动画混合和过渡
- 动画事件系统
- 网格变形

**DragonBones 运行时**：
- 支持 DragonBones Pro 导出格式
- 高效运行时性能
- 与 FairyGUI 集成

### 4. WebGL Shader 开发

使用 `/wechat-shader` Skill 开发自定义 Shader：

```
/wechat-shader setup webgl2
/wechat-shader convert unity Assets/Shaders/MyEffect.shader
```

支持的 Shader 效果：
- 2D 精灵特效（闪白、溶解、描边）
- 水面/流动效果
- 模糊和后处理
- UI 特效

从其他引擎转换：
- Unity HLSL → WebGL GLSL
- Unreal Material → WebGL GLSL
- Godot Shader → WebGL GLSL

### 5. UI 设计和 FairyGUI

使用 `/wechat-ui-design` Skill 设计 UI：

```
/wechat-ui-design init "MyGame"
/wechat-ui-design fairygui UI_Main
```

**设计流程**：
1. **Figma/Sketch** - 原型设计和视觉稿
2. **Photoshop/Illustrator** - 切图和精灵图制作
3. **FairyGUI** - 界面拼装和自适应布局

**FairyGUI 功能**：
- 组件化 UI 系统
- 控制器管理多状态
- 虚拟列表优化性能
- 过渡动画系统
- 多分辨率适配

**设计规范**：
- iOS Human Interface Guidelines
- 微信设计规范
- 移动端触摸目标（最小 44x44pt）
- 安全区域适配

---

## 平台特性

### 1. 云开发（Cloud Base）

启用云开发后，可以使用：

**数据库**：
```javascript
const db = wx.cloud.database();
db.collection('scores').add({
  data: {
    score: 1000,
    timestamp: db.serverDate()
  }
});
```

**云函数**：
```javascript
// 调用云函数
wx.cloud.callFunction({
  name: 'saveScore',
  data: { score: 1000 }
});
```

### 2. 开放数据域（排行榜）

```javascript
// 主域发送数据
wx.postMessage({
  action: 'setScore',
  score: 1000
});

// 开放数据域显示好友排行榜
// 见 open-data/index.js
```

### 3. 广告变现

```javascript
// 激励视频广告
let rewardedVideoAd = null;

function initAd() {
  if (wx.createRewardedVideoAd) {
    rewardedVideoAd = wx.createRewardedVideoAd({
      adUnitId: 'your-ad-unit-id'
    });
    
    rewardedVideoAd.onLoad(() => {
      console.log('广告加载成功');
    });
    
    rewardedVideoAd.onError((err) => {
      console.error('广告加载失败', err);
    });
    
    rewardedVideoAd.onClose((res) => {
      if (res && res.isEnded) {
        // 用户完整观看，给予奖励
        giveReward();
      }
    });
  }
}

function showAd() {
  if (rewardedVideoAd) {
    rewardedVideoAd.show().catch(() => {
      rewardedVideoAd.load().then(() => rewardedVideoAd.show());
    });
  }
}
```

### 4. 支付（虚拟道具）

```javascript
wx.requestMidasPayment({
  mode: 'game',
  env: 0, // 0: 正式环境, 1: 沙箱环境
  offerId: 'your-offer-id',
  currencyType: 'CNY',
  platform: 'android',
  buyQuantity: 10,
  success: () => {
    // 支付成功，发放道具
  },
  fail: (err) => {
    console.error('支付失败', err);
  }
});
```

---

## 发布流程

### 1. 构建检查

```
/wechat-build release
```

检查项：
- 包体大小 < 4MB
- 无 DOM API 使用
- 无硬编码密钥
- HTTPS 链接

### 2. 提交清单

| 检查项 | 要求 |
|--------|------|
| AppID | 在微信公众平台注册 |
| 游戏名称 | 4-30 个字符 |
| 游戏图标 | 144x144 PNG，< 2MB |
| 截图 | 5 张，480x800 或 800x480 |
| 描述 | 10-1000 个字符 |
| 隐私政策 | 如有用户数据收集 |
| 防沉迷 | 必须接入 |

### 3. 提交流程

1. 微信开发者工具 → 上传
2. 登录微信公众平台
3. 进入"小游戏管理"
4. 填写基本信息
5. 提交审核
6. 等待审核（1-7 个工作日）
7. 审核通过后发布

---

## 常见问题

### Q: 包体超过 4MB 怎么办？

A: 使用分包策略：
- 主包：核心玩法 + 第一关
- 分包1：后续关卡
- 分包2：皮肤、资源

### Q: 如何在电脑上调试？

A: 使用微信开发者工具：
- 模拟器调试（基础功能）
- 真机调试（完整功能，包括性能）

### Q: 需要实名认证吗？

A: 是的，根据法规要求：
- 游戏必须接入微信实名认证
- 未成年人需要防沉迷限制

### Q: 可以使用第三方库吗？

A: 可以，但需注意：
- 库的大小计入包体
- 确保库不依赖 DOM/BOM
- 推荐：lodash（精简版）、protobufjs

### Q: 性能优化有什么建议？

A: 主要优化点：
1. 使用对象池减少 GC
2. 帧率控制：目标 60fps
3. 离屏渲染复杂场景
4. 图片压缩和合并
5. 音频使用适当格式

---

## 资源链接

### 官方文档
- [微信小游戏官方文档](https://developers.weixin.qq.com/minigame/dev/guide/)
- [微信云开发文档](https://developers.weixin.qq.com/miniprogram/dev/wxcloud/basis/getting-started.html)
- [微信开发者工具下载](https://developers.weixin.qq.com/miniprogram/dev/devtools/download.html)

### CodeBuddy Agents
- [wechat-minigame-specialist](../../.codebuddy/agents/wechat-minigame-specialist.md) - 平台 API、物理引擎、WASM、骨骼动画
- [wechat-cloudbase-specialist](../../.codebuddy/agents/wechat-cloudbase-specialist.md) - 云开发后端
- [wechat-shader-specialist](../../.codebuddy/agents/wechat-shader-specialist.md) - WebGL Shader 开发
- [wechat-ui-specialist](../../.codebuddy/agents/wechat-ui-specialist.md) - UI 设计和 FairyGUI

### CodeBuddy Skills
- `/setup-wechat-minigame` - 项目初始化
- `/wechat-shader` - Shader 开发和转换
- `/wechat-ui-design` - UI 设计和资产制作

---

## 快速开始

```bash
# 1. 初始化项目
/setup-wechat-minigame

# 2. 选择配置（原生 API / TypeScript / 启用云开发）

# 3. 设计 UI（可选）
/wechat-ui-design init "MyGame"

# 4. 设置 Shader（可选）
/wechat-shader setup webgl2

# 5. 打开微信开发者工具，导入 miniprogram/ 文件夹

# 6. 开发游戏功能
/dev-story

# 7. 构建检查
/wechat-build

# 8. 上传并提交审核
```

---

*本指南由 Claude Code Game Studios 自动生成，结合微信小游戏官方文档和最佳实践。*
