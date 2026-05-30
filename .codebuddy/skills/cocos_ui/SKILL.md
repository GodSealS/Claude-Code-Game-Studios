---
name: cocos_ui
description: Cocos Creator UI system expert. Triggers when users need to handle Button, EditBox, ScrollView, Toggle, Slider, ProgressBar, Layout, Widget, PageView, RichText, UI event system, and MMORPG UI templates (UnitFrame, ActionBar, Minimap, ChatWindow, PartyFrame, RaidFrame, QuestTracker, Tooltip, BagPanel, CharacterPanel, CastingBar, Nameplate, CombatText, LootRoll, VendorPanel). 当用户需要处理交互式UI组件、UI事件系统、多分辨率适配、或魔兽世界风格MMORPG UI模板时触发此 Skill。
allowed-tools: Read, Grep
argument-hint: ""
user-invocable: false
---

# Cocos Creator UI System & MMORPG UI Templates

> **READY**: Skill loaded — provides Cocos Creator UI system domain knowledge.

## Overview

The Cocos Creator UI system provides a full set of interactive widgets and layout components built on the 2D rendering layer. This skill covers **all interactive UI widgets** (Button, EditBox, ScrollView, Toggle, Slider, ProgressBar, PageView, Layout, Widget, RichText, etc.), the **UI event system**, and **production-ready MMORPG UI templates** modeled after World of Warcraft's battle-tested interface patterns.

## Domain Knowledge

### Core Design Patterns

- **component-based** — each UI widget is a Component mounted on a Node
- **event-driven** — UI interaction through `Button.clickEvents`, `EditBox` events, `ScrollView` scroll events
- **layout-automated** — Layout + Widget for auto-arrangement and multi-resolution adaptation
- **canvas-based** — all UI rendered under a Camera + Canvas hierarchy

### UI Widget Components (Full Catalog)

| Category | Components | Role |
|----------|-----------|------|
| **Interactive** | `Button`, `Toggle`, `ToggleContainer`, `Slider`, `ProgressBar` | Click, toggle, drag, progress |
| **Input** | `EditBox`, `RichText` | Text input, styled text display |
| **Scroll** | `ScrollView`, `PageView`, `PageViewIndicator` | Scrollable content, page flipping |
| **Layout** | `Layout`, `Widget`, `SafeArea` | Auto-arrangement, alignment, safe zone |
| **Transform** | `UITransform` | ContentSize, AnchorPoint for UI nodes |
| **Visual** | `UIOpacity`, `UIReorder`, `BlockInputEvents`, `Canvas` | Opacity, ordering, event blocking |

### UI Event System

- `Node.EventType.TOUCH_START` / `TOUCH_MOVE` / `TOUCH_END` / `TOUCH_CANCEL` — raw touch events
- `Button.clickEvents` — `EventHandler` array for click handling
- `EditBox.EventType` — `TEXT_CHANGED`, `EDITING_RETURN`, `EDITING_DID_ENDED`
- `ScrollView.EventType` — `SCROLL_TO_TOP`, `SCROLL_TO_BOTTOM`, `SCROLLING`
- `PageView.EventType` — `PAGE_TURNING`
- `Toggle.EventType` — `CLICK`
- `Slider.EventType` — `SLIDE`

### Multi-Resolution Adaptation

- **Widget** — aligns UI elements to parent edges/corners/center with pixel/percentage offsets
- **Canvas.FitMode** — `AUTO` (WIDTH/HEIGHT priority) for design resolution fit
- **SafeArea** — handles notch/rounded corners on mobile devices

## Key APIs

### Classes

| Class | Source Module | Key Properties/Methods |
|-------|--------------|----------------------|
| `Button` | `cc` | `interactable`, `transition` (COLOR/SPRITE/SCALE), `clickEvents`, `target`, `normalColor`, `pressedColor`, `hoverColor`, `disabledColor`, `normalSprite`, `pressedSprite`, `hoverSprite`, `disabledSprite`, `duration`, `zoomScale` |
| `Toggle` | `cc` | `isChecked`, `checkMark`, `toggleEvents`, `checkEvents`, `uncheckEvents` |
| `ToggleContainer` | `cc` | `allowSwitchOff`, `toggleItems` (auto radio-group) |
| `Slider` | `cc` | `handle`, `progress`, `slideEvents`, `direction` (HORIZONTAL/VERTICAL) |
| `ProgressBar` | `cc` | `barSprite`, `mode` (HORIZONTAL/VERTICAL/FILLED), `totalLength`, `progress`, `reverse` |
| `EditBox` | `cc` | `string`, `placeholder`, `placeholderLabel`, `inputMode` (SINGLE_LINE/MULTI_LINE/PASSWORD), `maxLength`, `returnType`, `editingEvents`, `textChangedEvents` |
| `ScrollView` | `cc` | `content`, `horizontal`, `vertical`, `inertia`, `elastic`, `brake`, `scrollEvents`, `bounceDuration`, `horizontalScrollBar`, `verticalScrollBar` |
| `PageView` | `cc` | `content`, `sizeMode`, `indicator`, `pageEvents`, `scrollThreshold`, `autoPageTurningThreshold`, `pageTurningEventTiming` |
| `Layout` | `cc` | `type` (HORIZONTAL/VERTICAL/GRID), `resizeMode` (NONE/CHILDREN/CONTAINER), `spacingX`, `spacingY`, `paddingLeft/Right/Top/Bottom`, `constraint`, `constraintNum` |
| `Widget` | `cc` | `isAlignLeft/Top/Right/Bottom`, `left/top/right/bottom`, `isAlignHorizontalCenter`, `isAlignVerticalCenter`, `target`, `alignMode` (ALWAYS/ONCE/ON_WINDOW_RESIZE) |
| `UITransform` | `cc` | `contentSize`, `anchorPoint`, `width`, `height`, `priority` |
| `UIOpacity` | `cc` | `opacity` (0-255) |
| `RichText` | `cc` | `string` (HTML-like tags: `<color>`, `<b>`, `<i>`, `<u>`, `<size>`, `<img>`, `<br>`), `fontSize`, `maxWidth` |
| `BlockInputEvents` | `cc` | Blocks touch events from passing through |
| `Canvas` | `cc` | `cameraComponent`, `fitMode`, `designResolution`, `alignCanvasWithScreen` |
| `SafeArea` | `cc` | `updateArea()` |

### Key Methods

- `Button.updateTransition()` — force refresh transition state
- `ScrollView.scrollToTop()` / `scrollToBottom()` / `scrollToOffset()` / `scrollToPercentVertical()` — programmatic scrolling
- `Layout.updateLayout()` — force layout recalculation
- `PageView.setCurrentPage()` / `getCurrentPage()` — programmatic page control

## MMORPG UI Templates (WOW-Style)

Based on World of Warcraft's battle-tested interface architecture. Each template is a self-contained factory that can be instantiated and composed into a full MMO HUD.

### Template Architecture Overview

```
Screen Layout (WOW-inspired):
┌─────────────────────────────────────────────────┐
│ [PlayerFrame]           [TargetFrame]    [Minimap]│ ← top-left / top-right corners
│                                                    │
│                                  [QuestTracker]    │ ← right side
│                                                    │
│ [ChatWindow]                    [PartyFrame]      │ ← bottom-left / right side
│                                  [RaidFrame]       │
├─────────────────────────────────────────────────┤
│              [ActionBar 1..N]                     │ ← bottom-center
├─────────────────────────────────────────────────┤
│ [BagBar]  [MicroMenu]  [MainBar]                 │ ← bottom bar
└─────────────────────────────────────────────────┘

Overlay Layer:
  [Nameplates] — world-space above characters
  [CombatText] — floating damage numbers
  [Tooltip] — cursor-following info panel
  [CastingBar] — centered spell cast progress
```

### Template 1: UnitFrame (玩家/目标头像框)

MMORPG 角色头像+血条+蓝条+状态图标组合体。

**Features:**
- Portrait icon (Sprite, circular mask)

- Health bar (ProgressBar, green→yellow gradient)
- Mana/Energy/Rage bar (ProgressBar, class-colored)
- Level + Name text (Label)
- Elite/rare dragon border (Sprite frame variant)
- Buff row (horizontal Layout of small icons, expandable)
- Debuff row (horizontal Layout of small icons, expandable)
- Cast bar integration slot
- Target-of-target sub-frame (nested UnitFrame, scaled 0.7x)

**Structure:**
```
UnitFrame (Node)
├── Portrait (Sprite + Mask)
├── LevelText (Label)
├── NameText (Label)
├── HealthBar (ProgressBar)
├── ManaBar (ProgressBar)
├── EliteBorder (Sprite)
├── BuffContainer (Layout:HORIZONTAL)
│   └── BuffIcon[0..N] (Button + Sprite + Label[count])
├── DebuffContainer (Layout:HORIZONTAL)
│   └── DebuffIcon[0..N] (Button + Sprite + Label[count])
├── CastBar (sub-node, see Template 12)
└── TargetOfTarget (sub-UnitFrame, scale:0.7)
```

**Code Example:**
```typescript
import { Node, Sprite, Label, ProgressBar, Layout, Color, UITransform, Mask } from 'cc';

interface UnitFrameData {
    name: string;
    level: number;
    maxHp: number;
    currentHp: number;
    maxMp: number;
    currentMp: number;
    isElite: boolean;
    portraitFrame?: string;
    buffs: BuffData[];
    debuffs: BuffData[];
}

class UnitFrame {
    node: Node;
    private nameLabel: Label;
    private healthBar: ProgressBar;
    private manaBar: ProgressBar;
    private levelText: Label;
    private portrait: Sprite;
    private eliteBorder: Sprite;
    private buffContainer: Node;
    private debuffContainer: Node;

    constructor(parent: Node, isPlayer: boolean = false) {
        this.node = new Node('UnitFrame');
        this.node.addComponent(UITransform).setContentSize(200, 56);
        parent.addChild(this.node);

        // Portrait
        const portraitNode = new Node('Portrait');
        portraitNode.addComponent(UITransform).setContentSize(48, 48);
        portraitNode.addComponent(Mask).type = Mask.Type.RECT;
        this.portrait = portraitNode.addComponent(Sprite);
        this.node.addChild(portraitNode);

        // Health bar
        const hpNode = new Node('HealthBar');
        hpNode.addComponent(UITransform).setContentSize(140, 12);
        hpNode.setPosition(60, 16, 0);
        this.healthBar = hpNode.addComponent(ProgressBar);
        this.node.addChild(hpNode);

        // Mana bar
        const mpNode = new Node('ManaBar');
        mpNode.addComponent(UITransform).setContentSize(140, 6);
        mpNode.setPosition(60, 6, 0);
        this.manaBar = mpNode.addComponent(ProgressBar);
        this.node.addChild(mpNode);

        // Name label
        const nameNode = new Node('NameLabel');
        nameNode.setPosition(60, 36, 0);
        this.nameLabel = nameNode.addComponent(Label);
        this.nameLabel.fontSize = 14;
        this.nameLabel.color = Color.WHITE;
        this.node.addChild(nameNode);

        // Level text
        const levelNode = new Node('LevelText');
        levelNode.setPosition(66, 36, 0);
        this.levelText = levelNode.addComponent(Label);
        this.levelText.fontSize = 12;
        this.levelText.color = Color.YELLOW;
        this.node.addChild(levelNode);

        // Buff/Debuff containers
        this.buffContainer = new Node('BuffContainer');
        this.buffContainer.addComponent(UITransform).setContentSize(160, 18);
        this.buffContainer.addComponent(Layout).type = Layout.Type.HORIZONTAL;
        this.buffContainer.setPosition(60, -6, 0);
        this.node.addChild(this.buffContainer);

        this.debuffContainer = new Node('DebuffContainer');
        this.debuffContainer.addComponent(UITransform).setContentSize(160, 18);
        this.debuffContainer.addComponent(Layout).type = Layout.Type.HORIZONTAL;
        this.debuffContainer.setPosition(60, -22, 0);
        this.node.addChild(this.debuffContainer);
    }

    update(data: UnitFrameData) {
        this.nameLabel.string = data.name;
        this.levelText.string = (data.isElite ? '精英 ' : '') + `Lv.${data.level}`;
        this.healthBar.progress = data.currentHp / data.maxHp;
        this.healthBar.barSprite.color = this.getHealthColor(data.currentHp / data.maxHp);
        this.manaBar.progress = data.currentMp / data.maxMp;
        this.eliteBorder && (this.eliteBorder.node.active = data.isElite);
        this.refreshBuffs(data.buffs, this.buffContainer);
        this.refreshBuffs(data.debuffs, this.debuffContainer);
    }

    private getHealthColor(ratio: number): Color {
        if (ratio > 0.6) return new Color(0, 255, 0);
        if (ratio > 0.3) return new Color(255, 255, 0);
        return new Color(255, 0, 0);
    }

    private refreshBuffs(buffs: BuffData[], container: Node) {
        container.removeAllChildren();
        const maxVisible = 8;
        buffs.slice(0, maxVisible).forEach(b => {
            const icon = new Node('BuffIcon');
            icon.addComponent(UITransform).setContentSize(18, 18);
            const spr = icon.addComponent(Sprite);
            spr.spriteFrame = b.icon;
            container.addChild(icon);
        });
    }
}
```

---

### Template 2: ActionBar (技能动作条)

网格按钮栏，支持按键绑定提示、冷却螺旋覆盖、充能层数。

**Features:**
- N×1 or N×M button grid
- Cooldown spiral overlay with timer text
- Keybind label (bottom-right of each slot)
- Charge count label (bottom-right alternate)
- Drag-and-drop slot reordering
- Bar paging (PageView or ScrollView between bar pages)
- Action bar locking toggle

**Structure:**
```
ActionBar (Node)
├── SlotGrid (Layout:HORIZONTAL or GRID)
│   └── ActionSlot[0..N] (Button)
│       ├── Icon (Sprite)
│       ├── CooldownOverlay (Sprite + Mask + ProgressBar[radial])
│       ├── CooldownText (Label)
│       ├── KeybindText (Label)
│       ├── ChargeCount (Label)
│       └── EmptyBorder (Sprite)
└── PageIndicators (optional, PageViewIndicator)
```

**Code Example:**
```typescript
import { Node, Button, Sprite, Label, UITransform, Layout, Color, ProgressBar, tween, Tween } from 'cc';

interface ActionSlotData {
    icon: SpriteFrame | null;
    cooldownRemaining: number;   // seconds
    cooldownTotal: number;
    keybind: string;
    charges: number;
    maxCharges: number;
    isUsable: boolean;
}

class ActionBar {
    node: Node;
    private slots: ActionSlot[] = [];
    private slotCount: number = 12;

    constructor(parent: Node, slotCount: number = 12, rows: number = 1) {
        this.slotCount = slotCount;
        this.node = new Node('ActionBar');
        const cols = Math.ceil(slotCount / rows);
        const slotSize = 44;

        const layout = this.node.addComponent(Layout);
        layout.type = rows > 1 ? Layout.Type.GRID : Layout.Type.HORIZONTAL;
        layout.spacingX = 4;
        layout.spacingY = 4;
        layout.constraint = Layout.Constraint.FIXED_COL;
        layout.constraintNum = cols;

        this.node.addComponent(UITransform).setContentSize(
            cols * (slotSize + layout.spacingX) - layout.spacingX,
            rows * (slotSize + layout.spacingY) - layout.spacingY
        );
        parent.addChild(this.node);

        for (let i = 0; i < slotCount; i++) {
            this.slots.push(this.createSlot(i));
        }
    }

    private createSlot(index: number): ActionSlot {
        const slot = new ActionSlot(index);
        this.node.addChild(slot.node);
        return slot;
    }

    updateAll(data: ActionSlotData[]) {
        data.forEach((d, i) => { if (this.slots[i]) this.slots[i].update(d); });
    }

    updateSlot(index: number, data: ActionSlotData) {
        if (this.slots[index]) this.slots[index].update(data);
    }
}

class ActionSlot {
    node: Node;
    private icon: Sprite;
    private cooldownText: Label;
    private keybindLabel: Label;
    private chargeLabel: Label;
    private button: Button;
    slotIndex: number;

    constructor(index: number) {
        this.slotIndex = index;
        this.node = new Node(`Slot_${index}`);
        this.node.addComponent(UITransform).setContentSize(44, 44);
        this.button = this.node.addComponent(Button);

        // Icon
        const iconNode = new Node('Icon');
        iconNode.addComponent(UITransform).setContentSize(40, 40);
        this.icon = iconNode.addComponent(Sprite);
        this.node.addChild(iconNode);

        // Cooldown text (center overlay)
        const cdNode = new Node('CdText');
        cdNode.setPosition(0, 0, 0);
        this.cooldownText = cdNode.addComponent(Label);
        this.cooldownText.fontSize = 14;
        this.cooldownText.color = Color.WHITE;
        this.node.addChild(cdNode);

        // Keybind (bottom-right)
        const bindNode = new Node('Keybind');
        bindNode.setPosition(16, -16, 0);
        this.keybindLabel = bindNode.addComponent(Label);
        this.keybindLabel.fontSize = 10;
        this.keybindLabel.color = Color.WHITE;
        this.node.addChild(bindNode);

        // Charge count (bottom-right if keybind absent)
        const chargeNode = new Node('Charges');
        chargeNode.setPosition(16, -16, 0);
        this.chargeLabel = chargeNode.addComponent(Label);
        this.chargeLabel.fontSize = 12;
        this.chargeLabel.color = Color.YELLOW;
        this.node.addChild(chargeNode);
    }

    update(data: ActionSlotData) {
        this.icon.spriteFrame = data.icon;
        this.icon.node.active = data.icon != null;
        this.keybindLabel.string = data.keybind || '';

        if (data.cooldownRemaining > 0) {
            this.cooldownText.string = data.cooldownRemaining > 60
                ? `${Math.ceil(data.cooldownRemaining / 60)}m`
                : `${data.cooldownRemaining.toFixed(1)}`;
            this.icon.node.opacity = 128;
        } else {
            this.cooldownText.string = '';
            this.icon.node.opacity = data.isUsable ? 255 : 128;
        }

        if (data.maxCharges > 1) {
            this.chargeLabel.string = `${data.charges}`;
            this.chargeLabel.node.active = true;
        } else {
            this.chargeLabel.node.active = false;
        }

        this.button.interactable = data.isUsable && data.cooldownRemaining <= 0;
    }
}
```

---

### Template 3: Minimap (小地图)

圆形裁剪地图，带区域名、时钟、标记点。

**Features:**
- Circular crop via RECT Mask + Sprite
- Rotating player arrow at center
- Zone name label below
- Clock display (optional)
- POI marker nodes (quest, vendor, mailbox icons)
- Border ring art (Sprite frame)
- Zoom +/− buttons overlay
- Full map toggle click → opens MapPanel (Template 18)

**Structure:**
```
Minimap (Node)
├── BorderRing (Sprite)
├── MapMask (Mask:RECT + Sprite[circle])
│   └── MapContent (Sprite[large map texture])
│       ├── PlayerArrow (Sprite, rotating)
│       ├── POIMarkers[0..N] (Sprite)
│       └── PartyMemberDots[0..N] (Sprite)
├── ZoneName (Label)
├── Clock (Label)
└── ZoomButtons (Node)
    ├── ZoomIn (Button)
    └── ZoomOut (Button)
```

**Code Example:**
```typescript
import { Node, Sprite, Label, Button, Mask, UITransform, Color, Vec2, Vec3, tween } from 'cc';

class Minimap {
    node: Node;
    private mapContent: Node;
    private playerArrow: Node;
    private zoneLabel: Label;
    private clockLabel: Label;
    private mapMask: Mask;
    private zoomLevel: number = 1.0;
    private minZoom: number = 0.5;
    private maxZoom: number = 2.0;
    private markers: Map<string, Node> = new Map();

    constructor(parent: Node, size: number = 150) {
        this.node = new Node('Minimap');
        this.node.addComponent(UITransform).setContentSize(size, size);
        parent.addChild(this.node);

        // Border ring
        const borderNode = new Node('Border');
        borderNode.addComponent(UITransform).setContentSize(size + 8, size + 8);
        borderNode.addComponent(Sprite);
        borderNode.setSiblingIndex(0);
        this.node.addChild(borderNode);

        // Mask for circular crop
        const maskNode = new Node('MapMask');
        maskNode.addComponent(UITransform).setContentSize(size - 8, size - 8);
        this.mapMask = maskNode.addComponent(Mask);
        this.mapMask.type = Mask.Type.RECT; // Uses circular sprite image
        this.node.addChild(maskNode);

        // Map content
        this.mapContent = new Node('MapContent');
        this.mapContent.addComponent(UITransform).setContentSize(512, 512);
        this.mapContent.addComponent(Sprite);
        maskNode.addChild(this.mapContent);

        // Player arrow (center, rotates)
        this.playerArrow = new Node('PlayerArrow');
        this.playerArrow.addComponent(UITransform).setContentSize(12, 12);
        this.playerArrow.addComponent(Sprite);
        maskNode.addChild(this.playerArrow);

        // Zone name
        const zoneNode = new Node('ZoneName');
        zoneNode.setPosition(0, -(size / 2 + 16), 0);
        this.zoneLabel = zoneNode.addComponent(Label);
        this.zoneLabel.fontSize = 12;
        this.zoneLabel.color = Color.WHITE;
        this.node.addChild(zoneNode);

        // Clock (optional, top-right of minimap)
        const clockNode = new Node('Clock');
        clockNode.setPosition(size / 2 - 30, size / 2 + 12, 0);
        this.clockLabel = clockNode.addComponent(Label);
        this.clockLabel.fontSize = 10;
        this.clockLabel.color = Color.WHITE;
        this.node.addChild(clockNode);
    }

    updatePlayerPosition(worldPos: Vec3, rotation: number) {
        // Pan map texture offset inversely
        const halfMap = 256; // half of map content pixel size
        this.mapContent.setPosition(
            -worldPos.x * this.zoomLevel,
            -worldPos.z * this.zoomLevel,
            0
        );
        this.playerArrow.angle = rotation;
    }

    setZoneName(name: string) { this.zoneLabel.string = name; }

    setClock(hours: number, minutes: number) {
        this.clockLabel.string = `${hours}:${minutes.toString().padStart(2, '0')}`;
    }

    addMarker(id: string, worldPos: Vec3, icon: SpriteFrame) {
        const marker = new Node(`Marker_${id}`);
        marker.addComponent(UITransform).setContentSize(12, 12);
        marker.addComponent(Sprite).spriteFrame = icon;
        marker.setPosition(worldPos.x * this.zoomLevel, worldPos.z * this.zoomLevel, 0);
        this.mapContent.addChild(marker);
        this.markers.set(id, marker);
    }

    zoomIn() {
        this.zoomLevel = Math.min(this.maxZoom, this.zoomLevel * 1.5);
        this.mapContent.setScale(this.zoomLevel, this.zoomLevel);
    }

    zoomOut() {
        this.zoomLevel = Math.max(this.minZoom, this.zoomLevel / 1.5);
        this.mapContent.setScale(this.zoomLevel, this.zoomLevel);
    }
}
```

---

### Template 4: ChatWindow (聊天窗口)

可调整大小多标签聊天窗口。

**Features:**
- Multi-tab system (General, Combat Log, Whisper, Party, Guild, System)
- Tab buttons with flashing on new message in inactive tab
- RichText message display in ScrollView
- Timestamp prefix, channel color coding
- Item link highlighting
- Player name click → whisper / invite menu
- Resize handle (bottom-right drag zone)
- EditBox input line at bottom
- Chat channel selector dropdown (Button)

**Structure:**
```
ChatWindow (Node)
├── TabBar (Layout:HORIZONTAL)
│   └── Tab[0..N] (Button + Label)
├── MessageScroll (ScrollView)
│   └── Content (Layout:VERTICAL)
│       └── MessageLine[0..N] (RichText)
├── ResizeHandle (Button, bottom-right)
└── InputArea (Node)
    ├── ChannelButton (Button)
    ├── InputField (EditBox)
    └── SendButton (Button)
```

**Code Example:**
```typescript
import { Node, ScrollView, EditBox, Button, Layout, RichText, Label, UITransform, Color } from 'cc';

enum ChatChannel { SAY = 0, PARTY = 1, GUILD = 2, WHISPER = 3, SYSTEM = 4, COMBAT = 5 }

class ChatTab { label: string; channel: ChatChannel; unread: number = 0; }

class ChatWindow {
    node: Node;
    private scrollView: ScrollView;
    private content: Node;
    private editBox: EditBox;
    private tabs: ChatTab[] = [];
    private activeTabIndex: number = 0;
    private maxLines: number = 200;
    private tabButtons: Button[] = [];
    private tabLabels: Label[] = [];

    constructor(parent: Node, width: number = 360, height: number = 200) {
        this.node = new Node('ChatWindow');
        this.node.addComponent(UITransform).setContentSize(width, height);
        parent.addChild(this.node);

        // Initialize tabs
        const channelDefs = [
            { label: '综合', channel: ChatChannel.SAY },
            { label: '战斗', channel: ChatChannel.COMBAT },
            { label: '队伍', channel: ChatChannel.PARTY },
            { label: '公会', channel: ChatChannel.GUILD },
        ];

        // Tab bar
        const tabBar = new Node('TabBar');
        tabBar.addComponent(UITransform).setContentSize(width, 22);
        tabBar.addComponent(Layout).type = Layout.Type.HORIZONTAL;
        this.node.addChild(tabBar);

        channelDefs.forEach((def, i) => {
            const tabNode = new Node(`Tab_${i}`);
            tabNode.addComponent(UITransform).setContentSize(56, 22);
            const btn = tabNode.addComponent(Button);
            const lbl = tabNode.addComponent(Label);
            lbl.string = def.label;
            lbl.fontSize = 12;
            this.tabButtons.push(btn);
            this.tabLabels.push(lbl);
            this.tabs.push({ label: def.label, channel: def.channel });
            tabBar.addChild(tabNode);
        });

        // Message scroll view
        const scrollNode = new Node('MessageScroll');
        scrollNode.addComponent(UITransform).setContentSize(width, height - 44);
        scrollNode.setPosition(0, -11, 0);
        this.scrollView = scrollNode.addComponent(ScrollView);
        this.scrollView.vertical = true;
        this.scrollView.horizontal = false;
        this.scrollView.inertia = true;
        this.scrollView.elastic = true;
        this.node.addChild(scrollNode);

        // Content
        this.content = new Node('Content');
        this.content.addComponent(UITransform).setContentSize(width - 8, 0);
        this.content.addComponent(Layout).type = Layout.Type.VERTICAL;
        this.scrollView.content = this.content;

        // Input area
        const inputArea = new Node('InputArea');
        inputArea.addComponent(UITransform).setContentSize(width, 22);
        inputArea.setPosition(0, -(height - 11), 0);
        this.node.addChild(inputArea);

        const inputNode = new Node('Input');
        inputNode.addComponent(UITransform).setContentSize(width - 40, 22);
        this.editBox = inputNode.addComponent(EditBox);
        this.editBox.inputMode = EditBox.InputMode.SINGLE_LINE;
        this.editBox.placeholder = '输入消息...';
        inputArea.addChild(inputNode);

        // Resize handle
        const resizeNode = new Node('ResizeHandle');
        resizeNode.addComponent(UITransform).setContentSize(16, 16);
        resizeNode.setPosition(width / 2 - 8, -(height / 2 - 8), 0);
        resizeNode.addComponent(Button);
        resizeNode.addComponent(Sprite);
        this.node.addChild(resizeNode);
        // Attach resize drag logic here
    }

    addMessage(text: string, channel: ChatChannel, sender?: string) {
        const lineNode = new Node('MsgLine');
        const lineRT = lineNode.addComponent(RichText);
        lineRT.fontSize = 12;

        let color = '#FFFFFF';
        switch (channel) {
            case ChatChannel.SAY: color = '#FFFFFF'; break;
            case ChatChannel.PARTY: color = '#66CCFF'; break;
            case ChatChannel.GUILD: color = '#66FF66'; break;
            case ChatChannel.WHISPER: color = '#FF66FF'; break;
            case ChatChannel.SYSTEM: color = '#FFFF66'; break;
            case ChatChannel.COMBAT: color = '#FF9966'; break;
        }

        const now = new Date();
        const timeStr = `${now.getHours()}:${now.getMinutes().toString().padStart(2, '0')}`;
        const senderPart = sender ? `<color=#999999>[${timeStr}] <b>${sender}</b>: </color>` : '';
        lineRT.string = `${senderPart}<color=${color}>${this.escapeRichText(text)}</color>`;
        lineRT.maxWidth = this.scrollView.node.getComponent(UITransform).width - 8;

        this.content.addChild(lineNode);
        this.pruneLines();
        this.scrollView.scrollToBottom();
    }

    private escapeRichText(text: string): string {
        return text.replace(/</g, '&lt;').replace(/>/g, '&gt;');
    }

    private pruneLines() {
        while (this.content.children.length > this.maxLines) {
            const first = this.content.children[0];
            first.removeFromParent();
            first.destroy();
        }
    }
}
```

---

### Template 5: PartyFrame (小队框体)

紧凑队员头像+血条列表。

**Features:**
- 5-member horizontal or vertical list
- Compact UnitFrame per member (portrait + name + health bar)
- Leader crown icon
- Target-of-party-member sub-frame (on click)
- Health deficit color (missing HP shown)
- Disconnect icon overlay
- Dead/release spirit indicator
- Right-click context menu (promote, kick, trade, whisper)

**Structure:**
```
PartyFrame (Node)
├── Header (Label "小队")
└── MemberList (Layout:VERTICAL)
    └── PartyMemberSlot[0..4] (Button)
        ├── Portrait (Sprite + circular Mask)
        ├── NameLabel (Label, class-colored)
        ├── HealthBar (ProgressBar)
        ├── HealthText (Label)
        ├── LeaderCrown (Sprite)
        ├── DisconnectIcon (Sprite)
        └── DeathOverlay (Sprite)
```

**Code Example:**
```typescript
import { Node, Sprite, Label, ProgressBar, Layout, UITransform, Button, Mask } from 'cc';

interface PartyMemberData {
    name: string;
    level: number;
    maxHp: number;
    currentHp: number;
    class: CharacterClass;
    isLeader: boolean;
    isDead: boolean;
    isDisconnected: boolean;
}

enum CharacterClass { WARRIOR, MAGE, ROGUE, PRIEST, HUNTER, DRUID, WARLOCK, PALADIN, SHAMAN }

const CLASS_COLORS: Record<CharacterClass, string> = {
    [CharacterClass.WARRIOR]: '#C79C6E',
    [CharacterClass.MAGE]: '#69CCF0',
    [CharacterClass.ROGUE]: '#FFF569',
    [CharacterClass.PRIEST]: '#FFFFFF',
    [CharacterClass.HUNTER]: '#ABD473',
    [CharacterClass.DRUID]: '#FF7D0A',
    [CharacterClass.WARLOCK]: '#9482C9',
    [CharacterClass.PALADIN]: '#F58CBA',
    [CharacterClass.SHAMAN]: '#0070DE',
};

class PartyFrame {
    node: Node;
    private memberSlots: Map<number, Node> = new Map();

    constructor(parent: Node) {
        this.node = new Node('PartyFrame');
        this.node.addComponent(UITransform).setContentSize(140, 240);
        parent.addChild(this.node);

        const header = new Node('Header');
        header.addComponent(UITransform).setContentSize(140, 22);
        header.addComponent(Label).string = '小队';
        header.getComponent(Label).fontSize = 14;
        this.node.addChild(header);

        const list = new Node('MemberList');
        list.addComponent(UITransform).setContentSize(140, 218);
        list.addComponent(Layout).type = Layout.Type.VERTICAL;
        list.getComponent(Layout).spacingY = 2;
        list.setPosition(0, -14, 0);
        this.node.addChild(list);
    }

    createMemberSlot(data: PartyMemberData, index: number): Node {
        const slotNode = new Node(`PartyMember_${index}`);
        slotNode.addComponent(UITransform).setContentSize(140, 38);
        slotNode.addComponent(Button);

        // Portrait
        const portrait = new Node('Portrait');
        portrait.addComponent(UITransform).setContentSize(32, 32);
        portrait.addComponent(Mask).type = Mask.Type.RECT;
        portrait.addComponent(Sprite);
        portrait.setPosition(-50, 0, 0);
        slotNode.addChild(portrait);

        // Name
        const nameNode = new Node('Name');
        nameNode.addComponent(UITransform).setContentSize(80, 16);
        const nameLabel = nameNode.addComponent(Label);
        nameLabel.fontSize = 11;
        nameLabel.string = data.name;
        nameLabel.color = this.hexToColor(CLASS_COLORS[data.class]);
        nameNode.setPosition(10, 10, 0);
        slotNode.addChild(nameNode);

        // Health bar
        const hpBarNode = new Node('HealthBar');
        hpBarNode.addComponent(UITransform).setContentSize(80, 10);
        const hpBar = hpBarNode.addComponent(ProgressBar);
        hpBar.progress = data.currentHp / data.maxHp;
        hpBarNode.setPosition(10, -2, 0);
        slotNode.addChild(hpBarNode);

        // Health text
        const hpTextNode = new Node('HealthText');
        hpTextNode.addComponent(UITransform).setContentSize(80, 14);
        const hpText = hpTextNode.addComponent(Label);
        hpText.fontSize = 9;
        hpText.string = `${data.currentHp}/${data.maxHp}`;
        hpTextNode.setPosition(10, -10, 0);
        slotNode.addChild(hpTextNode);

        // Leader crown
        if (data.isLeader) {
            const crown = new Node('Crown');
            crown.addComponent(UITransform).setContentSize(14, 14);
            crown.addComponent(Sprite);
            crown.setPosition(-64, 10, 0);
            slotNode.addChild(crown);
        }

        return slotNode;
    }
}
```

---

### Template 6: RaidFrame (团队框体)

网格式团队血条，用于快速治疗/驱散。

**Features:**
- Grid layout (5 cols × 4 rows or 8 cols × 5 rows)
- Compact health bar per member (no portrait, just colored box + text)
- Class color background
- Health deficit highlighting (missing HP shown as dark overlay)
- Debuff highlight border (magic/curse/poison/disease color-coded glow)
- Incoming heal prediction overlay
- Aggro warning border
- Out-of-range alpha dimming
- Group header separators

**Structure:**
```
RaidFrame (Node)
├── Header (Label "团队")
└── RaidGrid (Layout:GRID, 5 cols)
    ├── GroupHeader1 (Label "一队")
    ├── RaidSlot[0..4] (Button)  // Group 1
    ├── GroupHeader2 (Label "二队")
    └── RaidSlot[5..9] (Button)  // Group 2
        └── [Same as compact PartyMemberSlot layout]
```

---

### Template 7: QuestTracker (任务追踪)

右侧任务目标列表，支持折叠展开。

**Features:**
- Scrollable quest list (max 5 visible by default)
- Quest title (bold) + color by difficulty/type
- Objective list with completion checkmarks
- Progress bar for "kill/collect X/Y" type objectives
- Quest item use button on relevant objectives
- Collapse/expand toggle per quest
- Pin quest to always show
- Auto-pop on new quest acceptance

**Structure:**
```
QuestTracker (Node)
├── Header (Label "任务")
├── QuestList (ScrollView)
│   └── Content (Layout:VERTICAL)
│       └── QuestEntry[0..N] (Node)
│           ├── QuestTitle (Button + Label, toggles collapse)
│           ├── QuestColorDot (Sprite, diff color)
│           └── ObjectiveList (Layout:VERTICAL)
│               └── ObjectiveLine[0..M] (Node)
│                   ├── Checkbox (Sprite)
│                   ├── ObjectiveText (Label)
│                   ├── ProgressText (Label "3/10")
│                   └── UseItemButton (Button, optional)
```

---

### Template 8: Tooltip (提示框)

跟随鼠标/UI元素的信息浮动面板。

**Features:**
- Float near cursor or anchor element
- Auto-position to avoid screen edges
- Multi-segment content (title, subtitle, body, footer)
- Item quality color border (gray/white/green/blue/purple/orange)
- Item icon + name header
- Stat lines with +/- comparison (equipped vs new)
- Set bonus listing
- "Right-click to equip/use" footer text
- Fade-in animation

**Code Example:**
```typescript
import { Node, Sprite, Label, RichText, UITransform, Color, Layout, Vec2, Vec3, tween, UIOpacity } from 'cc';

enum ItemQuality { POOR = 0, COMMON = 1, UNCOMMON = 2, RARE = 3, EPIC = 4, LEGENDARY = 5 }

const QUALITY_COLORS: Record<ItemQuality, Color> = {
    [ItemQuality.POOR]: Color.GRAY,
    [ItemQuality.COMMON]: Color.WHITE,
    [ItemQuality.UNCOMMON]: new Color(30, 255, 0),
    [ItemQuality.RARE]: new Color(0, 112, 221),
    [ItemQuality.EPIC]: new Color(163, 53, 238),
    [ItemQuality.LEGENDARY]: new Color(255, 128, 0),
};

interface TooltipData {
    title: string;
    quality: ItemQuality;
    icon?: SpriteFrame;
    subtitle?: string;
    bodyLines: string[];
    statLines: string[];  // e.g., "+12 力量"
    footer?: string;
}

class Tooltip {
    node: Node;
    private titleLabel: Label;
    private bodyRichText: RichText;
    private footerLabel: Label;
    private border: Sprite;
    private content: Node;
    private isVisible: boolean = false;

    constructor() {
        this.node = new Node('Tooltip');
        this.node.addComponent(UITransform).setContentSize(240, 120);
        this.node.addComponent(UIOpacity);
        this.node.active = false;

        // Border
        const borderNode = new Node('Border');
        borderNode.addComponent(UITransform).setContentSize(244, 124);
        this.border = borderNode.addComponent(Sprite);
        this.node.addChild(borderNode);

        // Content container
        this.content = new Node('Content');
        this.content.addComponent(UITransform).setContentSize(232, 112);
        this.content.addComponent(Layout).type = Layout.Type.VERTICAL;
        this.content.addComponent(Layout).spacingY = 2;
        this.node.addChild(this.content);

        // Title
        const titleNode = new Node('Title');
        titleNode.addComponent(UITransform).setContentSize(220, 20);
        this.titleLabel = titleNode.addComponent(Label);
        this.titleLabel.fontSize = 14;
        this.content.addChild(titleNode);

        // Body
        const bodyNode = new Node('Body');
        bodyNode.addComponent(UITransform).setContentSize(220, 60);
        this.bodyRichText = bodyNode.addComponent(RichText);
        this.bodyRichText.fontSize = 12;
        this.content.addChild(bodyNode);

        // Footer
        const footerNode = new Node('Footer');
        footerNode.addComponent(UITransform).setContentSize(220, 16);
        this.footerLabel = footerNode.addComponent(Label);
        this.footerLabel.fontSize = 10;
        this.footerLabel.color = Color.GRAY;
        this.content.addChild(footerNode);
    }

    show(data: TooltipData, screenPos: Vec2) {
        this.node.active = true;
        this.isVisible = true;

        // Color title by quality
        const qualityColor = QUALITY_COLORS[data.quality];
        this.titleLabel.string = data.title;
        this.titleLabel.color = qualityColor;
        this.border.color = qualityColor;

        // Build body
        let bodyText = '';
        if (data.subtitle) bodyText += `<color=#999999>${data.subtitle}</color><br>`;
        data.bodyLines.forEach(line => bodyText += `${line}<br>`);
        if (data.statLines.length > 0) {
            bodyText += '<br>';
            data.statLines.forEach(stat => bodyText += `<color=#00FF00>${stat}</color><br>`);
        }
        this.bodyRichText.string = bodyText;

        this.footerLabel.string = data.footer || '';

        // Position: follow cursor, avoid screen edge
        this.positionAt(screenPos);
        this.fadeIn();
    }

    private positionAt(screenPos: Vec2) {
        const size = this.node.getComponent(UITransform).contentSize;
        const x = Math.min(screenPos.x + 16, 960 - size.width / 2);  // Assuming 1920 design width
        const y = Math.max(screenPos.y - size.height / 2, size.height / 2 - 540);
        this.node.setPosition(x, y, 0);
    }

    private fadeIn() {
        const opacity = this.node.getComponent(UIOpacity);
        opacity.opacity = 0;
        tween(opacity).to(0.15, { opacity: 255 }).start();
    }

    hide() {
        this.isVisible = false;
        this.node.active = false;
    }
}
```

---

### Template 9: BagPanel (背包面板)

网格物品栏，支持分类标签。

**Features:**
- Item slot grid (variable row×col per bag)
- Category tabs (All, Equipment, Consumable, Trade Goods, Quest Items)
- Item count overlay
- Item quality border glow
- Drag-and-drop between slots
- Empty slot count display
- Gold/Silver/Copper currency display
- Sort bag button
- Auto-stack

**Structure:**
```
BagPanel (Node)
├── TitleBar (Label "背包")
├── CategoryTabs (Layout:HORIZONTAL)
│   └── Tab[0..N] (Button + Label)
├── CurrencyBar (Node)
│   ├── GoldIcon (Sprite) + GoldText (Label)
│   ├── SilverIcon (Sprite) + SilverText (Label)
│   └── CopperIcon (Sprite) + CopperText (Label)
├── BagGrid (Layout:GRID)
│   └── BagSlot[0..N] (Button)
│       ├── ItemIcon (Sprite)
│       ├── CountLabel (Label)
│       ├── QualityBorder (Sprite)
│       └── NewItemGlow (Sprite)
└── BottomBar
    └── SortButton (Button)
```

---

### Template 10: CharacterPanel (角色面板)

装备槽+属性面板。

**Features:**
- Character doll (Sprite, empty body outline)
- Equipment slots in ring/papyrus layout (Head, Neck, Shoulder, Back, Chest, Wrist, Hands, Waist, Legs, Feet, Ring1, Ring2, Trinket1, Trinket2, MainHand, OffHand/Ranged)
- Item level display
- Base stats (Strength, Agility, Stamina, Intellect, Spirit)
- Secondary stats (Crit, Haste, Mastery, Versatility)
- Equip/unequip by right-click from Bag
- Stat comparison coloring (green up / red down)
- Equipment durability bar

**Structure:**
```
CharacterPanel (Node)
├── TitleBar
├── EquipmentDollArea (Node)
│   ├── CharacterModel (Sprite)
│   └── EquipmentSlots (Grid of BagSlots, fixed positions)
├── StatList (ScrollView)
│   └── Content (Layout:VERTICAL)
│       ├── BaseStatsSection
│       │   └── StatRow[0..N] (Label icon + name + value)
│       └── SecondaryStatsSection
│           └── StatRow[0..N]
└── ItemLevelDisplay (Label)
```

---

### Template 11: TargetCastBar (目标施法条)

显示目标正在施放的法术及剩余时间。

**Features:**
- Spell name label
- Cast progress bar with fill animation
- Remaining time text
- Interruptible shield icon (if shieldable)
- Enemy cast lockout indicator

**Structure:**
```
CastingBar (Node)
├── CastBorder (Sprite)
├── SpellName (Label)
├── CastProgress (ProgressBar)
├── CastTime (Label)
└── InterruptShield (Sprite, optional)
```

---

### Template 12: Nameplate (头顶血条)

角色头顶跟随的生命条，世界空间→屏幕空间投影。

**Features:**
- World-space→screen-space position tracking
- Health bar with class color
- Name text
- Level display
- Cast bar (enemy-only)
- Threat indicator (aggro glow)
- Buff/Debuff icons (optional, above nameplate)
- Selection highlight
- Click-through for targeting
- Distance-based alpha fade

**Structure:**
```
NameplateManager (Node, manages all nameplates)
└── NameplatePool (ObjectPool)
    └── Nameplate[reusable] (Node)
        ├── Background (Sprite)
        ├── NameText (Label)
        ├── HealthBar (ProgressBar)
        ├── CastBar (ProgressBar, enemy)
        ├── ThreatGlow (Sprite)
        └── BuffIconsRow (Layout:HORIZONTAL)
```

**Code Example:**
```typescript
import { Node, Sprite, Label, ProgressBar, UITransform, Vec3, Camera, Color, UIOpacity, Layout } from 'cc';

class NameplateManager {
    private nameplatePool: Node[] = [];
    private activePlates: Map<number, Node> = new Map();
    private uiCamera: Camera;

    constructor(parent: Node, poolSize: number = 50) {
        const container = new Node('Nameplates');
        parent.addChild(container);

        for (let i = 0; i < poolSize; i++) {
            const plate = this.createNameplate();
            plate.active = false;
            container.addChild(plate);
            this.nameplatePool.push(plate);
        }
    }

    private createNameplate(): Node {
        const plate = new Node('Nameplate');
        plate.addComponent(UITransform).setContentSize(100, 30);

        const bg = new Node('Bg');
        bg.addComponent(UITransform).setContentSize(100, 6);
        bg.addComponent(Sprite);
        bg.setPosition(0, 10, 0);
        plate.addChild(bg);

        const hp = new Node('HealthBar');
        hp.addComponent(UITransform).setContentSize(98, 4);
        hp.addComponent(ProgressBar);
        hp.setPosition(0, 10, 0);
        plate.addChild(hp);

        const name = new Node('Name');
        name.addComponent(UITransform).setContentSize(100, 14);
        const lbl = name.addComponent(Label);
        lbl.fontSize = 10;
        lbl.color = Color.WHITE;
        name.setPosition(0, 16, 0);
        plate.addChild(name);

        return plate;
    }

    acquire(): Node {
        const plate = this.nameplatePool.pop();
        if (plate) { plate.active = true; return plate; }
        return null; // Pool exhausted
    }

    release(plate: Node) {
        plate.active = false;
        this.nameplatePool.push(plate);
    }
}
```

---

### Template 13: CombatText (战斗文字)

浮动的伤害/治疗/暴击/闪避等战斗数字。

**Features:**
- Float-up tween animation (rise + fade)
- Type-based color: damage (yellow→white→red crit), heal (green), dodge/miss/parry (white)
- Size variation: crit = larger
- Icon prefix (school icon: fire/frost/arcane for spells)
- Accumulation mode (stacking numbers) vs individual mode
- Screen shake on large crit

**Code Example:**
```typescript
import { Node, Label, UITransform, Color, tween, Vec3, UIOpacity } from 'cc';

enum CombatTextType { DAMAGE, CRIT, HEAL, DODGE, MISS, PARRY, BLOCK, ABSORB }

class CombatText {
    static show(parent: Node, value: number, type: CombatTextType, worldPos?: Vec3) {
        const node = new Node('CombatText');
        node.addComponent(UITransform).setContentSize(120, 30);
        node.addComponent(UIOpacity);

        const label = node.addComponent(Label);
        label.fontSize = type === CombatTextType.CRIT ? 22 : 14;
        label.string = '';

        switch (type) {
            case CombatTextType.DAMAGE:
                label.string = `-${value}`;
                label.color = new Color(255, 255, 100);
                break;
            case CombatTextType.CRIT:
                label.string = `-${value}`;
                label.color = new Color(255, 50, 50);
                label.fontSize = 26;
                break;
            case CombatTextType.HEAL:
                label.string = `+${value}`;
                label.color = new Color(50, 255, 50);
                break;
            case CombatTextType.DODGE:
                label.string = '闪避';
                label.color = new Color(255, 255, 255);
                break;
            case CombatTextType.MISS:
                label.string = '未命中';
                label.color = new Color(255, 255, 255);
                break;
            case CombatTextType.PARRY:
                label.string = '招架';
                label.color = new Color(255, 255, 255);
                break;
            case CombatTextType.BLOCK:
                label.string = `(${value})`;
                label.color = new Color(200, 200, 200);
                break;
        }

        const startPos = worldPos ? new Vec3(worldPos.x, worldPos.y + 40, 0) : new Vec3(0, 0, 0);
        node.setPosition(startPos);
        parent.addChild(node);

        // Animate: rise + fade
        const targetPos = startPos.clone();
        targetPos.y += 40;
        const opacity = node.getComponent(UIOpacity);

        tween(node)
            .to(1.5, { position: targetPos })
            .start();
        tween(opacity)
            .delay(0.8)
            .to(0.7, { opacity: 0 })
            .call(() => {
                node.removeFromParent();
                node.destroy();
            })
            .start();
    }

    static showCrit(parent: Node, value: number, worldPos?: Vec3) {
        CombatText.show(parent, value, CombatTextType.CRIT, worldPos);
    }

    static showHeal(parent: Node, value: number, worldPos?: Vec3) {
        CombatText.show(parent, value, CombatTextType.HEAL, worldPos);
    }
}
```

---

### Template 14: LootRoll（拾取掷骰）

队伍掉落时的 Need/Greed/Pass 投骰对话框。

**Features:**
- Item icon + name + quality color border
- Need / Greed / Pass 三按钮
- Countdown timer bar
- Need >= Greed roll value display (auto-award)
- Roll animation (dice spinning → reveal result)
- Tie handling display
- "Already won 1 item" warning text

---

### Template 15: VendorPanel (商人面板)

买/卖/修理界面。

**Features:**
- Split layout: vendor items (left) + player bag (right/compact)
- Currency display bar
- Item slot with price overlay
- Buy confirmation dialog with quantity selector
- Sell mode: click player bag item → confirm sell
- Buyback tab (last 12 sold items)
- Repair button with total cost preview
- "Can equip" highlight on usable items
- Item comparison tooltip on hover

---

### Template 16: MapPanel (世界地图)

全屏/半屏世界地图覆盖。

**Features:**
- Large scrollable/zoomable map texture
- Zone boundary lines
- Player position arrow
- Quest objective markers (numbered)
- Flight path nodes
- Zone level range display
- Fog-of-war undiscovered areas
- Search bar for NPC/location
- Pin markers (right-click)

**Structure:**
```
MapPanel (Node, fullscreen overlay)
├── Background (Sprite, black semi-transparent)
├── MapScrollView (ScrollView, both directions)
│   └── MapContent (Sprite[large texture])
│       ├── PlayerArrow (Sprite)
│       ├── QuestMarkers[0..N] (Sprite + Label)
│       ├── POINodes[0..N] (Sprite + Label)
│       └── FogOfWar (Graphics, masking undiscovered)
├── ZoneLabel (Label, top)
├── SearchBar (EditBox, top-right)
├── CloseButton (Button, corner X)
└── ZoomSlider (Slider, right side)
```

---

### Template 17: TalentPanel (天赋面板)

天赋树分页面板。

**Features:**
- Tab bar per specialization (3 tabs: e.g., Arms/Fury/Protection)
- Tree layout: branch nodes connected by lines
- Talent nodes: clickable circles with icons
- Points spent / total display
- Tooltip on hover
- Preview changes before confirm
- Reset all talents button (with gold cost confirmation)

---

### Template 18: AuctionHouse (拍卖行)

搜索/浏览/竞标/一口价界面。

**Features:**
- Search form: item name EditBox, category dropdown, level range, quality filter
- Results list (ScrollView of item rows)
- Bid / Buyout price columns
- Sortable column headers
- Bid input field + confirm button
- "My Auctions" tab
- Time remaining countdown per item
- Outbid notification

---

### Template 19: GuildPanel (公会面板)

公会管理+成员列表+信息。

**Features:**
- Tab bar: Info, Roster, Perks, Bank
- Roster list with sortable columns (Name, Rank, Level, Zone, Note, Officer Note)
- Online/offline status dots
- Right-click context menu (promote, demote, kick, whisper, invite to party)
- Guild message of the day (editable by officers)
- Guild perk list (unlocked perks)
- Guild bank tabs with permissions

---

### Template 20: BuffFrame (Buff/Debuff显示)

玩家Buff和Debuff图标行——通常位于屏幕角落或小地图旁。

**Features:**
- Horizontal row of small icons
- Buff/Debuff border type distinction
- Timer/count overlay
- Tooltip on hover
- Cancel buff on right-click
- Pulse glow when about to expire (<30s)
- Consolidation mode (stack similar buffs)

---

### Template Assembly: Full WOW-Style HUD

Combining all templates into a production-ready MMORPG HUD:

```typescript
class MMOHUD {
    constructor(canvasNode: Node) {
        // Populate screen by WOW layout zones

        // Top-Left Cluster
        new UnitFrame(canvasNode, true).node.setPosition(-420, 280, 0);  // Player
        new TargetFrame(canvasNode).node.setPosition(-260, 280, 0);       // Target

        // Top-Right Cluster
        new Minimap(canvasNode, 150).node.setPosition(420, 280, 0);
        new BuffFrame(canvasNode).node.setPosition(300, 290, 0);

        // Right Side
        new QuestTracker(canvasNode).node.setPosition(420, 80, 0);

        // Right Side Middle
        new PartyFrame(canvasNode).node.setPosition(420, -60, 0);

        // Bottom-Left
        new ChatWindow(canvasNode).node.setPosition(-420, -240, 0);

        // Bottom-Center
        const actionBar = new ActionBar(canvasNode, 12);
        actionBar.node.setPosition(0, -280, 0);

        // Bottom-Right
        new BagBar(canvasNode).node.setPosition(400, -290, 0);

        // Centered (conditional)
        const castingBar = new CastingBar(canvasNode);
        castingBar.node.setPosition(0, 180, 0);
        castingBar.node.active = false;

        // Overlay Layer
        const tooltip = new Tooltip();                // Singleton
        const nameplateMgr = new NameplateManager(canvasNode);
        const combatText = CombatText;                // Static class
    }
}
```

---

## Code Examples (General UI Widgets)

### Creating a Button with All Transition Modes

```typescript
import { Button, Sprite, Label, SpriteFrame, Color } from 'cc';

// COLOR transition
const colorBtn = node.addComponent(Button);
colorBtn.transition = Button.Transition.COLOR;
colorBtn.normalColor = new Color(255, 255, 255);
colorBtn.pressedColor = new Color(200, 200, 200);
colorBtn.hoverColor = new Color(230, 230, 230);
colorBtn.disabledColor = new Color(128, 128, 128);
colorBtn.clickEvents.push(/* EventHandler */);

// SPRITE transition
const spriteBtn = node.addComponent(Button);
spriteBtn.transition = Button.Transition.SPRITE;
spriteBtn.normalSprite = normalSF;
spriteBtn.pressedSprite = pressedSF;
spriteBtn.hoverSprite = hoverSF;
spriteBtn.disabledSprite = disabledSF;

// SCALE transition
const scaleBtn = node.addComponent(Button);
scaleBtn.transition = Button.Transition.SCALE;
scaleBtn.zoomScale = 0.9;
scaleBtn.duration = 0.1;
```

### Toggle Group (Radio Buttons)

```typescript
import { Toggle, ToggleContainer } from 'cc';

const containerNode = new Node('ToggleGroup');
const container = containerNode.addComponent(ToggleContainer);
container.allowSwitchOff = false;  // At least one always checked

for (let i = 0; i < 4; i++) {
    const toggleNode = new Node(`Toggle_${i}`);
    const toggle = toggleNode.addComponent(Toggle);
    toggle.isChecked = (i === 0);  // First selected by default
    toggle.checkEvents.push(/* onChecked */);
    toggle.uncheckEvents.push(/* onUnchecked */);
    containerNode.addChild(toggleNode);
    // ToggleContainer auto-manages radio behavior
}
```

### ScrollView with Dynamic Content (Virtual List Pattern)

```typescript
import { ScrollView, Layout, Node, UITransform } from 'cc';

class VirtualList {
    private scrollView: ScrollView;
    private itemPool: Node[] = [];
    private itemHeight: number = 80;
    private totalItems: number = 0;
    private visibleCount: number = 0;

    constructor(scrollNode: Node, itemPrefab: Node, visibleCount: number) {
        this.visibleCount = visibleCount;
        this.scrollView = scrollNode.getComponent(ScrollView);

        // Pre-create visible items
        for (let i = 0; i < visibleCount + 2; i++) {  // +2 for buffer
            const item = instantiate(itemPrefab);
            item.active = false;
            this.scrollView.content.addChild(item);
            this.itemPool.push(item);
        }

        // Listen to scroll
        this.scrollView.scrollEvents.push((scrollOffset: Vec2) => {
            this.onScroll();
        });
    }

    setData(data: any[], totalCount: number) {
        this.totalItems = totalCount;
        const layout = this.scrollView.content.getComponent(UITransform);
        layout.height = totalCount * this.itemHeight;
        this.onScroll();
    }

    private onScroll() {
        const offset = this.scrollView.getScrollOffset();
        const firstVisibleIndex = Math.floor(offset.y / this.itemHeight);
        // Recycle items that scrolled out of view
        // Assign new data to visible items
        // (Full implementation depends on specific needs)
    }
}
```

### Layout + Widget for Responsive Design

```typescript
import { Layout, Widget, UITransform } from 'cc';

// Auto-arranging horizontal button bar
const bar = new Node('ButtonBar');
bar.addComponent(UITransform).setContentSize(600, 50);
const layout = bar.addComponent(Layout);
layout.type = Layout.Type.HORIZONTAL;
layout.spacingX = 8;
layout.resizeMode = Layout.ResizeMode.NONE;

// Widget: anchor to bottom-center, stretch horizontally
const widget = bar.addComponent(Widget);
widget.isAlignBottom = true;
widget.bottom = 20;
widget.isAlignHorizontalCenter = true;
widget.alignMode = Widget.AlignMode.ALWAYS;
```

### RichText with Images and Styling

```typescript
import { RichText } from 'cc';

const richText = node.addComponent(RichText);
richText.string = `
    <color=#FFD700><size=24><b>传说物品</b></size></color><br>
    <img src='sword_icon' height=20/> <size=16>龙息之刃</size><br>
    <color=#999999>装备后绑定</color><br>
    <color=#00FF00>+45 力量</color><br>
    <color=#00FF00>+60 耐力</color><br>
`;
richText.maxWidth = 260;
richText.fontSize = 14;
```

### EditBox with Validation

```typescript
import { EditBox } from 'cc';

const editBox = node.addComponent(EditBox);
editBox.inputMode = EditBox.InputMode.SINGLE_LINE;
editBox.maxLength = 20;
editBox.placeholder = '请输入角色名...';
editBox.returnType = EditBox.ReturnType.DONE;

editBox.node.on(EditBox.EventType.TEXT_CHANGED, (edit: EditBox) => {
    // Validate: only allow alphanumeric + Chinese chars
    const valid = /^[a-zA-Z0-9\u4e00-\u9fa5]*$/.test(edit.string);
    if (!valid) {
        edit.string = edit.string.replace(/[^a-zA-Z0-9\u4e00-\u9fa5]/g, '');
    }
});
```

### Slider with Value Display

```typescript
import { Slider, Label } from 'cc';

const slider = node.addComponent(Slider);
slider.direction = Slider.Direction.Horizontal;

const valueLabel = new Node('ValueLabel');
const lbl = valueLabel.addComponent(Label);
lbl.fontSize = 14;

slider.slideEvents.push((slider: Slider) => {
    lbl.string = Math.round(slider.progress * 100) + '%';
});
```

---

## Usage Guide

### When to Use This Skill

- Building interactive UI widgets (buttons, toggles, sliders, progress bars, input fields)
- Implementing scrolling content (ScrollView, PageView)
- Creating responsive layouts (Layout + Widget + SafeArea)
- Displaying styled text (RichText with HTML-like tags)
- Setting up MMORPG HUD elements (action bars, unit frames, minimap, chat, quest tracker, nameplates, combat text)
- Implementing party/raid frames for group content
- Building inventory/character/talent panels
- Multi-resolution UI adaptation

### Best Practices

1. **Canvas Setup**: Set `designResolution` to cover most target devices; use `FitMode.AUTO` with WIDTH priority for landscape games
2. **Draw Call Optimization**: Use `SpriteAtlas` to batch UI sprites; avoid breaking batches with non-atlas sprites between atlas sprites
3. **ScrollView Performance**: Implement virtual list (object pool) for scroll views with >50 items; destroy items far outside viewport
4. **Event Debounce**: Throttle rapid button clicks (200ms minimum interval) to prevent double-purchase/item-use bugs
5. **Layout Performance**: Avoid nested `Layout` with `resizeMode = CONTAINER` (triggers recalculation chain); prefer fixed-size containers
6. **Tooltip Singleton**: Use a single global Tooltip node, reposition and show/hide rather than create/destroy per element
7. **Nameplate Pooling**: Object-pool nameplates; only update visible ones; consider spatial partitioning for large-scale scenes
8. **RichText Limitations**: `RichText` does not support BBCode or true HTML; use `<color>`, `<b>`, `<i>`, `<u>`, `<size>`, `<img>`, `<br>` tags only
9. **Widget Alignment**: Use percentage-based offsets on parent-size-dependent edges for truer resolution independence
10. **SafeArea**: Always enable `SafeArea` on UI root for mobile builds to handle notch and home indicator

### Common Tasks

- **Create a complete HUD**: Combine UnitFrame, ActionBar, Minimap, ChatWindow, QuestTracker, BuffFrame templates
- **Build a party/raid UI**: Use PartyFrame + RaidFrame templates with Layout auto-arrangement
- **Implement inventory**: BagPanel + Tooltip + drag-drop support
- **Create a character panel**: CharacterPanel with equipment slots + stat display
- **Set up combat feedback**: CombatText + Nameplate + CastingBar integration
- **Build social panels**: ChatWindow + GuildPanel + FriendsList
- **Implement trading UI**: VendorPanel + AuctionHouse + LootRoll
- **Create modal dialogs and popups**: Dialog system with overlay + stacking

---

## Modal Dialog / Popup System

Dialog template with blocking overlay, centered panel, and dialog stacking.

**Features:**
- `BlockInputEvents` overlay to prevent background interaction
- Centered panel with title, body, and action buttons
- Fade-in/fade-out animation
- Dialog stacking/queuing (show one dialog, dismiss, next pops)
- Close on overlay click (configurable) or explicit dismiss

**Structure:**
```
DialogManager (Node, singleton)
├── Overlay (Sprite, fullscreen + BlockInputEvents)
│   └── Blocker (BlockInputEvents component)
└── DialogStack (Node)
    └── DialogPanel[0..N] (Node, Widget: centered)
        ├── Border (Sprite)
        ├── Title (Label)
        ├── Body (Label / RichText)
        └── ActionButtons (Layout:HORIZONTAL)
            ├── BtnCancel (Button + Label)
            └── BtnConfirm (Button + Label)
```

**Code Example:**
```typescript
import { Node, Sprite, Label, Button, Widget, BlockInputEvents, UITransform, Color, UIOpacity, tween, Layout } from 'cc';

interface DialogConfig {
    title: string;
    body: string;
    confirmText?: string;
    cancelText?: string;
    onConfirm?: () => void;
    onCancel?: () => void;
    closeOnOverlay?: boolean;  // Close dialog when clicking outside
}

class DialogManager {
    private static instance: DialogManager;
    private overlay: Node;
    private dialogStack: DialogConfig[] = [];
    private activeDialog: Node | null = null;

    static get Instance(): DialogManager {
        if (!this.instance) {
            this.instance = new DialogManager();
        }
        return this.instance;
    }

    constructor() {
        // Overlay (reused across all dialogs)
        this.overlay = new Node('DialogOverlay');
        this.overlay.addComponent(UITransform).setContentSize(1920, 1080);  // Assumes design resolution
        this.overlay.addComponent(UIOpacity).opacity = 0;

        const bg = this.overlay.addComponent(Sprite);
        bg.color = new Color(0, 0, 0, 100);
        this.overlay.addComponent(BlockInputEvents);
        this.overlay.active = false;
    }

    show(config: DialogConfig): void {
        if (this.activeDialog) {
            // Queue: push to stack, show after current dialog closes
            this.dialogStack.push(config);
            return;
        }
        this.buildAndShow(config);
    }

    private buildAndShow(config: DialogConfig): void {
        this.overlay.active = true;
        this.activeDialog = new Node('DialogPanel');
        this.activeDialog.addComponent(UITransform).setContentSize(360, 200);
        this.overlay.addChild(this.activeDialog);

        // Widget: center the dialog
        const widget = this.activeDialog.addComponent(Widget);
        widget.isAlignHorizontalCenter = true;
        widget.isAlignVerticalCenter = true;

        // Border background
        const border = new Node('Border');
        border.addComponent(UITransform).setContentSize(364, 204);
        border.addComponent(Sprite);
        this.activeDialog.addChild(border);

        // Title
        const titleNode = new Node('Title');
        titleNode.addComponent(UITransform).setContentSize(320, 30);
        titleNode.setPosition(0, 80, 0);
        const titleLabel = titleNode.addComponent(Label);
        titleLabel.string = config.title;
        titleLabel.fontSize = 18;
        titleLabel.color = Color.WHITE;
        this.activeDialog.addChild(titleNode);

        // Body
        const bodyNode = new Node('Body');
        bodyNode.addComponent(UITransform).setContentSize(320, 80);
        bodyNode.setPosition(0, 20, 0);
        const bodyLabel = bodyNode.addComponent(Label);
        bodyLabel.string = config.body;
        bodyLabel.fontSize = 14;
        bodyLabel.color = new Color(200, 200, 200);
        bodyLabel.overflow = Label.Overflow.SHRINK;
        this.activeDialog.addChild(bodyNode);

        // Action buttons
        const btnRow = new Node('Actions');
        btnRow.addComponent(UITransform).setContentSize(320, 40);
        btnRow.addComponent(Layout).type = Layout.Type.HORIZONTAL;
        btnRow.addComponent(Layout).spacingX = 16;
        btnRow.setPosition(0, -70, 0);
        this.activeDialog.addChild(btnRow);

        if (config.cancelText) {
            const cancelNode = new Node('BtnCancel');
            cancelNode.addComponent(UITransform).setContentSize(100, 36);
            const cancelBtn = cancelNode.addComponent(Button);
            const cancelLabel = cancelNode.addComponent(Label);
            cancelLabel.string = config.cancelText;
            cancelLabel.fontSize = 14;
            cancelBtn.clickEvents.push(() => {
                config.onCancel?.();
                this.dismiss();
            });
            btnRow.addChild(cancelNode);
        }

        if (config.confirmText) {
            const confirmNode = new Node('BtnConfirm');
            confirmNode.addComponent(UITransform).setContentSize(100, 36);
            const confirmBtn = confirmNode.addComponent(Button);
            const confirmLabel = confirmNode.addComponent(Label);
            confirmLabel.string = config.confirmText;
            confirmLabel.fontSize = 14;
            confirmBtn.clickEvents.push(() => {
                config.onConfirm?.();
                this.dismiss();
            });
            btnRow.addChild(confirmNode);
        }

        // Overlay click to close (optional)
        if (config.closeOnOverlay) {
            this.overlay.on(Node.EventType.TOUCH_END, () => {
                config.onCancel?.();
                this.dismiss();
            }, this);
        }

        // Fade in
        const overlayOpacity = this.overlay.getComponent(UIOpacity);
        overlayOpacity.opacity = 0;
        tween(overlayOpacity).to(0.2, { opacity: 255 }).start();
    }

    dismiss(): void {
        const overlayOpacity = this.overlay.getComponent(UIOpacity);
        tween(overlayOpacity).to(0.15, { opacity: 0 }).call(() => {
            if (this.activeDialog) {
                this.activeDialog.removeFromParent();
                this.activeDialog.destroy();
                this.activeDialog = null;
            }
            this.overlay.active = false;
            // Process next dialog in queue
            const next = this.dialogStack.shift();
            if (next) {
                this.buildAndShow(next);
            }
        }).start();
    }
}
```

## Related Skills
- `cocos_2d` — Sprite, Label, Mask, Graphics for UI rendering components
- `cocos_core` — Component lifecycle, event system, Node hierarchy
- `cocos_editor` — MCP editor operations for creating UI nodes and components visually

## Recommended Next Steps
1. Verify Cocos Creator version via `docs/engine-reference/cocos/VERSION.md`
2. For UI rendering optimization (sprite batching, draw calls), load `cocos_2d`
3. For editor-based UI layout (visual Canvas and Widget setup), use `cocos_editor` MCP tools
4. For UI event-driven game logic, consult `cocos_core` for EventTarget and lifecycle patterns
