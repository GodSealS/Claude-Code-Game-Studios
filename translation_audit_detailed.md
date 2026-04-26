# 详细中文翻译完整性审核报告

## 概述
分析时间: 2026-04-25 19:35:08
总文件数: 61

## 汇总统计
- 总未翻译段落数: 1560
- 总未翻译列表项数: 932
- 有翻译问题的文件数: 54

## 详细分析结果

### .codebuddy\docs\templates\interaction-pattern-library.md
- 未翻译段落数: 195
- 未翻译列表项数: 45

**未翻译段落:**

**行 3-12:**
```
> **Status**: Draft | Stable | Under Revision
> **Author**: [ux-designer]
> **Last Updated**: [Date]
> **Engine**: [Godot 4.6 / Unity 6 / Unreal Engine 5]
> **UI Framework**: [Godot Control nodes / Unity UI Toolkit / Unreal UMG]
> **Related Documents**:
> - `docs/art-bible.md` — visual standards (colors, typography, iconography)
> - `docs/accessibility-requirements.md` — accessibility commitments per feature
> - `docs/ux/ux-spec-[screen].md` — individual screen specs that reference patterns
```

**行 64-69:**
```
|-------------|----------|-------------|------------------|--------|
| Button (Primary) | Input | Main call-to-action. High visual weight. One per screen. | [Main Menu, Pause Menu, Settings] | Draft |
| Button (Secondary) | Input | Alternative action or cancel. Lower visual weight than Primary. | [All modal dialogs, settings screens] | Draft |
| Button (Destructive) | Input | Irreversible action. Requires confirmation before execution. | [Delete Save, Reset Settings] | Draft |
| Toggle | Input | Binary on/off state selection. | [Accessibility settings, audio settings] | Draft |
| Slider | Input | Continuous value selection. | [Volume controls, brightness, text size] | Draft |
```

**行 76-76:**
```
| Tooltip | Feedback | Contextual information on hover or focus. | [Inventory items, ability descriptions, settings] | Draft |
```

**行 78-81:**
```
| Input Field | Input | Text entry control. | [Player name, search, key binding entry] | Draft |
| Tab Bar | Navigation | Tabbed section navigation within a single screen. | [Character sheet, settings, crafting] | Draft |
| Scroll Container | Layout | Scrollable content region with visible scroll indicator. | [Inventory, lore entries, credits] | Draft |
| Inventory Slot | Game-Specific | Item container in inventory grid (empty, filled, equipped, locked). | [Inventory screen, equipment screen] | Draft |
```

**行 84-84:**
```
| Minimap | Game-Specific | Overview map with player marker and points of interest. | [HUD] | Draft |
```

**行 86-93:**
```
| Dialogue Box | Game-Specific | NPC conversation UI with speaker identification. | [All dialogue sequences] | Draft |
| Context Action Prompt | Game-Specific | Contextual "Press X to [action]" prompt near interactable objects. | [World interaction] | Draft |
| Damage Number | Game-Specific | Floating combat feedback number. | [Combat HUD] | Draft |
| Status Effect Icon | Game-Specific | Buff/debuff indicator with duration. | [HUD status bar, enemy health display] | Draft |
| Notification Banner | Game-Specific | Achievement, level up, item acquired notifications. | [Global overlay] | Draft |
| Screen Push | Navigation | Forward navigation with directional animation. | [All menu navigation] | Draft |
| Screen Pop (Back) | Navigation | Back navigation with reversed animation. | [All menu navigation] | Draft |
| Screen Replace | Navigation | Replace current screen without stacking history. | [Main Menu to Loading Screen] | Draft |
```

**行 95-96:**
```
| Tab Switch | Navigation | Same-screen content switch between tabs. | [All tabbed screens] | Draft |
| Focus Management | Navigation | Rules for where focus goes when screens open, close, or change. | [All screens] | Draft |
```

**行 98-102:**
```
| Loading State | Feedback | How screens and components indicate loading in progress. | [All loading states] | Draft |
| Empty State | Feedback | How empty lists and grids are presented. | [Empty inventory, no quests, no saves] | Draft |
| Error State | Feedback | How errors are communicated. | [Save failed, network error, invalid input] | Draft |
| Success Confirmation | Feedback | How completed actions are confirmed. | [Settings saved, item crafted, quest turned in] | Draft |
| Optimistic UI | Feedback | Showing assumed success before system confirmation. | [If online features are present] | Draft |
```

**行 110-110:**
```
#### Button (Primary)
```

**行 114-119:**
```
**When to Use**: The single most important action on a screen. "Start Game,"
"Confirm," "Accept," "Buy." There should be at most one Primary button visible
at a time. It is the answer to "what does the player most likely want to do here?"
**When NOT to Use**: Alternative or secondary actions; destructive actions that
require confirmation before the consequence is irreversible; any action that is
not the primary intent of the screen.
```

**行 121-121:**
```
**Interaction Specification**:
```

**行 123-126:**
```
| State | Visual | Input | Response | Duration | Audio |
|-------|--------|-------|----------|----------|-------|
| Default | Full-opacity fill, primary color from art-bible. Label centered. | — | — | — | — |
| Hovered (mouse) | Brightness +15%, subtle scale 1.03x, cursor changes to pointer | Mouse over element | Transition from Default | 80ms ease-out | [UI hover sound — see Sound Standards] |
```

**行 129-130:**
```
| Disabled | 40% opacity, no pointer cursor, no hover state | — | No response | — | — |
| Loading (post-press) | Replace label with spinner. Button remains at pressed scale, disabled state. | — | Prevents double-submission | Duration of async operation | — |
```

**行 133-133:**
```
- Keyboard: Tab to focus, Enter or Space to activate. Must be reachable from any other interactive element on screen via Tab sequence.
```

**行 135-136:**
```
- Screen reader: Button must expose accessible name matching visible label. Role: "button." State: "dimmed" when disabled. Activation announcement: "[Label] button — [result of action, if known]."
- Colorblind: Do not rely on color alone to distinguish Primary from Secondary. Primary uses higher visual weight (fill vs. outline, or larger size) in addition to color differentiation.
```

**行 139-144:**
```
**Implementation Notes**:
[Godot: Extend `Button` control. Override `_draw()` for custom states rather than
modifying themes mid-state. Use `focus_mode = FOCUS_ALL` to ensure keyboard
focusability. Set `mouse_default_cursor_shape = CURSOR_POINTING_HAND`. For the
scale animation, use a Tween on the `scale` property of the button's parent
Control — scaling the Button itself can clip children.]
```

**行 148-148:**
```
#### Button (Secondary)
```

**行 152-155:**
```
**When to Use**: Alternative or cancel action. "Back," "Cancel," "Skip," "Maybe
Later." Lower visual weight than Primary — it should recede visually, not compete.
**When NOT to Use**: Destructive actions (use Button (Destructive)). The most
important action on the screen (use Button (Primary)).
```

**行 157-157:**
```
**Interaction Specification**:
```

**行 159-162:**
```
| State | Visual | Input | Response | Duration | Audio |
|-------|--------|-------|----------|----------|-------|
| Default | Outlined style (border only, transparent fill), secondary color. Slightly smaller or lower weight than Primary. | — | — | — | — |
| Hovered | Background fill appears at 15% opacity. Border brightens. Scale 1.02x. | Mouse over | Transition from Default | 80ms ease-out | [UI hover sound — softer variant than Primary] |
```

**行 165-165:**
```
| Disabled | 40% opacity | — | No response | — | — |
```

**行 167-170:**
```
**Accessibility**: Same requirements as Button (Primary). Accessible name must
match visible label. In a dialog with Primary and Secondary buttons, the Secondary
button typically maps to the platform "cancel" input (B / Circle / Escape) as well
as direct focus activation.
```

**行 172-175:**
```
**Implementation Notes**: [Same as Button (Primary). Where a Primary and Secondary
appear together, ensure Secondary is always positioned consistently — right/bottom
of Primary on horizontal layouts, or below Primary on vertical layouts. Consistency
across screens is more important than per-screen aesthetic preference.]
```

**行 179-179:**
```
#### Button (Destructive)
```

**行 183-187:**
```
**When to Use**: Any action that is irreversible and causes loss of player data or
significant progress: "Delete Save File," "Reset All Settings," "Leave Match,"
"Discard Changes." The visual treatment signals danger before the player presses.
**When NOT to Use**: Actions that can be undone, or actions that are merely
consequential but reversible.
```

**行 189-189:**
```
**Interaction Specification**:
```

**行 191-193:**
```
| State | Visual | Input | Response | Duration | Audio |
|-------|--------|-------|----------|----------|-------|
| Default | Outlined or filled with destructive color (typically a desaturated red — confirm colorblind compatibility in accessibility-requirements). Label may include a warning icon. | — | — | — | — |
```

**行 196-197:**
```
| — | Confirmation Dialog handles the actual execution | — | — | — | — |
| Disabled | 40% opacity | — | No response | — | — |
```

**行 199-204:**
```
> **Critical rule**: A Button (Destructive) NEVER executes its action directly.
> It always triggers a Confirmation Dialog. There are no exceptions. A player
> who presses it by accident must always have one more opportunity to back out.
> Games that skip confirmation on destructive actions generate the most visible
> negative community sentiment of any UX failure type. See: every "accidentally
> deleted save file" complaint on any game forum.
```

**行 206-206:**
```
**Accessibility**: Screen reader must announce the destructive nature: "[Label] button — this action cannot be undone." In addition to accessible name, use the `description` property if available to add the warning text.
```

**行 208-208:**
```
**Implementation Notes**: [Destructive button triggers a separate Confirmation Dialog scene. Pass the action callback to the dialog — the button itself does not hold the execution logic. This separation prevents accidental execution if the confirmation dialog has a bug.]
```

**行 216-222:**
```
**When to Use**: Binary on/off settings where both states are equally valid and
the current state must be visible at a glance. "Subtitles: On/Off," "Aim Assist:
On/Off," "Notifications: On/Off."
**When NOT to Use**: Selections from more than two options (use Dropdown). Actions
that happen once rather than representing a persistent state (use Button). Cases
where the consequence of toggling is complex enough to need explanation (show
a description field alongside).
```

**行 224-224:**
```
**Interaction Specification**:
```

**行 226-227:**
```
| State | Visual | Input | Response | Duration | Audio |
|-------|--------|-------|----------|----------|-------|
```

**行 229-229:**
```
| Hovered | Track brightens 10%. Cursor: pointer. | Mouse over | Transition | 60ms | [UI hover sound] |
```

**行 233-233:**
```
| Disabled | 40% opacity. No interaction. Current state still visible. | — | No response | — | — |
```

**行 236-238:**
```
- Keyboard/Gamepad: Space or Enter to toggle. Avoid requiring directional inputs (left/right) to toggle — some users cannot predict that behavior.
- Screen reader: Role: "switch." State: "on" or "off" — the accessible name should NOT include the state (the screen reader announces state separately). Correct: accessible name "Subtitles," state "on." Incorrect: accessible name "Subtitles On."
- The toggle label (not just the visual thumb position) must change to show current state for players who cannot reliably distinguish left from right positions.
```

**行 240-244:**
```
**Implementation Notes**: [Godot: Use a custom Control or a CheckButton. The
built-in CheckButton provides accessibility role but uses a checkbox-style visual;
a custom slide-toggle animation may be needed for the target art style. Ensure
the slide animation is skipped when motion reduction mode is active — in that
case, snap to final state instantly.]
```

**行 252-256:**
```
**When to Use**: Selecting a value from a continuous range where approximate values
are acceptable and the range and relative position matter. Volume (0–100%), brightness,
text size. The visual representation of position is itself useful information.
**When NOT to Use**: Precise value entry (use Input Field). Selection from a short
discrete list (use Dropdown). Binary state (use Toggle).
```

**行 258-258:**
```
**Interaction Specification**:
```

**行 260-263:**
```
| State | Visual | Input | Response | Duration | Audio |
|-------|--------|-------|----------|----------|-------|
| Default | Track (full width). Fill (left of thumb, shows current value). Thumb (draggable handle). Current value label (right of track or above thumb). | — | — | — | — |
| Hovered | Thumb enlarges slightly (1.2x). Track brightens. | Mouse over | — | 60ms | — |
```

**行 265-265:**
```
| Dragging (mouse) | Thumb follows cursor. Fill updates in real time. Value label updates in real time. | Click + drag on thumb | Continuous value update. Fire onChange continuously. | Real time | [Slider adjust sound — subtle, loops while dragging] |
```

**行 268-269:**
```
| Released | Value locks. onChange fires final value. | Mouse release | — | — | — |
| Disabled | 40% opacity. No interaction. Value visible. | — | No response | — | — |
```

**行 272-274:**
```
- Keyboard: Left/Right arrows to adjust by small step. Page Up/Page Down for large step. Home/End to jump to min/max.
- Screen reader: Role: "slider." Accessible name: the label (e.g., "Music Volume"). Current value announced on every change: "Music Volume, 80 percent." Min/max values announced on first focus.
- All sliders must show a numeric value alongside the visual position. Relying only on track fill position excludes players who cannot perceive relative position.
```

**行 276-281:**
```
**Implementation Notes**: [Godot `HSlider`: set `step` to appropriate increment.
Override keyboard input to add Page Up/Down support via `_input()`. Bind the
`value_changed` signal to update the displayed numeric label. When motion reduction
mode is enabled, ensure value label updates are the sole feedback — do not suppress
them. Rumble feedback on gamepad slider adjustment is a nice enhancement for
```

**行 289-294:**
```
**When to Use**: Selection from a discrete list of 3-15 options where only the
selected value needs to be visible at rest. Display resolution, language, window
mode, input preset. The closed state shows only the current selection.
**When NOT to Use**: Binary choices (use Toggle). More than ~15 options (use a
full List pattern or a scrollable Select). When comparing options matters as much
as selecting one (show options visibly, e.g., as a horizontal selector or list).
```

**行 296-296:**
```
**Interaction Specification**:
```

**行 298-299:**
```
| State | Visual | Input | Response | Duration | Audio |
|-------|--------|-------|----------|----------|-------|
```

**行 301-301:**
```
| Hovered | Row background fills at 10% opacity | Mouse over | — | 60ms | — |
```

**行 307-307:**
```
| Disabled | 40% opacity. No interaction. | — | — | — | — |
```

**行 310-312:**
```
- Keyboard: Up/Down arrows navigate list items while open. Enter selects. Escape dismisses. First letter of an option jumps focus to first matching item.
- Screen reader: Role: "combobox." Accessible name: the field label. Expanded/collapsed state announced. Current value announced when focused. Each list item announces its value and position: "English, 1 of 12."
- The dropdown list must never obscure the current item or the control that opened it — this is a common failure on small screens.
```

**行 314-318:**
```
**Implementation Notes**: [Godot: Custom implementation using a `Button` (the
closed state) and a `PopupMenu` or a `VBoxContainer` revealed by animation. Native
`OptionButton` provides accessibility but limited visual customization. Ensure
the popup positions itself above the control if it would be clipped by the screen
bottom. Close the popup on `_input` detecting click outside its rect.]
```

**行 324-330:**
```
**Category**: Layout / Input
**When to Use**: A single selectable row in a vertically scrollable list. Achievements,
quest log entries, settings categories, save file slots. The list is the container;
this is the row within it.
**When NOT to Use**: Grid layouts where items exist in two dimensions (use Grid Item).
Non-selectable content rows (remove hover/focus states and the pressed state).
```

**行 332-332:**
```
**Interaction Specification**:
```

**行 334-335:**
```
| State | Visual | Input | Response | Duration | Audio |
|-------|--------|-------|----------|----------|-------|
```

**行 337-337:**
```
| Hovered | Row background at 12% opacity highlight. | Mouse over | — | 60ms | — |
```

**行 339-339:**
```
| Selected (persistent) | Row background at 25% opacity. May show a selection indicator (left border, checkmark). Distinct from focused state — a row can be selected but not focused. | — | Rendered state | — | — |
```

**行 341-341:**
```
| Disabled | 40% opacity. No interaction. | — | — | — | — |
```

**行 344-345:**
```
- Keyboard/Gamepad: Up/Down arrows or D-pad to move between list items. The list must handle focus cycling — reaching the bottom should stop (not wrap) unless wrapping is explicitly designed.
- Screen reader: Role: "listitem." Parent list role: "list." Accessible name: primary label content. Metadata (secondary label) is optionally included in the description. Position announced: "Quest Log, 3 of 12."
```

**行 348-352:**
```
**Implementation Notes**: [Godot: Use a `VBoxContainer` inside a `ScrollContainer`.
Each row is a custom `Control` or `PanelContainer` with a `_gui_input` override.
For keyboard navigation inside the scroll container, implement custom focus
traversal — Godot's default Tab navigation does not scroll the container to keep
focused items in view. Use `ensure_control_visible()` on the scroll container.]
```

**行 358-364:**
```
**Category**: Layout / Input
**When to Use**: A selectable cell in a two-dimensional grid. Inventory slots,
ability select, crafting ingredient selection, character portrait selection. The
grid is the container; this is the cell.
**When NOT to Use**: Single-column content (use List Item). Non-selectable display
cells (remove interactive states).
```

**行 366-366:**
```
**Interaction Specification**:
```

**行 368-373:**
```
| State | Visual | Input | Response | Duration | Audio |
|-------|--------|-------|----------|----------|-------|
| Empty | Empty slot visual (subtle border or dashed outline). Different from disabled. | — | — | — | — |
| Populated | Item icon fills cell. Stack count (bottom right, if applicable). Quality indicator (border color or icon overlay). | — | — | — | — |
| Hovered | Brightness +15%. Tooltip appears after 400ms delay. | Mouse over | — | 60ms | — |
| Focused | Focus ring (2px, offset 2px). Same brightness as hovered. Tooltip appears after 400ms delay or immediately on gamepad. | D-pad navigation | — | 60ms | [UI focus sound] |
```

**行 376-379:**
```
| Locked | Padlock overlay icon on populated content. No hover/focus states. | — | No interaction | — | — |
| Drag source | Cell dims (50% opacity), drag preview appears at cursor. | Click + drag (mouse only) | Begin drag operation | Instant | [UI grab sound] |
| Drop target (valid) | Cell brightens, accepting color indicator | Item dragged over | — | 60ms | — |
| Drop target (invalid) | Red tint or shake animation | Item dragged over invalid slot | — | 60ms | [UI error sound] |
```

**行 382-384:**
```
- Keyboard/Gamepad: D-pad or arrow keys navigate cells. The grid must communicate its dimensions to screen readers. Row/column position announced.
- Screen reader: Role: "gridcell." Parent role: "grid." Accessible name: item name (or "empty slot" for empty cells). State: "selected" when selected, "dimmed" when locked. Position: "row 2, column 3."
- Tooltips must be reachable by keyboard — they must appear when the cell is focused, not only when hovered.
```

**行 386-389:**
```
**Implementation Notes**: [Godot: `GridContainer` with fixed column count. Each
cell is a custom `Control`. Implement custom D-pad navigation by overriding
`_gui_input` and calculating the cell to the left/right/above/below based on
index and column count. `GridContainer` does not provide this natively.]
```

**行 393-393:**
```
#### Modal Dialog
```

**行 395-402:**
```
**Category**: Feedback / Layout
**When to Use**: A decision or acknowledgment that must be resolved before the
player can continue. The dialog is blocking — background content is dimmed and
non-interactive. "Are you sure?", "Your progress will be saved.", error states.
**When NOT to Use**: Non-blocking notifications (use Toast / Notification). Information
that can wait until the player is ready (add it to a persistent help system instead).
Dialogs that should allow the player to continue playing behind them.
```

**行 404-404:**
```
**Interaction Specification**:
```

**行 406-408:**
```
| State | Visual | Input | Response | Duration | Audio |
|-------|--------|-------|----------|----------|-------|
| Opening | Background overlay animates from 0 to 60% opacity. Dialog panel scales from 0.9 to 1.0. Dialog enters from center (not from an edge). | Triggered by code | Focus moves to first interactive element in dialog (or the Primary button) | 200ms ease-out | [UI modal open sound] |
```

**行 410-410:**
```
| Dismissing (confirmed) | Dialog panel scales to 1.1 then fades. Overlay fades to 0%. | Primary button pressed | Execute action, return focus to trigger element | 180ms | [UI confirm sound] |
```

**行 412-412:**
```
| Cannot dismiss | If the dialog represents a blocking error, do not provide a cancel path. Provide only resolution options. | — | — | — | — |
```

**行 414-419:**
```
> **Focus trap rule**: While a modal dialog is open, Tab and D-pad navigation
> must cycle within the dialog's interactive elements only. It must not be possible
> to navigate focus outside the dialog to the background content. This is both
> an accessibility requirement (WCAG 2.1 SC 2.1.2) and a UX integrity requirement.
> When the dialog closes, focus must return to the element that triggered it,
> not to the top of the page.
```

**行 422-424:**
```
- Screen reader: Dialog container role: "dialog." Accessible name: dialog title (required — every dialog must have a title, even if visually hidden). On open, screen reader announces dialog title and first focusable element. Focus trap active.
- Keyboard: Escape key always maps to the cancel/dismiss action (same as Secondary button or close button). Enter always maps to the primary/confirm action.
- Motion reduction: Scale animation replaced with instant appear/disappear. Overlay fade retained at 100ms (faster).
```

**行 426-431:**
```
**Implementation Notes**: [Godot: Implement as a `CanvasLayer` with a high layer
value (100+) to ensure it renders above all game content. The background overlay
is a full-screen `ColorRect` at 60% black opacity. Use `grab_focus()` on the
dialog's primary button after the open animation completes. Override `_input()` to
implement the focus trap — intercept Tab navigation and reroute to the dialog's
```

**行 435-435:**
```
#### Confirmation Dialog
```

**行 437-443:**
```
**Category**: Feedback / Layout
**When to Use**: The specific case of confirming a destructive action. Always
triggered by Button (Destructive). Always has exactly two options: confirm (labeled
with the specific action, not "OK") and cancel.
**When NOT to Use**: Non-destructive confirmations. Errors or notifications that
do not require a decision. Any dialog with more than two actions.
```

**行 445-449:**
```
> **Label rule**: The confirm button must be labeled with the specific action,
> not a generic "OK" or "Yes." "Delete Save File" not "OK." "Leave Match" not
> "Yes." This reduces mistakes for players who have difficulty reading the dialog
> content quickly. The pattern comes from Apple HIG and is validated by decades
> of usability research.
```

**行 452-456:**
```
- Title: Brief, action-describing. "Delete save file?" not "Are you sure?"
- Body: One sentence stating the consequence. "This cannot be undone."
- Confirm button: Button (Primary) — labeled with the specific action. "Delete Save File."
- Cancel button: Button (Secondary) — "Cancel."
- Default focus: Cancel (safer default — reduces accidental destructive actions).
```

**行 458-460:**
```
**Accessibility**: Inherits all Modal Dialog accessibility. Additionally: screen
reader announces "Alert dialog, [title]" to signal destructive context. Default
focus on Cancel is a requirement, not a preference.
```

**行 462-465:**
```
**Implementation Notes**: [Confirmation Dialog is a specific instance of Modal
Dialog — implement it as a subclass or as a parameterized scene. The default
focus on Cancel is critical: set `grab_focus()` on the Cancel button, not the
Confirm button, after open animation completes.]
```

**行 471-478:**
```
**Category**: Feedback
**When to Use**: Brief, non-blocking information that does not require a player
decision. "Game saved." "Achievement unlocked." "Your inventory is full." The player
can continue playing; the notification disappears on its own.
**When NOT to Use**: Information that requires a decision (use Modal Dialog).
Errors that require the player to take action. Critical information that the player
```

**行 480-480:**
```
**Interaction Specification**:
```

**行 482-488:**
```
| State | Visual | Input | Response | Duration | Audio |
|-------|--------|-------|----------|----------|-------|
| Entering | Slides in from screen edge (typically bottom-right, away from primary action areas). Fades from 0 to 100% opacity. | Triggered by code | — | 200ms ease-out | [Sound matching notification type — see Sound Standards] |
| Displayed | Full opacity. Optional: icon (left), title, body text (optional), dismiss button (X, optional). | Pointer hover pauses auto-dismiss timer | Pause auto-dismiss | — | — |
| Auto-dismiss | Fades from 100 to 0% opacity, slides out | Timer expires (5 seconds default for one-line; 8 seconds for two-line) | Remove from queue | 200ms ease-in | — |
| Manual dismiss | Fades and slides out immediately | Click/tap X button or swipe on touch | Remove | 150ms | [UI cancel sound, quiet] |
| Queue overflow | New notification pushes oldest out early | New notification triggered while previous is displayed | FIFO queue, max 3 simultaneous | — | — |
```

**行 491-494:**
```
- Screen reader: Toasts must be read aloud without requiring focus. In HTML, this uses `role="status"` or `role="alert"`. In game UI, this requires the engine's accessibility notification system. Verify engine support in engine-reference docs.
- Motion reduction: Slide animation replaced with fade only.
- Toasts must never be the sole communication channel for information the player needs to act on. If the information requires action, use a persistent UI element in addition to the toast.
- Auto-dismiss timer: 5 seconds is the minimum. Players with cognitive processing differences may need more time. Consider a setting to extend to 10 or 15 seconds.
```

**行 496-501:**
```
**Implementation Notes**: [Godot: Manage a queue of `PanelContainer` scenes in a
`VBoxContainer` anchored to a screen corner. Each toast is instantiated, added to
the container, then auto-removed after a timer. The container should be on a high
`CanvasLayer` (50+) but below modal dialogs (100+). Animate using a `Tween` on
`modulate.a` and `position.x`. When motion reduction is active, skip the position
```

**行 507-516:**
```
**Category**: Feedback
**When to Use**: Contextual information that supplements a visible label. Item
descriptions in inventory. Stat explanations on a character sheet. Setting
descriptions in accessibility options. The player must be able to access this
information or proceed without it.
**When NOT to Use**: Information the player MUST read to complete an action — put
that in the label or body text, not a tooltip. Tooltips are not discoverable
on mobile touch without a hover state. On touch-only platforms, use an info button
that opens a description modal instead.
```

**行 518-518:**
```
**Interaction Specification**:
```

**行 520-526:**
```
| State | Visual | Input | Response | Duration | Audio |
|-------|--------|-------|----------|----------|-------|
| Hidden | — | — | — | — | — |
| Hover trigger | — | Mouse enters element | Begin 400ms delay timer | — | — |
| Gamepad/keyboard trigger | — | Element receives focus | Begin 300ms delay timer (shorter because navigation is intentional) | — | — |
| Appearing | Tooltip panel fades in and scales from 0.95 to 1.0. Positioned near element (prefer above, adjust if near screen edge). | Timer expires | Show tooltip | 120ms ease-out | — |
| Displayed | Tooltip visible. Title (optional). Body text. Max width: 300px. Multiple lines allowed. | — | — | — | — |
```

**行 530-532:**
```
- Screen reader: Tooltip content must be accessible without hover. The accessible name of the parent element should include the most critical tooltip information. The full tooltip text is optionally in the `description` property. Screen reader reads tooltip content when element is focused.
- The delay (300-400ms) prevents accidental tooltip display and is required — instant tooltips are disruptive in gamepad navigation.
- Tooltip text must meet the same contrast requirements as body text (4.5:1 minimum).
```

**行 534-538:**
```
**Implementation Notes**: [Godot: Attach a custom `TooltipControl` scene as a
child of the trigger element. Show/hide with a `Timer` node. Position the tooltip
using a `CanvasLayer` to ensure it appears above all other UI. For screen edges,
detect if the tooltip rect extends beyond `get_viewport_rect()` and flip the
position to the opposite side.]
```

**行 542-542:**
```
#### Progress Bar
```

**行 544-551:**
```
**Category**: Feedback / Layout
**When to Use**: Linear progress toward a defined endpoint. Loading screens (time
to completion), XP fill toward next level, quest objectives with countable progress
("3 of 10 enemies defeated"), download progress.
**When NOT to Use**: Circular or radial progress (use a separate Radial Progress
pattern if needed). Values that fluctuate up and down rapidly (use Health/Resource
Bar pattern). Values with no defined endpoint.
```

**行 553-553:**
```
**Interaction Specification**:
```

**行 555-561:**
```
| State | Visual | Input | Response | Duration | Audio |
|-------|--------|-------|----------|----------|-------|
| Default | Track (full width, background color). Fill (left to right, value color). Value label (percentage or N/M, outside or inside fill). | — | — | — | — |
| Value increasing | Fill width animates to new value | Value changes | Smooth fill animation | 300ms ease-out | [Context-dependent — XP gain has a sound; loading has none] |
| Value at maximum | Fill reaches full width. Optional: completion animation (pulse, glow). | Value reaches 100% | Completion event fires | 200ms | [Completion sound if appropriate] |
| Value at zero | Fill hidden (zero width). Track still visible. | — | — | — | — |
| Indeterminate (unknown duration) | Animated loop (fill segment moves left-to-right, repeat). Used for loading of unknown duration. | — | — | Infinite loop | — |
```

**行 564-567:**
```
- Screen reader: Role: "progressbar." Accessible name: what is progressing (e.g., "Experience Points," "Loading"). Value: current numeric value AND percentage AND maximum. "Experience Points, 450 of 1000, 45 percent." Update on significant changes (not every pixel).
- Do not rely only on fill color to communicate value. Include a numeric label.
- Indeterminate progress bars: announce "Loading, in progress" — do not announce changes since the value is unknown.
- Motion reduction: Indeterminate animation is replaced with a static "loading" indicator. Smooth fill animation is replaced with instant jump to new value.
```

**行 569-573:**
```
**Implementation Notes**: [Godot: `ProgressBar` built-in with custom theming.
For indeterminate mode, `ProgressBar` does not have a native indeterminate state
in Godot 4.x — implement using a looping `Tween` on a fill element's position.
Ensure the Tween is paused when motion reduction mode is active and a static
indicator is shown instead.]
```

**行 577-577:**
```
#### Input Field
```

**行 581-586:**
```
**When to Use**: Text entry. Player name on a new save, search within a list,
remapping a key binding (special case — shows the key press, not typed text),
entering a numeric value precisely.
**When NOT to Use**: Selecting from known options (use Dropdown or List). On
console-primary platforms, minimize text entry — it requires a virtual keyboard,
which is high friction.
```

**行 588-588:**
```
**Interaction Specification**:
```

**行 590-593:**
```
| State | Visual | Input | Response | Duration | Audio |
|-------|--------|-------|----------|----------|-------|
| Default | Field border, placeholder text (label-style, muted color), empty input area. | — | — | — | — |
| Hovered | Border brightens slightly | Mouse over | — | 60ms | — |
```

**行 595-597:**
```
| Typing | Characters appear. Cursor advances. | Keyboard input | Update field value | Immediate | [Subtle keystroke sound, optional] |
| Value present | Field shows typed value. Placeholder hidden. Clear button appears (X, right of field) if value is non-empty. | — | — | — | — |
| Character limit reached | No further input accepted. Optional: brief shake animation and limit indicator changes color. | Input at limit | Reject further characters | 200ms shake | [UI error sound, subtle] |
```

**行 599-599:**
```
| Validation error | Border turns error color (red — ensure colorblind safe). Error message appears below field. | On submit or on blur | Show error | Instant | [UI error sound] |
```

**行 601-601:**
```
| Disabled | 40% opacity, no interaction. Value still visible. | — | — | — | — |
```

**行 604-606:**
```
- Keyboard: All standard text editing shortcuts (Home, End, Ctrl+A, Ctrl+C, Ctrl+V, Ctrl+Z).
- Screen reader: Role: "textbox." Accessible name: field label (not placeholder text). Current value announced. Character limit announced when reached. Validation errors announced immediately on occurrence.
- Placeholder text must not be used as the only label — a visible label above or beside the field is required. Placeholder text disappears when the player types, causing confusion for players with cognitive or memory impairments.
```

**行 608-613:**
```
**Implementation Notes**: [Godot `LineEdit`: set `placeholder_text` for the hint
but always include a visible `Label` node as the field's accessible name. Bind
`text_changed` signal for real-time validation. Bind `text_submitted` for form
submission on Enter. On console, `LineEdit.call("_popup_keyboard")` or use the OS
virtual keyboard API — verify against engine-reference/godot/ for Godot 4.6
console keyboard API specifics.]
```

**行 619-628:**
```
**Category**: Navigation
**When to Use**: Dividing a single screen's content into discrete sections where
only one section is visible at a time. Character sheet tabs (Stats / Equipment /
Skills), settings tabs (Gameplay / Graphics / Audio / Accessibility). Maximum
5-6 tabs before the pattern breaks down and a sidebar navigation should be
**When NOT to Use**: More than 6 tabs. Content that benefits from simultaneous
visibility (use a layout pattern instead). Navigation between different screens
```

**行 630-630:**
```
**Interaction Specification**:
```

**行 632-637:**
```
| State | Visual | Input | Response | Duration | Audio |
|-------|--------|-------|----------|----------|-------|
| Default (inactive tab) | Tab label. No active indicator. | — | — | — | — |
| Active tab | Tab label. Active indicator (underline, fill, or contrasting background). Content area shows this tab's content. | — | — | — | — |
| Hovered (inactive) | Tab background fills slightly | Mouse over | — | 60ms | — |
| Focused (keyboard/gamepad) | Focus ring on tab label. | Tab key (within tab bar) or D-pad left/right on tab row | — | 60ms | [UI focus sound] |
```

**行 639-639:**
```
| Gamepad shoulder button | — | L1/R1 (PS) or LB/RB (Xbox) | Switch to previous/next tab (standard platform convention) | 150ms | [UI tab switch sound] |
```

**行 642-644:**
```
- Keyboard: Arrow keys navigate between tabs within the tab bar (left/right). Tab key moves focus into the content area below. This follows the ARIA tab panel pattern.
- Screen reader: Role: "tab" for individual tabs. Role: "tablist" for the container. Role: "tabpanel" for the content area. Active tab state: "selected." Accessible name: tab label. Tabpanel is labeled by its corresponding tab.
- The active tab must be visually distinguishable by more than color alone (underline, fill pattern, or weight change in addition to color).
```

**行 646-651:**
```
**Implementation Notes**: [Godot: `TabContainer` built-in. For custom visual
styling, implement manually with a `HBoxContainer` of tab buttons and a
`MarginContainer` for content. The shoulder button shortcut (LB/RB) must be
implemented in the screen's `_input()` override — it is not built into Godot's
tab system. Check platform conventions: Xbox uses LB/RB; PlayStation uses L1/R1;
both are the same physical button, so a single binding works.]
```

**行 655-655:**
```
#### Scroll Container
```

**行 659-664:**
```
**When to Use**: Content that exceeds the visible area of its container. Inventory
lists, lore entry text, credits, long settings lists. The scroll indicator shows
the player that more content exists.
**When NOT to Use**: Content that can be paginated instead (pagination may be
clearer for dense list navigation). Infinite scroll (always provide a loading
state and an end state).
```

**行 666-666:**
```
**Interaction Specification**:
```

**行 668-675:**
```
| State | Visual | Input | Response | Duration | Audio |
|-------|--------|-------|----------|----------|-------|
| Content fits | No scrollbar visible (or always-visible scrollbar at full height, depending on art direction). | — | — | — | — |
| Scrollable | Scrollbar appears (right edge). Scrollbar thumb size represents viewport vs. content ratio. | — | — | — | — |
| Scrolling (mouse) | Content moves. Scrollbar thumb moves proportionally. | Mouse wheel | Scroll by 3 lines per wheel tick (configurable in OS) | Smooth | — |
| Scrollbar drag | Content moves. Thumb follows pointer. | Click + drag scrollbar thumb | Scroll proportionally | Real time | — |
| Keyboard scroll | Content moves one item height per keypress. | Up/Down arrows when container is focused and no child is focused | Scroll by one unit | Immediate | — |
| Gamepad scroll | Content moves to keep focused item in view. | D-pad navigation to items beyond visible area | Auto-scroll to keep focused item visible | Smooth 150ms | — |
```

**行 677-677:**
```
| Focus follows scroll | When a child element receives focus, scroll container ensures it is fully visible. | Any child receives focus | Scroll to reveal focused element | 200ms ease | — |
```

**行 680-682:**
```
- Keyboard/Gamepad: The scroll container itself should not require explicit scrollbar interaction — navigating list items inside it should auto-scroll to keep focused items in view.
- Screen reader: The scroll container announces "scrollable" and the scroll position ("showing items 5 through 15 of 30"). This requires engine accessibility support — verify in engine-reference/godot/.
- Fade edges (content fading at scroll boundaries to indicate more content exists) are a helpful visual affordance but must not be the only indicator that content exists beyond the visible area. Include a scrollbar.
```

**行 684-688:**
```
**Implementation Notes**: [Godot `ScrollContainer`: call `ensure_control_visible()`
on the focused child whenever `gui_focus_changed` fires inside the container.
Bind this via a recursive `connect` on the container's `gui_focus_changed` signal.
For smooth scroll animation, use a `Tween` on `scroll_vertical` rather than
setting it directly.]
```

**行 696-696:**
```
#### Inventory Slot
```

**行 698-702:**
```
**Category**: Game-Specific
**When to Use**: Every item container in the inventory grid. Empty slots, populated
slots, equipped slots, locked slots. The slot is the frame; the item icon is the
```

**行 706-715:**
```
| State | Visual | Notes |
|-------|--------|-------|
| Empty | Subtle slot border, no content. Not the same as disabled. Empty slots are interactable (receive items). | Avoid fully invisible empty slots — players lose track of grid dimensions |
| Populated | Item icon fills 80% of slot area. Stack count bottom-right (if applicable). Quality border (colorblind-safe — icon + color). Equipped badge (top-right, if equipped). | |
| Focused | Focus ring. Tooltip appears after 300ms. | |
| Selected | Thicker or contrasting border. Used when multi-select is supported. | |
| Drag source | Slot dims, drag ghost follows pointer. | See Grid Item for full drag spec |
| Locked | Padlock icon overlay. No interaction. May show item at 50% opacity behind lock. | Used for locked loadout slots, DLC content, etc. |
| Highlighted | Animated border glow (pulsing). Used for quest-relevant items or newly acquired items. | Respect motion reduction — replace pulse with a static badge |
| Cooldown overlay | Radial fill overlay from 12 o'clock, clockwise, depleting as cooldown expires. | Only applicable if slots represent active items with cooldowns |
```

**行 717-717:**
```
**Accessibility**: Stack counts and quality tiers must have text or icon alternatives to color coding. Tooltip is the primary accessibility mechanism — ensure it is reachable by keyboard and screen reader. Locked slots must announce "locked" to screen readers.
```

**行 719-719:**
```
**Implementation Notes**: [Godot: Custom `Control` node. Quality border implemented as a `StyleBoxFlat` swapped based on rarity — avoid using `modulate` color for quality, as it affects the icon color. Drag and drop implemented via `get_drag_data()` and `can_drop_data()` / `drop_data()` override methods.]
```

**行 725-728:**
```
**Category**: Game-Specific
**When to Use**: Ability buttons in the HUD ability bar, skill tree nodes, and
any context where an ability must show availability state.
```

**行 732-737:**
```
| State | Visual | Notes |
|-------|--------|-------|
| Available | Full opacity icon. Keybinding label below. | |
| On cooldown | Radial overlay depleting clockwise from 12 o'clock. Remaining time shown as a number in the center when > 2 seconds remain. | |
| Charges remaining | Charge pip indicators below icon (e.g., 3 filled circles = 3 charges). Number alternative for screen readers. | |
| Out of resource | Icon desaturates to ~20%. Border dims. Keybinding label dims. Distinct from cooldown — resource-gated, not time-gated. | |
```

**行 740-740:**
```
| Just activated | Brief scale 0.9x then spring to 1.0x (overshoot to 1.05x). | Example: Guild Wars 2 and Path of Exile both use press-depress animations on ability use to confirm activation. Respect motion reduction. |
```

**行 742-742:**
```
**Accessibility**: All cooldown/charge information must have a numeric value (screen reader cannot parse radial overlays). The cooldown timer number satisfies this. Ability names and descriptions must be exposed to screen readers via tooltip.
```

**行 744-748:**
```
**Implementation Notes**: [Godot: Custom `TextureButton` subclass with overlay
`Control` nodes for cooldown radial and charge pips. The cooldown radial uses a
custom shader on a `ColorRect` rotating a mask — or implement with a
`ProgressBar` styled as circular if engine supports it. Verify against
engine-reference/godot/ for Godot 4.6 shader support for this pattern.]
```

**行 754-757:**
```
**Category**: Game-Specific
**When to Use**: Any continuously varying value in the HUD that represents a
critical player resource. Health, mana, stamina, shield, fuel.
```

**行 759-759:**
```
**States and behaviors**:
```

**行 761-768:**
```
| Event | Visual | Audio | Duration |
|-------|--------|-------|---------|
| Value decrease (damage) | Fill shrinks. Brief "damage flash" on the fill (white or red flash). Ghost bar lingers at previous value and drains to new value over 0.5s ("damage indicator"). | [Damage taken sound — varies by amount] | Instant decrease, 500ms ghost bar drain |
| Value increase (heal) | Fill grows. Brief heal color flash (green — ensure colorblind safe with icon/glow backup). | [Heal sound] | 300ms ease-in |
| Below 25% threshold | Fill changes color to warning state. Border pulses (or static badge in motion reduction mode). Optional: heartbeat audio cue (paired with visual if audio is sole signal). | [Low health sound — loops until above threshold] | Continuous |
| At zero | Bar empty. Optional: bar shakes briefly. Death/depletion event fires. | [Death/depletion sound] | 200ms shake |
| Maximum | Fill at 100%, brief glow. | — | 200ms |
| Overflow (shield) | A separate bar segment appears beyond the natural fill area, in shield color. | [Shield gain sound] | 200ms |
```

**行 770-770:**
```
**Accessibility**: The current value must be accessible as a number (tooltip or persistent display, or both). Color-coded threshold states must have non-color backups (icon, flashing, or audio visual warning). Warning state at 25% must have a visual signal independent of the color change.
```

**行 772-775:**
```
**Implementation Notes**: [Godot: Two overlapping `ProgressBar` nodes for ghost
bar effect — back bar holds previous value (drains via Tween), front bar holds
current value (updates instantly). Threshold states trigger `StyleBoxFlat` swaps
on the front bar. Ghost bar Tween duration is tunable as a designer parameter.]
```

**行 779-779:**
```
#### Dialogue Box
```

**行 781-784:**
```
**Category**: Game-Specific
**When to Use**: NPC conversation, voiced narrative dialogue, tutorial text
delivered through a character. All dialogue that has a speaker.
```

**行 786-786:**
```
**Structure**: Speaker portrait or name tag (top of box or left side). Dialogue text body. Continue/advance prompt (bottom right). Optional: skip-all button, voice acting indicator, subtitle indicator.
```

**行 788-788:**
```
**States and behaviors**:
```

**行 790-794:**
```
| State | Visual | Input | Response | Duration |
|-------|--------|-------|----------|---------|
| Line entering | Text reveals character-by-character (typewriter effect). Or: text fades in at full speed if accessibility option set. | — | — | Speed: configurable in accessibility settings |
| Revealing | Text animating in. Continue prompt hidden or pulsing at slow opacity. | [Any advance input] | Skip to end of current line instantly (show full line, stop typewriter) | Immediate |
| Line complete | Full line shown. Continue prompt visible and animated. | — | — | — |
```

**行 797-798:**
```
| Closing | Box fades out | Final line advanced | Return control to player | 200ms |
| Skipping all (if supported) | Brief confirmation prompt: "Skip dialogue?" | Dedicated skip button | Skip to post-dialogue state | — |
```

**行 800-800:**
```
**Accessibility**: Subtitles are always enabled by default for all voiced dialogue. Typewriter animation speed is a user setting (see accessibility-requirements.md). The dialogue box must not auto-advance — players must control pacing. Speaker name is always shown. All choice buttons must be navigable by keyboard and gamepad. Choices must be accessible to screen readers with position announced.
```

**行 802-807:**
```
**Implementation Notes**: [Godot: `RichTextLabel` with `bbcode_enabled` for
formatting. Typewriter effect via `visible_characters` property animated by a
`Timer`. Bind the advance input to a function that either skips typewriter
(sets `visible_characters = -1`) or advances the dialogue state. Speaker name
displayed in a separate `Label` above or beside the box. Dialogue data loaded from
JSON or a dedicated dialogue format (e.g., Dialogic, Yarn Spinner for Godot).]
```

**行 811-811:**
```
#### Context Action Prompt
```

**行 813-817:**
```
**Category**: Game-Specific
**When to Use**: A prompt that appears near an interactable game object indicating
what the player can do. "Press [A] to open chest." "Hold [E] to pick up." Appears
when the player enters the interaction zone, disappears when they leave.
```

**行 821-827:**
```
| State | Visual | Notes |
|-------|--------|-------|
| Appearing | Fades in and rises 8px from object anchor point. | Respect motion reduction — fade only, no rise |
| Idle | Platform-correct button icon + action label. Icon matches current input method (updates if player switches). | Always show platform-correct icon — do not hardcode "Press A" for all platforms |
| Holding (for hold inputs) | Radial fill on the button icon shows hold progress. Label changes to active verb ("Opening..."). | |
| Cannot interact (blocked) | Icon dims. Label shows reason if known ("Too heavy", "Need key"). | Optional — only show blocked state if the reason is meaningful to the player |
| Disappearing | Fades out. | Triggered when player exits interaction zone |
```

**行 829-829:**
```
**Accessibility**: The button icon must be accompanied by a text label — do not rely on icon alone (some players use custom button labels or adaptive controllers with non-standard icons). The prompt must be positioned to not overlap character health or critical HUD information.
```

**行 831-831:**
```
**Implementation Notes**: [Godot: Attach as a `Node3D` child (or `Node2D` child in 2D) of the interactable object. Use a `BillboardMesh` or a `SubViewport` with a UI scene for 3D games — this keeps the prompt facing the camera without code. Update the button icon texture based on `Input.get_joy_name()` or keyboard detection via `InputEventKey` vs `InputEventJoypadButton`. Hold progress implemented as an `AnimationPlayer` or `Tween` on a radial mask shader.]
```

**行 835-835:**
```
#### Damage Number
```

**行 837-840:**
```
**Category**: Game-Specific
**When to Use**: Floating feedback numbers above combat participants. Normal
damage, critical damage, healing, miss.
```

**行 844-848:**
```
| Variant | Visual | Notes |
|---------|--------|-------|
| Normal damage | White number, normal weight, medium size. | |
| Critical hit | Larger size (1.5x), bold weight, orange or yellow — verify colorblind safe. Brief scale impact (1.3x → 1.0x on appear). | Example: Path of Exile and Diablo IV both use scale-pop for crits to make them immediately recognizable by size alone, independent of color. |
| Healing | Green (verify colorblind safe — use + prefix and upward trajectory as non-color backups). | |
```

**行 850-850:**
```
| Status damage (DoT) | Smaller size, distinct color matching the status effect. | |
```

**行 852-852:**
```
**Behavior**: Numbers float upward from the hit location over 1.0 second. Numbers fade from 100% to 0% during the last 0.4 seconds. Multiple numbers from rapid hits stagger horizontally to avoid overlap. Maximum simultaneous damage numbers on screen: [define per game — typically 8-12 per character].
```

**行 854-854:**
```
**Accessibility**: Damage numbers are purely supplementary feedback — they must never be the only way to understand combat state. Health bars are the authoritative source. Provide an option to disable damage numbers entirely (some players find them visually overwhelming). When disabled, the game must remain fully playable.
```

**行 856-860:**
```
**Implementation Notes**: [Godot: Pool of `Label3D` (3D games) or `Label` (2D games)
instances recycled via an object pool. Each instance is given a random small
horizontal offset on spawn (±20px) to reduce overlap. Float animation via
`Tween` on `position.y` and `modulate.a`. Critical hit scale-pop via Tween
with `EASE_OUT` on scale followed by linear settle.]
```

**行 870-871:**
```
**Category**: Navigation
```

**行 873-873:**
```
These three patterns define how screens enter and exit the navigation stack.
```

**行 875-877:**
```
| Pattern | Trigger | Animation | Stack Behavior | Focus Behavior |
|---------|---------|-----------|---------------|----------------|
| Push | Navigate deeper (open submenu, open detail view) | New screen slides in from right. Previous screen slides left and dims. | Previous screen remains on stack | Focus moves to first interactive element on new screen |
```

**行 879-879:**
```
| Replace | Navigate to a peer screen (not child, not parent). Loading screen. | Fade out current, fade in new. No directional bias. | Current screen removed. New screen added. | Focus moves to first interactive element on new screen |
```

**行 881-881:**
```
**Animation durations**: Push/Pop: 250ms ease-in-out. Replace: 200ms fade out + 200ms fade in.
```

**行 883-883:**
```
**Motion reduction**: All slide animations become fades. Duration reduces to 100ms.
```

**行 885-889:**
```
**Implementation Notes**: [Godot: Implement as a `ScreenManager` singleton managing
a stack of `Control` scenes. `push(screen_scene)` instantiates and animates in.
`pop()` animates out and frees. `replace(screen_scene)` calls pop then push without
the intermediate stack state. Use `CanvasLayer` per screen to isolate input handling.
Store the "return focus" element reference before pushing so it can be restored on pop.]
```

**行 893-893:**
```
#### Focus Management
```

**行 895-896:**
```
**Category**: Navigation
```

**行 898-901:**
```
> Focus management is the most common keyboard and gamepad accessibility failure
> in game UIs. These rules must be implemented consistently. A player should
> never be in a state where they cannot see which element is focused, or where
> Tab/D-pad produces no visible result.
```

**行 903-905:**
```
| Rule | Description |
|------|-------------|
| Screen open | Focus is placed on the most logical interactive element — typically the Primary button, the first list item, or the last-focused element if the screen was previously visited. Never on a non-interactive element. |
```

**行 907-914:**
```
| Modal open | Focus is trapped inside the modal. See Modal Dialog pattern. |
| Modal close | Focus returns to the element that triggered the modal. |
| Element disabled | If the focused element becomes disabled, focus moves to the next available interactive element in the tab order. |
| Element destroyed | If the focused element is removed from the scene, focus moves to the nearest preceding element in the tab order. |
| Screen without interactive elements | Focus management is a no-op. Ensure back/cancel input still works. |
| Tab key (keyboard) | Moves focus forward through interactive elements in document order (left to right, top to bottom). Shift+Tab moves backward. |
| D-pad (gamepad) | Moves focus in the spatial direction pressed. Spatial navigation is preferred over strict tab order for gamepad. Never wrap focus between unrelated regions (e.g., Tab bar and content area should be separate navigation regions). |
| Focus is always visible | Focus ring or equivalent focus indicator must ALWAYS be visible when an element is focused via keyboard or gamepad. Never suppress focus indicators. |
```

**行 920-921:**
```
**Category**: Navigation
```

**行 923-924:**
```
> The "go back" action is the most-used navigation input in all menu systems.
> It must be consistent across every screen with no exceptions.
```

**行 926-927:**
```
| Platform | Input | Behavior |
|----------|-------|---------|
```

**行 930-932:**
```
| Xbox | B button | Same as Escape |
| PlayStation | Circle button | Same as Escape |
| Nintendo Switch | B button | Same as Escape (NOTE: Nintendo uses B for confirm in some first-party titles — verify platform convention for this release and document the decision) |
```

**行 934-934:**
```
**Rules**: This input must never be overridden to do something other than "go back / cancel." If a screen has no back action (e.g., the game is paused and the player must make a choice), Escape does nothing or shows a "you must choose" message — it does not navigate away. Every screen must define its Escape behavior explicitly in its UX spec.
```

**行 942-942:**
```
#### Loading State
```

**行 944-945:**
```
**Category**: Feedback
```

**行 947-950:**
```
| Scope | Pattern | Notes |
|-------|---------|-------|
| Full screen (initial load) | Full-screen loading screen with game art, progress bar (determinate if possible), tip text (optional). | Never use an empty black screen. Give the player something to read or look at. |
| Full screen (level transition) | Fade to black, loading screen, fade from black to new scene. | The fade removes the pop of the previous scene disappearing. |
```

**行 954-954:**
```
**Accessibility**: Loading states must announce to screen readers: "[Context] loading, please wait." Completion must announce "[Context] loaded." For full-screen loading, ensure the loading screen itself is navigable to screen readers — the tips text and any UI elements must be exposed.
```

**行 958-958:**
```
#### Empty State
```

**行 960-961:**
```
**Category**: Feedback
```

**行 963-967:**
```
> Empty states are consistently the least-designed parts of game UIs. They are
> the difference between a player feeling "this is where I'll store my items"
> and "why is nothing here? did something break?" Every empty list and grid must
> have a designed empty state. The empty state is not an error — it is a starting
```

**行 969-974:**
```
| Location | Empty State Content | Notes |
|----------|--------------------|----|
| Inventory (no items) | Icon (subtle, large, centered). Message: "Your inventory is empty." Sub-message: "Items you find on your journey will appear here." | Do not say "No items found" — "found" implies a failed search. |
| Quest Log (no active quests) | Icon. Message: "No active quests." Sub-message: "Talk to characters marked with [quest marker icon] to start a quest." | Give the player a clear action. |
| Achievements (none earned) | Icon. Message: "No achievements yet." List of hint achievements: "Try [Action] to earn your first achievement." | Gamified motivation, not just emptiness. |
| Search results (no matches) | Icon. Message: "No results for '[search term]'." Sub-message: "Try a different search or [browse all]." | Mirror the search term back at them. Give an alternative action. |
```

**行 976-976:**
```
**Rule**: Every empty state must include an icon, a message, and either a sub-message or an action button. A blank container with no explanation is never acceptable.
```

**行 980-980:**
```
#### Error State
```

**行 982-983:**
```
**Category**: Feedback
```

**行 985-990:**
```
| Error Type | Pattern | Tone |
|-----------|---------|------|
| Input validation (form field) | Inline error message below the field. Error icon left of message. Red border on field (colorblind-safe with icon). | Neutral and specific — "Username must be 3-20 characters." Not "Invalid input." |
| Operation failed (save error, network error) | Toast notification for non-critical failures. Modal Dialog for critical failures (save file cannot be written). | Calm and actionable — "Save failed. Check storage space." Not "FATAL ERROR." |
| System error (crash, data corruption) | Full-screen error screen with error code, recovery options ("Restart Game," "Load last save"), and support contact. | Reassuring — acknowledge the problem, give the player agency. Never blame the player. |
| Soft error (action cannot be performed) | Toast or inline message. | Explanatory — "Not enough gold" not "Action unavailable." |
```

**行 992-992:**
```
**Principle**: Error messages are never the player's fault. They are the game telling the player what happened and what to do next. Remove the word "invalid" from all error messages — replace with specific explanations.
```

**行 998-1001:**
```
> These timing values apply to ALL patterns in this library. When a pattern says
> "150ms ease-out," the easing function is defined here. Consistency in timing
> makes the UI feel like a single designed system rather than a collection of
> individual decisions.
```

**行 1003-1004:**
```
| Animation Type | Duration (ms) | Easing Function | Notes |
|---------------|--------------|----------------|-------|
```

**行 1007-1021:**
```
| Button press scale down | 60 | ease-in | Immediate feedback |
| Button press scale up (release) | 80 | ease-out | Slightly bouncy feel |
| Screen push (enter) | 250 | ease-in-out | Screen slides in from right |
| Screen pop (exit) | 250 | ease-in-out | Screen slides out to right |
| Modal open | 200 | ease-out | Expands from center |
| Modal close | 150 | ease-in | Collapses faster than it opens |
| Toast enter | 200 | ease-out | Slides in from screen edge |
| Toast exit | 200 | ease-in | |
| Tab switch | 150 | ease-in-out | Content cross-fades or slides |
| Tooltip appear | 120 | ease-out | After 300-400ms delay |
| Tooltip disappear | 80 | ease-in | |
| Progress bar fill | 300 | ease-out | Value changes animate smoothly |
| Value flash (damage, gain) | 100ms on + 100ms off | linear | Brief, attention-catching |
| Dialogue text reveal (per character) | 30ms per character | linear | Configurable in accessibility settings |
| HUD damage flash | 80 | linear | White or red overlay, immediate |
```

**行 1023-1023:**
```
**Motion reduction overrides**: When motion reduction mode is enabled (see accessibility-requirements.md), all slide and scale animations are replaced with fades. Fade durations are reduced by 50%. Looping animations (indeterminate spinners, pulsing indicators) are replaced with static equivalents.
```

**行 1029-1033:**
```
> Every interactive event should have audio feedback. Sound is a primary feedback
> channel, not a decoration. The sounds defined here are event categories — the
> specific audio assets are defined in `docs/sound-bible.md`. This table maps
> interaction events to sound categories so the sound designer and UI programmer
> use the same vocabulary.
```

**行 1035-1036:**
```
| Interaction Event | Sound Category | Notes |
|------------------|---------------|-------|
```

**行 1038-1038:**
```
| Button (Primary) confirm | UI Confirm — Primary | Slightly more prominent than secondary confirm. The "yes, let's go" sound. |
```

**行 1040-1045:**
```
| Button (Destructive) — opening confirmation | UI Warning | Distinct from standard confirm. Brief attention-catching sound. |
| Confirmation dialog — confirm destructive | UI Confirm — Destructive | Final, slightly weighted. The action is being taken. |
| Toggle ON | UI Toggle On | Brief, snappy, slightly bright. Celeste's accessibility toggles have a satisfying click-on sound. |
| Toggle OFF | UI Toggle Off | Same click family, slightly flatter. |
| Slider adjust | UI Slider | Subtle continuous sound while dragging. A single click per D-pad step. Never fatiguing. |
| Dropdown open | UI Expand | Brief, directional (opening feel). |
```

**行 1047-1057:**
```
| Tab switch | UI Tab | Horizontal movement feel. Distinct from vertical navigation. |
| Modal open | UI Modal Open | More prominent than standard navigation — draws attention. |
| Modal close (cancel) | UI Modal Close | Returns to previous context. |
| Toast — informational | UI Notification | Background-level, non-intrusive. |
| Toast — achievement | UI Achievement | Celebratory but not overlong. The player should feel rewarded, not interrupted. |
| Toast — warning | UI Warning — Toast | Distinct from error. Alert, not alarming. |
| Error state | UI Error | Friendly but clear. Not a harsh buzzer. Dark Souls uses a subtle dull thud for failed actions — communicates "no" without being harsh. |
| Success confirmation | UI Success | Clean and satisfying. |
| Ability activate | Gameplay — Ability Activate | In-world feel, distinct from pure UI. Part of game feel, not menu feel. |
| Damage received | Gameplay — Damage | See sound-bible.md for full specification. |
| Item pickup | Gameplay — Item Acquire | Brief, rewarding. |
```

**行 1059-1059:**
```
| Dialogue advance | UI Dialogue | Subtle, matches typewriter rhythm if typewriter is active. |
```

**行 1065-1071:**
```
| Question | Owner | Deadline | Resolution |
|----------|-------|----------|-----------|
| [Does the engine's accessibility node system support screen reader announcements for toast notifications without requiring focus? Verify against engine-reference/godot/ for Godot 4.6.] | [ux-designer] | [Before first menu implementation] | [Unresolved] |
| [What is the platform-correct confirm/cancel button mapping for Nintendo Switch release? Nintendo first-party convention differs from Xbox/PlayStation.] | [producer] | [Before platform certification submission] | [Unresolved] |
| [Should damage numbers be pooled as Label3D nodes or rendered in a SubViewport? Verify performance budget in coordination with technical-director.] | [lead-programmer, ux-designer] | [Before combat HUD implementation] | [Unresolved] |
| [What is the maximum number of simultaneous toast notifications before the queue becomes visually overwhelming? Needs playtesting.] | [ux-designer] | [First playtesting session] | [Unresolved] |
| [Add question] | [Owner] | [Deadline] | [Resolution] |
```

**未翻译列表项:**
- 行 133: - Keyboard: Tab to focus, Enter or Space to activate. Must be reachable from any other interactive element on screen via Tab sequence.
- 行 135: - Screen reader: Button must expose accessible name matching visible label. Role: "button." State: "dimmed" when disabled. Activation announcement: "[Label] button — [result of action, if known]."
- 行 136: - Colorblind: Do not rely on color alone to distinguish Primary from Secondary. Primary uses higher visual weight (fill vs. outline, or larger size) in addition to color differentiation.
- 行 236: - Keyboard/Gamepad: Space or Enter to toggle. Avoid requiring directional inputs (left/right) to toggle — some users cannot predict that behavior.
- 行 237: - Screen reader: Role: "switch." State: "on" or "off" — the accessible name should NOT include the state (the screen reader announces state separately). Correct: accessible name "Subtitles," state "on." Incorrect: accessible name "Subtitles On."
- 行 238: - The toggle label (not just the visual thumb position) must change to show current state for players who cannot reliably distinguish left from right positions.
- 行 272: - Keyboard: Left/Right arrows to adjust by small step. Page Up/Page Down for large step. Home/End to jump to min/max.
- 行 273: - Screen reader: Role: "slider." Accessible name: the label (e.g., "Music Volume"). Current value announced on every change: "Music Volume, 80 percent." Min/max values announced on first focus.
- 行 274: - All sliders must show a numeric value alongside the visual position. Relying only on track fill position excludes players who cannot perceive relative position.
- 行 310: - Keyboard: Up/Down arrows navigate list items while open. Enter selects. Escape dismisses. First letter of an option jumps focus to first matching item.
- 行 311: - Screen reader: Role: "combobox." Accessible name: the field label. Expanded/collapsed state announced. Current value announced when focused. Each list item announces its value and position: "English, 1 of 12."
- 行 312: - The dropdown list must never obscure the current item or the control that opened it — this is a common failure on small screens.
- 行 344: - Keyboard/Gamepad: Up/Down arrows or D-pad to move between list items. The list must handle focus cycling — reaching the bottom should stop (not wrap) unless wrapping is explicitly designed.
- 行 345: - Screen reader: Role: "listitem." Parent list role: "list." Accessible name: primary label content. Metadata (secondary label) is optionally included in the description. Position announced: "Quest Log, 3 of 12."
- 行 382: - Keyboard/Gamepad: D-pad or arrow keys navigate cells. The grid must communicate its dimensions to screen readers. Row/column position announced.
- 行 383: - Screen reader: Role: "gridcell." Parent role: "grid." Accessible name: item name (or "empty slot" for empty cells). State: "selected" when selected, "dimmed" when locked. Position: "row 2, column 3."
- 行 384: - Tooltips must be reachable by keyboard — they must appear when the cell is focused, not only when hovered.
- 行 422: - Screen reader: Dialog container role: "dialog." Accessible name: dialog title (required — every dialog must have a title, even if visually hidden). On open, screen reader announces dialog title and first focusable element. Focus trap active.
- 行 423: - Keyboard: Escape key always maps to the cancel/dismiss action (same as Secondary button or close button). Enter always maps to the primary/confirm action.
- 行 424: - Motion reduction: Scale animation replaced with instant appear/disappear. Overlay fade retained at 100ms (faster).
- 行 452: - Title: Brief, action-describing. "Delete save file?" not "Are you sure?"
- 行 453: - Body: One sentence stating the consequence. "This cannot be undone."
- 行 454: - Confirm button: Button (Primary) — labeled with the specific action. "Delete Save File."
- 行 455: - Cancel button: Button (Secondary) — "Cancel."
- 行 456: - Default focus: Cancel (safer default — reduces accidental destructive actions).
- 行 491: - Screen reader: Toasts must be read aloud without requiring focus. In HTML, this uses `role="status"` or `role="alert"`. In game UI, this requires the engine's accessibility notification system. Verify engine support in engine-reference docs.
- 行 492: - Motion reduction: Slide animation replaced with fade only.
- 行 493: - Toasts must never be the sole communication channel for information the player needs to act on. If the information requires action, use a persistent UI element in addition to the toast.
- 行 494: - Auto-dismiss timer: 5 seconds is the minimum. Players with cognitive processing differences may need more time. Consider a setting to extend to 10 or 15 seconds.
- 行 530: - Screen reader: Tooltip content must be accessible without hover. The accessible name of the parent element should include the most critical tooltip information. The full tooltip text is optionally in the `description` property. Screen reader reads tooltip content when element is focused.
- 行 531: - The delay (300-400ms) prevents accidental tooltip display and is required — instant tooltips are disruptive in gamepad navigation.
- 行 532: - Tooltip text must meet the same contrast requirements as body text (4.5:1 minimum).
- 行 564: - Screen reader: Role: "progressbar." Accessible name: what is progressing (e.g., "Experience Points," "Loading"). Value: current numeric value AND percentage AND maximum. "Experience Points, 450 of 1000, 45 percent." Update on significant changes (not every pixel).
- 行 565: - Do not rely only on fill color to communicate value. Include a numeric label.
- 行 566: - Indeterminate progress bars: announce "Loading, in progress" — do not announce changes since the value is unknown.
- 行 567: - Motion reduction: Indeterminate animation is replaced with a static "loading" indicator. Smooth fill animation is replaced with instant jump to new value.
- 行 604: - Keyboard: All standard text editing shortcuts (Home, End, Ctrl+A, Ctrl+C, Ctrl+V, Ctrl+Z).
- 行 605: - Screen reader: Role: "textbox." Accessible name: field label (not placeholder text). Current value announced. Character limit announced when reached. Validation errors announced immediately on occurrence.
- 行 606: - Placeholder text must not be used as the only label — a visible label above or beside the field is required. Placeholder text disappears when the player types, causing confusion for players with cognitive or memory impairments.
- 行 642: - Keyboard: Arrow keys navigate between tabs within the tab bar (left/right). Tab key moves focus into the content area below. This follows the ARIA tab panel pattern.
- 行 643: - Screen reader: Role: "tab" for individual tabs. Role: "tablist" for the container. Role: "tabpanel" for the content area. Active tab state: "selected." Accessible name: tab label. Tabpanel is labeled by its corresponding tab.
- 行 644: - The active tab must be visually distinguishable by more than color alone (underline, fill pattern, or weight change in addition to color).
- 行 680: - Keyboard/Gamepad: The scroll container itself should not require explicit scrollbar interaction — navigating list items inside it should auto-scroll to keep focused items in view.
- 行 681: - Screen reader: The scroll container announces "scrollable" and the scroll position ("showing items 5 through 15 of 30"). This requires engine accessibility support — verify in engine-reference/godot/.
- 行 682: - Fade edges (content fading at scroll boundaries to indicate more content exists) are a helpful visual affordance but must not be the only indicator that content exists beyond the visible area. Include a scrollbar.

--------------------------------------------------------------------------------

### .codebuddy\docs\director-gates.md
- 未翻译段落数: 73
- 未翻译列表项数: 124

**未翻译段落:**

**行 59-61:**
```
> `/brainstorm space horror` → 使用全局模式
> `/brainstorm space horror --review full` → 本次运行强制完整模式
> `/architecture-decision --review solo` → 本次运行跳过所有门控
```

**行 72-75:**
```
|------|----------|----------|
| `full` | 所有门控激活——每个工作流步骤都被审查 | 团队、学习型用户，或当你希望在每一步都获得详细总监反馈时 |
| `lean` | 仅阶段门控（`/gate-check`）——跳过每技能门控 | **默认**——独立开发者和小团队；总监仅在里程碑时审查 |
| `solo` | 任何地方都不运行总监门控 | 游戏 jams、原型、最大速度 |
```

**行 96-106:**
```
> 在生成门控 [GATE-ID] 之前：
> 1. 如果技能以 --review [mode] 调用，使用该模式
> 2. 否则读取 production/review-mode.txt
> - solo → 跳过所有门控。注明："[GATE-ID] 已跳过——Solo 模式"
> - lean → 除非是阶段门控（CD-PHASE-GATE, TD-PHASE-GATE, PR-PHASE-GATE），否则跳过
>          注明："[GATE-ID] 已跳过——Lean 模式"
```

**行 118-120:**
```
> 1. 如果技能以 `--review [mode]` 调用，使用该模式
> 2. 否则读取 `production/review-mode.txt`
```

**行 122-125:**
```
Apply the resolved mode:
- `solo` → **skip all gates**. Note in output: `[GATE-ID] skipped — Solo mode`
- `lean` → **skip unless this is a PHASE-GATE** (CD-PHASE-GATE, TD-PHASE-GATE, PR-PHASE-GATE, AD-PHASE-GATE). Note: `[GATE-ID] skipped — Lean mode`
- `full` → spawn as normal
```

**行 144-148:**
```
> 通过 Task 生成 `[agent-name]`：
> - 门控：[GATE-ID]（参见 .codebuddy/docs/director-gates.md）
```

**行 163-166:**
```
> # 先对每个门控应用模式检查，然后生成所有存活者：
> 通过 Task 同时生成所有 [N] 个代理——在等待任何结果之前发出所有 Task 调用。
```

**行 176-177:**
```
| Verdict | Meaning | Default action |
|---------|---------|----------------|
```

**行 185-185:**
```
|------|------|----------|
```

**行 209-210:**
```
> > **[总监] 审查 ([GATE-ID])**：已批准 [日期] / 关注（已接受）[日期] / 已修订 [日期]
```

**行 235-238:**
```
- Full pillar set with names, definitions, and design tests
- Anti-pillars list
- Core fantasy statement
- Unique hook ("Like X, AND ALSO Y")
```

**行 241-244:**
```
- 完整支柱集，包含名称、定义和设计测试
- 反支柱列表
- 核心幻想陈述
- 独特卖点（"像X，而且还有Y"）
```

**行 271-274:**
```
- GDD file path
- Game pillars (from `design/gdd/game-concept.md` or `design/gdd/game-pillars.md`)
- MDA aesthetics target for this game
- System's stated Player Fantasy section
```

**行 290-290:**
```
> "审查此系统 GDD 的支柱对齐情况。每个部分是否服务于声明的支柱？是否存在与支柱矛盾或削弱支柱的机制或规则？玩家幻想部分是否匹配游戏的核心幻想？返回 APPROVE、CONCERNS [有问题的具体部分] 或 REJECT [必须在系统可实现之前重新设计的支柱违规]。"
```

**行 306-307:**
```
- Systems index path (`design/gdd/systems-index.md`)
- Game pillars and core fantasy (from `design/gdd/game-concept.md`)
```

**行 309-309:**
```
- Any high-risk or bottleneck systems identified in the dependency map
```

**行 312-313:**
```
- 系统索引路径（`design/gdd/systems-index.md`）
- 游戏支柱和核心幻想（来自 `design/gdd/game-concept.md`）
```

**行 329-329:**
```
> "对照游戏设计支柱审查此系统分解。完整的 MVP 层系统是否共同交付了核心幻想？是否存在其机制不服务于任何声明的支柱的系统——表明它们可能是范围蔓延？是否存在对支柱至关重要的玩家体验没有分配系统来交付？核心循环是否缺少任何必需的系统？返回 APPROVE（系统服务于愿景）、CONCERNS [具体差距或与支柱含义的偏差] 或 REJECT [根本性差距——分解遗漏了关键设计意图，必须在 GDD 编写开始前修订]。"
```

**行 339-341:**
```
**Trigger**: After narrative GDDs, lore documents, dialogue specs, or world-building
documents are authored (team-narrative, design-system for story systems, writer
```

**行 346-349:**
```
- Document file path(s)
- Game pillars
- Narrative direction brief or tone guide (if exists at `design/narrative/`)
- Any existing lore that the new document references
```

**行 365-365:**
```
> "审查此叙事内容与游戏支柱和既定世界规则的一致性。语调是否匹配游戏既定的声音？是否与现有背景设定或世界构建存在矛盾？内容是否服务于玩家体验支柱？返回 APPROVE、CONCERNS [具体不一致处] 或 REJECT [破坏世界连贯性的矛盾]。"
```

**行 381-383:**
```
- Playtest report file path
- Game pillars and core fantasy statement
- The specific hypothesis being tested
```

**行 399-399:**
```
> "对照游戏设计支柱和核心幻想审查此试玩报告。玩家体验是否匹配预期幻想？是否存在代表支柱漂移的系统性问题——单独感觉良好但破坏预期体验的机制？返回 APPROVE（核心幻想正在实现）、CONCERNS [预期与实际体验之间的差距] 或 REJECT [核心幻想未出现——在进一步试玩前需要重新设计]。"
```

**行 414-416:**
```
- Target phase name
- List of all artifacts present (file paths)
- Game pillars and core fantasy
```

**行 456-456:**
```
- Systems index path (or the dependency map summary if index not yet written)
```

**行 458-460:**
```
- The full dependency graph (what each system depends on)
- Any bottleneck systems flagged (many dependents)
- Any circular dependencies found and their proposed resolutions
```

**行 463-463:**
```
- 系统索引路径（或如果索引尚未编写时的依赖映射摘要）
```

**行 465-467:**
```
- 完整依赖图（每个系统依赖什么）
- 标记的任何瓶颈系统（有多个依赖方）
- 发现的任何循环依赖及其建议解决方案
```

**行 499-502:**
```
- Concept's core loop description
- Platform target
- Engine choice (or "undecided")
- List of identified technical risks
```

**行 505-508:**
```
- 概念的核心循环描述
- 平台目标
- 引擎选择（或"未决定"）
- 已识别的技术风险列表
```

**行 519-519:**
```
> "审查这些技术风险，针对一款 [类型] 游戏，目标平台 [平台]，使用 [引擎或'未决定引擎']。标记任何可能使所述概念失效的高风险项、任何特定于引擎且应影响引擎选择的风险，以及任何常被独立开发者低估的风险。返回 VIABLE（风险可控）、CONCERNS [列表及缓解建议] 或 HIGH RISK [需要概念或范围修订的阻塞项]。"
```

**行 535-538:**
```
- Architecture document path (`docs/architecture/architecture.md`)
- Technical requirements baseline (TR-IDs and count)
- ADR list with statuses
- Engine knowledge gap inventory
```

**行 571-573:**
```
- ADR file path
- Engine version and knowledge gap risk level for the domain
- Related ADRs (if any)
```

**行 589-589:**
```
> "审查此架构决策记录。它是否有清晰的问题陈述和理由？被拒绝的替代方案是否被真正考虑？后果部分是否诚实地承认了权衡？引擎版本是否已标记？截止日期后的 API 风险是否被标记？它是否链接到它覆盖的 GDD 需求？返回 APPROVE、CONCERNS [具体差距] 或 REJECT [决策不够具体或做出了不健全的技术假设]。"
```

**行 605-607:**
```
- The specific API or feature being used
- Engine version and LLM knowledge cutoff (from `docs/engine-reference/[engine]/VERSION.md`)
- Relevant excerpt from breaking-changes or deprecated-apis docs
```

**行 637-640:**
```
- Target phase name
- Architecture document path (if exists)
- Engine reference path
- ADR list
```

**行 680-682:**
```
- Full vision scope description
- MVP definition
- Timeline estimate
```

**行 684-684:**
```
- Scope tiers (what ships if time runs out)
```

**行 687-689:**
```
- 完整愿景范围描述
- MVP 定义
- 时间线估算
```

**行 691-691:**
```
- 范围层级（如果时间耗尽发布什么）
```

**行 702-702:**
```
> "审查此范围估算。在声明的团队规模下，MVP 是否可以在声明的时间线内实现？范围层级是否按风险正确排序——如果工作在每个层级停止，是否都能交付可发布的产品？在时间压力下最可能的切割点是什么，是优雅的降级还是残缺的产品？返回 REALISTIC（范围与能力匹配）、OPTIMISTIC [建议的具体调整] 或 UNREALISTIC [阻塞项——时间线或 MVP 必须修订]。"
```

**行 718-721:**
```
- Proposed sprint story list (titles, estimates, dependencies)
- Team capacity (hours available)
- Current sprint backlog debt (if any)
- Milestone constraints
```

**行 724-727:**
```
- 建议的冲刺故事列表（标题、估算、依赖）
- 团队产能（可用小时数）
- 当前冲刺积压债务（如有）
- 里程碑约束
```

**行 754-757:**
```
- Milestone definition and target date
- Current completion percentage
- Blocked stories count
- Sprint velocity data (if available)
```

**行 760-763:**
```
- 里程碑定义和目标日期
- 当前完成百分比
- 阻塞故事数量
- 冲刺速度数据（如有）
```

**行 766-771:**
```
> "Review this milestone status. Based on current velocity and blocked story count,
> will this milestone hit its target date? What are the top 3 production risks
> between now and the milestone? Are there scope items that should be cut to protect
> the milestone date vs. items that are non-negotiable? Return ON TRACK, AT RISK
> [specific mitigations], or OFF TRACK [date must slip or scope must cut — provide
```

**行 774-774:**
```
> "审查此里程碑状态。基于当前速度和阻塞故事数量，此里程碑能否达到目标日期？从现在到里程碑之间前3大生产风险是什么？是否应削减某些范围项以保护里程碑日期，而非不可协商的项？返回 ON TRACK、AT RISK [具体缓解措施] 或 OFF TRACK [日期必须推迟或范围必须削减——提供两种选项]。"
```

**行 784-786:**
```
**Trigger**: After epics are defined by `/create-epics`, before stories are
broken out — validates the epic structure is producible before `/create-stories`
```

**行 791-793:**
```
- Epic definition file paths (all epics just created)
- Epic index path (`production/epics/index.md`)
- Milestone timeline and target dates
```

**行 817-817:**
```
> "在故事拆分开始之前审查此史诗结构的生产可行性。史诗边界是否范围适当——每个史诗是否能在里程碑截止日期前实际完成？史诗是否按系统依赖正确排序——是否有史诗在开始前需要另一个史诗的输出？是否有任何史诗范围过小（应合并）或范围过大（应拆分为2-3个专注的史诗）？基础层史诗的范围是否允许核心层史诗在基础层完成后的下一个冲刺开始时启动？返回 REALISTIC（史诗结构可生产）、CONCERNS [编写故事前需要的具体结构调整] 或 UNREALISTIC [史诗必须拆分、合并或重新排序——在解决之前无法开始故事拆分]。"
```

**行 832-835:**
```
- Target phase name
- Sprint and milestone artifacts present
- Team size and capacity
- Current blocked story count
```

**行 838-841:**
```
- 目标阶段名称
- 现有冲刺和里程碑产物
- 团队规模和产能
- 当前阻塞故事数量
```

**行 851-851:**
```
> "从生产角度审查当前项目状态的 [目标阶段] 门控就绪度。范围对于声明的团队规模和时间线是否现实？依赖是否正确排序以便团队可以按序执行？是否存在可能在前两个冲刺内使阶段脱轨的里程碑或冲刺风险？返回 READY、CONCERNS [列表] 或 NOT READY [阻塞项]。"
```

**行 874-877:**
```
- Game concept (elevator pitch, core fantasy, unique hook)
- Full pillar set with names, definitions, and design tests
- Target platform (if known)
- Any reference games or visual touchstones mentioned by the user
```

**行 880-883:**
```
- 游戏概念（电梯演讲、核心幻想、独特卖点）
- 完整支柱集，包含名称、定义和设计测试
- 目标平台（如已知）
- 用户提到的任何参考游戏或视觉参考点
```

**行 911-914:**
```
- Art bible path (`design/art/art-bible.md`)
- Game pillars and core fantasy
- Platform and performance constraints (from `.codebuddy/docs/technical-preferences.md` if configured)
- Visual identity anchor chosen during brainstorm (from `design/gdd/game-concept.md`)
```

**行 917-920:**
```
- 美术圣经路径（`design/art/art-bible.md`）
- 游戏支柱和核心幻想
- 平台和性能约束（来自 `.codebuddy/docs/technical-preferences.md`，如已配置）
- brainstorm 期间选择的视觉标识锚点（来自 `design/gdd/game-concept.md`）
```

**行 949-952:**
```
- Target phase name
- List of all art/visual artifacts present (file paths)
- Visual identity anchor from `design/gdd/game-concept.md` (if present)
- Art bible path if it exists (`design/art/art-bible.md`)
```

**行 972-972:**
```
> "从视觉方向角度审查当前项目状态的 [目标阶段] 门控就绪度。视觉标识是否已建立并记录到此阶段所需的水平？是否具备正确的视觉产物？视觉团队能否在无视觉方向缺口的情况下开始工作（这些缺口可能导致后期昂贵的返工）？是否有视觉决策被推迟到了最迟负责时刻之后？返回 READY、CONCERNS [可能导致生产返工的具体视觉方向缺口] 或 NOT READY [此阶段成功之前必须存在的视觉阻塞项——说明缺少什么产物以及为什么在此阶段很重要]。"
```

**行 997-999:**
```
- Architecture document path
- Technical requirements baseline summary
- ADR list with statuses
```

**行 1015-1015:**
```
> "审查此架构的实现可行性。标记：（a）任何用声明的引擎和语言难以或无法实现的决策，（b）任何程序员需要自行发明的缺失接口定义，（c）任何造成可避免技术债务或与标准 [引擎] 习惯用法矛盾的模式。返回 FEASIBLE、CONCERNS [列表] 或 INFEASIBLE [使此架构按所写无法实现的阻塞项]。"
```

**行 1031-1034:**
```
- Implementation file paths
- Story file path (for acceptance criteria)
- Relevant GDD section
- ADR that governs this system
```

**行 1066-1066:**
```
- Story file path
```

**行 1068-1069:**
```
- Acceptance criteria list (verbatim from the story)
- The GDD requirement (TR-ID and text) the story covers
```

**行 1106-1107:**
```
- Test file paths in `tests/`
- GDD acceptance criteria for the system
```

**行 1139-1142:**
```
- Document or content file path(s)
- Narrative bible or tone guide path (if exists)
- Relevant world-building rules
- Character or faction profiles affected
```

**行 1151-1156:**
```
> "Review this narrative content for internal consistency and adherence to
> established world rules. Are character voices consistent with their established
> profiles? Does the lore contradict any established facts? Is the tone consistent
> with the game's narrative direction? Return APPROVE, CONCERNS [specific
> inconsistencies to fix], or REJECT [contradictions that break the narrative
```

**行 1159-1159:**
```
> "审查此叙事内容的内部一致性和对既定世界规则的遵守。角色声音是否与既定档案一致？背景设定是否与既定事实矛盾？语调是否与游戏的叙事方向一致？返回 APPROVE、CONCERNS [需要修复的具体不一致处] 或 REJECT [破坏叙事基础的矛盾]。"
```

**行 1175-1178:**
```
- Art bible path (if exists at `design/art-bible.md`)
- The specific asset type, style decision, or visual direction being reviewed
- Reference images or style descriptions
- Platform and performance constraints
```

**行 1181-1184:**
```
- 美术圣经路径（如存在于 `design/art-bible.md`）
- 正在审查的具体资产类型、风格决策或视觉方向
- 参考图像或风格描述
- 平台和性能约束
```

**行 1194-1194:**
```
> "审查此视觉方向决策与既定美术风格和生产约束的一致性。它是否匹配美术圣经？在平台性能预算内是否可实现？是否存在造成技术风险的资产管线影响？返回 APPROVE、CONCERNS [具体调整] 或 REJECT [必须先解决的风格违规或生产风险]。"
```

**行 1224-1234:**
```
> 并行生成（在等待任何结果之前发出所有 Task 调用）：
> 1. creative-director  → 门控 CD-PHASE-GATE
> 2. technical-director → 门控 TD-PHASE-GATE
> 3. producer           → 门控 PR-PHASE-GATE
> 4. art-director       → 门控 AD-PHASE-GATE
> - 任何 NOT READY / REJECT → 总体裁决最低为 FAIL
> - 任何 CONCERNS → 总体裁决最低为 CONCERNS
> - 全部 READY / APPROVE → 符合 PASS 条件（仍需产物检查）
```

**行 1275-1282:**
```
|------|----------|----------|
| **概念** | CD-PILLARS, AD-CONCEPT-VISUAL | TD-FEASIBILITY, PR-SCOPE |
| **系统设计** | TD-SYSTEM-BOUNDARY, CD-SYSTEMS, PR-SCOPE, CD-GDD-ALIGN（每个GDD） | ND-CONSISTENCY, AD-VISUAL |
| **技术设置** | TD-ARCHITECTURE, TD-ADR（每个ADR）, LP-FEASIBILITY, AD-ART-BIBLE | TD-ENGINE-RISK |
| **预生产** | PR-EPIC, QL-STORY-READY（每个故事）, PR-SPRINT, 所有四个阶段门控（通过gate-check） | CD-PLAYTEST |
| **生产** | LP-CODE-REVIEW（每个故事）, QL-STORY-READY, PR-SPRINT（每个冲刺） | PR-MILESTONE, QL-TEST-COVERAGE, AD-VISUAL |
| **打磨** | QL-TEST-COVERAGE, CD-PLAYTEST, PR-MILESTONE | AD-VISUAL |
| **发布** | 所有四个阶段门控（通过gate-check） | QL-TEST-COVERAGE |
```

**未翻译列表项:**
- 行 113: 1. If skill was called with `--review [mode]`, use that
- 行 123: - `solo` → **skip all gates**. Note in output: `[GATE-ID] skipped — Solo mode`
- 行 124: - `lean` → **skip unless this is a PHASE-GATE** (CD-PHASE-GATE, TD-PHASE-GATE, PR-PHASE-GATE, AD-PHASE-GATE). Note: `[GATE-ID] skipped — Lean mode`
- 行 235: - Full pillar set with names, definitions, and design tests
- 行 236: - Anti-pillars list
- 行 237: - Core fantasy statement
- 行 241: - 完整支柱集，包含名称、定义和设计测试
- 行 244: - 独特卖点（"像X，而且还有Y"）
- 行 271: - GDD file path
- 行 272: - Game pillars (from `design/gdd/game-concept.md` or `design/gdd/game-pillars.md`)
- 行 273: - MDA aesthetics target for this game
- 行 278: - 游戏支柱（来自 `design/gdd/game-concept.md` 或 `design/gdd/game-pillars.md`）
- 行 279: - 该游戏的 MDA 美学目标
- 行 280: - 系统声明的玩家幻想部分
- 行 306: - Systems index path (`design/gdd/systems-index.md`)
- 行 307: - Game pillars and core fantasy (from `design/gdd/game-concept.md`)
- 行 312: - 系统索引路径（`design/gdd/systems-index.md`）
- 行 313: - 游戏支柱和核心幻想（来自 `design/gdd/game-concept.md`）
- 行 315: - 依赖图中识别的任何高风险或瓶颈系统
- 行 346: - Document file path(s)
- 行 347: - Game pillars
- 行 348: - Narrative direction brief or tone guide (if exists at `design/narrative/`)
- 行 354: - 叙事方向简报或语调指南（如存在于 `design/narrative/`）
- 行 355: - 新文档引用的任何现有背景设定
- 行 381: - Playtest report file path
- 行 382: - Game pillars and core fantasy statement
- 行 387: - 游戏支柱和核心幻想陈述
- 行 414: - Target phase name
- 行 415: - List of all artifacts present (file paths)
- 行 420: - 所有现有产物列表（文件路径）
- 行 456: - Systems index path (or the dependency map summary if index not yet written)
- 行 458: - The full dependency graph (what each system depends on)
- 行 459: - Any bottleneck systems flagged (many dependents)
- 行 463: - 系统索引路径（或如果索引尚未编写时的依赖映射摘要）
- 行 465: - 完整依赖图（每个系统依赖什么）
- 行 466: - 标记的任何瓶颈系统（有多个依赖方）
- 行 467: - 发现的任何循环依赖及其建议解决方案
- 行 499: - Concept's core loop description
- 行 500: - Platform target
- 行 501: - Engine choice (or "undecided")
- 行 507: - 引擎选择（或"未决定"）
- 行 535: - Architecture document path (`docs/architecture/architecture.md`)
- 行 536: - Technical requirements baseline (TR-IDs and count)
- 行 537: - ADR list with statuses
- 行 541: - 架构文档路径（`docs/architecture/architecture.md`）
- 行 542: - 技术需求基线（TR-ID 和数量）
- 行 571: - ADR file path
- 行 572: - Engine version and knowledge gap risk level for the domain
- 行 577: - 引擎版本和该领域的知识差距风险级别
- 行 605: - The specific API or feature being used
- 行 606: - Engine version and LLM knowledge cutoff (from `docs/engine-reference/[engine]/VERSION.md`)
- 行 610: - 正在使用的具体 API 或功能
- 行 611: - 引擎版本和 LLM 知识截止日期（来自 `docs/engine-reference/[engine]/VERSION.md`）
- 行 612: - 重大变更或弃用 API 文档的相关摘录
- 行 637: - Target phase name
- 行 638: - Architecture document path (if exists)
- 行 639: - Engine reference path
- 行 644: - 架构文档路径（如存在）
- 行 680: - Full vision scope description
- 行 681: - MVP definition
- 行 682: - Timeline estimate
- 行 691: - 范围层级（如果时间耗尽发布什么）
- 行 718: - Proposed sprint story list (titles, estimates, dependencies)
- 行 719: - Team capacity (hours available)
- 行 720: - Current sprint backlog debt (if any)
- 行 724: - 建议的冲刺故事列表（标题、估算、依赖）
- 行 725: - 团队产能（可用小时数）
- 行 726: - 当前冲刺积压债务（如有）
- 行 754: - Milestone definition and target date
- 行 755: - Current completion percentage
- 行 756: - Blocked stories count
- 行 791: - Epic definition file paths (all epics just created)
- 行 792: - Epic index path (`production/epics/index.md`)
- 行 793: - Milestone timeline and target dates
- 行 798: - 史诗定义文件路径（刚创建的所有史诗）
- 行 799: - 史诗索引路径（`production/epics/index.md`）
- 行 800: - 里程碑时间线和目标日期
- 行 832: - Target phase name
- 行 833: - Sprint and milestone artifacts present
- 行 834: - Team size and capacity
- 行 874: - Game concept (elevator pitch, core fantasy, unique hook)
- 行 875: - Full pillar set with names, definitions, and design tests
- 行 876: - Target platform (if known)
- 行 880: - 游戏概念（电梯演讲、核心幻想、独特卖点）
- 行 881: - 完整支柱集，包含名称、定义和设计测试
- 行 883: - 用户提到的任何参考游戏或视觉参考点
- 行 911: - Art bible path (`design/art/art-bible.md`)
- 行 912: - Game pillars and core fantasy
- 行 913: - Platform and performance constraints (from `.codebuddy/docs/technical-preferences.md` if configured)
- 行 917: - 美术圣经路径（`design/art/art-bible.md`）
- 行 919: - 平台和性能约束（来自 `.codebuddy/docs/technical-preferences.md`，如已配置）
- 行 920: - brainstorm 期间选择的视觉标识锚点（来自 `design/gdd/game-concept.md`）
- 行 949: - Target phase name
- 行 950: - List of all art/visual artifacts present (file paths)
- 行 951: - Visual identity anchor from `design/gdd/game-concept.md` (if present)
- 行 956: - 所有现有美术/视觉产物列表（文件路径）
- 行 957: - 来自 `design/gdd/game-concept.md` 的视觉标识锚点（如存在）
- 行 958: - 美术圣经路径（如存在 `design/art/art-bible.md`）
- 行 997: - Architecture document path
- 行 998: - Technical requirements baseline summary
- 行 1031: - Implementation file paths
- 行 1032: - Story file path (for acceptance criteria)
- 行 1033: - Relevant GDD section
- 行 1038: - 故事文件路径（用于验收标准）
- 行 1066: - Story file path
- 行 1068: - Acceptance criteria list (verbatim from the story)
- 行 1074: - 验收标准列表（原文摘自故事）
- 行 1075: - 故事覆盖的 GDD 需求（TR-ID 和文本）
- 行 1106: - Test file paths in `tests/`
- 行 1111: - `tests/` 中的测试文件路径
- 行 1112: - 系统的 GDD 验收标准
- 行 1139: - Document or content file path(s)
- 行 1140: - Narrative bible or tone guide path (if exists)
- 行 1141: - Relevant world-building rules
- 行 1146: - 叙事圣经或语调指南路径（如存在）
- 行 1148: - 受影响的角色或阵营档案
- 行 1175: - Art bible path (if exists at `design/art-bible.md`)
- 行 1176: - The specific asset type, style decision, or visual direction being reviewed
- 行 1177: - Reference images or style descriptions
- 行 1181: - 美术圣经路径（如存在于 `design/art-bible.md`）
- 行 1182: - 正在审查的具体资产类型、风格决策或视觉方向
- 行 1244: 1. Assign a gate ID: `[DIRECTOR-PREFIX]-[DESCRIPTIVE-SLUG]`
- 行 1245: - Prefixes: `CD-` `TD-` `PR-` `LP-` `QL-` `ND-` `AD-`
- 行 1246: - Add new prefixes for new agents: `AudioDirector` → `AU-`, `UX` → `UX-`

--------------------------------------------------------------------------------

### .codebuddy\docs\templates\concept-doc-from-prototype.md
- 未翻译段落数: 83
- 未翻译列表项数: 76

**未翻译段落:**

**行 4-9:**
```
**Status**: Reverse-Documented from Prototype
**Prototype Path**: `prototypes/[name]/`
**Date**: [YYYY-MM-DD]
**Creator**: [User name]
**Outcome**: [Success | Partial Success | Failed | Needs More Testing]
```

**行 11-15:**
```
> **⚠️ Reverse-Documentation Notice**
> This concept document was created **after** the prototype was built. It captures
> the core mechanic, learnings, and design insights discovered through prototyping.
> This is a formalization of experimental work, not a pre-planned design.
```

**行 19-19:**
```
## 1. Prototype Overview
```

**行 21-22:**
```
**Original Hypothesis**:
[What question or idea was this prototype testing?]
```

**行 25-25:**
```
[How was the prototype built? Quick and dirty? Focused on one mechanic?]
```

**行 28-29:**
```
- Time spent: [X hours/days]
- Complexity: [Throwaway | Could be production-ready | Needs full rewrite]
```

**行 31-34:**
```
**Outcome** (clarified):
- ✅ **Validated**: [What worked and should move forward]
- ⚠️ **Needs Work**: [What showed promise but needs refinement]
- ❌ **Invalidated**: [What didn't work and should be abandoned]
```

**行 38-38:**
```
## 2. Core Mechanic
```

**行 40-41:**
```
**What the Prototype Does**:
[Describe the mechanic or system that was prototyped]
```

**行 43-46:**
```
**How It Feels** (user feedback):
- [Feeling 1 — e.g., "Satisfying", "Clunky", "Too complex"]
- [Feeling 2 — e.g., "Intuitive", "Confusing", "Needs tutorial"]
- [Feeling 3 — e.g., "Fun", "Boring", "Has potential"]
```

**行 49-49:**
```
[What fantasy or experience does this mechanic create?]
```

**行 51-51:**
```
**Core Loop** (if applicable):
```

**行 56-58:**
```
**Emergent Behaviors** (unintended but interesting):
- [Behavior 1]: [What players did that wasn't planned]
- [Behavior 2]: [Unexpected strategy or interaction]
```

**行 62-62:**
```
## 3. What Worked
```

**行 64-64:**
```
### Mechanic Successes
```

**行 66-68:**
```
✅ **[Success 1]**: [What worked well]
- **Why**: [What made this successful]
- **Keep for Production**: [Should this be preserved?]
```

**行 70-72:**
```
✅ **[Success 2]**: [What worked well]
- **Why**: [What made this successful]
- **Keep for Production**: [Should this be preserved?]
```

**行 74-74:**
```
### Technical Successes
```

**行 76-78:**
```
✅ **[Technical win 1]**: [What technical approach worked]
- **Lesson**: [What we learned]
- **Reusable**: [Can this code/approach be used in production?]
```

**行 80-81:**
```
✅ **[Technical win 2]**: [What worked]
- **Lesson**: [What we learned]
```

**行 85-85:**
```
## 4. What Didn't Work
```

**行 87-87:**
```
### Mechanic Failures
```

**行 89-91:**
```
❌ **[Failure 1]**: [What didn't work]
- **Why**: [Root cause]
- **Could It Be Fixed**: [Is it salvageable or fundamentally flawed?]
```

**行 93-95:**
```
❌ **[Failure 2]**: [What didn't work]
- **Why**: [Root cause]
- **Could It Be Fixed**: [Yes/No + how]
```

**行 97-97:**
```
### Technical Failures
```

**行 99-100:**
```
❌ **[Technical issue 1]**: [What caused problems]
- **Lesson**: [What to avoid in production]
```

**行 102-103:**
```
❌ **[Technical issue 2]**: [What caused problems]
- **Lesson**: [What to avoid]
```

**行 107-107:**
```
## 5. What Needs Refinement
```

**行 109-112:**
```
⚠️ **[Element 1]**: [What showed promise but needs work]
- **Issue**: [What's wrong with it currently]
- **Path Forward**: [How to improve it]
- **Effort**: [Small | Medium | Large refactor]
```

**行 114-117:**
```
⚠️ **[Element 2]**: [What needs refinement]
- **Issue**: [Current problem]
- **Path Forward**: [Improvement approach]
- **Effort**: [Estimate]
```

**行 121-121:**
```
## 6. Key Learnings
```

**行 123-123:**
```
### Design Insights
```

**行 125-126:**
```
💡 **[Insight 1]**: [What we learned about game design]
- **Implication**: [How this affects future work]
```

**行 128-129:**
```
💡 **[Insight 2]**: [Design learning]
- **Implication**: [Impact on GDD or other systems]
```

**行 131-131:**
```
### Technical Insights
```

**行 133-134:**
```
💡 **[Insight 3]**: [Technical learning]
- **Implication**: [Architecture or implementation guidance]
```

**行 136-137:**
```
💡 **[Insight 4]**: [Technical learning]
- **Implication**: [Future technical decisions]
```

**行 139-139:**
```
### Player Psychology Insights
```

**行 141-142:**
```
💡 **[Insight 5]**: [What we learned about player behavior]
- **Implication**: [How this affects design philosophy]
```

**行 146-146:**
```
## 7. Production Readiness Assessment
```

**行 148-148:**
```
**Should This Become a Full Feature?**: [Yes | No | Needs More Testing | Pivot to Different Approach]
```

**行 150-154:**
```
**If Yes — Production Requirements**:
- [ ] [Requirement 1 — e.g., "Rewrite for performance"]
- [ ] [Requirement 2 — e.g., "Add proper UI"]
- [ ] [Requirement 3 — e.g., "Design 10 more variations"]
- [ ] [Requirement 4 — e.g., "Integrate with progression system"]
```

**行 156-158:**
```
**Estimated Production Effort**: [Small | Medium | Large]
- Prototype reusability: [X%] of code can be kept
- From-scratch effort: [X hours/days to production-ready]
```

**行 160-163:**
```
**If No — Why Not?**:
- [Reason 1 — e.g., "Fun but doesn't fit game pillars"]
- [Reason 2 — e.g., "Too complex for target audience"]
- [Reason 3 — e.g., "Technically infeasible at scale"]
```

**行 165-167:**
```
**If Pivot — Suggested Direction**:
- [Alternative approach 1]
- [Alternative approach 2]
```

**行 171-171:**
```
## 8. Design Pillars Alignment
```

**行 173-173:**
```
**How This Relates to Game Pillars** (if game pillars are defined):
```

**行 175-176:**
```
| Pillar | Alignment | Notes |
|--------|-----------|-------|
```

**行 181-181:**
```
**Overall Pillar Fit**: [Does this belong in the game?]
```

**行 185-185:**
```
## 9. Next Steps
```

**行 187-187:**
```
### Immediate (If Moving Forward)
```

**行 188-190:**
```
1. **[Task 1]**: [e.g., "Create full design doc for this system"]
2. **[Task 2]**: [e.g., "Write ADR for technical approach"]
3. **[Task 3]**: [e.g., "Add to backlog for Sprint X"]
```

**行 192-192:**
```
### Before Production (If Needs More Work)
```

**行 193-195:**
```
1. **[Task 1]**: [e.g., "Build second prototype testing X variation"]
2. **[Task 2]**: [e.g., "Playtest with 5+ people"]
3. **[Task 3]**: [e.g., "Investigate technical feasibility of Y"]
```

**行 197-197:**
```
### If Abandoning
```

**行 198-200:**
```
1. **[Task 1]**: [e.g., "Archive prototype with this document"]
2. **[Task 2]**: [e.g., "Extract reusable code/learnings"]
3. **[Task 3]**: [e.g., "Update game pillars if this changed thinking"]
```

**行 204-204:**
```
## 10. Technical Notes
```

**行 206-209:**
```
**Prototype Implementation**:
- Language/Engine: [What was used]
- Architecture: [How it was structured]
- Shortcuts taken: [What was hacky or throwaway]
```

**行 211-213:**
```
**Reusable Code** (if any):
- `[file/path 1]`: [What it does, reusability]
- `[file/path 2]`: [What it does, reusability]
```

**行 215-217:**
```
**Technical Debt** (if moving to production):
- [Debt 1]: [What needs rewriting]
- [Debt 2]: [What needs proper implementation]
```

**行 221-221:**
```
## 11. Playtest Feedback
```

**行 223-223:**
```
*(If prototype was playtested)*
```

**行 225-225:**
```
**Testers**: [N people, [internal/external]]
```

**行 227-229:**
```
**Positive Feedback**:
- "[Quote 1]" — [Tester name/role]
- "[Quote 2]" — [Tester name/role]
```

**行 231-233:**
```
**Negative Feedback**:
- "[Quote 1]" — [Tester name/role]
- "[Quote 2]" — [Tester name/role]
```

**行 236-237:**
```
- "[Suggestion 1]" — [Tester name]
- "[Suggestion 2]" — [Tester name]
```

**行 240-241:**
```
- [Theme 1]: [What multiple testers agreed on]
- [Theme 2]: [Common feedback]
```

**行 245-245:**
```
## 12. Related Work
```

**行 247-249:**
```
**Inspired By** (games/mechanics this was influenced by):
- [Game 1]: [What mechanic or feeling]
- [Game 2]: [What was borrowed or adapted]
```

**行 251-253:**
```
**Differs From** (how this is unique or different):
- [Difference 1]
- [Difference 2]
```

**行 255-257:**
```
**Integrates With** (existing game systems):
- [System 1]: [How they would connect]
- [System 2]: [How they would connect]
```

**行 261-261:**
```
## 13. Open Questions
```

**行 263-265:**
```
**Design Questions**:
1. **[Question 1]**: [What's still undecided about the design?]
2. **[Question 2]**: [What needs playtesting or iteration?]
```

**行 267-269:**
```
**Technical Questions**:
3. **[Question 3]**: [What technical unknowns remain?]
4. **[Question 4]**: [What needs feasibility testing?]
```

**行 273-273:**
```
## 14. Appendix: Prototype Assets
```

**行 276-277:**
```
- Location: `prototypes/[name]/src/`
- Status: [Archival | Partial reuse | Full reuse]
```

**行 279-281:**
```
**Art/Audio** (if any):
- Location: `prototypes/[name]/assets/`
- Status: [Placeholder | Production-ready | Needs replacement]
```

**行 284-285:**
```
- README: [Exists | Missing]
- Build instructions: [Exists | Missing]
```

**行 289-289:**
```
## Version History
```

**行 291-294:**
```
| Date | Author | Changes |
|------|--------|---------|
| [Date] | Claude (reverse-doc) | Initial concept doc from prototype analysis |
| [Date] | [User] | Clarified outcomes, added playtest feedback |
```

**行 298-298:**
```
**Final Recommendation**: [GO | NO-GO | PIVOT]
```

**行 300-300:**
```
**Rationale**: [1-2 sentence summary of why]
```

**行 304-304:**
```
*This concept document was generated by `/reverse-document concept prototypes/[name]`*
```

**未翻译列表项:**
- 行 28: - Time spent: [X hours/days]
- 行 29: - Complexity: [Throwaway | Could be production-ready | Needs full rewrite]
- 行 32: - ✅ **Validated**: [What worked and should move forward]
- 行 33: - ⚠️ **Needs Work**: [What showed promise but needs refinement]
- 行 34: - ❌ **Invalidated**: [What didn't work and should be abandoned]
- 行 44: - [Feeling 1 — e.g., "Satisfying", "Clunky", "Too complex"]
- 行 45: - [Feeling 2 — e.g., "Intuitive", "Confusing", "Needs tutorial"]
- 行 46: - [Feeling 3 — e.g., "Fun", "Boring", "Has potential"]
- 行 57: - [Behavior 1]: [What players did that wasn't planned]
- 行 58: - [Behavior 2]: [Unexpected strategy or interaction]
- 行 67: - **Why**: [What made this successful]
- 行 68: - **Keep for Production**: [Should this be preserved?]
- 行 71: - **Why**: [What made this successful]
- 行 72: - **Keep for Production**: [Should this be preserved?]
- 行 77: - **Lesson**: [What we learned]
- 行 78: - **Reusable**: [Can this code/approach be used in production?]
- 行 81: - **Lesson**: [What we learned]
- 行 90: - **Why**: [Root cause]
- 行 91: - **Could It Be Fixed**: [Is it salvageable or fundamentally flawed?]
- 行 94: - **Why**: [Root cause]
- 行 95: - **Could It Be Fixed**: [Yes/No + how]
- 行 100: - **Lesson**: [What to avoid in production]
- 行 103: - **Lesson**: [What to avoid]
- 行 110: - **Issue**: [What's wrong with it currently]
- 行 111: - **Path Forward**: [How to improve it]
- 行 112: - **Effort**: [Small | Medium | Large refactor]
- 行 115: - **Issue**: [Current problem]
- 行 116: - **Path Forward**: [Improvement approach]
- 行 117: - **Effort**: [Estimate]
- 行 126: - **Implication**: [How this affects future work]
- 行 129: - **Implication**: [Impact on GDD or other systems]
- 行 134: - **Implication**: [Architecture or implementation guidance]
- 行 137: - **Implication**: [Future technical decisions]
- 行 142: - **Implication**: [How this affects design philosophy]
- 行 151: - [ ] [Requirement 1 — e.g., "Rewrite for performance"]
- 行 152: - [ ] [Requirement 2 — e.g., "Add proper UI"]
- 行 153: - [ ] [Requirement 3 — e.g., "Design 10 more variations"]
- 行 154: - [ ] [Requirement 4 — e.g., "Integrate with progression system"]
- 行 157: - Prototype reusability: [X%] of code can be kept
- 行 158: - From-scratch effort: [X hours/days to production-ready]
- 行 161: - [Reason 1 — e.g., "Fun but doesn't fit game pillars"]
- 行 162: - [Reason 2 — e.g., "Too complex for target audience"]
- 行 163: - [Reason 3 — e.g., "Technically infeasible at scale"]
- 行 166: - [Alternative approach 1]
- 行 167: - [Alternative approach 2]
- 行 188: 1. **[Task 1]**: [e.g., "Create full design doc for this system"]
- 行 193: 1. **[Task 1]**: [e.g., "Build second prototype testing X variation"]
- 行 198: 1. **[Task 1]**: [e.g., "Archive prototype with this document"]
- 行 207: - Language/Engine: [What was used]
- 行 208: - Architecture: [How it was structured]
- 行 209: - Shortcuts taken: [What was hacky or throwaway]
- 行 212: - `[file/path 1]`: [What it does, reusability]
- 行 213: - `[file/path 2]`: [What it does, reusability]
- 行 216: - [Debt 1]: [What needs rewriting]
- 行 217: - [Debt 2]: [What needs proper implementation]
- 行 228: - "[Quote 1]" — [Tester name/role]
- 行 229: - "[Quote 2]" — [Tester name/role]
- 行 232: - "[Quote 1]" — [Tester name/role]
- 行 233: - "[Quote 2]" — [Tester name/role]
- 行 236: - "[Suggestion 1]" — [Tester name]
- 行 237: - "[Suggestion 2]" — [Tester name]
- 行 240: - [Theme 1]: [What multiple testers agreed on]
- 行 241: - [Theme 2]: [Common feedback]
- 行 248: - [Game 1]: [What mechanic or feeling]
- 行 249: - [Game 2]: [What was borrowed or adapted]
- 行 252: - [Difference 1]
- 行 253: - [Difference 2]
- 行 256: - [System 1]: [How they would connect]
- 行 257: - [System 2]: [How they would connect]
- 行 264: 1. **[Question 1]**: [What's still undecided about the design?]
- 行 276: - Location: `prototypes/[name]/src/`
- 行 277: - Status: [Archival | Partial reuse | Full reuse]
- 行 280: - Location: `prototypes/[name]/assets/`
- 行 281: - Status: [Placeholder | Production-ready | Needs replacement]
- 行 284: - README: [Exists | Missing]
- 行 285: - Build instructions: [Exists | Missing]

--------------------------------------------------------------------------------

### .codebuddy\docs\templates\hud-design.md
- 未翻译段落数: 95
- 未翻译列表项数: 56

**未翻译段落:**

**行 3-10:**
```
> **Status**: Draft | In Review | Approved | Implemented
> **Author**: [Name or agent — e.g., ui-designer]
> **Last Updated**: [Date]
> **Game**: [Game name — this is a single document per game, not per element]
> **Platform Targets**: [All platforms this HUD must work on — e.g., PC, PS5, Xbox Series X, Steam Deck]
> **Related GDDs**: [Every system that exposes information through the HUD — e.g., `design/gdd/combat.md`, `design/gdd/progression.md`, `design/gdd/quests.md`]
> **Accessibility Tier**: Basic | Standard | Comprehensive | Exemplary
> **Style Reference**: [Link to art bible HUD section if it exists — e.g., `design/gdd/art-bible.md § HUD Visual Language`]
```

**行 12-17:**
```
> **Note — Scope boundary**: This document specifies all elements that overlay the
> game world during active gameplay — health bars, ammo counters, minimaps, quest
> trackers, subtitles, damage numbers, and notification toasts. For menu screens,
> pause menus, inventory, and dialogs that the player navigates explicitly, use
> `ux-spec.md` instead. The test: if it appears while the player is directly
> controlling their character, it belongs here.
```

**行 21-21:**
```
## 1. HUD Philosophy
```

**行 23-29:**
```
> **Why this section exists**: The HUD design philosophy is not decoration — it is a
> design constraint that every subsequent decision is measured against. Without a
> philosophy, individual elements get added on request ("the quest tracker wants a
> bigger icon") without any principled way to push back. With a philosophy, there is
> a shared, explicit standard. More importantly, the philosophy prevents the HUD from
> slowly growing to cover the game world while each individual addition seemed
> reasonable in isolation. Write this before specifying any elements.
```

**行 31-31:**
```
**What is this game's relationship with on-screen information?**
```

**行 33-37:**
```
[One paragraph. This is a design statement, not a description of features. Consider
the game's genre, pacing, and player fantasy. A stealth game's HUD philosophy might
be: "The world is the interface. If the player has to look away from the environment
to survive, the HUD has failed." A tactics game might say: "Complete situational
awareness is the game. The HUD is not an overlay — it is the battlefield."
```

**行 39-43:**
```
Reference comparable games if helpful, but describe your specific stance:
Example — diegetic-first action RPG: "We treat screen information as a concession,
not a feature. Every HUD element must earn its pixel space by answering the question:
would the player make demonstrably worse decisions without this information visible?
If the answer is 'they'd adapt,' we put it in the environment instead."]
```

**行 45-45:**
```
**Visibility principle** — when in doubt, show or hide?
```

**行 47-51:**
```
[State the default resolution for ambiguous cases. Options:
- Default to HIDE: information is available on demand (e.g., Dark Souls — no quest tracker, no minimap, stats are in a menu)
- Default to SHOW: players prefer to be informed; cluttered is better than uncertain
- Default to CONTEXTUAL: information appears when it becomes relevant and fades when it does not
Most games benefit from contextual defaults. State your game's default clearly so every element decision is consistent.]
```

**行 53-53:**
```
**The Rule of Necessity for this game**:
```

**行 55-55:**
```
[Complete this sentence: "A HUD element earns its place when ______________."
```

**行 57-58:**
```
Example: "...the player would have to stop playing to find the same information
elsewhere, or would make meaningfully worse decisions without it."
```

**行 60-61:**
```
Example: "...removing it in playtesting causes measurable frustration or confusion
in more than 25% of testers within the first hour of play."
```

**行 63-64:**
```
This rule is the veto power over feature requests to add HUD elements. Document it
so it can be cited in design reviews.]
```

**行 68-68:**
```
## 2. Information Architecture
```

**行 70-76:**
```
> **Why this section exists**: Before specifying any HUD element's visual design,
> position, or behavior, you must answer a more fundamental question: should this
> information be on the HUD at all? This section is a forcing function — it requires
> you to categorize EVERY piece of information the game world generates and make an
> explicit, intentional decision about how each is presented. "We'll figure that out
> later" is how games end up with 18 elements competing for the player's peripheral
> vision. This table is the master inventory of game information, not just HUD information.
```

**行 79-79:**
```
|-----------------|-------------|--------------------------------|------------------------|----------------------------------|-----------|
```

**行 84-87:**
```
| [Quest objective] | [ ] | [X — show when objective changes or player is near it] | [ ] | [ ] | [Example: contextual — player knows their objective; only remind at key moments] |
| [Enemy health bar] | [ ] | [X — show only during combat encounters] | [ ] | [ ] | [Example: contextual because enemy health is irrelevant outside combat] |
| [Status effects (buffs/debuffs)] | [ ] | [X — show when active] | [ ] | [ ] | [Example: contextual because status effects only affect decisions when present] |
| [Dialogue subtitles] | [X when dialogue is playing] | [ ] | [ ] | [ ] | [Example: always show while dialogue is active — accessibility requirement] |
```

**行 89-90:**
```
| [Timer] | [ ] | [X — show only in timed sequences] | [ ] | [ ] | [Example: contextual because timers only exist in specific encounter types] |
| [Tutorial prompts] | [ ] | [X — show for first-time situations only] | [ ] | [ ] | [Example: contextual and one-time; never repeat to experienced players] |
```

**行 97-97:**
```
## 3. Layout Zones
```

**行 99-104:**
```
> **Why this section exists**: The game world is the primary content — the HUD is a
> frame around it. Before placing any element, divide the screen into named zones
> with explicit positions and safe zone margins. This section prevents two failure
> modes: (1) elements placed ad-hoc until the screen is cluttered, and (2) elements
> that overlap platform-required safe zones and get rejected in certification.
> Every element in Section 4 must be assigned to a zone defined here.
```

**行 106-106:**
```
### 3.1 Zone Diagram
```

**行 133-136:**
```
> Rule for zone placement: the center 40% of the screen (both horizontally and
> vertically) is the player's primary focus area. Keep this zone as clear as
> possible at all times. HUD elements that appear in the center zone — crosshairs,
> interaction prompts, hit markers — must be minimal, high-contrast, and brief.
```

**行 138-138:**
```
### 3.2 Zone Specification Table
```

**行 140-148:**
```
| Zone Name | Screen Position | Safe Zone Compliant | Primary Elements | Max Simultaneous Elements | Notes |
|-----------|----------------|---------------------|-----------------|--------------------------|-------|
| [Top Left] | [Top-left corner, within safe margin] | [Yes — 10% from top, 10% from left] | [Health bar, stamina bar, shield bar] | [3] | [Vital status — player's own resources. Priority zone for player state.] |
| [Top Center] | [Top edge, centered horizontally] | [Yes — 10% from top] | [Quest objective, area name (on enter)] | [1 — only one message at a time] | [Use for narrative context, not mechanical information. Keep text minimal.] |
| [Top Right] | [Top-right corner, within safe margin] | [Yes — 10% from top, 10% from right] | [Ammo count, ability cooldowns] | [2] | [Weapon/ability state. Most relevant during active combat.] |
| [Center] | [Screen center ±15%] | [N/A — not a margin zone] | [Crosshair, interaction prompt, hit marker] | [1 active at a time] | [CRITICAL: Nothing persistent here. Only momentary indicators.] |
| [Bottom Left] | [Bottom-left corner, within safe margin] | [Yes — 10% from bottom, 10% from left] | [Minimap, ability icons] | [2] | [Navigation and ability readout. Small, non-intrusive.] |
| [Bottom Center] | [Bottom edge, centered horizontally] | [Yes — 10% from bottom] | [Subtitles, tutorial prompts] | [2 — subtitle + tutorial may coexist] | [Highest-priority accessibility zone. Never place other elements here.] |
| [Bottom Right] | [Bottom-right corner, within safe margin] | [Yes — 10% from bottom, 10% from right] | [Notification toasts, pick-up feedback] | [3 stacked] | [Transient notifications. Stack vertically. Oldest disappears first.] |
```

**行 150-150:**
```
**Safe zone margins by platform**:
```

**行 152-159:**
```
| Platform | Top | Bottom | Left | Right | Notes |
|----------|-----|--------|------|-------|-------|
| [PC — windowed] | [0% — no safe zone required] | [0%] | [0%] | [0%] | [But respect minimum resolution — elements must not crowd at 1280x720] |
| [PC — fullscreen] | [3%] | [3%] | [3%] | [3%] | [Slight margin for 4K TV-connected PCs] |
| [Console — TV] | [10%] | [10%] | [10%] | [10%] | [Action-safe zone for broadcast-spec TVs. Some TVs overscan beyond this.] |
| [Steam Deck] | [5%] | [5%] | [5%] | [5%] | [Small screen; safe zone is smaller but crowding risk is higher] |
| [Mobile — portrait] | [15% top] | [10% bottom] | [5%] | [5%] | [15% top avoids notch/camera cutout on most devices] |
| [Mobile — landscape] | [5%] | [5%] | [15% left] | [15% right] | [Thumb placement on landscape — side zones are obscured by hands] |
```

**行 163-163:**
```
## 4. HUD Element Specifications
```

**行 165-169:**
```
> **Why this section exists**: Each HUD element needs its own specification to be
> built correctly. Ad-hoc implementation of HUD elements produces inconsistent
> sizing, mismatched update frequencies, missing urgency states, and accessibility
> failures. This section is the implementation brief for every element — fill it
> completely before any element moves into development.
```

**行 171-171:**
```
### 4.1 Element Overview Table
```

**行 173-173:**
```
> One row per HUD element. This is the master inventory for implementation planning.
```

**行 175-179:**
```
| Element Name | Zone | Always Visible | Visibility Trigger | Data Source | Update Frequency | Max Size (% screen W) | Min Readable Size | Overlap Priority | Accessibility Alt |
|-------------|------|---------------|-------------------|-------------|-----------------|----------------------|------------------|-----------------|------------------|
| [Health Bar] | [Top Left] | [Yes] | [N/A] | [PlayerStats] | [On value change] | [20%] | [120px wide] | [1 — highest] | [Numerical text label showing current/max: "80/100"] |
| [Stamina Bar] | [Top Left] | [No — context] | [Show when consuming stamina; hide 3s after full] | [PlayerStats] | [Realtime during use] | [15%] | [80px wide] | [2] | [Numerical label, or hide if full (accessible assumption)] |
| [Shield Indicator] | [Top Left] | [No — context] | [Show when shield is active or recently hit] | [PlayerStats] | [On value change] | [20%] | [120px wide] | [3] | [Numerical label. Must not use color alone — add shield icon.] |
```

**行 181-182:**
```
| [Minimap] | [Bottom Left] | [Yes] | [N/A — but suppressed in cinematic mode] | [NavigationSystem] | [Realtime] | [18%] | [150x150px] | [5] | [Cardinal direction compass strip as fallback; must be toggleable] |
| [Quest Objective] | [Top Center] | [No — context] | [Show on objective change; show when near objective location; hide after 5s] | [QuestSystem] | [On event] | [30%] | [Legible at body text size] | [6] | [Read aloud on objective change via screen reader] |
```

**行 184-185:**
```
| [Interaction Prompt] | [Center] | [No — context] | [Show when player is within interaction range of an interactive object] | [InteractionSystem] | [On enter/exit interaction range] | [15%] | [24px icon + readable text] | [2 — center zone] | [Text description of interaction always present, not icon-only] |
| [Subtitles] | [Bottom Center] | [No — always on when dialogue plays, if setting enabled] | [Show during any voiced line or ambient dialogue] | [DialogueSystem] | [Per dialogue line] | [60%] | [Minimum 24px font] | [1 — highest in zone] | [This IS the accessibility feature — see Section 8 for subtitle spec] |
```

**行 187-188:**
```
| [Status Effect Icons] | [Top Left — below health bar] | [No — context] | [Show when any status effect is active on player] | [StatusSystem] | [On effect add/remove] | [3% per icon] | [24px per icon] | [3] | [Icon + text label on hover/focus. Never icon-only.] |
| [Notification Toast] | [Bottom Right] | [No — event-driven] | [On loot, XP gain, achievement, quest update] | [Multiple — see Section 6] | [On event] | [25%] | [Legible at body text size] | [7 — lowest] | [Queued; never overlapping. Read by screen reader if subtitle mode on.] |
```

**行 190-190:**
```
### 4.2 Element Detail Blocks
```

**行 192-193:**
```
> For each element in the table above, write a detail block. Copy and complete
> one block per element.
```

**行 199-199:**
```
- Visual description: [Horizontal fill bar. Left-to-right fill direction. Segmented at 25/50/75% to aid reading at a glance. Background: dark semi-transparent (40% opacity). Fill color: context-dependent — see Urgency States.]
```

**行 201-208:**
```
- Update behavior: [Bar fill decreases or increases smoothly using a lerp over 150ms per change. Large damage (>25% single hit) triggers a brief flash (1 frame white, then drain).]
- Urgency states:
  - Normal (>50% HP): [Green fill, no special behavior]
  - Caution (25–50% HP): [Yellow fill, low warning pulse every 4 seconds]
  - Critical (<25% HP): [Red fill, persistent slow pulse (1 Hz), vignette appears at screen edges]
  - Zero (0% HP): [Bar empties and turns grey; death state begins]
- Interaction: [Display only. Not interactive. Player cannot click, hover, or focus this element as an action target.]
- Player customization: [Opacity adjustable (see Section 7 Tuning Knobs). Can be repositioned to any corner by player in accessibility settings.]
```

**行 214-219:**
```
- Visual description: [Circular mask, radius = 75px at reference resolution 1920x1080. Player icon at center. North always up unless player has unlocked "Rotate minimap" setting. Range = configurable, default 80 world units radius.]
- Data displayed: [Player position, nearby enemies (if detection perk unlocked), quest markers within range, points of interest icons, traversal obstacles (walls, drops).]
- Update behavior: [Realtime. Updates every frame. Enemy icons fade in/out as they enter/leave detection range over 300ms.]
- Urgency states: [None for the map itself. Enemy icons turn red when they are in combat-alert state.]
- Interaction: [Not interactive in-game. Press dedicated Map button to open the full map screen (separate UX spec).]
- Player customization: [Size: S/M/L (70/90/110px radius). Opacity: 30–100%. Rotation: locked-north or player-relative. Can be disabled entirely (compass strip shows as fallback).]
```

**行 223-223:**
```
**[Repeat this block for every element in Section 4.1]**
```

**行 227-227:**
```
## 5. HUD States by Gameplay Context
```

**行 229-234:**
```
> **Why this section exists**: The HUD is not a static overlay — it is a dynamic
> system that must adapt to what the player is doing. A HUD designed only for
> standard gameplay will look wrong in cutscenes, feel cluttered in exploration,
> and occlude critical information in boss fights. This section defines the
> transformations the HUD undergoes in each gameplay context. It is also the spec
> for the system that manages HUD visibility — the HUD state machine.
```

**行 236-239:**
```
| Context | Elements Shown | Elements Hidden | Elements Modified | Transition Into This State |
|---------|---------------|-----------------|------------------|---------------------------|
| [Exploration — no threats] | [Minimap, Quest Objective (faded, 60%), Subtitles (if active)] | [Ammo Counter, Crosshair, Damage Numbers, Status Effects (if none active)] | [Health Bar fades to 40% opacity — visible but not dominant] | [Fade transition, 500ms, when no enemies detected for 10s] |
| [Combat — active threat] | [Health Bar (full opacity), Stamina Bar (when used), Ammo Counter, Crosshair, Damage Numbers, Status Effects, Enemy Health Bars] | [Quest Objective (temporarily hidden), Notification Toasts (paused queue)] | [Minimap scales down 15% and raises opacity to 100%] | [Immediate snap in on first enemy detection — no fade. Combat readiness requires instant info.] |
```

**行 241-241:**
```
| [Cinematic (scripted camera sequence)] | [Subtitles only] | [Everything else including speaker name] | [Letterbox bars appear (if applicable to this game's style)] | [Immediate on cinematic flag; letterbox slides in from top/bottom over 400ms] |
```

**行 245-246:**
```
| [Tutorial — new mechanic] | [Standard context HUD + Tutorial Prompt overlay] | [Nothing additional hidden] | [Tutorial prompt dims background subtly to draw attention to prompt] | [Tutorial system fires ShowTutorial event; prompt fades in over 200ms] |
| [Boss Encounter] | [Boss health bar appears (large, bottom of screen or top center), all combat elements] | [Quest Objective] | [Boss bar renders in a distinct visual style — must not be confused with player health] | [Boss health bar slides in on boss encounter trigger over 400ms] |
```

**行 250-250:**
```
## 6. Information Hierarchy
```

**行 252-257:**
```
> **Why this section exists**: Not all HUD information is equally important. When
> screen space is limited, when the player is under high stress, or when elements
> compete for the same zone, there must be a principled priority order that governs
> which elements survive and which get suppressed. This section formalizes that
> hierarchy so it can be enforced systematically and not just "feels obvious" decisions
> made at implementation time.
```

**行 259-271:**
```
| Element | Priority Tier | Reasoning | What Replaces It If Hidden |
|---------|--------------|-----------|---------------------------|
| [Subtitles] | [MUST KEEP — never hide during dialogue] | [Accessibility requirement. Legal requirement in some markets. Story clarity.] | [N/A — nothing replaces subtitles] |
| [Health Bar] | [MUST KEEP — during any state where the player can be damaged] | [Without health visibility, survival decisions become impossible] | [Auditory cues (heartbeat, breathing) supplement but do not replace] |
| [Crosshair] | [MUST KEEP — while aiming with a ranged weapon] | [Targeting without a crosshair is a precision failure, not a difficulty feature] | [Alternative: dot-only mode for minimalists; never fully hidden while aiming] |
| [Interaction Prompt] | [MUST KEEP — when player is in interaction range] | [Without it, interactive objects are invisible to the player] | [Environmental visual cues can supplement but interaction affordance must be explicit] |
| [Ammo Counter] | [SHOULD KEEP] | [Low ammo decisions (switch weapon, reload) require awareness; can be contextual] | [Auditory "click" on empty chamber is acceptable fallback for experienced players] |
| [Minimap] | [SHOULD KEEP] | [Navigation requires spatial awareness; loss forces repeated map opens] | [Compass strip (simplified directional indicator) is acceptable fallback] |
| [Status Effects] | [SHOULD KEEP — while active] | [Active debuffs change what actions are viable; invisible debuffs feel unfair] | [Character animation states can partially communicate status effects (limping, sparks)] |
| [Quest Objective] | [CAN HIDE] | [Player can hold objective in memory for extended periods; contextual is correct default] | [Player remembers objective from context] |
| [Damage Numbers] | [CAN HIDE] | [Feedback element, not decision-critical. Many players turn these off.] | [Hit sounds and enemy reactions communicate hit registration] |
| [Notification Toasts] | [CAN HIDE in high-intensity moments] | [Mid-combat "You gained 50 XP" is noise, not signal. Queue and show after combat.] | [Queue held and released when combat ends] |
| [Combo Counter] | [ALWAYS HIDE when combo resets or player is not attacking] | [Stale combo information is actively misleading] | [N/A — simply hidden] |
```

**行 275-275:**
```
## 7. Visual Budget
```

**行 277-280:**
```
> **Why this section exists**: Without explicit budget constraints, HUD elements
> accumulate until the game world is nearly invisible. These numbers are hard limits,
> not guidelines. Every element addition that would breach a limit requires explicit
> approval and must displace or reduce an existing element.
```

**行 282-284:**
```
| Budget Constraint | Limit | Measurement Method | Current Estimate | Status |
|------------------|-------|--------------------|-----------------|--------|
| Maximum simultaneous active HUD elements | [8] | [Count all visible, non-faded elements at any one frame] | [TBD — verify at implementation] | [To verify] |
```

**行 286-290:**
```
| Maximum % of screen occupied by HUD (combat mode) | [22%] | [Same method — combat adds ammo, crosshair, enemy bars] | [TBD] | [To verify] |
| Maximum % of center screen zone (40% of screen W/H) occupied | [5%] | [Only crosshair and interaction prompt allowed here] | [TBD] | [To verify] |
| Minimum contrast ratio — HUD text on any background | [4.5:1 (WCAG AA)] | [Measured against the darkest and lightest game world areas the element will appear over] | [TBD] | [To verify] |
| Maximum opacity for HUD background panels | [65%] | [Opacity of any panel behind HUD text — must preserve world visibility through panel] | [TBD] | [To verify] |
| Minimum HUD element size at minimum supported resolution | [40px for icons, 18px for text] | [Measure at lowest target resolution] | [TBD] | [To verify] |
```

**行 292-295:**
```
> **How to apply these budgets**: For every new HUD element proposed during
> production, require the proposer to state (1) which budget line it affects,
> (2) what the new total will be, and (3) what existing element will be reduced or
> made contextual to stay within budget. "It's a small icon" is not an analysis.
```

**行 299-299:**
```
## 8. Feedback & Notification Systems
```

**行 301-306:**
```
> **Why this section exists**: Notifications are the most frequently-added and
> worst-controlled part of most HUDs. Every system wants to tell the player
> something. Without explicit rules about notification priority, stacking limits,
> and queue behavior, the notification zone becomes a firehose of overlapping
> toasts that players learn to ignore entirely. This section establishes the
> notification contract for all systems.
```

**行 309-309:**
```
|------------------|---------------|-----------------|--------------|-------------------|-----------------|----------|---------------|-------------|
```

**行 312-312:**
```
| [Level Up] | [ProgressionSystem] | [Center screen — persistent until dismissed] | [Persistent — requires input to dismiss] | [Scale up from 80% + fade in 400ms] | [1] | [High — interrupts normal toasts] | [Pauses all other notifications until dismissed] | [Yes — any input] |
```

**行 314-314:**
```
| [Objective Complete] | [QuestSystem] | [Top Center] | [3000] | [Same as Quest Update but with additional completion sound] | [1] | [Medium-High — preempts Quest Update] | [Preempts any queued top-center message] | [No] |
```

**行 319-322:**
```
**Notification queue rules**:
1. Combat-aware queue: notifications tagged as Low priority are queued, not displayed, when the player is in combat state. The queue is flushed in a batch when the player exits combat, with a max of 3 items displayed in sequence.
2. Merge rule: identical notification types that fire within 500ms of each other are merged into a single notification with a combined value (e.g., "Item Pickup x3" rather than three separate toasts).
3. Critical notifications (health warning, environmental hazard) are never queued, never merged, and always displayed immediately regardless of combat state or existing notifications.
```

**行 326-326:**
```
## 9. Platform Adaptation
```

**行 328-333:**
```
> **Why this section exists**: A HUD designed at 1920x1080 on a monitor may be
> illegible on a 55-inch TV at 4K, broken at 1280x720 on Steam Deck, or hidden
> behind a notch on mobile. Platform adaptation is not optional post-ship work —
> it is a design requirement that must be specified before implementation so the
> architecture can support it from the start. Every platform listed here requires
> explicit layout testing before certification.
```

**行 335-338:**
```
| Platform | Safe Zone | Resolution Range | Input Method | HUD-Specific Notes |
|----------|-----------|-----------------|-------------|-------------------|
| [PC — Windows, 1920x1080 reference] | [3% margin] | [1280x720 min to 3840x2160 max] | [Mouse + keyboard, controller optional] | [HUD must scale correctly at all resolutions. Test at 1280x720 — minimum before cert. Consider ultrawide (21:9) — minimap must not stretch.] |
| [PC — Steam Deck, 1280x800] | [5% margin] | [Fixed 1280x800] | [Controller + touchscreen] | [Smaller screen means minimum text sizes are critical. Test ALL elements at this resolution. Touch targets irrelevant (controller-only by default).] |
```

**行 342-345:**
```
**HUD repositionability requirement**: Players must be able to reposition at minimum the following elements using an in-game HUD layout editor (required for accessibility compliance on console):
- Health bar
- Minimap
- Ability bar (if present)
```

**行 347-347:**
```
Repositioning saves to player profile, not to a single slot. Applies across play sessions.
```

**行 351-351:**
```
## 10. Accessibility — HUD Specific
```

**行 353-358:**
```
> **Why this section exists**: HUD accessibility failures are the most visible
> accessibility failures in games — players encounter the HUD in every session,
> in every gameplay moment. Color-blind failures, illegible text at minimum scale,
> and inability to disable distracting animations are among the top accessibility
> complaints in game reviews. This section defines HUD-specific requirements; refer
> to the project's `docs/accessibility-requirements.md` for the full project standard.
```

**行 360-360:**
```
### 10.1 Colorblind Modes
```

**行 362-368:**
```
| Element | Color-Only Information Risk | Colorblind Mode Fix |
|---------|----------------------------|---------------------|
| [Health bar fill] | [Red = low health uses red/green distinction] | [Add icon pulse + vignette as non-color indicators. Red fill is supplemental, not sole indicator.] |
| [Damage numbers] | [Red = taken, green = healed] | [Add minus (-) prefix for damage, plus (+) for healing. Symbols, not color.] |
| [Enemy health bars] | [If colored by faction or threat level] | [Add text label or icon badge for faction/threat level. Never color-only.] |
| [Status effect icons] | [If icon tint communicates status type] | [All status icons must have distinct shapes, not just distinct colors. Shape encodes meaning; color is secondary.] |
| [Minimap icons] | [If player vs. enemy vs. objective distinguished by color] | [Distinct icon shapes: circle = player, triangle = enemy, star = objective. Color supplements shape.] |
```

**行 370-370:**
```
### 10.2 Text Scaling
```

**行 372-372:**
```
[Describe what happens when the player sets the UI text scale to 150% (the maximum required for your Accessibility Tier). Which elements reflow? Which elements clip? Which elements are architecturally blocked from scaling (e.g., fixed-size canvases)?
```

**行 374-374:**
```
Example: "Health bar numerical label grows with text scale — bar expands slightly to accommodate. Quest objective text wraps at 150% scale — verify Top Center zone can accommodate two-line objectives. Damage numbers do not scale (they are world-space, not screen-space) — this is an accepted limitation documented here."]
```

**行 376-376:**
```
**Text scaling test matrix**:
```

**行 378-383:**
```
| Element | 100% (baseline) | 125% | 150% | Overflow behavior |
|---------|----------------|------|------|-------------------|
| [Health bar label] | [Pass] | [Pass] | [TBD] | [Bar expands; does not overlap stamina bar] |
| [Quest objective text] | [Pass] | [TBD] | [TBD] | [Wraps to second line; zone height expands] |
| [Notification toast text] | [Pass] | [TBD] | [TBD] | [Toast width expands to max 35% screen width, then wraps] |
| [Subtitle text] | [Pass] | [TBD] | [TBD] | [Dedicated subtitle zone — must accommodate scale] |
```

**行 385-385:**
```
### 10.3 Motion Sensitivity
```

**行 388-394:**
```
|---------------------------|----------|-------------------------------------|---------------------|
| [Health bar low-HP pulse] | [Mild] | [Yes] | [Solid fill, no pulse. Vignette remains as it is less likely to trigger sensitivity.] |
| [Screen edge vignette] | [Moderate] | [Optional — separate toggle] | [Replace with static darkened corners at 30% opacity] |
| [Damage numbers float upward] | [Mild] | [Yes] | [Instant appear/disappear in place, no float] |
| [Notification toast slide-in] | [Mild] | [Yes] | [Instant appear at final position] |
| [Level up center animation] | [High] | [Yes — required] | [Static level up card, no scale animation, no particle effects] |
| [Combo counter scale pulse] | [Mild] | [Yes] | [Number increments without scale animation] |
```

**行 396-396:**
```
### 10.4 Subtitles Specification
```

**行 398-400:**
```
> Subtitles are the highest-impact accessibility feature in the HUD. Specify them
> with the same rigor as the rest of the HUD. Do not leave subtitle behavior to
> implementation discretion.
```

**行 402-411:**
```
- **Default setting**: [ON or OFF — document your game's default and the rationale. Industry standard is ON by default.]
- **Position**: Bottom Center zone, centered horizontally, above the bottom safe zone margin
- **Max characters per line**: [42 characters — the readable limit for subtitle lines at minimum text size on TV viewing distance]
- **Max simultaneous lines**: [2 lines before scrolling — do not display more than 2 lines at once]
- **Speaker identification**: [Speaker name displayed in color or above subtitle text — never rely on color alone; add colon prefix: "ARIA: The door is locked."]
- **Background**: [Semi-transparent black panel, 70% opacity, behind all subtitle text — ensures contrast against any game world background]
- **Font size minimum**: [24px at 1080p reference — scales with text scale setting]
- **Line break behavior**: [Break at natural language pause points — before conjunctions, after commas, never mid-word]
- **Subtitle persistence**: [Each subtitle line holds for the duration of the spoken line plus 300ms after it ends — never disappear while audio is still playing]
- **Non-dialogue captions**: [Document whether ambient sounds, music descriptions, and sound effects are captioned — e.g., "[tense music]", "[explosion in the distance]" — and where these appear if different from dialogue subtitles]
```

**行 413-413:**
```
### 10.5 HUD Opacity and Visibility Controls
```

**行 415-415:**
```
The following player-adjustable settings must be available from the Accessibility menu:
```

**行 417-420:**
```
| Setting | Range | Default | Effect |
|---------|-------|---------|--------|
| [HUD Opacity — Global] | [0% (HUD hidden) to 100%] | [100%] | [Scales all HUD element opacities simultaneously] |
| [HUD Text Scale] | [75% to 150%] | [100%] | [Scales all HUD text elements; layout adapts] |
```

**行 429-429:**
```
## 11. Tuning Knobs
```

**行 431-435:**
```
> **Why this section exists**: HUD behavior should be data-driven to the same degree
> as gameplay systems. Values that are hardcoded are values that require an engineer
> to change. Values that are in config can be tuned by a designer or adjusted for
> player preferences. Document all tunable parameters before implementation so the
> programmer knows which values to externalize.
```

**行 437-447:**
```
| Parameter | Current Value | Range | Effect of Increase | Effect of Decrease | Player Adjustable? | Notes |
|-----------|-------------|-------|-------------------|-------------------|-------------------|-------|
| [Notification display duration (default)] | [2000ms] | [500ms – 5000ms] | [Toasts persist longer — less likely to be missed, more screen clutter] | [Toasts disappear faster — cleaner, higher miss risk] | [No — but player can adjust verbosity level] | [Per-type overrides in Section 8 take precedence] |
| [Notification queue max size] | [8] | [3 – 15] | [More messages preserved but queue takes longer to clear] | [Older messages dropped earlier] | [No] | [Expand if playtesting reveals important messages being lost] |
| [Health bar low-HP pulse frequency] | [1 Hz] | [0.5 – 2 Hz] | [More urgent feeling — can become fatiguing] | [Calmer — may fail to communicate urgency] | [No — but Reduced Motion disables it] | [Linked to accessibility setting] |
| [Combat HUD reveal duration] | [0ms (instant)] | [0 – 300ms] | [Softer reveal — feels less jarring] | [Instant — highest responsiveness] | [No] | [Keep at 0ms — combat information must be instant] |
| [Exploration HUD fade-out delay] | [10000ms (10s after last threat)] | [3000 – 30000ms] | [HUD fades sooner — cleaner exploration] | [HUD stays longer — more reassurance] | [No] | [Tune based on playtest; 10s is a starting estimate] |
| [Minimap range (world units visible)] | [80] | [40 – 200] | [More map context visible] | [Tighter local view] | [Yes — Small/Medium/Large preset] | [Exposed as S/M/L, not raw unit value] |
| [Minimap size (px radius at 1080p)] | [75] | [50 – 120] | [Larger map, more screen space consumed] | [Smaller, less intrusive] | [Yes — S/M/L preset] | [Three sizes exposed to player] |
| [Damage number duration (ms)] | [800] | [400 – 1500] | [Numbers linger longer — easier to read, more cluttered] | [Numbers clear faster — cleaner, harder to parse] | [No] | [Tune based on visual noise in dense combat] |
| [Global HUD opacity] | [100%] | [0 – 100%] | [Fully visible] | [Fully hidden] | [Yes — opacity slider in Accessibility settings] | [0% = full HUD off; some players prefer this] |
```

**行 451-451:**
```
## 12. Acceptance Criteria
```

**行 453-455:**
```
> **Why this section exists**: These criteria are the certification checklist for the
> HUD. Every item must pass before the HUD can be marked Approved. QA must be able
> to verify each item independently.
```

**行 457-463:**
```
**Layout & Visibility**
- [ ] All HUD elements are within platform safe zone margins on all target platforms
- [ ] No two HUD elements overlap in any documented gameplay context
- [ ] HUD occupies less than [12]% of screen area in exploration context (measure at reference resolution)
- [ ] HUD occupies less than [22]% of screen area in combat context
- [ ] No HUD element occupies the center [40]% of screen during exploration (crosshair excepted during combat)
- [ ] All HUD elements are visible and legible at minimum supported resolution on all platforms
```

**行 465-469:**
```
**Per-Context Correctness**
- [ ] HUD correctly shows only specified elements in every context defined in Section 5
- [ ] Context transitions (combat enter/exit, dialogue, cinematic) show correct elements within transition timing spec
- [ ] Boss health bar appears correctly on boss encounter trigger and disappears after boss defeat
- [ ] Death state correctly hides all gameplay HUD elements
```

**行 472-478:**
```
- [ ] All HUD text elements meet 4.5:1 contrast ratio against all backgrounds they appear over (test light AND dark scenes)
- [ ] No HUD element uses color as the ONLY differentiator (verify: remove color from each element and confirm information is still communicated)
- [ ] Subtitles appear for all voiced lines and ambient dialogue when subtitle setting is enabled
- [ ] Subtitle text never disappears while audio is still playing
- [ ] Reduced Motion setting disables all HUD animations listed in Section 10.3
- [ ] Text Scale 150% does not cause any HUD text to overflow its container or overlap another element
- [ ] All player-adjustable HUD settings in Section 10.5 are functional and persist between sessions
```

**行 481-485:**
```
- [ ] Notifications of the same type that fire within 500ms merge into a single notification
- [ ] Low-priority notifications are queued (not displayed) during combat and released post-combat
- [ ] Critical warnings (low health, hazard) appear immediately regardless of queue state or combat state
- [ ] No more than [3] notification toasts are visible simultaneously
- [ ] Notification queue is cleared correctly on level transition (no stale notifications from previous area)
```

**行 488-491:**
```
- [ ] All elements respect 10% safe zone margins on console (test on physical TV — not monitor)
- [ ] HUD displays correctly at 1280x720 (Steam Deck) with no element clipping or overlap
- [ ] HUD elements are repositionable (Health, Minimap, Ability Bar) and reposition settings persist
- [ ] Controller disconnection during play does not cause HUD state corruption
```

**行 495-495:**
```
## 13. Open Questions
```

**行 497-498:**
```
> Track unresolved design questions here. All questions must be resolved before
> the HUD design document can be marked Approved.
```

**行 500-505:**
```
| Question | Owner | Deadline | Resolution |
|----------|-------|----------|-----------|
| [e.g., Should the minimap show enemy positions by default, or only after a detection skill is unlocked?] | [systems-designer + ui-designer] | [Sprint 5, Day 2] | [Pending — depends on progression GDD decision] |
| [e.g., Does the game have a boss health bar, or do bosses use the standard enemy health bar? Bosses need a visually distinct treatment if they are significantly more important than normal enemies.] | [game-designer] | [Sprint 5, Day 1] | [Pending] |
| [e.g., Damage numbers: diegetic (floating in world space, occluded by geometry) or screen space (always readable, overlaid on HUD layer)?] | [ui-designer + lead-programmer] | [Sprint 4, Day 5] | [Pending — architecture decision affects rendering layer choice] |
| [e.g., Mobile portrait vs. landscape: does the game support both orientations? If yes, each requires its own zone layout.] | [producer] | [Sprint 3, Day 3] | [Pending — platform scope decision required first] |
```

**未翻译列表项:**
- 行 48: - Default to HIDE: information is available on demand (e.g., Dark Souls — no quest tracker, no minimap, stats are in a menu)
- 行 49: - Default to SHOW: players prefer to be informed; cluttered is better than uncertain
- 行 50: - Default to CONTEXTUAL: information appears when it becomes relevant and fades when it does not
- 行 199: - Visual description: [Horizontal fill bar. Left-to-right fill direction. Segmented at 25/50/75% to aid reading at a glance. Background: dark semi-transparent (40% opacity). Fill color: context-dependent — see Urgency States.]
- 行 201: - Update behavior: [Bar fill decreases or increases smoothly using a lerp over 150ms per change. Large damage (>25% single hit) triggers a brief flash (1 frame white, then drain).]
- 行 202: - Urgency states:
- 行 203: - Normal (>50% HP): [Green fill, no special behavior]
- 行 204: - Caution (25–50% HP): [Yellow fill, low warning pulse every 4 seconds]
- 行 205: - Critical (<25% HP): [Red fill, persistent slow pulse (1 Hz), vignette appears at screen edges]
- 行 206: - Zero (0% HP): [Bar empties and turns grey; death state begins]
- 行 207: - Interaction: [Display only. Not interactive. Player cannot click, hover, or focus this element as an action target.]
- 行 208: - Player customization: [Opacity adjustable (see Section 7 Tuning Knobs). Can be repositioned to any corner by player in accessibility settings.]
- 行 214: - Visual description: [Circular mask, radius = 75px at reference resolution 1920x1080. Player icon at center. North always up unless player has unlocked "Rotate minimap" setting. Range = configurable, default 80 world units radius.]
- 行 215: - Data displayed: [Player position, nearby enemies (if detection perk unlocked), quest markers within range, points of interest icons, traversal obstacles (walls, drops).]
- 行 216: - Update behavior: [Realtime. Updates every frame. Enemy icons fade in/out as they enter/leave detection range over 300ms.]
- 行 217: - Urgency states: [None for the map itself. Enemy icons turn red when they are in combat-alert state.]
- 行 218: - Interaction: [Not interactive in-game. Press dedicated Map button to open the full map screen (separate UX spec).]
- 行 219: - Player customization: [Size: S/M/L (70/90/110px radius). Opacity: 30–100%. Rotation: locked-north or player-relative. Can be disabled entirely (compass strip shows as fallback).]
- 行 320: 1. Combat-aware queue: notifications tagged as Low priority are queued, not displayed, when the player is in combat state. The queue is flushed in a batch when the player exits combat, with a max of 3 items displayed in sequence.
- 行 345: - Ability bar (if present)
- 行 402: - **Default setting**: [ON or OFF — document your game's default and the rationale. Industry standard is ON by default.]
- 行 403: - **Position**: Bottom Center zone, centered horizontally, above the bottom safe zone margin
- 行 404: - **Max characters per line**: [42 characters — the readable limit for subtitle lines at minimum text size on TV viewing distance]
- 行 405: - **Max simultaneous lines**: [2 lines before scrolling — do not display more than 2 lines at once]
- 行 406: - **Speaker identification**: [Speaker name displayed in color or above subtitle text — never rely on color alone; add colon prefix: "ARIA: The door is locked."]
- 行 407: - **Background**: [Semi-transparent black panel, 70% opacity, behind all subtitle text — ensures contrast against any game world background]
- 行 408: - **Font size minimum**: [24px at 1080p reference — scales with text scale setting]
- 行 409: - **Line break behavior**: [Break at natural language pause points — before conjunctions, after commas, never mid-word]
- 行 410: - **Subtitle persistence**: [Each subtitle line holds for the duration of the spoken line plus 300ms after it ends — never disappear while audio is still playing]
- 行 411: - **Non-dialogue captions**: [Document whether ambient sounds, music descriptions, and sound effects are captioned — e.g., "[tense music]", "[explosion in the distance]" — and where these appear if different from dialogue subtitles]
- 行 458: - [ ] All HUD elements are within platform safe zone margins on all target platforms
- 行 459: - [ ] No two HUD elements overlap in any documented gameplay context
- 行 460: - [ ] HUD occupies less than [12]% of screen area in exploration context (measure at reference resolution)
- 行 461: - [ ] HUD occupies less than [22]% of screen area in combat context
- 行 462: - [ ] No HUD element occupies the center [40]% of screen during exploration (crosshair excepted during combat)
- 行 463: - [ ] All HUD elements are visible and legible at minimum supported resolution on all platforms
- 行 466: - [ ] HUD correctly shows only specified elements in every context defined in Section 5
- 行 467: - [ ] Context transitions (combat enter/exit, dialogue, cinematic) show correct elements within transition timing spec
- 行 468: - [ ] Boss health bar appears correctly on boss encounter trigger and disappears after boss defeat
- 行 469: - [ ] Death state correctly hides all gameplay HUD elements
- 行 472: - [ ] All HUD text elements meet 4.5:1 contrast ratio against all backgrounds they appear over (test light AND dark scenes)
- 行 473: - [ ] No HUD element uses color as the ONLY differentiator (verify: remove color from each element and confirm information is still communicated)
- 行 474: - [ ] Subtitles appear for all voiced lines and ambient dialogue when subtitle setting is enabled
- 行 475: - [ ] Subtitle text never disappears while audio is still playing
- 行 476: - [ ] Reduced Motion setting disables all HUD animations listed in Section 10.3
- 行 477: - [ ] Text Scale 150% does not cause any HUD text to overflow its container or overlap another element
- 行 478: - [ ] All player-adjustable HUD settings in Section 10.5 are functional and persist between sessions
- 行 481: - [ ] Notifications of the same type that fire within 500ms merge into a single notification
- 行 482: - [ ] Low-priority notifications are queued (not displayed) during combat and released post-combat
- 行 483: - [ ] Critical warnings (low health, hazard) appear immediately regardless of queue state or combat state
- 行 484: - [ ] No more than [3] notification toasts are visible simultaneously
- 行 485: - [ ] Notification queue is cleared correctly on level transition (no stale notifications from previous area)
- 行 488: - [ ] All elements respect 10% safe zone margins on console (test on physical TV — not monitor)
- 行 489: - [ ] HUD displays correctly at 1280x720 (Steam Deck) with no element clipping or overlap
- 行 490: - [ ] HUD elements are repositionable (Health, Minimap, Ability Bar) and reposition settings persist
- 行 491: - [ ] Controller disconnection during play does not cause HUD state corruption

--------------------------------------------------------------------------------

### .codebuddy\docs\templates\ux-spec.md
- 未翻译段落数: 96
- 未翻译列表项数: 52

**未翻译段落:**

**行 3-11:**
```
> **Status**: Draft | In Review | Approved | Implemented
> **Author**: [Name or agent — e.g., ui-designer]
> **Last Updated**: [Date]
> **Screen / Flow Name**: [Short identifier used in code and tickets — e.g., `InventoryScreen`, `NewGameFlow`]
> **Platform Target**: [PC | Console | Mobile | All — list all that this spec covers]
> **Related GDDs**: [Links to the GDD sections that generated this UI requirement — e.g., `design/gdd/inventory.md § UI Requirements`]
> **Related ADRs**: [Any architectural decisions that constrain this screen — e.g., `ADR-0012: UI Framework Selection`]
> **Related UX Specs**: [Sibling and parent screens — e.g., `ux-spec-pause-menu.md`, `ux-spec-settings.md`]
> **Accessibility Tier**: Basic | Standard | Comprehensive | Exemplary
```

**行 13-17:**
```
> **Note — Scope boundary**: This template covers discrete screens and flows (menus,
> dialogs, inventory, settings, cutscene UI, etc.). For persistent in-game overlays
> that exist during active gameplay, use `hud-design.md` instead. If a screen is a
> hybrid (e.g., a pause menu that overlays the game world), treat it as a screen spec
> and note the overlay relationship in Navigation Position.
```

**行 21-21:**
```
## 1. Purpose & Player Need
```

**行 23-29:**
```
> **Why this section exists**: Every screen must justify its existence from the
> player's perspective. Screens that are designed from a developer perspective ("display
> the save data") produce cluttered, confusing interfaces. Screens designed from the
> player's perspective ("let the player feel confident their progress is safe before they
> put the controller down") produce purposeful, calm interfaces. Write this section before
> touching any layout decisions — it is the filter through which every subsequent choice
```

**行 31-31:**
```
**What player need does this screen serve?**
```

**行 33-35:**
```
[One paragraph. Name the real human need, not the system function. Consider: what would
a player say they want when they open this screen? What would frustrate them if it did
not work? That frustration describes the need.
```

**行 37-40:**
```
Example — bad: "Displays the player's current items and equipment."
Example — good: "Lets the player understand what they're carrying and quickly decide what
to take into the next encounter, without breaking their mental model of the game world.
The inventory is the player's planning tool between moments of action."]
```

**行 42-42:**
```
**The player goal** (what the player wants to accomplish):
```

**行 44-46:**
```
[One sentence. Specific enough that you could write an acceptance criterion for it.
Example: "Find the item they are looking for within three button presses and equip it
without navigating to a separate screen."]
```

**行 48-48:**
```
**The game goal** (what the game needs to communicate or capture):
```

**行 50-53:**
```
[One sentence. This is what the system needs from this interaction. Example: "Record the
player's equipment choices and relay them to the combat system before the next encounter
loads." This section prevents UI that looks good but fails to serve the system it is
```

**行 57-57:**
```
## 2. Player Context on Arrival
```

**行 59-65:**
```
> **Why this section exists**: Screens do not exist in isolation. A player opening the
> inventory mid-combat is in a completely different cognitive and emotional state than
> a player opening it after clearing a dungeon. The same information architecture can
> feel oppressively complex in one context and trivially simple in another. Document the
> context so that design decisions — what to show first, what to hide, what to animate,
> what to simplify — are calibrated to the actual player arriving at this screen, not
```

**行 67-68:**
```
| Question | Answer |
|----------|--------|
```

**行 72-74:**
```
| What information do they already have? | [e.g., They know they just picked up an item but haven't seen its stats yet] |
| What are they most likely trying to do? | [e.g., Check if the new item is better than their current weapon — primary use case] |
| What are they likely afraid of? | [e.g., Missing something, making an irreversible mistake, losing track of where they were] |
```

**行 76-76:**
```
**Emotional design target for this screen**:
```

**行 78-80:**
```
[One sentence describing the feeling the player should have while using this screen.
Example: "Confident and in control — the player should feel like they have complete
information and complete authority over their choices, with no ambiguity about outcomes."]
```

**行 84-84:**
```
## 3. Navigation Position
```

**行 86-91:**
```
> **Why this section exists**: A screen that does not know where it sits in the
> navigation hierarchy cannot define its entry/exit transitions, its back-button
> behavior, or its relationship to the game's pause state. Navigation position also
> reveals architectural problems early — if this screen is reachable from eight
> different places, that is a complexity flag that should be resolved in design, not
```

**行 93-93:**
```
**Screen hierarchy** (use indentation to show parent-child relationships):
```

**行 103-103:**
```
**Modal behavior**: [Modal (blocks everything behind it, requires explicit dismiss) | Non-modal (game continues behind it) | Overlay (renders over game world, game paused) | Overlay-live (renders over game world, game continues)]
```

**行 105-107:**
```
> If this screen is modal: document the dismiss behavior. Can it be dismissed by pressing
> Back/B? By pressing Escape? By clicking outside it? Can it be dismissed at all, or
> must the player complete it? Undismissable modals are high-friction — justify them.
```

**行 109-109:**
```
**Reachability — all entry points**:
```

**行 111-115:**
```
| Entry Point | Triggered By | Notes |
|-------------|-------------|-------|
| [e.g., Main Menu → Play] | [Player selects "New Game"] | [Primary entry point] |
| [e.g., Pause Menu → Resume] | [Player presses Start from any gameplay state] | [Secondary entry] |
| [e.g., Game event] | [Tutorial system forces open first time only] | [Systemic entry — must not break if player dismisses] |
```

**行 119-119:**
```
## 4. Entry & Exit Points
```

**行 121-125:**
```
> **Why this section exists**: Entry and exit define the screen's contract with the
> rest of the navigation system. Every entry point must have a corresponding exit point.
> Transitions that are undefined become bugs — the player finds themselves stuck, or the
> game state becomes inconsistent. Fill this table completely before implementation
> begins. Empty cells are a sign that design work is unfinished.
```

**行 130-130:**
```
|---------|----------------------|-----------------|----------------|-------|
```

**行 138-141:**
```
|-------------|------------|-----------------|----------------------|-------|
| [e.g., Player closes inventory (Back/B/Esc)] | [Previous state — Exploration] | [Overlay pop — game resumes] | [Updated equipment loadout committed] | [Changes must be committed before transition begins] |
| [e.g., Player selects "Equip" on item] | [Same screen, updated state] | [In-place state change] | [Loadout change event fired] | [No navigation, just a state refresh] |
| [e.g., Player navigates to Map from inventory shortcut] | [Map Screen] | [Replace] | [No data] | [Inventory state is preserved if player returns] |
```

**行 145-145:**
```
## 5. Layout Specification
```

**行 147-156:**
```
> **Why this section exists**: The layout specification is the handoff artifact between
> UX design and UI programming. It does not need to be pixel-perfect — it needs to
> communicate hierarchy (what is important), proximity (what belongs together), and
> proportion (what is big vs. small). ASCII wireframes achieve this without requiring
> design software. A programmer who reads this section should be able to build the
> correct structure without guessing. An artist who reads it should know where
> visual weight should be concentrated.
> Draw the layout at one standard resolution (e.g., 1920x1080). Note adaptations
> for other resolutions separately.
```

**行 158-158:**
```
### 5.1 Wireframe
```

**行 191-191:**
```
### 5.2 Zone Definitions
```

**行 193-199:**
```
| Zone Name | Description | Approximate Size | Scrollable? | Overflow Behavior |
|-----------|-------------|-----------------|-------------|-------------------|
| [e.g., Header Zone] | [Top bar: navigation, screen title, global actions] | [Full width, ~10% height] | [No] | [Truncate long screen names with ellipsis] |
| [e.g., Category Nav] | [Left panel: item category tabs] | [~25% width, ~75% height] | [Yes — vertical if categories exceed panel] | [Scroll indicator appears at bottom of list] |
| [e.g., Item Grid] | [Center: grid of item icons for selected category] | [~45% width, ~75% height] | [Yes — vertical] | [Page-based: 4x4 grid, next page on overflow] |
| [e.g., Detail Panel] | [Right: stats and description for selected item] | [~30% width, ~75% height] | [Yes — vertical for long descriptions] | [Fade at bottom, scroll to reveal] |
| [e.g., Action Bar] | [Bottom: context-sensitive actions for selected item] | [Full width, ~15% height] | [No] | [Actions collapse to icon-only below 4] |
```

**行 201-201:**
```
### 5.3 Component Inventory
```

**行 203-204:**
```
> List every discrete UI component on this screen. This table drives the implementation
> task list — each row becomes a component to build or reuse.
```

**行 206-215:**
```
| Component Name | Type | Zone | Purpose | Required? | Reuses Existing Component? |
|----------------|------|------|---------|-----------|---------------------------|
| [e.g., Back Button] | [Button] | [Header] | [Returns to previous screen] | [Yes] | [Yes — standard NavButton component] |
| [e.g., Screen Title Label] | [Text] | [Header] | [Displays "INVENTORY" or context name] | [Yes] | [Yes — ScreenTitle component] |
| [e.g., Category Tab] | [Toggle Button] | [Category Nav] | [Filters item grid by category] | [Yes] | [No — new component needed] |
| [e.g., Item Slot] | [Icon + Frame] | [Item Grid] | [Represents one inventory slot, empty or filled] | [Yes] | [No — new component] |
| [e.g., Item Name Label] | [Text] | [Detail Panel] | [Shows selected item's name] | [Yes] | [Yes — BodyText component] |
| [e.g., Stat Comparison Row] | [Compound — label + value + delta] | [Detail Panel] | [Shows stat value vs. currently equipped] | [Yes] | [No — new component] |
| [e.g., Equip Button] | [Primary Button] | [Action Bar] | [Equips selected item in appropriate slot] | [Yes] | [Yes — PrimaryAction component] |
| [e.g., Empty State Message] | [Text + Icon] | [Item Grid] | [Shown when category has no items] | [Yes] | [Yes — EmptyState component] |
```

**行 217-217:**
```
**Primary focus element on open**: [e.g., The first item in the Item Grid — or, if deep-linked, the highlighted item. If the grid is empty, focus lands on the first Category Tab.]
```

**行 221-221:**
```
## 6. States & Variants
```

**行 223-227:**
```
> **Why this section exists**: A screen is not a single picture — it is a set of
> states, each of which must look correct and behave correctly. Screens that are
> designed only in their "happy path" state ship with broken empty states, invisible
> loading indicators, and crashes when data is missing. Document every state before
> implementation. The states table is also the test matrix for QA.
```

**行 229-237:**
```
| State Name | Trigger | What Changes Visually | What Changes Behaviorally | Notes |
|------------|---------|----------------------|--------------------------|-------|
| [Loading] | [Screen is opening, data not yet available] | [Item Grid shows skeleton/shimmer placeholders; Action Bar buttons disabled] | [No interactions possible except Close] | [Should not be visible >500ms under normal conditions; if it is, investigate data fetch performance] |
| [Empty — no items in category] | [Player switches to a category with zero items] | [Item Grid replaced by EmptyState component: icon + "Nothing here yet."] | [Action Bar shows no item actions; Drop/Equip/Compare all hidden] | [Do not show disabled buttons — remove them. Disabled buttons with no tooltip are confusing.] |
| [Populated — items present] | [Category has at least one item] | [Item Grid fills with item slots; first slot is auto-focused] | [All item actions available for selected item] | [Default and most common state] |
| [Item Selected] | [Player navigates to an item slot] | [Detail Panel populates; selected slot has focus ring; Action Bar updates to item's valid actions] | [Equip/Drop/Compare enabled based on item type] | [Equip is disabled if item is already equipped — show a "Equipped" badge instead] |
| [Confirmation Pending — Drop] | [Player selects Drop action] | [Confirmation dialog overlays the screen] | [All background interactions suspended until dialog resolves] | [Use a modal confirmation, not an inline toggle. Items cannot be recovered after dropping.] |
| [Error — data load failed] | [Inventory data could not be retrieved] | [Item Grid shows error state: icon + "Couldn't load items." + Retry button] | [Only Retry and Close are available] | [Log the error; do not expose technical details to player] |
| [Item Newly Acquired] | [Screen opened from item pickup deep-link] | [Newly acquired item has a visual "New" badge; Detail Panel pre-populated with that item] | [Same as Item Selected but with badge until player navigates away] | [Badge persists until the player manually navigates off that slot once] |
```

**行 241-241:**
```
## 7. Interaction Map
```

**行 243-248:**
```
> **Why this section exists**: This section is the source of truth for what every
> input does on this screen. It forces the designer to think through every input
> method (mouse, keyboard, gamepad, touch) and every interactive state (hover, focus,
> pressed, disabled). Gaps in this table are bugs waiting to happen. The
> interaction map is also the input for the accessibility audit — if an action is
> only reachable by mouse, it will fail the keyboard and gamepad columns.
```

**行 250-250:**
```
### 7.1 Navigation Inputs
```

**行 252-253:**
```
| Input | Platform | Action | Visual Response | Audio Cue | Notes |
|-------|----------|--------|-----------------|-----------|-------|
```

**行 257-258:**
```
| [Mouse click] | [PC] | [Select and focus the clicked element] | [Pressed state flash, then selected/focused] | [Soft click] | [Right-click opens context menu if applicable; otherwise no-op] |
| [Touch tap] | [Mobile] | [Select and activate in one gesture] | [Press ripple] | [Soft click] | [Treat tap as click + confirm for low-risk actions; require explicit confirm for destructive actions] |
```

**行 260-260:**
```
### 7.2 Action Inputs
```

**行 262-263:**
```
| Input | Platform | Context (What must be focused) | Action | Response | Animation | Audio Cue | Notes |
|-------|----------|-------------------------------|--------|----------|-----------|-----------|-------|
```

**行 271-271:**
```
### 7.3 State-Specific Behaviors
```

**行 273-277:**
```
| State | Input Restriction | Reason |
|-------|------------------|--------|
| [Loading] | [All item and action inputs disabled] | [No data to act on; prevent race conditions] |
| [Confirmation dialog open] | [Only Confirm and Cancel inputs active] | [Modal — background is locked] |
| [Error state] | [Only Retry and Close active] | [No data available to navigate] |
```

**行 281-281:**
```
## 8. Data Requirements
```

**行 283-289:**
```
> **Why this section exists**: The separation between UI and game state is the most
> important architectural boundary in a game's UI system. UI reads data; it does not
> own it. UI fires events; it does not write state directly. This section defines
> exactly what data this screen needs to display, where it comes from, and how
> frequently it updates. Filling this table before implementation prevents two
> common failure modes: (1) UI developers reaching into systems they should not touch,
> and (2) systems not knowing they need to expose data until a UI is half-built.
```

**行 292-297:**
```
|--------------|--------------|-----------------|-------------|--------|------------------------|
| [e.g., Item list] | [Inventory System] | [On screen open; on InventoryChanged event] | [InventorySystem] | [Array of ItemData structs: id, name, icon_path, category, stats, is_equipped] | [Empty array → show Empty State. Never null — system must return array.] |
| [e.g., Equipped loadout] | [Equipment System] | [On screen open; on EquipmentChanged event] | [EquipmentSystem] | [Dict mapping slot_id → item_id] | [Unequipped slot has null value — UI shows empty slot icon] |
| [e.g., Item stat comparisons] | [Stats System] | [On item selection change] | [StatsSystem] | [Dict mapping stat_name → {current, new, delta}] | [If no item selected, detail panel shows placeholder. Stats system must handle this gracefully.] |
| [e.g., Player currency] | [Economy System] | [On screen open only — inventory does not show live currency] | [EconomySystem] | [Int — gold pieces] | [If currency system not active for this game mode, hide the currency row entirely] |
| [e.g., Newly acquired item flag] | [Inventory System] | [On screen open] | [InventorySystem] | [Array of item_ids flagged as new] | [If empty array, no badges shown] |
```

**行 299-301:**
```
> **Rule**: This screen must never write directly to any system listed above. All
> player actions fire events (see Section 9). Systems update their own data and
```

**行 305-305:**
```
## 9. Events Fired
```

**行 307-312:**
```
> **Why this section exists**: This is the other half of the UI/system boundary.
> Where Section 8 defines what the UI reads, this section defines what the UI
> communicates back to the game. Specifying events at design time prevents UI
> programmers from writing game logic, and prevents game programmers from being
> surprised by what the UI does. Every destructive or state-changing player action
> must appear in this table.
```

**行 314-320:**
```
| Player Action | Event Fired | Payload | Receiver System | Notes |
|---------------|-------------|---------|-----------------|-------|
| [Player equips an item] | [EquipItemRequested] | [{item_id: string, target_slot: string}] | [Equipment System] | [Equipment System validates the action and fires EquipmentChanged if successful; UI listens for EquipmentChanged to update its display] |
| [Player drops an item] | [DropItemRequested] | [{item_id: string, quantity: int}] | [Inventory System] | [Fires only after player confirms the drop dialog. Inventory System removes the item and fires InventoryChanged.] |
| [Player opens item compare] | [ItemCompareOpened] | [{item_a_id: string, item_b_id: string}] | [Analytics System] | [No game-state change — analytics event only. Compare view is purely local UI state.] |
| [Player closes screen] | [InventoryScreenClosed] | [{session_duration_ms: int}] | [Analytics System] | [Fires on every close regardless of reason. Used for engagement metrics.] |
| [Player navigates between categories] | [InventoryCategoryChanged] | [{category: string}] | [Analytics System] | [Analytics only. No game state change.] |
```

**行 324-324:**
```
## 10. Transition & Animation
```

**行 326-332:**
```
> **Why this section exists**: Transitions are not decoration — they communicate
> hierarchy and causality. A screen that slides in from the right implies the
> player has moved forward. A screen that fades implies a context break. Inconsistent
> transitions make navigation feel broken even when it is technically correct.
> This section ensures transitions are specified intentionally, not left to the
> developer's discretion, and that accessibility settings (reduced motion) are
> planned for from the start.
```

**行 335-340:**
```
|------------|---------|-----------------|--------------|--------|----------------|---------------------------|
| [Screen enter] | [Screen pushed onto stack] | [Slide in from right] | [250] | [Ease out cubic] | [No — must complete before interaction is enabled] | [Yes — instant appear at 0ms] |
| [Screen exit — Back] | [Player presses Back] | [Slide out to right] | [200] | [Ease in cubic] | [No] | [Yes — instant disappear] |
| [Screen exit — Forward] | [Player navigates to child screen] | [Slide out to left] | [200] | [Ease in cubic] | [No] | [Yes — instant] |
| [Detail panel update] | [Player selects a new item] | [Cross-fade content] | [120] | [Linear] | [Yes — if player navigates quickly, previous animation cancels] | [Yes — instant swap] |
| [Loading → Populated] | [Data arrives after load] | [Skeleton shimmer fades out, content fades in] | [180] | [Ease out] | [No] | [Yes — instant reveal] |
```

**行 342-343:**
```
| [Confirmation dialog open] | [Player initiates destructive action] | [Background dims 60% opacity; dialog scales up from 95%] | [150] | [Ease out] | [No] | [Yes — instant appear, no scale] |
| [New item badge appear] | [Screen opens with newly acquired item] | [Badge pops from 0% to 110% to 100% scale] | [200 total] | [Ease out back] | [No] | [Yes — instant appear at 100% scale] |
```

**行 347-347:**
```
## 11. Input Method Completeness Checklist
```

**行 349-352:**
```
> **Why this section exists**: Input completeness is not optional — it is a
> certification requirement for console platforms and a legal risk area for
> accessibility laws in multiple markets. Fill this checklist before marking
> the spec as Approved. Any unchecked item blocks implementation start.
```

**行 355-360:**
```
- [ ] All interactive elements are reachable using Tab and arrow keys alone
- [ ] Tab order follows visual reading order (left-to-right, top-to-bottom within each zone)
- [ ] Every action achievable by mouse is also achievable by keyboard
- [ ] Focus is visible at all times (no element where focus ring disappears)
- [ ] Focus does not escape the screen while it is open (focus trap for modals)
- [ ] Esc key closes or cancels (and does not quit the game from within a screen)
```

**行 363-367:**
```
- [ ] All interactive elements reachable with D-Pad and left stick
- [ ] Face button mapping documented and consistent with platform conventions (see Section 7.2)
- [ ] No action requires analog stick precision that cannot be replicated with D-Pad
- [ ] Trigger and bumper shortcuts documented if used
- [ ] Controller disconnection while screen is open is handled gracefully
```

**行 370-373:**
```
- [ ] Hover states defined for all interactive elements
- [ ] Clickable hit targets are at minimum 32x32px (44x44px preferred)
- [ ] Right-click behavior defined (context menu or no-op — not undefined)
- [ ] Scroll wheel behavior defined in all scrollable zones
```

**行 375-379:**
```
**Touch (if applicable)**
- [ ] All touch targets are minimum 44x44px
- [ ] Swipe gestures do not conflict with system-level swipe navigation
- [ ] All actions achievable with one hand in portrait orientation
- [ ] Long-press behavior defined if used
```

**行 383-383:**
```
## 12. Screen-Level Accessibility Requirements
```

**行 385-395:**
```
> **Why this section exists**: Accessibility requirements must be specified at design
> time because retrofitting them is expensive and often architecturally impractical.
> This section documents requirements specific to this screen. Project-wide standards
> live in `docs/accessibility-requirements.md` — consult it before filling this
> section so you do not duplicate or contradict project-level commitments.
> Accessibility Tiers in this project:
> - Basic: WCAG 2.1 AA text contrast, keyboard navigable, no motion-only information
> - Standard: Basic + screen reader support, colorblind-safe, focus management
> - Comprehensive: Standard + reduced motion support, text scaling, high contrast mode
> - Exemplary: Comprehensive + cognitive load management, AAA equivalent, certified
```

**行 397-397:**
```
**Text contrast requirements for this screen**:
```

**行 399-405:**
```
| Text Element | Background Context | Required Ratio | Current Ratio | Pass? |
|--------------|-------------------|---------------|---------------|-------|
| [e.g., Item name in Detail Panel] | [Dark panel background ~#1a1a1a] | [4.5:1 (WCAG AA normal text)] | [TBD — verify in implementation] | [ ] |
| [e.g., Category tab label — inactive] | [Mid-grey tab background] | [4.5:1] | [TBD] | [ ] |
| [e.g., Category tab label — active] | [Accent color background] | [4.5:1] | [TBD] | [ ] |
| [e.g., Action button label] | [Button color (varies by state)] | [4.5:1] | [TBD] | [ ] |
| [e.g., Stat comparison delta (positive)] | [Detail panel] | [4.5:1 — do NOT rely on green color alone] | [TBD] | [ ] |
```

**行 407-407:**
```
**Colorblind-unsafe elements and mitigations**:
```

**行 409-410:**
```
| Element | Colorblind Risk | Mitigation |
|---------|----------------|------------|
```

**行 412-412:**
```
| [e.g., Item rarity color coding (grey/green/blue/purple/orange)] | [Multiple types — rarity color is a common industry failure] | [Add rarity name text label below icon. Color is supplemental only.] |
```

**行 414-414:**
```
**Focus order** (Tab key sequence, numbered):
```

**行 417-430:**
```
1. Back button (Header)
2. Options button (Header)
3. Category Tab 1 — Weapons
4. Category Tab 2 — Armor
5. Category Tab 3 — Consumables
6. Category Tab 4 — Key Items
8. Item Slot [0,1] ... (grid traverses left-to-right, top-to-bottom)
10. Equip button (Action Bar)
11. Drop button (Action Bar)
12. Compare button (Action Bar)
13. Close button (Action Bar)
→ Cycles back to Back button
```

**行 432-432:**
```
Focus does not enter the Detail Panel — it is a display panel driven by item focus, not independently navigable.]
```

**行 434-434:**
```
**Screen reader announcements for key state changes**:
```

**行 436-438:**
```
| State Change | Announcement Text | Announcement Timing |
|--------------|------------------|---------------------|
| [Screen opens] | ["Inventory screen. [N] items. [Active category] selected."] | [On screen focus settle] |
```

**行 440-443:**
```
| [Player equips an item] | ["[Item name] equipped to [slot name]."] | [After EquipmentChanged event confirmed] |
| [Player drops an item] | ["[Item name] dropped."] | [After InventoryChanged event confirmed] |
| [Category changes] | ["[Category name]. [N] items."] | [On category tab focus] |
| [Empty state shown] | ["No items in [category name]."] | [When empty state renders] |
```

**行 445-445:**
```
**Cognitive load assessment**:
```

**行 447-453:**
```
[Estimate the number of information streams the player is simultaneously tracking while
using this screen. For this screen: (1) item grid position, (2) item detail stats,
(3) current equipment loadout for comparison, (4) available actions, (5) item category.
That is 5 concurrent streams — within the standard 7±2 limit, but at the higher end.
Mitigation: detail panel auto-updates on navigation so the player never needs to
manually retrieve item info. Reduce active decisions by surfacing stat comparison
```

**行 457-457:**
```
## 13. Localization Considerations
```

**行 459-464:**
```
> **Why this section exists**: UI built without localization in mind breaks on first
> translation. German text is typically 30–40% longer than English. Arabic and Hebrew
> require right-to-left layout mirroring. Japanese and Chinese text may be significantly
> shorter than English, creating awkward whitespace. These issues are cheap to plan for
> and expensive to fix after a layout is built and shipped. Every text element should
> have an explicit max-character count and a plan for overflow.
```

**行 466-470:**
```
**General rules for this screen**:
- All text elements must tolerate a minimum of 40% expansion from English baseline
- RTL layout (Arabic, Hebrew): mirrored layout required — document which elements mirror and which do not
- CJK languages (Japanese, Korean, Chinese): text may be 20-30% shorter — verify layouts do not look broken with less text
- Do not use text in images — all text must be from localization strings
```

**行 472-478:**
```
| Text Element | English Baseline Length | Max Characters | Expansion Budget | RTL Behavior | Overflow Behavior | Risk |
|--------------|------------------------|----------------|-----------------|--------------|-------------------|------|
| [e.g., Screen title "INVENTORY"] | [9 chars] | [16 chars] | [78%] | [Mirror to right, or center — acceptable] | [Truncate with ellipsis — title is not critical content] | [Low] |
| [e.g., Item name] | [~15 chars avg, max ~35 "Enchanted Dragon Scale Gauntlets"] | [50 chars] | [43%] | [Right-align in RTL layouts] | [Truncate with tooltip showing full name on hover/focus] | [Medium — long fantasy item names are common] |
| [e.g., Item description] | [~80–120 chars] | [200 chars] | [67%] | [Right-align, wrap normally] | [Scroll within Detail Panel — no truncation] | [Low — panel is scrollable] |
| [e.g., Action button "Equip"] | [5 chars] | [14 chars] | [180%] | [Button layout mirrors; text right-aligns] | [Shrink font to 90% minimum, then truncate] | [Medium — "Ausrüsten" in German is 9 chars] |
| [e.g., Category tab "Consumables"] | [11 chars] | [18 chars] | [64%] | [Mirror tab position] | [Abbreviate: "Consum." — define abbreviations per language in loc file] | [High — long localized tab labels are a known problem] |
```

**行 482-482:**
```
## 14. Acceptance Criteria
```

**行 484-489:**
```
> **Why this section exists**: Acceptance criteria are the contractual definition of
> "done." Without them, implementation is complete when the developer says it is.
> With them, implementation is complete when a QA tester can verify every item on
> this list. Write criteria that a tester can verify independently, without asking the
> designer what they meant. Every criterion should be binary — pass or fail, not
```

**行 492-494:**
```
- [ ] Screen opens (first frame visible) within 200ms of trigger on minimum-spec hardware
- [ ] Screen is fully interactive (all data loaded) within 500ms of trigger on minimum-spec hardware
- [ ] Navigation between items produces no perceptible frame drop (maintain target framerate ±5fps)
```

**行 496-503:**
```
**Layout & Rendering**
- [ ] Screen displays correctly (no overlap, no cutoff, no overflow) at minimum supported resolution [specify]
- [ ] Screen displays correctly at maximum supported resolution [specify]
- [ ] Screen displays correctly at 4:3, 16:9, 16:10, and 21:9 aspect ratios if targeting PC
- [ ] No text overflow or truncation in English within defined max-character bounds
- [ ] No text overflow or truncation in the longest-translation language [specify — typically German]
- [ ] All states (Loading, Empty, Populated, Error, Confirmation) render correctly
- [ ] Item grid scrolls smoothly without frame drops when all item slots are populated
```

**行 506-511:**
```
- [ ] All interactive elements reachable by keyboard using Tab and arrow keys only
- [ ] All interactive elements reachable by gamepad using D-Pad and face buttons only
- [ ] All interactive elements reachable by mouse without keyboard
- [ ] No action requires simultaneous input that is not documented in Section 7
- [ ] Focus is visible at all times on keyboard and gamepad navigation
- [ ] Focus does not escape the screen while it is open
```

**行 514-517:**
```
- [ ] All events in Section 9 fire with correct payloads on all exit paths (verify with debug logging)
- [ ] Screen does not write directly to any game system (verify: no direct state mutation calls)
- [ ] Inventory changes persist correctly after screen is closed and reopened
- [ ] Screen handles InventoryChanged events fired by other systems while it is open without crashing
```

**行 520-524:**
```
- [ ] All text passes minimum contrast ratios specified in Section 12
- [ ] Stat comparison does not rely on color alone as the sole differentiator
- [ ] Screen reader announces item name and key stats on focus (verify with platform screen reader)
- [ ] Reduced motion setting results in instant transitions (no animated transitions)
- [ ] High contrast mode (if applicable to Accessibility Tier) renders without visual breakage
```

**行 527-529:**
```
- [ ] No text element overflows its container in any supported language
- [ ] RTL layout renders correctly (if RTL is a target language)
- [ ] All text elements are driven by localization strings — no hardcoded display text
```

**行 533-533:**
```
## 15. Open Questions
```

**行 535-537:**
```
> Track unresolved design questions here. Each question should have a clear owner
> and a deadline. An Approved spec must have zero open questions — move to a decision
> or explicitly document the deferral rationale.
```

**行 539-544:**
```
| Question | Owner | Deadline | Resolution |
|----------|-------|----------|-----------|
| [e.g., Should item comparison be automatic (always showing equipped stats) or player-triggered (press Compare)?] | [ui-designer] | [Sprint 4, Day 3] | [Pending] |
| [e.g., Do we support controller cursor (free aim) in the item grid, or d-pad-only grid navigation?] | [lead-programmer + ui-designer] | [Sprint 4, Day 3] | [Pending — depends on ADR-0015 input model decision] |
| [e.g., What is the game's item drop policy — permanent loss or drop-to-world?] | [systems-designer] | [Requires GDD update] | [Blocked on inventory GDD Edge Cases section] |
| [e.g., Maximum inventory size — does the grid have a hard cap or is it infinite-scroll?] | [economy-designer] | [Sprint 3, Day 5] | [Pending] |
```

**未翻译列表项:**
- 行 355: - [ ] All interactive elements are reachable using Tab and arrow keys alone
- 行 356: - [ ] Tab order follows visual reading order (left-to-right, top-to-bottom within each zone)
- 行 357: - [ ] Every action achievable by mouse is also achievable by keyboard
- 行 358: - [ ] Focus is visible at all times (no element where focus ring disappears)
- 行 359: - [ ] Focus does not escape the screen while it is open (focus trap for modals)
- 行 360: - [ ] Esc key closes or cancels (and does not quit the game from within a screen)
- 行 363: - [ ] All interactive elements reachable with D-Pad and left stick
- 行 364: - [ ] Face button mapping documented and consistent with platform conventions (see Section 7.2)
- 行 365: - [ ] No action requires analog stick precision that cannot be replicated with D-Pad
- 行 366: - [ ] Trigger and bumper shortcuts documented if used
- 行 367: - [ ] Controller disconnection while screen is open is handled gracefully
- 行 370: - [ ] Hover states defined for all interactive elements
- 行 371: - [ ] Clickable hit targets are at minimum 32x32px (44x44px preferred)
- 行 372: - [ ] Right-click behavior defined (context menu or no-op — not undefined)
- 行 373: - [ ] Scroll wheel behavior defined in all scrollable zones
- 行 376: - [ ] All touch targets are minimum 44x44px
- 行 377: - [ ] Swipe gestures do not conflict with system-level swipe navigation
- 行 378: - [ ] All actions achievable with one hand in portrait orientation
- 行 379: - [ ] Long-press behavior defined if used
- 行 417: 1. Back button (Header)
- 行 467: - All text elements must tolerate a minimum of 40% expansion from English baseline
- 行 468: - RTL layout (Arabic, Hebrew): mirrored layout required — document which elements mirror and which do not
- 行 469: - CJK languages (Japanese, Korean, Chinese): text may be 20-30% shorter — verify layouts do not look broken with less text
- 行 470: - Do not use text in images — all text must be from localization strings
- 行 492: - [ ] Screen opens (first frame visible) within 200ms of trigger on minimum-spec hardware
- 行 493: - [ ] Screen is fully interactive (all data loaded) within 500ms of trigger on minimum-spec hardware
- 行 494: - [ ] Navigation between items produces no perceptible frame drop (maintain target framerate ±5fps)
- 行 497: - [ ] Screen displays correctly (no overlap, no cutoff, no overflow) at minimum supported resolution [specify]
- 行 498: - [ ] Screen displays correctly at maximum supported resolution [specify]
- 行 499: - [ ] Screen displays correctly at 4:3, 16:9, 16:10, and 21:9 aspect ratios if targeting PC
- 行 500: - [ ] No text overflow or truncation in English within defined max-character bounds
- 行 501: - [ ] No text overflow or truncation in the longest-translation language [specify — typically German]
- 行 502: - [ ] All states (Loading, Empty, Populated, Error, Confirmation) render correctly
- 行 503: - [ ] Item grid scrolls smoothly without frame drops when all item slots are populated
- 行 506: - [ ] All interactive elements reachable by keyboard using Tab and arrow keys only
- 行 507: - [ ] All interactive elements reachable by gamepad using D-Pad and face buttons only
- 行 508: - [ ] All interactive elements reachable by mouse without keyboard
- 行 509: - [ ] No action requires simultaneous input that is not documented in Section 7
- 行 510: - [ ] Focus is visible at all times on keyboard and gamepad navigation
- 行 511: - [ ] Focus does not escape the screen while it is open
- 行 514: - [ ] All events in Section 9 fire with correct payloads on all exit paths (verify with debug logging)
- 行 515: - [ ] Screen does not write directly to any game system (verify: no direct state mutation calls)
- 行 516: - [ ] Inventory changes persist correctly after screen is closed and reopened
- 行 517: - [ ] Screen handles InventoryChanged events fired by other systems while it is open without crashing
- 行 520: - [ ] All text passes minimum contrast ratios specified in Section 12
- 行 521: - [ ] Stat comparison does not rely on color alone as the sole differentiator
- 行 522: - [ ] Screen reader announces item name and key stats on focus (verify with platform screen reader)
- 行 523: - [ ] Reduced motion setting results in instant transitions (no animated transitions)
- 行 524: - [ ] High contrast mode (if applicable to Accessibility Tier) renders without visual breakage
- 行 527: - [ ] No text element overflows its container in any supported language
- 行 528: - [ ] RTL layout renders correctly (if RTL is a target language)
- 行 529: - [ ] All text elements are driven by localization strings — no hardcoded display text

--------------------------------------------------------------------------------

### .codebuddy\docs\templates\game-concept.md
- 未翻译段落数: 78
- 未翻译列表项数: 44

**未翻译段落:**

**行 38-39:**
```
[What power, experience, or feeling does the player get from this game?
What can they do here that they can't do anywhere else?
```

**行 41-43:**
```
The core fantasy is the emotional promise. It's not a feature list — it's the
answer to "why would someone choose THIS game over anything else they could
```

**行 45-49:**
```
Examples of strong core fantasies:
- "You are a lone survivor building a new life in a hostile wilderness" (survival)
- "You command a civilization across millennia" (strategy)
- "You explore a vast, beautiful world at your own pace" (open world)
- "You master intricate combat and overcome impossible odds" (soulslike)]
```

**行 55-57:**
```
[What makes this game different from everything else in its genre? This is
the single most important differentiator.
/ 什么让这款游戏与同类型其他游戏不同？这是最重要的差异化因素。
```

**行 59-62:**
```
A strong hook passes the "and also" test: "It's like [comparable game],
AND ALSO [unique thing]." If the "and also" doesn't spark curiosity, the
/ 强力卖点通过"而且还有"测试："它像[同类游戏]，而且还有[独特之处]。"如果"而且还有"不能激发好奇心，卖点就需要改进。
```

**行 64-64:**
```
The hook should be / 卖点应该：
```

**行 72-72:**
```
## Player Experience Analysis (MDA Framework)
```

**行 74-75:**
```
The MDA (Mechanics-Dynamics-Aesthetics) framework ensures we design from the
player's emotional experience backward to the systems that create it.
```

**行 77-77:**
```
### Target Aesthetics (What the player FEELS)
```

**行 78-79:**
```
Rank the following aesthetic goals for this game (1 = primary, mark N/A if not
relevant). These come from the MDA framework's 8 aesthetic categories:
```

**行 81-90:**
```
| Aesthetic | Priority | How We Deliver It |
| ---- | ---- | ---- |
| **Sensation** (sensory pleasure) | [1-8 or N/A] | [Visual beauty, audio design, haptics] |
| **Fantasy** (make-believe, role-playing) | [Priority] | [World, characters, player identity] |
| **Narrative** (drama, story arc) | [Priority] | [Plot structure, player-driven stories] |
| **Challenge** (obstacle course, mastery) | [Priority] | [Difficulty curve, skill ceiling] |
| **Fellowship** (social connection) | [Priority] | [Co-op, guilds, shared experiences] |
| **Discovery** (exploration, secrets) | [Priority] | [Hidden areas, emergent systems, lore] |
| **Expression** (self-expression, creativity) | [Priority] | [Build variety, cosmetics, creation tools] |
| **Submission** (relaxation, comfort zone) | [Priority] | [Low-stress loops, ambient gameplay] |
```

**行 92-92:**
```
### Key Dynamics (Emergent player behaviors)
```

**行 93-94:**
```
[What behaviors do we WANT to emerge from our mechanics? What should players
naturally start doing without being told?
```

**行 96-97:**
```
Example: "Players will experiment with ability combinations to find synergies"
Example: "Players will share discoveries with the community"]
```

**行 99-99:**
```
### Core Mechanics (Systems we build)
```

**行 100-101:**
```
[What are the 3-5 mechanical systems that generate the dynamics and aesthetics
above? These are the rules, verbs, and systems we actually implement.]
```

**行 103-105:**
```
1. [Mechanic 1 — e.g., "Real-time combat with stamina management"]
2. [Mechanic 2 — e.g., "Procedurally generated dungeons with hand-crafted rooms"]
3. [Mechanic 3 — e.g., "Crafting system with discoverable recipes"]
```

**行 109-109:**
```
## Player Motivation Profile
```

**行 111-113:**
```
Understanding WHY players play helps us make every design decision. Based on
Self-Determination Theory (SDT) and the Player Experience of Need Satisfaction
```

**行 115-115:**
```
### Primary Psychological Needs Served
```

**行 117-118:**
```
| Need | How This Game Satisfies It | Strength |
| ---- | ---- | ---- |
```

**行 123-123:**
```
### Player Type Appeal (Bartle Taxonomy)
```

**行 125-125:**
```
Which player types does this game primarily serve?
```

**行 127-130:**
```
- [ ] **Achievers** (goal completion, collection, progression) — How: [...]
- [ ] **Explorers** (discovery, understanding systems, finding secrets) — How: [...]
- [ ] **Socializers** (relationships, cooperation, community) — How: [...]
- [ ] **Killers/Competitors** (domination, PvP, leaderboards) — How: [...]
```

**行 132-132:**
```
### Flow State Design
```

**行 134-134:**
```
Flow occurs when challenge matches skill. How does this game maintain flow?
```

**行 136-139:**
```
- **Onboarding curve**: [How do the first 10 minutes teach the player?]
- **Difficulty scaling**: [How does challenge grow with player skill?]
- **Feedback clarity**: [How does the player know they're improving?]
- **Recovery from failure**: [How quickly can they try again? Is failure punishing or educational?]
```

**行 145-145:**
```
### Moment-to-Moment (30 seconds)
```

**行 146-148:**
```
[What is the player physically doing most of the time? The most basic, repeated
action. This MUST be intrinsically satisfying — if the 30-second loop isn't
fun in isolation, no amount of progression will save the game.]
```

**行 150-150:**
```
### Short-Term (5-15 minutes)
```

**行 151-153:**
```
[What objective or cycle structures the moment-to-moment play? Encounters,
puzzles, rounds, quests. This is where "one more turn" or "one more run"
```

**行 155-155:**
```
### Session-Level (30-120 minutes)
```

**行 156-157:**
```
[What does a full play session look like? What does the player accomplish?
This should end with a natural stopping point AND a reason to come back.]
```

**行 159-159:**
```
### Long-Term Progression
```

**行 160-161:**
```
[How does the player grow over days/weeks? Character progression, unlocks,
story advancement, mastery. What is the player working toward?]
```

**行 163-163:**
```
### Retention Hooks
```

**行 164-168:**
```
[What specifically brings the player back for their next session?]
- **Curiosity**: [Unanswered questions, unexplored areas, locked content]
- **Investment**: [Progress they don't want to lose, characters they care about]
- **Social**: [Friends playing, guild obligations, shared goals]
- **Mastery**: [Skills to improve, challenges to overcome, rankings to climb]
```

**行 174-175:**
```
Design pillars are non-negotiable principles that guide EVERY decision. When
two design choices conflict, pillars break the tie. Keep to 3-5 pillars.
```

**行 178-180:**
```
- God of War: "Intense combat", "Father-son story", "World exploration"
- Hades: "Fast fluid combat", "Narrative depth through repeated runs"
- The Last of Us: "Story as essential", "AI partners build relationships", "Stealth encouraged"
```

**行 182-182:**
```
### Pillar 1: [Name]
```

**行 183-183:**
```
[One sentence defining this non-negotiable design principle.]
```

**行 185-186:**
```
*Design test*: [A concrete decision this pillar would resolve. "If we're
debating between X and Y, this pillar says we choose __."]
```

**行 188-188:**
```
### Pillar 2: [Name]
```

**行 191-191:**
```
*Design test*: [Decision it resolves]
```

**行 193-193:**
```
### Pillar 3: [Name]
```

**行 196-196:**
```
*Design test*: [Decision it resolves]
```

**行 198-198:**
```
### Anti-Pillars (What This Game Is NOT)
```

**行 200-201:**
```
Anti-pillars are equally important — they prevent scope creep and keep the
vision focused. Every "no" protects the "yes."
```

**行 203-205:**
```
- **NOT [thing]**: [Why this is explicitly excluded and what it would compromise]
- **NOT [thing]**: [Why]
- **NOT [thing]**: [Why]
```

**行 209-209:**
```
## Inspiration and References
```

**行 211-215:**
```
| Reference | What We Take From It | What We Do Differently | Why It Matters |
| ---- | ---- | ---- | ---- |
| [Game 1] | [Specific mechanic, feeling, or approach] | [Our twist] | [What it validates about our concept] |
| [Game 2] | [What we learn] | [Our twist] | [Validation] |
| [Game 3] | [What we learn] | [Our twist] | [Validation] |
```

**行 217-219:**
```
**Non-game inspirations**: [Films, books, music, art, real-world experiences
that influence the tone, world, or feel. Great games often pull from outside
```

**行 223-223:**
```
## Target Player Profile
```

**行 225-225:**
```
[Be specific. "Gamers" is not a target audience.]
```

**行 227-229:**
```
| Attribute | Detail |
| **Age range** | [e.g., 18-35] |
```

**行 231-235:**
```
| **Time availability** | [e.g., "30-minute sessions on weeknights, longer on weekends"] |
| **Platform preference** | [Where they play most] |
| **Current games they play** | [2-3 specific titles] |
| **What they're looking for** | [The unmet need this game fills] |
| **What would turn them away** | [Dealbreakers for this audience] |
```

**行 239-239:**
```
## Technical Considerations
```

**行 241-242:**
```
| Consideration | Assessment |
```

**行 244-244:**
```
| **Key Technical Challenges** | [What's technically hard about this game?] |
```

**行 249-250:**
```
| **Content Volume** | [Estimate: X levels, Y items, Z hours of gameplay] |
| **Procedural Systems** | [Any procedural generation? What scope?] |
```

**行 254-254:**
```
## Risks and Open Questions
```

**行 256-256:**
```
### Design Risks
```

**行 257-259:**
```
[Things that could make the game unfun or uncompelling]
- [Risk 1 — e.g., "Core loop may not sustain sessions > 30 minutes"]
- [Risk 2 — e.g., "Player motivation unclear after main story ends"]
```

**行 261-261:**
```
### Technical Risks
```

**行 262-264:**
```
[Things that could be hard or impossible to build]
- [Risk 1 — e.g., "Procedural generation quality is unproven"]
- [Risk 2 — e.g., "Networking for 100+ players may require dedicated infrastructure"]
```

**行 266-266:**
```
### Market Risks
```

**行 267-269:**
```
[Things that could prevent commercial success]
- [Risk 1 — e.g., "Genre is saturated with established competitors"]
- [Risk 2 — e.g., "Target audience may be too niche for financial sustainability"]
```

**行 272-274:**
```
[Things that could blow the timeline]
- [Risk 1 — e.g., "Content volume exceeds team capacity"]
- [Risk 2 — e.g., "Feature X depends on technology we haven't prototyped"]
```

**行 276-276:**
```
### Open Questions
```

**行 277-279:**
```
[Things that need prototyping or research before we can answer]
- [Question 1 — and how we plan to answer it]
- [Question 2 — and what prototype would resolve it]
```

**行 283-283:**
```
## MVP Definition
```

**行 285-286:**
```
[The absolute minimum version that validates the core hypothesis. The MVP
answers ONE question: "Is the core loop fun?"]
```

**行 288-289:**
```
**Core hypothesis**: [The single statement the MVP tests, e.g., "Players find
the combat-crafting loop engaging for 30+ minute sessions"]
```

**行 291-294:**
```
**Required for MVP**:
1. [Essential feature 1 — directly tests the hypothesis]
2. [Essential feature 2]
3. [Essential feature 3]
```

**行 296-298:**
```
**Explicitly NOT in MVP** (defer to later):
- [Feature that's nice but doesn't test the hypothesis]
- [Feature that adds scope without validating the core]
```

**行 300-300:**
```
### Scope Tiers (if budget/time shrinks)
```

**行 302-307:**
```
| Tier | Content | Features | Timeline |
| ---- | ---- | ---- | ---- |
| **MVP** | [Minimal] | [Core loop only] | [X weeks] |
| **Vertical Slice** | [One complete area] | [Core + progression] | [X weeks] |
| **Alpha** | [All areas, placeholder] | [All features, rough] | [X weeks] |
| **Full Vision** | [Complete content] | [All features, polished] | [X weeks] |
```

**行 313-320:**
```
- [ ] Get concept approval from creative-director
- [ ] Fill in CLAUDE.md technology stack based on engine choice (`/setup-engine`)
- [ ] Create game pillars document (`/design-review` to validate)
- [ ] Decompose concept into systems (`/map-systems` — maps dependencies, assigns priorities, guides per-system GDD writing)
- [ ] Create first architecture decision record (`/architecture-decision`)
- [ ] Prototype core loop (`/prototype [core-mechanic]`)
- [ ] Validate core loop with playtest (`/playtest-report`)
- [ ] Plan first milestone (`/sprint-plan new`)
```

**未翻译列表项:**
- 行 46: - "You are a lone survivor building a new life in a hostile wilderness" (survival)
- 行 47: - "You command a civilization across millennia" (strategy)
- 行 48: - "You explore a vast, beautiful world at your own pace" (open world)
- 行 49: - "You master intricate combat and overcome impossible odds" (soulslike)]
- 行 103: 1. [Mechanic 1 — e.g., "Real-time combat with stamina management"]
- 行 127: - [ ] **Achievers** (goal completion, collection, progression) — How: [...]
- 行 128: - [ ] **Explorers** (discovery, understanding systems, finding secrets) — How: [...]
- 行 129: - [ ] **Socializers** (relationships, cooperation, community) — How: [...]
- 行 130: - [ ] **Killers/Competitors** (domination, PvP, leaderboards) — How: [...]
- 行 136: - **Onboarding curve**: [How do the first 10 minutes teach the player?]
- 行 137: - **Difficulty scaling**: [How does challenge grow with player skill?]
- 行 138: - **Feedback clarity**: [How does the player know they're improving?]
- 行 139: - **Recovery from failure**: [How quickly can they try again? Is failure punishing or educational?]
- 行 165: - **Curiosity**: [Unanswered questions, unexplored areas, locked content]
- 行 166: - **Investment**: [Progress they don't want to lose, characters they care about]
- 行 167: - **Social**: [Friends playing, guild obligations, shared goals]
- 行 168: - **Mastery**: [Skills to improve, challenges to overcome, rankings to climb]
- 行 178: - God of War: "Intense combat", "Father-son story", "World exploration"
- 行 179: - Hades: "Fast fluid combat", "Narrative depth through repeated runs"
- 行 180: - The Last of Us: "Story as essential", "AI partners build relationships", "Stealth encouraged"
- 行 203: - **NOT [thing]**: [Why this is explicitly excluded and what it would compromise]
- 行 204: - **NOT [thing]**: [Why]
- 行 205: - **NOT [thing]**: [Why]
- 行 258: - [Risk 1 — e.g., "Core loop may not sustain sessions > 30 minutes"]
- 行 259: - [Risk 2 — e.g., "Player motivation unclear after main story ends"]
- 行 263: - [Risk 1 — e.g., "Procedural generation quality is unproven"]
- 行 264: - [Risk 2 — e.g., "Networking for 100+ players may require dedicated infrastructure"]
- 行 268: - [Risk 1 — e.g., "Genre is saturated with established competitors"]
- 行 269: - [Risk 2 — e.g., "Target audience may be too niche for financial sustainability"]
- 行 273: - [Risk 1 — e.g., "Content volume exceeds team capacity"]
- 行 274: - [Risk 2 — e.g., "Feature X depends on technology we haven't prototyped"]
- 行 278: - [Question 1 — and how we plan to answer it]
- 行 279: - [Question 2 — and what prototype would resolve it]
- 行 292: 1. [Essential feature 1 — directly tests the hypothesis]
- 行 297: - [Feature that's nice but doesn't test the hypothesis]
- 行 298: - [Feature that adds scope without validating the core]
- 行 313: - [ ] Get concept approval from creative-director
- 行 314: - [ ] Fill in CLAUDE.md technology stack based on engine choice (`/setup-engine`)
- 行 315: - [ ] Create game pillars document (`/design-review` to validate)
- 行 316: - [ ] Decompose concept into systems (`/map-systems` — maps dependencies, assigns priorities, guides per-system GDD writing)
- 行 317: - [ ] Create first architecture decision record (`/architecture-decision`)
- 行 318: - [ ] Prototype core loop (`/prototype [core-mechanic]`)
- 行 319: - [ ] Validate core loop with playtest (`/playtest-report`)
- 行 320: - [ ] Plan first milestone (`/sprint-plan new`)

--------------------------------------------------------------------------------

### .codebuddy\docs\templates\architecture-doc-from-code.md
- 未翻译段落数: 58
- 未翻译列表项数: 56

**未翻译段落:**

**行 4-9:**
```
**Status**: Reverse-Documented
**Source**: `[path to implementation code]`
**Date**: [YYYY-MM-DD]
**Decision Makers**: [User name or "inferred from code"]
**Implementation Status**: [Deployed | Partial | Planned]
```

**行 11-16:**
```
> **⚠️ Reverse-Documentation Notice**
> This Architecture Decision Record was created **after** the implementation already
> existed. It captures the current implementation approach and clarified rationale
> based on code analysis and user consultation. Some context may be reconstructed
> rather than contemporaneously documented.
```

**行 22-22:**
```
**Problem Statement**: [What problem did this implementation solve? / 问题陈述：这个实现解决了什么问题？]
```

**行 24-27:**
```
**Background** (inferred from code):
- [Context 1 — why this problem needed solving]
- [Context 2 — constraints at the time]
- [Context 3 — alternatives that were likely considered]
```

**行 29-29:**
```
**System Scope**: [What parts of the codebase does this affect? / 系统范围：这影响代码库的哪些部分？]
```

**行 31-31:**
```
**Stakeholders** / 利益相关者：
```

**行 39-39:**
```
**Approach Taken** (as implemented) / 采用的方法（已实现）：
```

**行 41-41:**
```
[Describe the architectural approach found in the code]
```

**行 43-46:**
```
**Key Implementation Details** / 关键实现细节：
- [Detail 1]: [How it works]
- [Detail 2]: [Pattern or structure used]
- [Detail 3]: [Notable design choice]
```

**行 48-51:**
```
**Clarified Rationale** (from user) / 澄清的理由（来自用户）：
- [Reason 1 — why this approach was chosen]
- [Reason 2 — what problem it solves]
- [Reason 3 — what benefit it provides]
```

**行 53-53:**
```
**Code Locations** / 代码位置：
```

**行 61-61:**
```
*(These may be inferred or clarified with user / 这些可能根据推断或与用户澄清确定)*
```

**行 65-65:**
```
**Description**: [What this alternative would have been / 描述：这个替代方案会是怎样的]
```

**行 68-69:**
```
- ✅ [Advantage 1]
- ✅ [Advantage 2]
```

**行 72-73:**
```
- ❌ [Disadvantage 1]
- ❌ [Disadvantage 2]
```

**行 75-75:**
```
**Why Not Chosen**: [Reason — from user clarification or inference]
```

**行 79-79:**
```
**Description**: [What this alternative would have been / 描述：这个替代方案会是怎样的]
```

**行 82-83:**
```
- ✅ [Advantage 1]
- ✅ [Advantage 2]
```

**行 86-87:**
```
- ❌ [Disadvantage 1]
- ❌ [Disadvantage 2]
```

**行 89-89:**
```
**Why Not Chosen**: [Reason / 未选择的原因]
```

**行 93-93:**
```
**Description**: [What "doing nothing" would mean]
```

**行 95-95:**
```
**Why Not Acceptable**: [Why the problem needed solving]
```

**行 103-103:**
```
✅ **[Benefit 1]**: [How the implementation provides this]
```

**行 105-105:**
```
✅ **[Benefit 2]**: [Impact]
```

**行 107-107:**
```
✅ **[Benefit 3]**: [Impact]
```

**行 111-111:**
```
⚠️ **[Trade-off 1]**: [What was sacrificed or made harder]
```

**行 113-113:**
```
⚠️ **[Trade-off 2]**: [Limitation or cost]
```

**行 115-115:**
```
⚠️ **[Trade-off 3]**: [Complexity or maintenance burden]
```

**行 119-119:**
```
ℹ️ **[Observation 1]**: [Emergent property or side effect]
```

**行 121-121:**
```
ℹ️ **[Observation 2]**: [Unexpected outcome]
```

**行 128-129:**
```
- [Pattern 1]: [Where and why]
- [Pattern 2]: [Where and why]
```

**行 131-133:**
```
**Dependencies Introduced**:
- [Dependency 1]: [Why needed]
- [Dependency 2]: [Why needed]
```

**行 135-138:**
```
**Performance Characteristics**:
- Time complexity: [O(n), etc.]
- Space complexity: [Memory usage]
- Bottlenecks: [Known performance concerns]
```

**行 141-141:**
```
- [Thread safety approach — single-threaded, mutex-protected, lock-free, etc.]
```

**行 143-145:**
```
**Testing Strategy**:
- [How this is tested — unit tests, integration tests, etc.]
- Coverage: [Estimated or measured]
```

**行 151-154:**
```
**How We Know This Works**:
- ✅ [Evidence 1 — e.g., "6 months in production without issues"]
- ✅ [Evidence 2 — e.g., "handles 10k entities at 60 FPS"]
- ⚠️ [Evidence 3 — e.g., "works but needs monitoring"]
```

**行 156-158:**
```
**Known Issues** (discovered during analysis):
- ⚠️ [Issue 1]: [Problem and potential fix]
- ⚠️ [Issue 2]: [Problem and potential fix]
```

**行 161-162:**
```
- [Risk 1]: [Potential problem if X happens]
- [Risk 2]: [Scalability concern]
```

**行 168-171:**
```
**Unresolved During Reverse-Documentation**:
1. **[Question 1]**: [What's unclear about the decision or implementation?]
   - Needs clarification from: [Who]
   - Impact if unresolved: [Consequence]
```

**行 173-173:**
```
2. **[Question 2]**: [What needs to be decided for future work?]
```

**行 180-181:**
```
- [ ] [Task 1 — e.g., "Add missing unit tests"]
- [ ] [Task 2 — e.g., "Document edge case handling"]
```

**行 184-185:**
```
- [ ] [Task 3 — e.g., "Refactor X for clarity"]
- [ ] [Task 4 — e.g., "Add performance monitoring"]
```

**行 188-188:**
```
- [ ] [Task 5 — e.g., "Revisit decision when Y is available"]
```

**行 194-195:**
```
**Depends On** (ADRs this builds upon):
- [ADR-XXX]: [Related decision]
```

**行 197-198:**
```
**Influences** (ADRs affected by this):
- [ADR-YYY]: [How this impacts it]
```

**行 201-201:**
```
- [ADR-ZZZ]: [Old decision this replaces, if any]
```

**行 204-204:**
```
- [None yet | ADR-WWW if this decision is later replaced]
```

**行 211-212:**
```
- `[path/file 1]`: [Primary implementation]
- `[path/file 2]`: [Related code]
```

**行 214-216:**
```
**External Resources**:
- [Article/Book]: [Relevant pattern or technique reference]
- [Documentation]: [Engine or library docs consulted]
```

**行 218-219:**
```
**Design Documents**:
- [GDD Section]: [If this implements a design]
```

**行 225-228:**
```
| Date | Author | Changes |
|------|--------|---------|
| [Date] | Claude (reverse-doc) | Initial reverse-documentation from `[source path]` |
| [Date] | [User] | Clarified rationale for [X] |
```

**行 234-238:**
```
- **Proposed**: Under discussion, not implemented
- **Accepted**: Decided, implementation in progress
- **Deprecated**: No longer recommended, but may exist in code
- **Superseded**: Replaced by another decision
- **Reverse-Documented**: Created after implementation (this document)
```

**行 242-242:**
```
**Current Status**: **Reverse-Documented**
```

**行 246-246:**
```
*This ADR was generated by `/reverse-document architecture [path]`*
```

**行 252-252:**
```
**Key Implementation Pattern**:
```

**行 258-258:**
```
**Rationale**: [Why this code structure embodies the decision]
```

**行 260-260:**
```
**Alternative Approach** (not chosen):
```

**行 266-266:**
```
**Why Not**: [Why the implemented approach was preferred]
```

**未翻译列表项:**
- 行 25: - [Context 1 — why this problem needed solving]
- 行 26: - [Context 2 — constraints at the time]
- 行 27: - [Context 3 — alternatives that were likely considered]
- 行 44: - [Detail 1]: [How it works]
- 行 45: - [Detail 2]: [Pattern or structure used]
- 行 46: - [Detail 3]: [Notable design choice]
- 行 49: - [Reason 1 — why this approach was chosen]
- 行 50: - [Reason 2 — what problem it solves]
- 行 51: - [Reason 3 — what benefit it provides]
- 行 68: - ✅ [Advantage 1]
- 行 69: - ✅ [Advantage 2]
- 行 72: - ❌ [Disadvantage 1]
- 行 73: - ❌ [Disadvantage 2]
- 行 82: - ✅ [Advantage 1]
- 行 83: - ✅ [Advantage 2]
- 行 86: - ❌ [Disadvantage 1]
- 行 87: - ❌ [Disadvantage 2]
- 行 128: - [Pattern 1]: [Where and why]
- 行 129: - [Pattern 2]: [Where and why]
- 行 132: - [Dependency 1]: [Why needed]
- 行 133: - [Dependency 2]: [Why needed]
- 行 136: - Time complexity: [O(n), etc.]
- 行 137: - Space complexity: [Memory usage]
- 行 138: - Bottlenecks: [Known performance concerns]
- 行 141: - [Thread safety approach — single-threaded, mutex-protected, lock-free, etc.]
- 行 144: - [How this is tested — unit tests, integration tests, etc.]
- 行 145: - Coverage: [Estimated or measured]
- 行 152: - ✅ [Evidence 1 — e.g., "6 months in production without issues"]
- 行 153: - ✅ [Evidence 2 — e.g., "handles 10k entities at 60 FPS"]
- 行 154: - ⚠️ [Evidence 3 — e.g., "works but needs monitoring"]
- 行 157: - ⚠️ [Issue 1]: [Problem and potential fix]
- 行 158: - ⚠️ [Issue 2]: [Problem and potential fix]
- 行 161: - [Risk 1]: [Potential problem if X happens]
- 行 162: - [Risk 2]: [Scalability concern]
- 行 169: 1. **[Question 1]**: [What's unclear about the decision or implementation?]
- 行 170: - Needs clarification from: [Who]
- 行 171: - Impact if unresolved: [Consequence]
- 行 180: - [ ] [Task 1 — e.g., "Add missing unit tests"]
- 行 181: - [ ] [Task 2 — e.g., "Document edge case handling"]
- 行 184: - [ ] [Task 3 — e.g., "Refactor X for clarity"]
- 行 185: - [ ] [Task 4 — e.g., "Add performance monitoring"]
- 行 188: - [ ] [Task 5 — e.g., "Revisit decision when Y is available"]
- 行 195: - [ADR-XXX]: [Related decision]
- 行 198: - [ADR-YYY]: [How this impacts it]
- 行 201: - [ADR-ZZZ]: [Old decision this replaces, if any]
- 行 204: - [None yet | ADR-WWW if this decision is later replaced]
- 行 211: - `[path/file 1]`: [Primary implementation]
- 行 212: - `[path/file 2]`: [Related code]
- 行 215: - [Article/Book]: [Relevant pattern or technique reference]
- 行 216: - [Documentation]: [Engine or library docs consulted]
- 行 219: - [GDD Section]: [If this implements a design]
- 行 234: - **Proposed**: Under discussion, not implemented
- 行 235: - **Accepted**: Decided, implementation in progress
- 行 236: - **Deprecated**: No longer recommended, but may exist in code
- 行 237: - **Superseded**: Replaced by another decision
- 行 238: - **Reverse-Documented**: Created after implementation (this document)

--------------------------------------------------------------------------------

### .codebuddy\docs\templates\design-doc-from-implementation.md
- 未翻译段落数: 51
- 未翻译列表项数: 58

**未翻译段落:**

**行 4-9:**
```
**Status**: Reverse-Documented
**Source**: `[path to implementation code]`
**Date**: [YYYY-MM-DD]
**Verified By**: [User name or "pending review"]
**Implementation Status**: [Fully implemented | Partially implemented | Needs extension]
```

**行 11-16:**
```
> **⚠️ Reverse-Documentation Notice**
> This design document was created **after** the implementation already existed.
> It captures current behavior and clarified design intent based on code analysis
> and user consultation. Some sections may be incomplete where implementation is
> partial or design intent was unclear during reverse-engineering.
```

**行 22-22:**
```
**Purpose**: [What problem does this system solve?]
```

**行 24-24:**
```
**Scope**: [What is included/excluded from this system?]
```

**行 26-26:**
```
**Current Implementation**: [Brief description of what exists in code]
```

**行 28-31:**
```
**Design Intent** (clarified):
- [Intent 1 — why this feature exists]
- [Intent 2 — what player experience it creates]
- [Intent 3 — how it fits into overall game pillars]
```

**行 35-35:**
```
## 2. Detailed Design
```

**行 37-37:**
```
### 2.1 Core Mechanics
```

**行 39-39:**
```
[Describe the mechanics as implemented, organized clearly]
```

**行 41-45:**
```
**[Mechanic 1 Name]**:
- **Description**: [What it does]
- **Implementation**: [How it works in code]
- **Design Rationale**: [Why it exists — from user clarification]
- **Player-Facing**: [How players experience this]
```

**行 47-51:**
```
**[Mechanic 2 Name]**:
- **Description**: [What it does]
- **Implementation**: [How it works]
- **Design Rationale**: [Why it exists]
- **Player-Facing**: [Player experience]
```

**行 53-53:**
```
### 2.2 Rules and Formulas
```

**行 55-55:**
```
**Formulas Discovered in Code**:
```

**行 57-58:**
```
| Formula | Expression | Purpose | Verified? |
|---------|-----------|---------|-----------|
```

**行 63-64:**
```
- [Formula X]: Originally [value/approach], user clarified intent is [corrected intent]
- [Formula Y]: Implemented as [X], but should be [Y] — flagged for update
```

**行 66-66:**
```
### 2.3 State and Data
```

**行 68-70:**
```
**Data Structures** (from code):
- [Data structure 1]: `[fields/properties]`
- [Data structure 2]: `[fields/properties]`
```

**行 72-72:**
```
**State Machines** (if applicable):
```

**行 78-79:**
```
- Saved: [What is saved to player save file]
- Not saved: [What is session-only or recalculated]
```

**行 81-81:**
```
### 2.4 Integration Points
```

**行 83-85:**
```
**Dependencies** (systems this depends on):
- [System 1]: [What it provides]
- [System 2]: [What it provides]
```

**行 87-89:**
```
**Dependents** (systems that depend on this):
- [System 3]: [How it uses this system]
- [System 4]: [How it uses this system]
```

**行 91-93:**
```
**API Surface** (public interface):
- [Method/Function 1]: [Purpose]
- [Method/Function 2]: [Purpose]
```

**行 97-97:**
```
## 3. Edge Cases
```

**行 100-101:**
```
- ✅ [Edge case 1]: [How it's handled]
- ✅ [Edge case 2]: [How it's handled]
```

**行 103-105:**
```
**Not Yet Handled** (discovered during analysis):
- ⚠️ [Edge case 3]: [What happens? Needs implementation]
- ⚠️ [Edge case 4]: [What happens? Needs implementation]
```

**行 107-108:**
```
**Unclear** (need user clarification):
- ❓ [Edge case 5]: [What should happen? Pending decision]
```

**行 112-112:**
```
## 4. Dependencies
```

**行 114-116:**
```
**Technical Dependencies**:
- [Dependency 1]: [Why needed]
- [Dependency 2]: [Why needed]
```

**行 118-120:**
```
**Design Dependencies** (other design docs):
- [System X Design]: [How they interact]
- [System Y Design]: [How they interact]
```

**行 122-124:**
```
**Content Dependencies**:
- [Asset type]: [What's needed]
- [Data files]: [Required config/balance data]
```

**行 128-128:**
```
## 5. Balance and Tuning
```

**行 130-130:**
```
**Current Values** (as implemented):
```

**行 132-133:**
```
| Parameter | Current Value | Rationale | Needs Tuning? |
|-----------|--------------|-----------|---------------|
```

**行 137-139:**
```
**Balance Concerns Identified**:
- ⚠️ [Concern 1]: [What's wrong, suggested fix]
- ⚠️ [Concern 2]: [What's wrong, suggested fix]
```

**行 141-143:**
```
**Recommended Balance Pass**:
- Run `/balance-check` on [specific aspect]
- Playtest with focus on [specific scenario]
```

**行 147-147:**
```
## 6. Acceptance Criteria
```

**行 149-152:**
```
**What Exists** (implemented):
- ✅ [Criterion 1]
- ✅ [Criterion 2]
- ⚠️ [Criterion 3] — partially implemented
```

**行 154-156:**
```
**What's Missing** (not yet implemented):
- ❌ [Criterion 4] — flagged for future work
- ❌ [Criterion 5] — flagged for future work
```

**行 158-161:**
```
**Definition of Done** (when is this system "complete"?):
- [ ] [Requirement 1]
- [ ] [Requirement 2]
- [ ] [Requirement 3]
```

**行 165-165:**
```
## 7. Open Questions and Follow-Up Work
```

**行 167-167:**
```
### Questions Needing User Decision
```

**行 168-170:**
```
1. **[Question 1]**: [What needs to be decided?]
   - Option A: [Approach A]
   - Option B: [Approach B]
```

**行 172-172:**
```
2. **[Question 2]**: [What needs to be decided?]
```

**行 174-174:**
```
### Flagged Follow-Up Work
```

**行 175-179:**
```
- [ ] **Update [Formula X]**: Change from exponential to linear (per user clarification)
- [ ] **Implement [Edge Case Y]**: Handle scenario not in current code
- [ ] **Create ADR**: Document why [architectural decision] was chosen
- [ ] **Balance pass**: Run `/balance-check` on progression curve
- [ ] **Extend design doc**: When [related feature] is implemented, update this doc
```

**行 183-183:**
```
## 8. Version History
```

**行 185-188:**
```
| Date | Author | Changes |
|------|--------|---------|
| [Date] | Claude (reverse-doc) | Initial reverse-documentation from `[source path]` |
| [Date] | [User] | Clarified design intent, corrected [X] |
```

**行 193-195:**
```
1. [Priority 1 task based on gaps identified]
```

**行 198-200:**
```
- `/balance-check` — Validate formulas and progression
- `/architecture-decision` — Document technical decisions
- `/code-review` — Ensure code matches clarified design
```

**行 204-204:**
```
*This document was generated by `/reverse-document design [path]`*
```

**未翻译列表项:**
- 行 29: - [Intent 1 — why this feature exists]
- 行 30: - [Intent 2 — what player experience it creates]
- 行 31: - [Intent 3 — how it fits into overall game pillars]
- 行 42: - **Description**: [What it does]
- 行 43: - **Implementation**: [How it works in code]
- 行 44: - **Design Rationale**: [Why it exists — from user clarification]
- 行 45: - **Player-Facing**: [How players experience this]
- 行 48: - **Description**: [What it does]
- 行 49: - **Implementation**: [How it works]
- 行 50: - **Design Rationale**: [Why it exists]
- 行 51: - **Player-Facing**: [Player experience]
- 行 63: - [Formula X]: Originally [value/approach], user clarified intent is [corrected intent]
- 行 64: - [Formula Y]: Implemented as [X], but should be [Y] — flagged for update
- 行 69: - [Data structure 1]: `[fields/properties]`
- 行 70: - [Data structure 2]: `[fields/properties]`
- 行 78: - Saved: [What is saved to player save file]
- 行 79: - Not saved: [What is session-only or recalculated]
- 行 84: - [System 1]: [What it provides]
- 行 85: - [System 2]: [What it provides]
- 行 88: - [System 3]: [How it uses this system]
- 行 89: - [System 4]: [How it uses this system]
- 行 92: - [Method/Function 1]: [Purpose]
- 行 93: - [Method/Function 2]: [Purpose]
- 行 100: - ✅ [Edge case 1]: [How it's handled]
- 行 101: - ✅ [Edge case 2]: [How it's handled]
- 行 104: - ⚠️ [Edge case 3]: [What happens? Needs implementation]
- 行 105: - ⚠️ [Edge case 4]: [What happens? Needs implementation]
- 行 108: - ❓ [Edge case 5]: [What should happen? Pending decision]
- 行 115: - [Dependency 1]: [Why needed]
- 行 116: - [Dependency 2]: [Why needed]
- 行 119: - [System X Design]: [How they interact]
- 行 120: - [System Y Design]: [How they interact]
- 行 123: - [Asset type]: [What's needed]
- 行 124: - [Data files]: [Required config/balance data]
- 行 138: - ⚠️ [Concern 1]: [What's wrong, suggested fix]
- 行 139: - ⚠️ [Concern 2]: [What's wrong, suggested fix]
- 行 142: - Run `/balance-check` on [specific aspect]
- 行 143: - Playtest with focus on [specific scenario]
- 行 150: - ✅ [Criterion 1]
- 行 151: - ✅ [Criterion 2]
- 行 152: - ⚠️ [Criterion 3] — partially implemented
- 行 155: - ❌ [Criterion 4] — flagged for future work
- 行 156: - ❌ [Criterion 5] — flagged for future work
- 行 159: - [ ] [Requirement 1]
- 行 160: - [ ] [Requirement 2]
- 行 161: - [ ] [Requirement 3]
- 行 168: 1. **[Question 1]**: [What needs to be decided?]
- 行 169: - Option A: [Approach A]
- 行 170: - Option B: [Approach B]
- 行 175: - [ ] **Update [Formula X]**: Change from exponential to linear (per user clarification)
- 行 176: - [ ] **Implement [Edge Case Y]**: Handle scenario not in current code
- 行 177: - [ ] **Create ADR**: Document why [architectural decision] was chosen
- 行 178: - [ ] **Balance pass**: Run `/balance-check` on progression curve
- 行 179: - [ ] **Extend design doc**: When [related feature] is implemented, update this doc
- 行 193: 1. [Priority 1 task based on gaps identified]
- 行 198: - `/balance-check` — Validate formulas and progression
- 行 199: - `/architecture-decision` — Document technical decisions
- 行 200: - `/code-review` — Ensure code matches clarified design

--------------------------------------------------------------------------------

### .codebuddy\docs\templates\project-stage-report.md
- 未翻译段落数: 36
- 未翻译列表项数: 56

**未翻译段落:**

**行 3-5:**
```
**Generated** / **生成于**: [DATE] / [日期]
**Stage** / **阶段**: [Concept | Systems Design | Technical Setup | Pre-Production | Production | Polish | Release] / [概念 | 系统设计 | 技术设置 | 预生产 | 生产 | 打磨 | 发布]
**Analysis Scope** / **分析范围**: [Full project | Specific role: programmer/designer/producer] / [完整项目 | 特定角色：程序员/设计师/制作人]
```

**行 11-11:**
```
[1-2 paragraph overview of project state, primary gaps, and recommended priority] / [关于项目状态、主要差距和推荐优先级的1-2段概述]
```

**行 13-15:**
```
**Current Focus** / **当前重点**: [What the project is actively working on] / [项目正在积极进行的工作]
**Blocking Issues** / **阻塞问题**: [Critical gaps preventing progress] / [阻碍进展的关键差距]
**Estimated Time to Next Stage** / **到下一阶段的估计时间**: [If applicable] / [如果适用]
```

**行 42-42:**
```
### Architecture Documentation
```

**行 43-51:**
```
- **Status**: [X%] complete
- **ADRs Found**: [N] decisions documented in `docs/architecture/`
- **Coverage**:
  - ✅ [Decision area 1] — documented
  - ⚠️  [Decision area 2] — undocumented but implemented
  - ❌ [Decision area 3] — neither documented nor decided
- **Key Gaps**:
  - [ ] [Missing ADR 1 + why it's needed]
  - [ ] [Missing ADR 2 + why it's needed]
```

**行 53-53:**
```
### Production Management
```

**行 54-60:**
```
- **Status**: [X%] complete
- **Found**:
  - Sprint plans: [N] in `production/sprints/`
  - Milestones: [N] in `production/milestones/`
  - Roadmap: [Exists | Missing]
- **Key Gaps**:
  - [ ] [Missing production artifact + impact]
```

**行 63-69:**
```
- **Status**: [X%] coverage (estimated)
- **Test Files**: [N] in `tests/`
- **Coverage by System**:
  - [System 1]: [X%] (estimated)
  - [System 2]: [X%] (estimated)
- **Key Gaps**:
  - [ ] [Missing test area + risk]
```

**行 72-77:**
```
- **Active Prototypes**: [N] in `prototypes/`
  - ✅ [Prototype 1] — documented with README
  - ⚠️  [Prototype 2] — no README, unclear status
- **Archived**: [N] (experiments completed)
- **Key Gaps**:
  - [ ] [Undocumented prototype + why it matters]
```

**行 81-81:**
```
## Stage Classification Rationale
```

**行 85-85:**
```
[Explain why the project is classified at this stage based on indicators found]
```

**行 87-89:**
```
**Indicators for this stage**:
- [Indicator 1 that matches this stage]
- [Indicator 2 that matches this stage]
```

**行 91-94:**
```
**Next stage requirements**:
- [ ] [Requirement 1 to reach next stage]
- [ ] [Requirement 2 to reach next stage]
- [ ] [Requirement 3 to reach next stage]
```

**行 98-98:**
```
## Gaps Identified (with Clarifying Questions)
```

**行 100-100:**
```
### Critical Gaps (block progress)
```

**行 102-105:**
```
1. **[Gap Name]**
   - **Impact**: [Why this blocks progress]
   - **Question**: [Clarifying question before assuming solution]
   - **Suggested Action**: [What could be done, pending clarification]
```

**行 107-107:**
```
### Important Gaps (affect quality/velocity)
```

**行 110-112:**
```
   - **Impact**: [Why this matters]
   - **Question**: [Clarifying question]
   - **Suggested Action**: [Proposed solution]
```

**行 114-114:**
```
### Nice-to-Have Gaps (polish/best practices)
```

**行 117-119:**
```
   - **Impact**: [Minor but valuable]
   - **Question**: [Clarifying question]
   - **Suggested Action**: [Optional improvement]
```

**行 123-123:**
```
## Recommended Next Steps
```

**行 125-125:**
```
### Immediate Priority (Do First)
```

**行 126-128:**
```
1. **[Action 1]** — [Why it's priority 1]
   - Suggested skill: `/[skill-name]` or manual work
   - Estimated effort: [S/M/L]
```

**行 130-132:**
```
2. **[Action 2]** — [Why it's priority 2]
   - Suggested skill: `/[skill-name]`
   - Estimated effort: [S/M/L]
```

**行 134-134:**
```
### Short-Term (This Sprint/Week)
```

**行 135-136:**
```
3. **[Action 3]** — [Why it's important soon]
4. **[Action 4]** — [Why it's important soon]
```

**行 138-138:**
```
### Medium-Term (Next Milestone)
```

**行 139-140:**
```
5. **[Action 5]** — [Future need]
6. **[Action 6]** — [Future need]
```

**行 144-144:**
```
## Role-Specific Recommendations
```

**行 146-146:**
```
[If role filter was used, provide role-specific guidance]
```

**行 149-153:**
```
- **Focus areas**: [What this role should prioritize]
- **Blockers**: [What's blocking this role's work]
- **Next tasks**:
  1. [Task 1]
```

**行 157-157:**
```
## Follow-Up Skills to Run
```

**行 159-159:**
```
Based on gaps identified, consider running:
```

**行 161-165:**
```
- `/reverse-document [type] [path]` — [For which gap]
- `/architecture-decision` — [For which gap]
- `/sprint-plan` — [If production planning missing]
- `/milestone-review` — [If approaching deadline]
- `/onboard [role]` — [If new contributor joining]
```

**行 169-169:**
```
## Appendix: File Counts by Directory
```

**行 199-199:**
```
*Generated by `/project-stage-detect` skill*
```

**未翻译列表项:**
- 行 43: - **Status**: [X%] complete
- 行 44: - **ADRs Found**: [N] decisions documented in `docs/architecture/`
- 行 45: - **Coverage**:
- 行 46: - ✅ [Decision area 1] — documented
- 行 47: - ⚠️  [Decision area 2] — undocumented but implemented
- 行 48: - ❌ [Decision area 3] — neither documented nor decided
- 行 49: - **Key Gaps**:
- 行 50: - [ ] [Missing ADR 1 + why it's needed]
- 行 51: - [ ] [Missing ADR 2 + why it's needed]
- 行 54: - **Status**: [X%] complete
- 行 56: - Sprint plans: [N] in `production/sprints/`
- 行 57: - Milestones: [N] in `production/milestones/`
- 行 58: - Roadmap: [Exists | Missing]
- 行 59: - **Key Gaps**:
- 行 60: - [ ] [Missing production artifact + impact]
- 行 63: - **Status**: [X%] coverage (estimated)
- 行 64: - **Test Files**: [N] in `tests/`
- 行 65: - **Coverage by System**:
- 行 66: - [System 1]: [X%] (estimated)
- 行 67: - [System 2]: [X%] (estimated)
- 行 68: - **Key Gaps**:
- 行 69: - [ ] [Missing test area + risk]
- 行 72: - **Active Prototypes**: [N] in `prototypes/`
- 行 73: - ✅ [Prototype 1] — documented with README
- 行 74: - ⚠️  [Prototype 2] — no README, unclear status
- 行 75: - **Archived**: [N] (experiments completed)
- 行 76: - **Key Gaps**:
- 行 77: - [ ] [Undocumented prototype + why it matters]
- 行 88: - [Indicator 1 that matches this stage]
- 行 89: - [Indicator 2 that matches this stage]
- 行 92: - [ ] [Requirement 1 to reach next stage]
- 行 93: - [ ] [Requirement 2 to reach next stage]
- 行 94: - [ ] [Requirement 3 to reach next stage]
- 行 102: 1. **[Gap Name]**
- 行 103: - **Impact**: [Why this blocks progress]
- 行 104: - **Question**: [Clarifying question before assuming solution]
- 行 105: - **Suggested Action**: [What could be done, pending clarification]
- 行 110: - **Impact**: [Why this matters]
- 行 111: - **Question**: [Clarifying question]
- 行 112: - **Suggested Action**: [Proposed solution]
- 行 117: - **Impact**: [Minor but valuable]
- 行 118: - **Question**: [Clarifying question]
- 行 119: - **Suggested Action**: [Optional improvement]
- 行 126: 1. **[Action 1]** — [Why it's priority 1]
- 行 127: - Suggested skill: `/[skill-name]` or manual work
- 行 128: - Estimated effort: [S/M/L]
- 行 131: - Suggested skill: `/[skill-name]`
- 行 132: - Estimated effort: [S/M/L]
- 行 149: - **Focus areas**: [What this role should prioritize]
- 行 150: - **Blockers**: [What's blocking this role's work]
- 行 151: - **Next tasks**:
- 行 161: - `/reverse-document [type] [path]` — [For which gap]
- 行 162: - `/architecture-decision` — [For which gap]
- 行 163: - `/sprint-plan` — [If production planning missing]
- 行 164: - `/milestone-review` — [If approaching deadline]
- 行 165: - `/onboard [role]` — [If new contributor joining]

--------------------------------------------------------------------------------

### .codebuddy\docs\templates\player-journey.md
- 未翻译段落数: 65
- 未翻译列表项数: 23

**未翻译段落:**

**行 12-16:**
```
[One paragraph capturing the full emotional arc from first launch to long-term / [一段话，捕捉从首次启动到长期
play. This is the player's story, not the game's feature list. Describe the / 游玩的全过程情感弧线。这是玩家的故事，不是游戏的功能列表。用情感术语描述
journey in emotional terms: where do they start (curious, skeptical, cautious), / 旅程：他们从哪里开始（好奇、怀疑、谨慎），
how does the relationship with the game deepen, what is the peak emotional / 他们与游戏的关系如何加深，巅峰情感
experience, and what sustains them afterward? / 体验是什么，之后是什么让他们持续下去？
```

**行 24-25:**
```
If this arc cannot be described in one paragraph, the emotional design is not / 如果这段弧线不能用一段话描述，情感设计还
yet clear enough — resolve that ambiguity before filling in the phases below.] / 不够清晰——在填写下面的阶段之前解决这种模糊性。]
```

**行 31-33:**
```
[3-4 lines describing the player's MINDSET and gaming literacy, not their / [3-4行描述玩家的心态和游戏素养，而不是他们的
demographics. Demographics answer "who are they" — this answers "how do they / 人口统计数据。人口统计数据回答"他们是谁"——这部分回答"他们如何
approach games." / 接近游戏。"
```

**行 60-63:**
```
**Emotional state on arrival** / **到达时的情感状态**: [What is the player feeling before they touch / [玩家在接触游戏前感受如何？
the game? They may be skeptical (purchased on impulse), curious (followed / 他们可能怀疑（冲动购买）、好奇（听从
recommendations), or expectant (been waiting for it). This state is your / 推荐），或期待（一直在等待）。这种状态是你的
starting condition — your design must meet them there.] / 起点条件——你的设计必须在这里与他们相遇。]
```

**行 65-66:**
```
**Primary question the player is asking**: [e.g., "Is this worth my time?",
"Will this be too hard?", "Do I understand what I'm supposed to do?"]
```

**行 68-73:**
```
**Key experience the game must deliver**:
[What MUST happen in these five minutes for the player to stay? Not a tutorial
beat — an emotional beat. The first contact experience should answer the player's
primary question with a confident "yes." It may be a moment of beauty, a
satisfying mechanical click, a surprising twist on a familiar genre pattern, or
an early win that feels earned.]
```

**行 75-77:**
```
**Emotional state on exit**: [What does success look like? e.g., "Curious
about the next layer", "Surprised that this feels different from similar games",
"Already thinking about a decision they made and whether it was right."]
```

**行 79-81:**
```
**Risk if this phase fails**: [What does the player do? e.g., "Refund within
the 2-hour Steam window", "Put it down and never return", "Post a negative
first impression", "Recommend it to no one."]
```

**行 85-85:**
```
### Phase 2: Orientation (5-30 minutes)
```

**行 87-88:**
```
**Emotional state on arrival**: [Player is intrigued but not yet committed.
They are forming their first mental model of what this game is.]
```

**行 90-91:**
```
**Primary question the player is asking**: [e.g., "How does this actually work?",
"What am I building toward?", "Am I going to be good at this?"]
```

**行 93-98:**
```
**Key experience the game must deliver**:
[This is the window where the player builds their foundational mental model.
Describe the one or two "aha" moments that crystallize the game's identity.
The player should feel competence growing — their predictions about the game
should start coming true. They should also catch their first glimpse of depth:
a system or interaction that hints "this goes further than I thought."]
```

**行 100-102:**
```
**Emotional state on exit**: [e.g., "Has a working model of the core loop",
"Has made at least one meaningful decision they care about the outcome of",
"Feels the skill ceiling is higher than it first appeared."]
```

**行 104-105:**
```
**Risk if this phase fails**: [e.g., "Player concludes the game is shallow",
"Player feels lost and stops trying", "Player never forms a goal."]
```

**行 109-109:**
```
### Phase 3: First Mastery (30 minutes - 2 hours)
```

**行 111-113:**
```
**Emotional state on arrival**: [Player understands the basics and is testing
the edges. They are actively trying to get better rather than just trying to
```

**行 115-116:**
```
**Primary question the player is asking**: [e.g., "What's the right strategy?",
"What's possible if I get good at this?", "What am I missing?"]
```

**行 118-125:**
```
**Key experience the game must deliver**:
[This is the phase where the player earns their first genuine skill victory —
a moment where something that was hard becomes easy through their own growth,
not through the game getting easier. It should feel like crossing a threshold.
They should also discover their first piece of emergent depth: a system
interaction, a build synergy, or a hidden mechanic that rewards curiosity.
According to Csikszentmihalyi's flow model, challenge must scale here — introduce
the first real test of the skills they've been building.]
```

**行 127-129:**
```
**Emotional state on exit**: [e.g., "Proud of a specific decision or victory",
"Has an opinion about what the 'right' way to play is (even if wrong)",
"Has questions they want to answer in their next session."]
```

**行 131-133:**
```
**Risk if this phase fails**: [e.g., "Player never reaches flow state and stops
before the game gets interesting", "Player forms wrong mental model and blames
the game when it breaks."]
```

**行 137-137:**
```
### Phase 4: Depth Discovery (2-10 hours)
```

**行 139-140:**
```
**Emotional state on arrival**: [Player has a working strategy and is starting
to see its limits. They are ready to discover that there is more.]
```

**行 142-143:**
```
**Primary question the player is asking**: [e.g., "Is there a better way?",
"What am I missing that other players know?", "How deep does this actually go?"]
```

**行 145-151:**
```
**Key experience the game must deliver**:
[This is where the game's true depth must reveal itself. Players who reach this
phase are your core audience — they have cleared the onboarding and proven their
commitment. They should discover systems, combinations, or strategies that
recontextualize everything they have done so far. The world should feel larger
than the tutorial implied. This is also the phase where Bartle's Explorers find
their reward: content and knowledge that only the curious find.
```

**行 153-155:**
```
Design note: Depth Discovery is where many indie games fail silently. Players
exhaust the visible content without ever finding the hidden depth. Audit every
layer of depth in this window and confirm it is discoverable without a guide.]
```

**行 157-159:**
```
**Emotional state on exit**: [e.g., "Has rebuilt their strategy from scratch
at least once", "Can imagine multiple viable approaches to the same problem",
"Has discovered at least one thing that surprised them."]
```

**行 161-163:**
```
**Risk if this phase fails**: [e.g., "Player concludes they have 'finished'
the game and feels mild disappointment", "Player recommends the game but says
'it's a bit short.'"]
```

**行 167-167:**
```
### Phase 5: Habitual Play (10-50 hours)
```

**行 169-171:**
```
> *Note: Not applicable to short-form games (visual novels, short narrative
> games, puzzle games with fixed content). Delete this phase if the game's
> intended experience concludes before this timeframe.*
```

**行 173-174:**
```
**Emotional state on arrival**: [Player considers themselves competent. The
game has become part of their routine. They have a playstyle identity.]
```

**行 176-177:**
```
**Primary question the player is asking**: [e.g., "What's my next goal?",
"Can I beat my previous record?", "What haven't I tried yet?"]
```

**行 179-186:**
```
**Key experience the game must deliver**:
[Habitual play requires the game to offer goals beyond the tutorial narrative.
The player generates their own challenges, pursues optional content, or begins
competing (against the game, other players, or their own records). This phase
sustains through Bartle's Achiever motivations: collection completion, mastery
benchmarks, visible milestones. It also requires natural session endings that
leave forward tension — the player should always stop with something unfinished
that they want to return to.]
```

**行 188-190:**
```
**Emotional state on exit**: [e.g., "Has a specific goal they are working toward
across multiple sessions", "Considers themselves part of a community of people
who play this game."]
```

**行 192-194:**
```
**Risk if this phase fails**: [e.g., "Player churns after completing main content
and never returns", "Game fails word-of-mouth because players don't develop
strong opinions about it."]
```

**行 198-198:**
```
### Phase 6: Long-Term Engagement (50+ hours)
```

**行 200-202:**
```
> *Note: Only applies to games designed for extended play — live service games,
> deeply systemic games, competitive games, and games with community-driven
> content. Delete this phase if it does not fit the game's design intent.*
```

**行 204-205:**
```
**Emotional state on arrival**: [Player is a veteran. The game is part of their
identity to some degree. They are invested in the community and the ecosystem.]
```

**行 207-208:**
```
**Primary question the player is asking**: [e.g., "What's new?", "Can I reach
the top?", "Can I find something no one has found before?"]
```

**行 210-216:**
```
**Key experience the game must deliver**:
[Long-term engagement is sustained by different mechanisms than initial fun:
social status, creative expression, competitive standing, or the role of expert
and guide. Design for this phase by asking what role a veteran player wants to
play in the ecosystem — not just what content they want to consume. Systems
that enable knowledge transfer (guides, community sharing, mentorship) dramatically
```

**行 218-219:**
```
**Emotional state on exit**: [e.g., "Part of a community", "Considered an
expert by newer players", "Invested in the game's ongoing development and direction."]
```

**行 221-222:**
```
**Risk if this phase fails**: [e.g., "Veteran players leave and take their
social influence with them, accelerating churn in the broader player base."]
```

**行 226-226:**
```
## Critical Moments
```

**行 228-232:**
```
> **Guidance**: These are specific, individual events — not phases — that
> must land with precision. A critical moment is a single interaction, scene,
> or beat that carries outsized emotional weight. Missing it (through bad UX,
> poor timing, or weak feedback) can derail the entire journey. Identify 8-15
> such moments across the game.
```

**行 234-241:**
```
| Moment | Phase | Emotional Target | If It Fails |
|--------|-------|-----------------|-------------|
| [The first death] | [First Contact] | [Surprise followed by understanding — "I see what I did wrong"] | [Player feels the death was unfair and loses trust in the game's fairness] |
| [The first big win] | [Orientation] | [Earned pride — "I figured that out myself"] | [Player feels the win was handed to them and undervalues it] |
| [The first system discovery] | [First Mastery] | [Delight — "I didn't know you could do that"] | [Player misses it entirely and never discovers the depth] |
| [The moment the world opens up] | [Depth Discovery] | [Awe followed by hunger — "How much more is there?"] | [Player feels underwhelmed and concludes they have seen everything] |
| [The first endgame goal] | [Habitual Play] | [Renewed purpose — "Now I have something to work toward"] | [Player completes the main content and feels finished] |
| [Add moment] | [Phase] | [Emotional target] | [Failure consequence] |
```

**行 245-245:**
```
## Retention Hooks
```

**行 247-253:**
```
> **Guidance**: Retention hooks are the specific mechanisms that pull the player
> back to the next session. They operate at different time scales. A game with
> only one hook type has a fragile retention loop. Strong games layer multiple
> hook types, so players with different motivations all have a reason to return.
> Map each hook to the systems that deliver it — if a hook has no system behind
> it, it is an aspiration, not a design.
```

**行 255-260:**
```
| Hook Type | Hook Description | Systems That Deliver It |
|-----------|-----------------|------------------------|
| **Session Start** | [What draws the player in when they launch? e.g., "Unresolved choices from last session", "World state changed while they were away", "Daily reward waiting"] | [System names, e.g., "Persistent world state, save system, daily login reward"] |
| **Session End** | [What feeling do they have as they close the game? e.g., "A goal just out of reach", "A question unanswered", "An upgrade ready to use next time"] | [e.g., "Progress bar at 90%, next-session unlock notification"] |
| **Daily Return** | [What reason exists to play today vs. skipping a day? e.g., "Daily challenge", "Time-gated resource replenishment", "Limited-time event"] | [e.g., "Daily quest system, resource regen timers, event calendar"] |
| **Long-Term** | [What provides purpose across weeks? e.g., "Season pass milestones", "Competitive ranking reset", "Community challenge goals"] | [e.g., "Ranked system, seasonal content, community events"] |
```

**行 264-264:**
```
## Player Progression Feel
```

**行 266-267:**
```
[Describe HOW the player should experience their progression — not the mechanical
system (that belongs in GDDs), but the FEELING of growing.
```

**行 269-270:**
```
Choose the primary progression feeling and describe what it should feel like in
concrete emotional terms. Examples of distinct progression feelings:
```

**行 272-283:**
```
- **Power growth**: "The player should feel increasingly dangerous. Early game
  combat should feel tense and measured; late game combat should feel effortless
  against common enemies, reserving challenge for elite encounters."
- **World expansion**: "The player's sense of the world should grow outward.
  Each new area should make the map feel larger, not just longer."
- **Story revelation**: "The player should feel like they are slowly assembling
  a picture. Early revelations should recontextualize what they have already seen."
- **Skill improvement**: "The player should feel themselves getting sharper.
  Encounters they struggled with early should feel controlled by mid-game,
  not because they got more powerful, but because their decisions improved."
- **Community status**: "The player should feel a growing sense of belonging and
  recognition within the player community as their knowledge deepens."
```

**行 285-286:**
```
Answer: what is the primary progression feeling in this game, and what does it
concretely look and feel like at the beginning, middle, and end of the journey?]
```

**行 290-290:**
```
## Anti-Patterns to Avoid
```

**行 292-295:**
```
> **Guidance**: Anti-patterns are recurring design mistakes that reliably
> break the player journey. List the ones most relevant to this specific game
> and how the design actively guards against them. Be specific — "avoid bad UX"
> is not an anti-pattern, it is a platitude.
```

**行 297-313:**
```
- **[Player feels punished for experimenting]**: [e.g., "The crafting system
  should never consume irreplaceable resources. All experiment costs must be
  recoverable within one session."]
- **[Player loses progress with no explanation]**: [e.g., "All save points are
  visible before risky encounters. Progress loss must always be preceded by a
  warning the player could have noticed."]
- **[Difficulty spike creates a wall, not a gate]**: [e.g., "When a player
  fails an encounter three times, the game surfaces a contextual hint. A wall
  stops progress; a gate requires the right key — make sure players know what
- **[Player reaches the content ceiling before the emotional arc completes]**:
  [e.g., "The game should never run out of content while the player still has
  unanswered questions about the world or their build."]
- **[Mandatory systems are introduced too late to feel meaningful]**: [e.g.,
  "Any system the player must engage with in the late game must be introduced
  in an optional or low-stakes context earlier."]
- **[Add anti-pattern specific to this game's design risks]**: [Description]
```

**行 317-317:**
```
## Validation Questions
```

**行 319-322:**
```
> **Guidance**: These are questions a playtester session facilitator asks
> during or after a session to verify the journey is working as intended.
> They are not yes/no questions — they probe the player's emotional experience
> and surface gaps between design intent and player reality.
```

**行 324-326:**
```
**First Contact (0-5 min)**
- [ ] "Without looking at any menus or tooltips, what do you think this game is about?"
- [ ] "What's the first thing you want to do next?"
```

**行 328-330:**
```
**Orientation (5-30 min)**
- [ ] "What does winning or succeeding look like to you right now?"
- [ ] "Is there anything you feel like you should understand but don't?"
```

**行 332-334:**
```
**First Mastery (30 min - 2 hrs)**
- [ ] "What's the best decision you've made so far? Why did you make it?"
- [ ] "What would you do differently if you started over?"
```

**行 336-338:**
```
**Depth Discovery (2-10 hrs)**
- [ ] "Has the game surprised you? When? How did it feel?"
- [ ] "What questions do you have about systems you haven't fully explored?"
```

**行 340-342:**
```
**Habitual Play (10-50 hrs)**
- [ ] "What's your current goal? How long have you been working toward it?"
- [ ] "Have you told anyone about this game? What did you say?"
```

**行 344-347:**
```
**General (any phase)**
- [ ] "If you had to stop playing right now, what would you be most eager to
- [ ] "Is there anything you feel the game is not letting you do that you want to do?"
```

**行 351-351:**
```
## Open Questions
```

**行 353-357:**
```
| Question | Owner | Deadline | Resolution |
|----------|-------|----------|-----------|
| [Does the Phase 1 hook work for players without prior genre experience?] | [game-designer] | [Date] | [Unresolved] |
| [Is Phase 4 depth discoverable without external guides?] | [game-designer, ux-designer] | [Date] | [Unresolved] |
| [Add question] | [Owner] | [Date] | [Resolution] |
```

**未翻译列表项:**
- 行 272: - **Power growth**: "The player should feel increasingly dangerous. Early game
- 行 275: - **World expansion**: "The player's sense of the world should grow outward.
- 行 277: - **Story revelation**: "The player should feel like they are slowly assembling
- 行 279: - **Skill improvement**: "The player should feel themselves getting sharper.
- 行 282: - **Community status**: "The player should feel a growing sense of belonging and
- 行 297: - **[Player feels punished for experimenting]**: [e.g., "The crafting system
- 行 300: - **[Player loses progress with no explanation]**: [e.g., "All save points are
- 行 303: - **[Difficulty spike creates a wall, not a gate]**: [e.g., "When a player
- 行 307: - **[Player reaches the content ceiling before the emotional arc completes]**:
- 行 310: - **[Mandatory systems are introduced too late to feel meaningful]**: [e.g.,
- 行 313: - **[Add anti-pattern specific to this game's design risks]**: [Description]
- 行 325: - [ ] "Without looking at any menus or tooltips, what do you think this game is about?"
- 行 326: - [ ] "What's the first thing you want to do next?"
- 行 329: - [ ] "What does winning or succeeding look like to you right now?"
- 行 330: - [ ] "Is there anything you feel like you should understand but don't?"
- 行 333: - [ ] "What's the best decision you've made so far? Why did you make it?"
- 行 334: - [ ] "What would you do differently if you started over?"
- 行 337: - [ ] "Has the game surprised you? When? How did it feel?"
- 行 338: - [ ] "What questions do you have about systems you haven't fully explored?"
- 行 341: - [ ] "What's your current goal? How long have you been working toward it?"
- 行 342: - [ ] "Have you told anyone about this game? What did you say?"
- 行 345: - [ ] "If you had to stop playing right now, what would you be most eager to
- 行 347: - [ ] "Is there anything you feel the game is not letting you do that you want to do?"

--------------------------------------------------------------------------------

### .codebuddy\docs\templates\game-pillars.md
- 未翻译段落数: 64
- 未翻译列表项数: 20

**未翻译段落:**

**行 13-15:**
```
Pillars are the 3-5 non-negotiable principles that define this game's identity. / 支柱是定义游戏身份的3-5个不可协商的原则。
Every design, art, audio, narrative, and technical decision must serve at least / 每一个设计、美术、音频、叙事和技术决策必须至少服务于
one pillar. If a feature doesn't serve a pillar, it doesn't belong in the game. / 一个支柱。如果一个功能不服务于任何支柱，它就不属于这个游戏。
```

**行 24-24:**
```
A good pillar is: / 一个好的支柱应该：
```

**行 26-26:**
```
  aggression" is — it makes a testable claim about design choices. / 攻击性"才是——它提出了关于设计选择的可测试主张。
```

**行 28-28:**
```
  too vague. Good pillars eliminate options. / 那就太模糊了。好的支柱会消除选项。
```

**行 30-31:**
```
  nothing about art, audio, or narrative is incomplete. Real pillars shape / 对美术、音频或叙事没有任何约束的支柱是不完整的。真正的支柱
  every discipline. / 塑造每一个学科。
```

**行 33-33:**
```
  If they can't, the pillars are too numerous or too complex. / 如果不能，支柱就太多或太复杂了。
```

**行 35-35:**
```
### Real AAA Examples
```

**行 37-38:**
```
These studios publicly shared their game pillars, showing how concrete and / 这些工作室公开分享了他们的游戏支柱，展示了有效支柱如何
specific effective pillars can be: / 具体而明确：
```

**行 41-47:**
```
| ---- | ---- | ---- |
| **God of War (2018)** | Visceral combat; Father-son emotional journey; Continuous camera (no cuts); Norse mythology reimagined | "Continuous camera" is radical — it cut a standard cinematic tool. "Father-son journey" constrains narrative, level design, AND combat (Atreus as companion). |
| **Hades** | Fast fluid combat; Story depth through repetition; Every run teaches something new | "Story through repetition" justified the roguelike structure narratively — death IS the story. "Every run teaches" constrains level and encounter design. |
| **The Last of Us** | Story is essential, not optional; AI partners build relationships; Stealth is always an option | "AI partners build relationships" drove massive investment in companion AI — not just pathfinding, but emotional presence. |
| **Celeste** | Tough but fair; Accessibility without compromise; Story and mechanics are the same thing | "Story and mechanics are the same thing" — climbing IS the struggle, the dash IS the anxiety. Pillar prevented mechanics from being "just gameplay." |
| **Hollow Knight** | Atmosphere over explanation; Earned mastery; World tells its own story | "Atmosphere over explanation" — no tutorials, no hand-holding, the world teaches through environmental design. |
| **Dead Cells** | Every weapon is viable; Combat is a dance; Permanent death creates meaning | "Every weapon is viable" is extremely constraining — it demands constant balance work across hundreds of items. |
```

**行 72-72:**
```
| ---- | ---- | ---- |
```

**行 79-79:**
```
**Aesthetics reference** (Hunicke, LeBlanc, Zubek): / **美学参考** (Hunicke, LeBlanc, Zubek):
```

**行 95-97:**
```
**One-Sentence Definition**: [A clear, falsifiable statement of what this pillar / **一句话定义**: [关于这个支柱含义的清晰、可证伪的陈述。
means. Must be specific enough that two people would reach the same conclusion / 必须足够具体，以至于两个人在将其应用于设计问题时
when applying it to a design question.] / 会得出相同的结论。]
```

**行 102-103:**
```
**Design Test**: [A concrete decision this pillar resolves. "If we're debating / **设计测试**: [该支柱解决的具体决策。"如果我们正在争论
between X and Y, this pillar says we choose __."] / X和Y，这个支柱说我们选择__。"]
```

**行 108-108:**
```
| ---- | ---- | ---- |
```

**行 125-125:**
```
### Pillar 2: [Name]
```

**行 127-127:**
```
**One-Sentence Definition**: [Specific, falsifiable statement]
```

**行 129-129:**
```
**Target Aesthetics Served**: [MDA aesthetics]
```

**行 131-131:**
```
**Design Test**: [Concrete decision it resolves]
```

**行 133-133:**
```
#### What This Means for Each Department
```

**行 135-141:**
```
| Department | This Pillar Says... | Example |
| ---- | ---- | ---- |
| **Game Design** | [Constraint/inspiration] | [Example] |
| **Art** | [Constraint/inspiration] | [Example] |
| **Audio** | [Constraint/inspiration] | [Example] |
| **Narrative** | [Constraint/inspiration] | [Example] |
| **Engineering** | [Constraint/inspiration] | [Example] |
```

**行 143-143:**
```
#### Serving This Pillar
```

**行 144-145:**
```
- [Example]
- [Example]
```

**行 147-147:**
```
#### Violating This Pillar
```

**行 148-149:**
```
- [Example]
- [Example]
```

**行 153-153:**
```
### Pillar 3: [Name]
```

**行 155-155:**
```
**One-Sentence Definition**: [Specific, falsifiable statement]
```

**行 157-157:**
```
**Target Aesthetics Served**: [MDA aesthetics]
```

**行 159-159:**
```
**Design Test**: [Concrete decision it resolves]
```

**行 161-161:**
```
#### What This Means for Each Department
```

**行 163-169:**
```
| Department | This Pillar Says... | Example |
| ---- | ---- | ---- |
| **Game Design** | [Constraint/inspiration] | [Example] |
| **Art** | [Constraint/inspiration] | [Example] |
| **Audio** | [Constraint/inspiration] | [Example] |
| **Narrative** | [Constraint/inspiration] | [Example] |
| **Engineering** | [Constraint/inspiration] | [Example] |
```

**行 171-171:**
```
#### Serving This Pillar
```

**行 172-173:**
```
- [Example]
- [Example]
```

**行 175-175:**
```
#### Violating This Pillar
```

**行 176-177:**
```
- [Example]
- [Example]
```

**行 181-181:**
```
### Pillar 4: [Name] (Optional)
```

**行 183-183:**
```
[Same structure as Pillars 1-3]
```

**行 185-185:**
```
### Pillar 5: [Name] (Optional)
```

**行 187-187:**
```
[Same structure as Pillars 1-3]
```

**行 191-191:**
```
## Anti-Pillars (What This Game Is NOT)
```

**行 193-194:**
```
Anti-pillars are equally important as pillars — they prevent scope creep and
keep the vision focused. Every "no" protects the "yes."
```

**行 196-198:**
```
Great anti-pillars are things the team might actually want to do. "NOT a racing
game" is obvious and useless. "NOT an open-world game" is useful if the genre
could plausibly support it.
```

**行 200-203:**
```
- **NOT [thing]**: [Why this is explicitly excluded, what pillar it would
  compromise, and what it would cost in development focus]
- **NOT [thing]**: [Why excluded]
- **NOT [thing]**: [Why excluded]
```

**行 207-207:**
```
## Pillar Conflict Resolution
```

**行 209-210:**
```
When two pillars conflict (and they will), use this priority order. The ranking
reflects which aspects of the experience are most essential to the core fantasy.
```

**行 212-216:**
```
| Priority | Pillar | Rationale |
| ---- | ---- | ---- |
| 1 | [Highest priority pillar] | [Why this wins when it conflicts with others] |
| 2 | [Second priority] | [Why] |
| 3 | [Third priority] | [Why] |
```

**行 218-226:**
```
**Resolution Process**:
1. Identify which pillars are in tension
2. Consult the priority ranking above
3. If the lower-priority pillar can be served partially without compromising the
   higher-priority one, do so
4. If not, the higher-priority pillar wins
5. Document the decision and rationale in the relevant design document
6. If the conflict is fundamental (two pillars are irreconcilable), escalate to
   the creative-director to consider revising the pillars themselves
```

**行 230-230:**
```
## Player Motivation Alignment
```

**行 232-234:**
```
[Verify that the pillars collectively serve the target player's psychological needs.
Based on Self-Determination Theory (Deci & Ryan) and the Player Experience of
Need Satisfaction model.]
```

**行 236-240:**
```
| Need | Which Pillar Serves It | How |
| ---- | ---- | ---- |
| **Autonomy** (meaningful choice, player agency) | [Pillar name] | [How this pillar creates autonomy] |
| **Competence** (mastery, skill growth, clear feedback) | [Pillar name] | [How this pillar creates competence] |
| **Relatedness** (connection, belonging, emotional bond) | [Pillar name] | [How this pillar creates relatedness] |
```

**行 242-244:**
```
**Gap check**: If any of the three needs is not served by at least one pillar,
consider whether the pillar set is complete. A game that satisfies all three
SDT needs has the strongest foundation for sustained engagement.
```

**行 248-248:**
```
## Emotional Arc
```

**行 250-251:**
```
[Map the intended emotional journey of a play session. This should be a
deliberate design, not an accident.]
```

**行 253-253:**
```
### Session Emotional Arc
```

**行 255-261:**
```
| Phase | Duration | Target Emotion | Pillar(s) Driving It | Mechanics Delivering It |
| ---- | ---- | ---- | ---- | ---- |
| Opening | [e.g., 0-5 min] | [e.g., Curiosity, anticipation] | [Which pillar] | [What the player does] |
| Rising | [e.g., 5-20 min] | [e.g., Tension, focus, flow] | [Which pillar] | [What the player does] |
| Climax | [e.g., 20-30 min] | [e.g., Triumph, relief, awe] | [Which pillar] | [What the player does] |
| Resolution | [e.g., 30-40 min] | [e.g., Satisfaction, reflection] | [Which pillar] | [What the player does] |
| Hook | [End of session] | [e.g., Curiosity, unfinished business] | [Which pillar] | [What makes them return] |
```

**行 263-263:**
```
### Long-Term Emotional Progression
```

**行 265-266:**
```
[How does the emotional experience evolve across the full game? Early game vs
mid game vs late game vs endgame should each feel distinct.]
```

**行 270-270:**
```
## Reference Games
```

**行 272-276:**
```
| Reference | What We Take From It | What We Do Differently | Which Pillar It Validates |
| ---- | ---- | ---- | ---- |
| [Game 1] | [Specific mechanic, feeling, or approach] | [Our twist] | [Pillar name] |
| [Game 2] | [What we learn] | [Our twist] | [Pillar name] |
| [Game 3] | [What we learn] | [Our twist] | [Pillar name] |
```

**行 278-279:**
```
**Non-game inspirations**: [Films, books, music, art, real-world experiences
that inform the tone, world, or feel. Great games pull from outside the medium.]
```

**行 283-283:**
```
## Pillar Validation Checklist
```

**行 285-285:**
```
Before finalizing the pillars, verify:
```

**行 287-297:**
```
- [ ] **Count**: 3-5 pillars (no more, no fewer)
- [ ] **Falsifiable**: Each pillar makes a claim that could be wrong
- [ ] **Constraining**: Each pillar forces saying "no" to some plausible ideas
- [ ] **Cross-departmental**: Each pillar has implications for design, art, audio, narrative, AND engineering
- [ ] **Design-tested**: Each pillar has a concrete design test that resolves a real decision
- [ ] **Anti-pillars defined**: At least 3 explicit "this game is NOT" statements
- [ ] **Priority-ranked**: Clear order for resolving conflicts between pillars
- [ ] **MDA-aligned**: Pillars collectively deliver the top-ranked target aesthetics
- [ ] **SDT coverage**: At least one pillar serves Autonomy, one Competence, one Relatedness
- [ ] **Memorable**: The team can recite all pillars from memory
- [ ] **Core fantasy served**: Every pillar traces back to the core fantasy promise
```

**行 303-307:**
```
- [ ] Get pillar approval from creative-director
- [ ] Distribute to all department leads for sign-off
- [ ] Create design tests for each pillar using real upcoming decisions
- [ ] Schedule first pillar review (after 2 weeks of development)
- [ ] Add pillars to the game-concept document and pitch document
```

**行 311-313:**
```
*This document is the creative north star. It lives in `design/gdd/game-pillars.md`
and is referenced by every design, art, audio, and narrative document in the project.
Review quarterly or after major milestone pivots.*
```

**未翻译列表项:**
- 行 200: - **NOT [thing]**: [Why this is explicitly excluded, what pillar it would
- 行 202: - **NOT [thing]**: [Why excluded]
- 行 203: - **NOT [thing]**: [Why excluded]
- 行 219: 1. Identify which pillars are in tension
- 行 287: - [ ] **Count**: 3-5 pillars (no more, no fewer)
- 行 288: - [ ] **Falsifiable**: Each pillar makes a claim that could be wrong
- 行 289: - [ ] **Constraining**: Each pillar forces saying "no" to some plausible ideas
- 行 290: - [ ] **Cross-departmental**: Each pillar has implications for design, art, audio, narrative, AND engineering
- 行 291: - [ ] **Design-tested**: Each pillar has a concrete design test that resolves a real decision
- 行 292: - [ ] **Anti-pillars defined**: At least 3 explicit "this game is NOT" statements
- 行 293: - [ ] **Priority-ranked**: Clear order for resolving conflicts between pillars
- 行 294: - [ ] **MDA-aligned**: Pillars collectively deliver the top-ranked target aesthetics
- 行 295: - [ ] **SDT coverage**: At least one pillar serves Autonomy, one Competence, one Relatedness
- 行 296: - [ ] **Memorable**: The team can recite all pillars from memory
- 行 297: - [ ] **Core fantasy served**: Every pillar traces back to the core fantasy promise
- 行 303: - [ ] Get pillar approval from creative-director
- 行 304: - [ ] Distribute to all department leads for sign-off
- 行 305: - [ ] Create design tests for each pillar using real upcoming decisions
- 行 306: - [ ] Schedule first pillar review (after 2 weeks of development)
- 行 307: - [ ] Add pillars to the game-concept document and pitch document

--------------------------------------------------------------------------------

### .codebuddy\docs\templates\game-design-document.md
- 未翻译段落数: 55
- 未翻译列表项数: 14

**未翻译段落:**

**行 15-15:**
```
> **Quick reference** — Layer: `[Foundation | Core | Feature | Presentation]` · Priority: `[MVP | Vertical Slice | Alpha | Full Vision]` · Key deps: `[System names or "None"]` / > **快速参考** — 层级: `[基础 | 核心 | 功能 | 表现]` · 优先级: `[MVP | 垂直切片 | Alpha | 完整愿景]` · 关键依赖: `[系统名称或"无"]`
```

**行 19-20:**
```
[One paragraph that explains this mechanic to someone who knows nothing about / [一段话，向对该项目一无所知的人解释这个机制。它是什么，
the project. What is it, what does the player做什么，以及它为什么存在？] / 玩家做什么，以及它为什么存在？]
```

**行 24-26:**
```
[What should the player FEEL when engaging with this mechanic? What is the / [玩家参与这个机制时应该感受到什么？正在提供的是什么样的
emotional or power fantasy being served? This section guides all detail / 情感或力量幻想？此部分指导下面所有的细节决策。]
```

**行 28-28:**
```
## Detailed Design
```

**行 32-34:**
```
[Precise, unambiguous rules. A programmer should be able to implement this
section without asking questions. Use numbered rules for sequential processes
and bullet points for properties.]
```

**行 36-36:**
```
### States and Transitions
```

**行 38-39:**
```
[If this system has states (e.g., weapon states, status effects, phases),
document every state and every valid transition between states.]
```

**行 41-42:**
```
| State | Entry Condition | Exit Condition | Behavior |
|-------|----------------|----------------|----------|
```

**行 44-44:**
```
### Interactions with Other Systems
```

**行 46-48:**
```
[How does this system interact with combat? Inventory? Progression? UI?
For each interaction, specify the interface: what data flows in, what flows
out, and who is responsible for what.]
```

**行 52-52:**
```
[Every mathematical formula used by this system. For each formula:]
```

**行 54-54:**
```
### [Formula Name]
```

**行 60-64:**
```
| Variable | Type | Range | Source | Description |
|----------|------|-------|--------|-------------|
| base_value | float | 1-100 | data file | The base amount before modifiers |
| modifier_sum | float | -0.9 to 5.0 | calculated | Sum of all active modifiers |
| scaling_factor | float | 0.5-2.0 | data file | Level-based scaling |
```

**行 66-67:**
```
**Expected output range**: [min] to [max]
**Edge case**: When modifier_sum < -0.9, clamp to -0.9 to prevent negative results.
```

**行 71-72:**
```
[Explicitly document what happens in unusual situations. Each edge case
should have a clear resolution.]
```

**行 74-77:**
```
| Scenario | Expected Behavior | Rationale |
|----------|------------------|-----------|
| [What if X is zero?] | [This happens] | [Because of this reason] |
| [What if both effects trigger?] | [Priority rule] | [Design reasoning] |
```

**行 81-81:**
```
[List every system this mechanic depends on or that depends on this mechanic.]
```

**行 83-86:**
```
| System | Direction | Nature of Dependency |
|--------|-----------|---------------------|
| [Combat] | This depends on Combat | Needs damage calculation results |
| [Inventory] | Inventory depends on this | Provides item effect data |
```

**行 90-91:**
```
[Every value that should be adjustable for balancing. Include the current
value, the safe range, and what happens at the extremes.]
```

**行 93-94:**
```
| Parameter | Current Value | Safe Range | Effect of Increase | Effect of Decrease |
|-----------|--------------|------------|-------------------|-------------------|
```

**行 96-96:**
```
## Visual/Audio Requirements
```

**行 98-98:**
```
[What visual and audio feedback does this mechanic need?]
```

**行 100-101:**
```
| Event | Visual Feedback | Audio Feedback | Priority |
|-------|----------------|---------------|----------|
```

**行 105-112:**
```
> **Why this section exists separately from Visual/Audio Requirements**: Visual/Audio
> Requirements document WHAT feedback events occur (tables of events mapped to assets).
> Game Feel documents HOW the mechanic feels to operate — the responsiveness, weight,
> snap, and kinesthetic quality of the interaction. These are design targets for timing,
> frame data, and physical sensation of control. Game feel must be specified at design
> time because it drives animation budgets, input handling architecture, and hitbox
> timing. Retrofitting feel targets after implementation is expensive and often requires
> fundamental rework.
```

**行 114-114:**
```
### Feel Reference
```

**行 116-118:**
```
[Name a specific game, mechanic, or moment that captures the target feel. Be precise —
cite the exact mechanic, not just the game. Explain what quality you are borrowing.
Optionally include an anti-reference (what this should NOT feel like).]
```

**行 120-121:**
```
> Example: "Should feel like Dark Souls weapon swings — weighty, committed, and
> telegraphed, but satisfying on contact. NOT floaty like early Halo melee."
```

**行 123-123:**
```
### Input Responsiveness
```

**行 125-125:**
```
[Maximum acceptable latency from player input to visible/audible response, per action.]
```

**行 127-130:**
```
| Action | Max Input-to-Response Latency (ms) | Frame Budget (at 60fps) | Notes |
|--------|-----------------------------------|------------------------|-------|
| [Primary action] | [e.g., 50ms] | [e.g., 3 frames] | |
| [Secondary action] | | | |
```

**行 132-132:**
```
### Animation Feel Targets
```

**行 134-136:**
```
[Frame data targets for each animation in this mechanic. Startup = windup before the
action has any effect. Active = frames when the action is "happening" (hitbox live,
ability firing, etc.). Recovery = committed/vulnerable frames after the action resolves.]
```

**行 138-141:**
```
| Animation | Startup Frames | Active Frames | Recovery Frames | Feel Goal | Notes |
|-----------|---------------|--------------|----------------|-----------|-------|
| [e.g., Light attack] | | | | [e.g., Snappy, low commitment] | |
| [e.g., Heavy attack] | | | | [e.g., Weighty, high commitment] | |
```

**行 143-143:**
```
### Impact Moments
```

**行 145-146:**
```
[Defines the punctuation of the mechanic — the moments of peak feedback intensity that
make actions feel consequential. Every high-stakes event should have at least one entry.]
```

**行 148-154:**
```
| Impact Type | Duration (ms) | Effect Description | Configurable? |
|-------------|--------------|-------------------|---------------|
| Hit-stop (freeze frames) | [e.g., 80ms] | [Freeze both objects on contact] | Yes |
| Screen shake | [e.g., 150ms] | [Directional, decaying] | Yes |
| Camera impact | | | |
| Controller rumble | | | |
| Time-scale slowdown | | | |
```

**行 156-156:**
```
### Weight and Responsiveness Profile
```

**行 158-158:**
```
[A short prose description of the overall feel target. Answer the following:]
```

**行 160-167:**
```
- **Weight**: Does this feel heavy and deliberate, or light and reactive?
- **Player control**: How much does the player feel in control at every moment?
  (High control = can course-correct mid-action; Low control = committed, momentum-based)
- **Snap quality**: Does this feel crisp and binary, or smooth and analog?
- **Acceleration model**: Does movement/action start instantly (arcade feel) or
  ramp up from zero (simulation feel)? Same question for deceleration.
- **Failure texture**: When the player makes an error, does the mechanic feel fair
  or punishing? What is the read on WHY they failed?
```

**行 169-169:**
```
### Feel Acceptance Criteria
```

**行 171-172:**
```
[Specific, testable criteria a playtester can verify without measurement instruments.
These are subjective targets stated precisely enough to get consistent verdicts.]
```

**行 174-177:**
```
- [ ] [e.g., "Combat feels impactful — playtesters comment on weight unprompted"]
- [ ] [e.g., "No reviewer uses the words 'floaty', 'slippery', or 'unresponsive'"]
- [ ] [e.g., "Input latency is imperceptible at target 60fps framerate"]
- [ ] [e.g., "Hit-stop reads as satisfying, not as lag or stutter"]
```

**行 179-179:**
```
## UI Requirements
```

**行 181-181:**
```
[What information needs to be displayed to the player and when?]
```

**行 183-184:**
```
| Information | Display Location | Update Frequency | Condition |
|-------------|-----------------|-----------------|-----------|
```

**行 186-186:**
```
## Cross-References
```

**行 188-191:**
```
[Declare every explicit dependency on another GDD's specific mechanic, value, or
rule. This table is machine-checked by `/review-all-gdds` Phase 2c — it replaces
implicit prose references with verifiable declarations. If you reference another
system's behaviour anywhere in this document, it must appear here.]
```

**行 193-197:**
```
| This Document References | Target GDD | Specific Element Referenced | Nature |
|--------------------------|-----------|----------------------------|--------|
| [e.g., "combo multiplier feeds score"] | `design/gdd/score.md` | `combo_multiplier` output value | Data dependency |
| [e.g., "death triggers respawn"] | `design/gdd/respawn.md` | Death state transition | State trigger |
| [e.g., "stamina gates dodge"] | `design/gdd/stamina.md` | Stamina depletion rule | Rule dependency |
```

**行 199-202:**
```
> **Note on "Nature"**: use one of — `Data dependency` (we consume their output),
> `State trigger` (their state change triggers our behaviour), `Rule dependency`
> (our rule assumes their rule is also true), `Ownership handoff` (we hand off
> ownership of a value to them).
```

**行 204-204:**
```
## Acceptance Criteria
```

**行 206-206:**
```
[Testable criteria that confirm this mechanic is working as designed.]
```

**行 208-212:**
```
- [ ] [Criterion 1: specific, measurable, testable]
- [ ] [Criterion 2]
- [ ] [Criterion 3]
- [ ] Performance: System update completes within [X]ms
- [ ] No hardcoded values in implementation
```

**行 214-214:**
```
## Open Questions
```

**行 216-216:**
```
[Anything not yet decided. Each question should have an owner and deadline.]
```

**行 218-219:**
```
| Question | Owner | Deadline | Resolution |
|----------|-------|----------|-----------|
```

**未翻译列表项:**
- 行 160: - **Weight**: Does this feel heavy and deliberate, or light and reactive?
- 行 161: - **Player control**: How much does the player feel in control at every moment?
- 行 163: - **Snap quality**: Does this feel crisp and binary, or smooth and analog?
- 行 164: - **Acceleration model**: Does movement/action start instantly (arcade feel) or
- 行 166: - **Failure texture**: When the player makes an error, does the mechanic feel fair
- 行 174: - [ ] [e.g., "Combat feels impactful — playtesters comment on weight unprompted"]
- 行 175: - [ ] [e.g., "No reviewer uses the words 'floaty', 'slippery', or 'unresponsive'"]
- 行 176: - [ ] [e.g., "Input latency is imperceptible at target 60fps framerate"]
- 行 177: - [ ] [e.g., "Hit-stop reads as satisfying, not as lag or stutter"]
- 行 208: - [ ] [Criterion 1: specific, measurable, testable]
- 行 209: - [ ] [Criterion 2]
- 行 210: - [ ] [Criterion 3]
- 行 211: - [ ] Performance: System update completes within [X]ms
- 行 212: - [ ] No hardcoded values in implementation

--------------------------------------------------------------------------------

### .codebuddy\docs\templates\architecture-decision-record.md
- 未翻译段落数: 42
- 未翻译列表项数: 22

**未翻译段落:**

**行 5-5:**
```
[Proposed | Accepted | Deprecated | Superseded by ADR-XXXX] / [提议 | 已接受 | 已弃用 | 被ADR-XXXX取代]
```

**行 9-9:**
```
[YYYY-MM-DD — when this ADR was written] / [YYYY-MM-DD — 当此ADR被编写时]
```

**行 13-15:**
```
[YYYY-MM-DD — when this ADR was last confirmed accurate against the current / [YYYY-MM-DD — 当此ADR最后被确认与当前引擎版本和设计一致时。
engine version and design. Update this date when you re-read and confirm it / 当您重新阅读并确认它仍然正确时，请更新此日期，
is still correct, even if nothing changed.] / 即使没有任何变化。]
```

**行 19-19:**
```
[Who was involved in this decision] / [谁参与了此决策]
```

**行 35-37:**
```
| **References Consulted** | [e.g. `docs/engine-reference/godot/modules/physics.md`, `breaking-changes.md`] |
| **Post-Cutoff APIs Used** | [Specific APIs from post-cutoff engine versions this decision depends on, or "None"] |
| **Verification Required** | [Concrete behaviours to test against the target engine version before shipping, or "None"] |
```

**行 42-42:**
```
## ADR Dependencies
```

**行 46-49:**
```
| **Depends On** | [ADR-NNNN (must be Accepted before this can be implemented), or "None"] |
| **Enables** | [ADR-NNNN (this ADR unlocks that decision), or "None"] |
| **Blocks** | [Epic/Story name — cannot start until this ADR is Accepted, or "None"] |
| **Ordering Note** | [Any sequencing constraint that isn't captured above] |
```

**行 53-53:**
```
### Problem Statement
```

**行 55-56:**
```
[What problem are we solving? Why must this decision be made now? What is the
cost of not deciding?]
```

**行 58-58:**
```
### Current State
```

**行 60-60:**
```
[How does the system work today? What is wrong with the current approach?]
```

**行 64-67:**
```
- [Technical constraints -- engine limitations, platform requirements]
- [Timeline constraints -- deadline pressures, dependencies]
- [Resource constraints -- team size, expertise available]
- [Compatibility requirements -- must work with existing systems]
```

**行 69-69:**
```
### Requirements
```

**行 71-74:**
```
- [Functional requirement 1]
- [Functional requirement 2]
- [Performance requirement -- specific, measurable]
- [Scalability requirement]
```

**行 78-79:**
```
[The specific technical decision, described in enough detail for someone to
implement it without further clarification.]
```

**行 81-81:**
```
### Architecture
```

**行 88-88:**
```
### Key Interfaces
```

**行 95-95:**
```
### Implementation Guidelines
```

**行 97-97:**
```
[Specific guidance for the programmer implementing this decision.]
```

**行 99-99:**
```
## Alternatives Considered
```

**行 101-101:**
```
### Alternative 1: [Name]
```

**行 103-107:**
```
- **Description**: [How this approach would work]
- **Pros**: [What is good about this approach]
- **Cons**: [What is bad about this approach]
- **Estimated Effort**: [Relative effort compared to chosen approach]
- **Rejection Reason**: [Why this was not chosen]
```

**行 109-109:**
```
### Alternative 2: [Name]
```

**行 111-111:**
```
[Same structure as above]
```

**行 117-117:**
```
- [Good outcomes of this decision]
```

**行 121-121:**
```
- [Trade-offs and costs we are accepting]
```

**行 125-125:**
```
- [Changes that are neither good nor bad, just different]
```

**行 129-130:**
```
| Risk | Probability | Impact | Mitigation |
|------|------------|--------|-----------|
```

**行 132-132:**
```
## Performance Implications
```

**行 134-139:**
```
| Metric | Before | Expected After | Budget |
|--------|--------|---------------|--------|
| CPU (frame time) | [X]ms | [Y]ms | [Z]ms |
| Memory | [X]MB | [Y]MB | [Z]MB |
| Load Time | [X]s | [Y]s | [Z]s |
| Network (if applicable) | [X]KB/s | [Y]KB/s | [Z]KB/s |
```

**行 141-141:**
```
## Migration Plan
```

**行 143-143:**
```
[If this changes existing systems, the step-by-step plan to migrate.]
```

**行 145-147:**
```
1. [Step 1 -- what changes, what breaks, how to verify]
```

**行 149-149:**
```
**Rollback plan**: [How to revert if this decision proves wrong]
```

**行 151-151:**
```
## Validation Criteria
```

**行 153-153:**
```
[How we will know this decision was correct after implementation.]
```

**行 155-157:**
```
- [ ] [Measurable criterion 1]
- [ ] [Measurable criterion 2]
- [ ] [Performance criterion]
```

**行 159-159:**
```
## GDD Requirements Addressed
```

**行 161-163:**
```
<!-- This section is MANDATORY. Every ADR must trace back to at least one GDD
     requirement, or explicitly state it is a foundational decision with no GDD
     dependency. Traceability is audited by /architecture-review. -->
```

**行 165-167:**
```
| GDD Document | System | Requirement | How This ADR Satisfies It |
|-------------|--------|-------------|--------------------------|
| [e.g. `design/gdd/combat.md`] | [e.g. Combat] | [e.g. "Hitbox detection must resolve within 1 frame"] | [e.g. "Jolt physics collision queries run synchronously in _physics_process"] |
```

**行 169-171:**
```
> If this is a foundational decision with no direct GDD dependency, write:
> "Foundational — no GDD requirement. Enables: [list what GDD systems this
> decision unlocks or constrains]"
```

**行 175-176:**
```
- [Link to related ADRs — note if supersedes, contradicts, or depends on]
- [Link to relevant code files once implemented]
```

**未翻译列表项:**
- 行 64: - [Technical constraints -- engine limitations, platform requirements]
- 行 65: - [Timeline constraints -- deadline pressures, dependencies]
- 行 66: - [Resource constraints -- team size, expertise available]
- 行 67: - [Compatibility requirements -- must work with existing systems]
- 行 71: - [Functional requirement 1]
- 行 72: - [Functional requirement 2]
- 行 73: - [Performance requirement -- specific, measurable]
- 行 74: - [Scalability requirement]
- 行 103: - **Description**: [How this approach would work]
- 行 104: - **Pros**: [What is good about this approach]
- 行 105: - **Cons**: [What is bad about this approach]
- 行 106: - **Estimated Effort**: [Relative effort compared to chosen approach]
- 行 107: - **Rejection Reason**: [Why this was not chosen]
- 行 117: - [Good outcomes of this decision]
- 行 121: - [Trade-offs and costs we are accepting]
- 行 125: - [Changes that are neither good nor bad, just different]
- 行 145: 1. [Step 1 -- what changes, what breaks, how to verify]
- 行 155: - [ ] [Measurable criterion 1]
- 行 156: - [ ] [Measurable criterion 2]
- 行 157: - [ ] [Performance criterion]
- 行 175: - [Link to related ADRs — note if supersedes, contradicts, or depends on]
- 行 176: - [Link to relevant code files once implemented]

--------------------------------------------------------------------------------

### .codebuddy\docs\quick-start.md
- 未翻译段落数: 13
- 未翻译列表项数: 50

**未翻译段落:**

**行 24-27:**
```
- **Tier 1 (DeepSeek-V3.2/GLM-5.1)**: Directors who make high-level decisions
  - `creative-director` -- vision and creative conflict resolution
  - `technical-director` -- architecture and technology decisions
  - `producer` -- scheduling, coordination, and risk management
```

**行 30-32:**
```
> - `creative-director` -- 愿景和创意冲突解决
> - `technical-director` -- 架构和技术决策
> - `producer` -- 排期、协调和风险管理
```

**行 39-40:**
```
> - `game-designer`、`lead-programmer`、`art-director`、`audio-director`、
>   `narrative-director`、`qa-lead`、`release-manager`、`localization-lead`
```

**行 43-43:**
```
  - Designers, programmers, artists, writers, testers, engineers
```

**行 46-46:**
```
> - 设计师、程序员、美术师、作家、测试员、工程师
```

**行 134-201:**
```
| Command | What it does |
|---------|-------------|
| `/start` | First-time onboarding — asks where you are, guides you to the right workflow |
| `/help` | Context-aware "what do I do next?" — reads your current phase and artifacts |
| `/project-stage-detect` | Analyze project state, detect stage, identify gaps |
| `/setup-engine` | Configure engine + version, populate reference docs |
| `/adopt` | Brownfield audit and migration plan for existing projects |
| `/brainstorm` | Guided game concept ideation from scratch |
| `/map-systems` | Decompose concept into systems, map dependencies, guide per-system GDDs |
| `/design-system` | Guided, section-by-section GDD authoring for a single game system |
| `/quick-design` | Lightweight spec for small changes — tuning, tweaks, minor additions |
| `/review-all-gdds` | Cross-GDD consistency and game design theory review |
| `/propagate-design-change` | Find ADRs and stories affected by a GDD change |
| `/ux-design` | Author UX specs (screen/flow, HUD, interaction patterns) |
| `/ux-review` | Validate UX specs for accessibility and GDD alignment |
| `/create-architecture` | Master architecture document for the game |
| `/architecture-decision` | Creates an ADR |
| `/architecture-review` | Validate all ADRs, dependency ordering, GDD traceability |
| `/create-control-manifest` | Flat programmer rules sheet from Accepted ADRs |
| `/create-epics` | Translate GDDs + ADRs into epics (one per architectural module) |
| `/create-stories` | Break a single epic into implementable story files |
| `/dev-story` | Read a story and implement it — routes to the correct programmer agent |
| `/sprint-plan` | Creates or updates sprint plans |
| `/sprint-status` | Quick 30-line sprint snapshot |
| `/story-readiness` | Validate a story is implementation-ready before pickup |
| `/story-done` | End-of-story completion review — verifies acceptance criteria |
| `/estimate` | Produces structured effort estimates |
| `/design-review` | Reviews a design document |
| `/code-review` | Reviews code for quality and architecture |
| `/balance-check` | Analyzes game balance data |
| `/asset-audit` | Audits assets for compliance |
| `/content-audit` | GDD-specified content vs. implemented — find gaps |
| `/scope-check` | Detect scope creep against plan |
| `/perf-profile` | Performance profiling and bottleneck ID |
| `/tech-debt` | Scan, track, and prioritize tech debt |
| `/gate-check` | Validate phase readiness (PASS/CONCERNS/FAIL) |
| `/consistency-check` | Scan all GDDs for cross-document inconsistencies (conflicting stats, names, rules) |
| `/reverse-document` | Generate design/architecture docs from existing code |
| `/milestone-review` | Reviews milestone progress |
| `/retrospective` | Runs sprint/milestone retrospective |
| `/bug-report` | Structured bug report creation |
| `/playtest-report` | Creates or analyzes playtest feedback |
| `/onboard` | Generates onboarding docs for a role |
| `/release-checklist` | Validates pre-release checklist |
| `/launch-checklist` | Complete launch readiness validation |
| `/changelog` | Generates changelog from git history |
| `/patch-notes` | Generate player-facing patch notes |
| `/hotfix` | Emergency fix with audit trail |
| `/prototype` | Scaffolds a throwaway prototype |
| `/localize` | Localization scan, extract, validate |
| `/team-combat` | Orchestrate full combat team pipeline |
| `/team-narrative` | Orchestrate full narrative team pipeline |
| `/team-ui` | Orchestrate full UI team pipeline |
| `/team-release` | Orchestrate full release team pipeline |
| `/team-polish` | Orchestrate full polish team pipeline |
| `/team-audio` | Orchestrate full audio team pipeline |
| `/team-level` | Orchestrate full level creation pipeline |
| `/team-live-ops` | Orchestrate live-ops team for seasons, events, and post-launch content |
| `/team-qa` | Orchestrate full QA team cycle — test plan, test cases, smoke check, sign-off |
| `/qa-plan` | Generate a QA test plan for a sprint or feature |
| `/bug-triage` | Re-prioritize open bugs, assign to sprints, surface systemic trends |
| `/smoke-check` | Run critical path smoke test gate before QA hand-off (PASS/FAIL) |
| `/soak-test` | Generate a soak test protocol for extended play sessions |
| `/regression-suite` | Map coverage to GDD critical paths, flag gaps, maintain regression suite |
| `/test-setup` | Scaffold test framework + CI pipeline for the project's engine (run once) |
| `/test-helpers` | Generate engine-specific test helper libraries and factory functions |
| `/test-flakiness` | Detect flaky tests from CI history, flag for quarantine or fix |
| `/test-evidence-review` | Quality review of test files and manual evidence — ADEQUATE/INCOMPLETE/MISSING |
```

**行 282-315:**
```
- `game-design-document.md` -- for new mechanics and systems
- `architecture-decision-record.md` -- for technical decisions
- `architecture-traceability.md` -- maps GDD requirements to ADRs to story IDs
- `risk-register-entry.md` -- for new risks
- `narrative-character-sheet.md` -- for new characters
- `test-plan.md` -- for feature test plans
- `sprint-plan.md` -- for sprint planning
- `milestone-definition.md` -- for new milestones
- `level-design-document.md` -- for new levels
- `game-pillars.md` -- for core design pillars
- `art-bible.md` -- for visual style reference
- `technical-design-document.md` -- for per-system technical designs
- `post-mortem.md` -- for project/milestone retrospectives
- `sound-bible.md` -- for audio style reference
- `release-checklist-template.md` -- for platform release checklists
- `changelog-template.md` -- for player-facing patch notes
- `release-notes.md` -- for player-facing release notes
- `incident-response.md` -- for live incident response playbooks
- `game-concept.md` -- for initial game concepts (MDA, SDT, Flow, Bartle)
- `pitch-document.md` -- for pitching the game to stakeholders
- `economy-model.md` -- for virtual economy design (sink/faucet model)
- `faction-design.md` -- for faction identity, lore, and gameplay role
- `systems-index.md` -- for systems decomposition and dependency mapping
- `project-stage-report.md` -- for project stage detection output
- `design-doc-from-implementation.md` -- for reverse-documenting existing code into GDDs
- `architecture-doc-from-code.md` -- for reverse-documenting code into architecture docs
- `concept-doc-from-prototype.md` -- for reverse-documenting prototypes into concept docs
- `ux-spec.md` -- for per-screen UX specifications (layout zones, states, events)
- `hud-design.md` -- for whole-game HUD philosophy, zones, and element specs
- `accessibility-requirements.md` -- for project-wide accessibility tier and feature matrix
- `interaction-pattern-library.md` -- for standard UI controls and game-specific patterns
- `player-journey.md` -- for 6-phase emotional arc and retention hooks by time scale
- `difficulty-curve.md` -- for difficulty axes, onboarding ramp, and cross-system interactions
- `test-evidence.md` -- template for recording manual test evidence (screenshots, walkthrough notes)
```

**行 357-359:**
```
- `design-agent-protocol.md` -- question-options-draft-approval cycle for design agents
- `implementation-agent-protocol.md` -- story pickup through /story-done cycle for programming agents
- `leadership-agent-protocol.md` -- cross-department delegation and escalation for director-tier agents
```

**行 362-364:**
```
> - `design-agent-protocol.md` -- 设计代理的问题-选项-草案-审批循环
> - `implementation-agent-protocol.md` -- 编程代理的故事拾取到 /story-done 循环
> - `leadership-agent-protocol.md` -- 总监层级代理的跨部门委派和升级
```

**行 394-411:**
```
1. **Run `/start`** (or `/brainstorm open`) — guided creative exploration:
   what excites you, what you've played, your constraints
   - Generates 3 concepts, helps you pick one, defines core loop and pillars
   - Produces a game concept document and recommends an engine
2. **Set up the engine** — Run `/setup-engine` (uses the brainstorm recommendation)
   - Configures CODEBUDDY.md, detects knowledge gaps, populates reference docs
   - Creates `.codebuddy/docs/technical-preferences.md` with naming conventions,
     performance budgets, and engine-specific defaults
   - If the engine version is newer than the LLM's training data, it fetches
     current docs from the web so agents suggest correct APIs
3. **Validate the concept** — Run `/design-review design/gdd/game-concept.md`
4. **Decompose into systems** — Run `/map-systems` to map all systems and dependencies
5. **Design each system** — Run `/design-system [system-name]` (or `/map-systems next`)
   to write GDDs in dependency order
6. **Test the core loop** — Run `/prototype [core-mechanic]`
7. **Playtest it** — Run `/playtest-report` to validate the hypothesis
8. **Plan the first sprint** — Run `/sprint-plan new`
```

**行 435-443:**
```
1. **Set up the engine** — Run `/setup-engine [engine] [version]`
   (e.g., `/setup-engine godot 4.6`) — also creates technical preferences
2. **Write the Game Pillars** — delegate to `creative-director`
3. **Decompose into systems** — Run `/map-systems` to enumerate systems and dependencies
4. **Design each system** — Run `/design-system [system-name]` for GDDs in dependency order
5. **Create the initial ADR** — Run `/architecture-decision`
6. **Create the first milestone** in `production/milestones/`
7. **Plan the first sprint** — Run `/sprint-plan new`
```

**行 467-468:**
```
> 1. **运行 `/setup-engine`** 不带参数 — 它会询问你的游戏需求（2D/3D、平台、团队规模、语言偏好）并根据你的回答推荐引擎
```

**行 486-490:**
```
> 1. **运行 `/start`**（或 `/project-stage-detect`）— 分析已有内容、识别差距、推荐下一步
> 2. **运行 `/adopt`** 如果你已有GDD、ADR或故事 — 审计内部格式合规性并生成编号的迁移计划来填补差距，不会覆盖已有工作
> 3. **按需配置引擎** — 如未配置则运行 `/setup-engine`
> 4. **验证阶段就绪度** — 运行 `/gate-check` 查看当前状态
> 5. **规划下一个冲刺** — 运行 `/sprint-plan new`
```

**未翻译列表项:**
- 行 24: - **Tier 1 (DeepSeek-V3.2/GLM-5.1)**: Directors who make high-level decisions
- 行 25: - `creative-director` -- vision and creative conflict resolution
- 行 26: - `technical-director` -- architecture and technology decisions
- 行 34: - **Tier 2 (Kimi-K2.5/GLM-5.1)**: Department leads who own their domain
- 行 35: - `game-designer`, `lead-programmer`, `art-director`, `audio-director`,
- 行 282: - `game-design-document.md` -- for new mechanics and systems
- 行 283: - `architecture-decision-record.md` -- for technical decisions
- 行 284: - `architecture-traceability.md` -- maps GDD requirements to ADRs to story IDs
- 行 285: - `risk-register-entry.md` -- for new risks
- 行 286: - `narrative-character-sheet.md` -- for new characters
- 行 287: - `test-plan.md` -- for feature test plans
- 行 288: - `sprint-plan.md` -- for sprint planning
- 行 289: - `milestone-definition.md` -- for new milestones
- 行 290: - `level-design-document.md` -- for new levels
- 行 291: - `game-pillars.md` -- for core design pillars
- 行 292: - `art-bible.md` -- for visual style reference
- 行 293: - `technical-design-document.md` -- for per-system technical designs
- 行 294: - `post-mortem.md` -- for project/milestone retrospectives
- 行 295: - `sound-bible.md` -- for audio style reference
- 行 296: - `release-checklist-template.md` -- for platform release checklists
- 行 297: - `changelog-template.md` -- for player-facing patch notes
- 行 298: - `release-notes.md` -- for player-facing release notes
- 行 299: - `incident-response.md` -- for live incident response playbooks
- 行 300: - `game-concept.md` -- for initial game concepts (MDA, SDT, Flow, Bartle)
- 行 301: - `pitch-document.md` -- for pitching the game to stakeholders
- 行 302: - `economy-model.md` -- for virtual economy design (sink/faucet model)
- 行 303: - `faction-design.md` -- for faction identity, lore, and gameplay role
- 行 304: - `systems-index.md` -- for systems decomposition and dependency mapping
- 行 305: - `project-stage-report.md` -- for project stage detection output
- 行 306: - `design-doc-from-implementation.md` -- for reverse-documenting existing code into GDDs
- 行 307: - `architecture-doc-from-code.md` -- for reverse-documenting code into architecture docs
- 行 308: - `concept-doc-from-prototype.md` -- for reverse-documenting prototypes into concept docs
- 行 309: - `ux-spec.md` -- for per-screen UX specifications (layout zones, states, events)
- 行 310: - `hud-design.md` -- for whole-game HUD philosophy, zones, and element specs
- 行 311: - `accessibility-requirements.md` -- for project-wide accessibility tier and feature matrix
- 行 312: - `interaction-pattern-library.md` -- for standard UI controls and game-specific patterns
- 行 313: - `player-journey.md` -- for 6-phase emotional arc and retention hooks by time scale
- 行 314: - `difficulty-curve.md` -- for difficulty axes, onboarding ramp, and cross-system interactions
- 行 357: - `design-agent-protocol.md` -- question-options-draft-approval cycle for design agents
- 行 358: - `implementation-agent-protocol.md` -- story pickup through /story-done cycle for programming agents
- 行 368: 1. Work flows down the hierarchy: Directors -> Leads -> Specialists
- 行 394: 1. **Run `/start`** (or `/brainstorm open`) — guided creative exploration:
- 行 396: - Generates 3 concepts, helps you pick one, defines core loop and pillars
- 行 397: - Produces a game concept document and recommends an engine
- 行 399: - Configures CODEBUDDY.md, detects knowledge gaps, populates reference docs
- 行 400: - Creates `.codebuddy/docs/technical-preferences.md` with naming conventions,
- 行 402: - If the engine version is newer than the LLM's training data, it fetches
- 行 435: 1. **Set up the engine** — Run `/setup-engine [engine] [version]`
- 行 461: 1. **Run `/setup-engine`** with no arguments — it will ask about your game's
- 行 476: 1. **Run `/start`** (or `/project-stage-detect`) — analyzes what exists,

--------------------------------------------------------------------------------

### .codebuddy\docs\templates\incident-response.md
- 未翻译段落数: 41
- 未翻译列表项数: 20

**未翻译段落:**

**行 3-8:**
```
**Severity**: [S1-Critical / S2-Major / S3-Moderate / S4-Minor]
**Status**: [Active / Mitigated / Resolved / Post-Mortem Complete]
**Detected**: [Date Time UTC]
**Resolved**: [Date Time UTC or ONGOING]
**Duration**: [Total time from detection to resolution]
**Incident Commander**: [Name/Role]
```

**行 12-12:**
```
## Impact Summary
```

**行 14-15:**
```
[2-3 sentences describing what players experienced. Write from the player
perspective, not the technical perspective.]
```

**行 17-17:**
```
- **Players affected**: [estimated count or percentage]
```

**行 20-20:**
```
- **Revenue impact**: [estimated if applicable]
```

**行 26-30:**
```
| Time (UTC) | Event | Action Taken |
| ---- | ---- | ---- |
| [HH:MM] | Incident detected via [monitoring/player report/etc.] | Incident commander assigned |
| [HH:MM] | Root cause identified | [Brief description of cause] |
| [HH:MM] | Mitigation deployed | [What was done] |
```

**行 32-32:**
```
| [HH:MM] | All-clear declared | Post-mortem scheduled |
```

**行 38-38:**
```
### What Happened
```

**行 39-40:**
```
[Technical description of the root cause. Be specific about the chain of events
that led to the incident.]
```

**行 42-42:**
```
### Why It Happened
```

**行 43-44:**
```
[Systemic cause — why did existing processes, tests, or safeguards fail to
prevent this? This is more important than the technical cause.]
```

**行 46-46:**
```
### Contributing Factors
```

**行 47-49:**
```
- [Factor 1 — e.g., "Insufficient load testing for the new matchmaking system"]
- [Factor 2 — e.g., "Monitoring alert threshold was set too high"]
- [Factor 3]
```

**行 53-53:**
```
## Mitigation and Resolution
```

**行 55-55:**
```
### Immediate Actions (during incident)
```

**行 56-58:**
```
1. [Action taken to stop the bleeding]
2. [Action taken to restore service]
3. [Action taken to verify resolution]
```

**行 60-60:**
```
### Follow-Up Actions (after resolution)
```

**行 61-63:**
```
1. [Permanent fix if immediate action was a workaround]
2. [Additional testing or monitoring added]
3. [Process changes to prevent recurrence]
```

**行 67-67:**
```
## Player Communication
```

**行 69-69:**
```
### Initial Acknowledgment
```

**行 70-71:**
```
*Sent: [Time] via [channel]*
> [Exact text of the first public message acknowledging the issue]
```

**行 73-73:**
```
### Status Updates
```

**行 74-75:**
```
*Sent: [Time] via [channel]*
> [Text of each subsequent update]
```

**行 77-77:**
```
### Resolution Notice
```

**行 78-79:**
```
*Sent: [Time] via [channel]*
> [Text announcing the fix and any compensation]
```

**行 81-81:**
```
### Compensation (if applicable)
```

**行 82-82:**
```
- **What**: [description of compensation — e.g., "500 premium currency + 24-hour XP boost"]
```

**行 84-85:**
```
- **When**: [delivery date and method]
- **Rationale**: [why this compensation is appropriate for the impact]
```

**行 91-91:**
```
### What We Are Changing
```

**行 93-98:**
```
| Action Item | Owner | Deadline | Status |
| ---- | ---- | ---- | ---- |
| [Specific preventive measure] | [Role] | [Date] | [TODO/Done] |
| [Add monitoring for X] | [Role] | [Date] | [TODO/Done] |
| [Add test coverage for Y] | [Role] | [Date] | [TODO/Done] |
| [Update runbook for Z] | [Role] | [Date] | [TODO/Done] |
```

**行 100-100:**
```
### Process Improvements
```

**行 101-103:**
```
- [Process change to prevent similar incidents]
- [Monitoring/alerting improvement]
- [Testing improvement]
```

**行 107-107:**
```
## Lessons Learned
```

**行 109-109:**
```
### What Went Well
```

**行 110-112:**
```
- [Positive aspect of incident response — e.g., "Detection was fast due to
- [Positive aspect]
```

**行 114-114:**
```
### What Went Poorly
```

**行 115-117:**
```
- [Problem with response — e.g., "Took 20 minutes to identify the correct
- [Problem]
```

**行 119-119:**
```
### Where We Got Lucky
```

**行 120-121:**
```
- [Factor that reduced impact by chance rather than design — these are hidden
```

**行 127-130:**
```
- [ ] Technical Director — Root cause accurate, prevention plan sufficient
- [ ] QA Lead — Test coverage gaps addressed
- [ ] Producer — Timeline and communication reviewed
- [ ] Community Manager — Player communication reviewed
```

**行 134-135:**
```
*This document is filed in `production/hotfixes/` and linked from the
release notes for the fix version.*
```

**未翻译列表项:**
- 行 17: - **Players affected**: [estimated count or percentage]
- 行 20: - **Revenue impact**: [estimated if applicable]
- 行 47: - [Factor 1 — e.g., "Insufficient load testing for the new matchmaking system"]
- 行 48: - [Factor 2 — e.g., "Monitoring alert threshold was set too high"]
- 行 56: 1. [Action taken to stop the bleeding]
- 行 61: 1. [Permanent fix if immediate action was a workaround]
- 行 82: - **What**: [description of compensation — e.g., "500 premium currency + 24-hour XP boost"]
- 行 84: - **When**: [delivery date and method]
- 行 85: - **Rationale**: [why this compensation is appropriate for the impact]
- 行 101: - [Process change to prevent similar incidents]
- 行 102: - [Monitoring/alerting improvement]
- 行 103: - [Testing improvement]
- 行 110: - [Positive aspect of incident response — e.g., "Detection was fast due to
- 行 112: - [Positive aspect]
- 行 115: - [Problem with response — e.g., "Took 20 minutes to identify the correct
- 行 120: - [Factor that reduced impact by chance rather than design — these are hidden
- 行 127: - [ ] Technical Director — Root cause accurate, prevention plan sufficient
- 行 128: - [ ] QA Lead — Test coverage gaps addressed
- 行 129: - [ ] Producer — Timeline and communication reviewed
- 行 130: - [ ] Community Manager — Player communication reviewed

--------------------------------------------------------------------------------

### .codebuddy\docs\templates\release-checklist-template.md
- 未翻译段落数: 16
- 未翻译列表项数: 39

**未翻译段落:**

**行 3-5:**
```
**Release Date** / **发布日期**: [Target Date] / [目标日期]
**Release Manager** / **发布经理**: [Name] / [姓名]
**Status** / **状态**: [ ] GO / [ ] NO-GO / [ ] 进行 / [ ] 不进行
```

**行 28-29:**
```
| ---- | ---- | ---- | ---- |
```

**行 46-46:**
```
## Content Complete
```

**行 48-54:**
```
- [ ] All placeholder assets replaced with final versions
- [ ] All player-facing text proofread
- [ ] All text localization-ready (no hardcoded strings)
- [ ] Localization complete for: [list locales]
- [ ] Audio mix finalized and approved
- [ ] Credits complete and accurate
- [ ] Legal notices and third-party attributions complete
```

**行 60-68:**
```
- [ ] Minimum and recommended specs documented
- [ ] Keyboard+mouse controls fully functional
- [ ] Controller support tested (Xbox, PlayStation, generic)
- [ ] Resolution scaling tested: 1080p, 1440p, 4K, ultrawide
- [ ] Windowed, borderless, fullscreen modes working
- [ ] Graphics settings save and load correctly
- [ ] Store SDK integrated and tested: [Steam/Epic/GOG]
- [ ] Achievements functional
- [ ] Cloud saves functional
```

**行 70-70:**
```
## Platform: Console (if applicable)
```

**行 72-79:**
```
- [ ] TRC/TCR/Lotcheck requirements met
- [ ] Platform controller prompts correct
- [ ] Suspend/resume works
- [ ] User switching handled
- [ ] Network loss handled gracefully
- [ ] Storage full scenario handled
- [ ] Parental controls respected
- [ ] Certification submission prepared
```

**行 83-83:**
```
## Store and Distribution
```

**行 85-91:**
```
- [ ] Store page metadata complete and proofread
- [ ] Screenshots current and meet platform requirements
- [ ] Trailer current
- [ ] Key art and capsule images final
- [ ] Age ratings obtained: [ ] ESRB [ ] PEGI [ ] Other
- [ ] Legal: EULA, Privacy Policy, Terms of Service
- [ ] Pricing configured for all regions
```

**行 95-95:**
```
## Launch Readiness
```

**行 97-104:**
```
- [ ] Analytics/telemetry verified and receiving data
- [ ] Crash reporting configured: [service name]
- [ ] Day-one patch prepared (if needed)
- [ ] On-call team schedule set for first 72 hours
- [ ] Community announcements drafted
- [ ] Press/influencer keys prepared
- [ ] Support team briefed on known issues
- [ ] Rollback plan documented and tested
```

**行 110-115:**
```
| Role | Name | Status | Date |
| ---- | ---- | ---- | ---- |
| QA Lead | | [ ] Approved | |
| Technical Director | | [ ] Approved | |
| Producer | | [ ] Approved | |
| Creative Director | | [ ] Approved | |
```

**行 119-119:**
```
## Final Decision
```

**行 121-121:**
```
**GO / NO-GO**: ____________
```

**行 123-123:**
```
**Rationale**: [Summary of readiness. If NO-GO, list specific blocking items and estimated time to resolve.]
```

**行 125-125:**
```
**Notes**: [Any additional context, known risks accepted, or conditions on the release.]
```

**未翻译列表项:**
- 行 48: - [ ] All placeholder assets replaced with final versions
- 行 49: - [ ] All player-facing text proofread
- 行 50: - [ ] All text localization-ready (no hardcoded strings)
- 行 51: - [ ] Localization complete for: [list locales]
- 行 52: - [ ] Audio mix finalized and approved
- 行 53: - [ ] Credits complete and accurate
- 行 54: - [ ] Legal notices and third-party attributions complete
- 行 60: - [ ] Minimum and recommended specs documented
- 行 61: - [ ] Keyboard+mouse controls fully functional
- 行 62: - [ ] Controller support tested (Xbox, PlayStation, generic)
- 行 63: - [ ] Resolution scaling tested: 1080p, 1440p, 4K, ultrawide
- 行 64: - [ ] Windowed, borderless, fullscreen modes working
- 行 65: - [ ] Graphics settings save and load correctly
- 行 66: - [ ] Store SDK integrated and tested: [Steam/Epic/GOG]
- 行 67: - [ ] Achievements functional
- 行 68: - [ ] Cloud saves functional
- 行 72: - [ ] TRC/TCR/Lotcheck requirements met
- 行 73: - [ ] Platform controller prompts correct
- 行 74: - [ ] Suspend/resume works
- 行 75: - [ ] User switching handled
- 行 76: - [ ] Network loss handled gracefully
- 行 77: - [ ] Storage full scenario handled
- 行 78: - [ ] Parental controls respected
- 行 79: - [ ] Certification submission prepared
- 行 85: - [ ] Store page metadata complete and proofread
- 行 86: - [ ] Screenshots current and meet platform requirements
- 行 87: - [ ] Trailer current
- 行 88: - [ ] Key art and capsule images final
- 行 89: - [ ] Age ratings obtained: [ ] ESRB [ ] PEGI [ ] Other
- 行 90: - [ ] Legal: EULA, Privacy Policy, Terms of Service
- 行 91: - [ ] Pricing configured for all regions
- 行 97: - [ ] Analytics/telemetry verified and receiving data
- 行 98: - [ ] Crash reporting configured: [service name]
- 行 99: - [ ] Day-one patch prepared (if needed)
- 行 100: - [ ] On-call team schedule set for first 72 hours
- 行 101: - [ ] Community announcements drafted
- 行 102: - [ ] Press/influencer keys prepared
- 行 103: - [ ] Support team briefed on known issues
- 行 104: - [ ] Rollback plan documented and tested

--------------------------------------------------------------------------------

### .codebuddy\docs\templates\collaborative-protocols\leadership-agent-protocol.md
- 未翻译段落数: 23
- 未翻译列表项数: 28

**未翻译段落:**

**行 50-50:**
```
User: "The game-designer wants complex crafting but the lead-programmer says it will take 3 weeks and we only have 2 weeks before Alpha. What should we do?"
```

**行 52-53:**
```
You (understand context):
"I need to understand both sides fully before making a recommendation.
```

**行 56-58:**
```
 - design/gdd/crafting-system.md (what's designed)
 - production/sprints/sprint-current.md (what's planned)
 - design/pillars.md (what's non-negotiable)
```

**行 62-66:**
```
I also need to clarify:
 1. Is crafting a core pillar feature or a nice-to-have?
 2. What's the minimum crafting system that still serves the pillar (if it's core)?
 3. Can we slip Alpha by 1 week, or is that date hard?
 4. What breaks if crafting is cut entirely?"
```

**行 68-68:**
```
User: [answers: crafting is pillar 2 "emergent discovery", Alpha date is hard (investor demo), minimum is recipe discovery without complex UI]
```

**行 70-71:**
```
You (frame and present options):
"Thank you. Here's the core decision:
```

**行 73-73:**
```
**The Question:** Do we deliver full crafting for Alpha, accept schedule slip, or simplify crafting to meet deadline?
```

**行 75-78:**
```
**What's at Stake:** This affects:
 - Pillar 2 ("Emergent Discovery") representation at the investor demo
 - Schedule integrity and team trust
 - Technical debt if we rush complex systems
```

**行 80-85:**
```
**Option A: Implement Full Crafting (3 weeks, slip Alpha)**
 - ✅ Pillar 2 fully represented
 - ✅ No design compromises
 - ❌ Misses investor demo date
 - ❌ May damage relationship with investor
 - Risk: High — could lose funding opportunity
```

**行 87-93:**
```
**Option B: Simplify Crafting to Core (1.5 weeks, make Alpha)**
 - Scope: Recipe discovery only, no UI polish, 10 recipes instead of 30
 - ✅ Pillar 2 still represented (core mechanic intact)
 - ✅ Makes investor demo
 - ✅ Can polish post-Alpha
 - ❌ First impression is "rough"
 - Risk: Medium — demo may not wow, but pillar is visible
```

**行 95-100:**
```
**Option C: Cut Crafting Entirely (0 weeks, make Alpha)**
 - ✅ Makes deadline with polish
 - ✅ Team focuses on core combat (Pillar 1)
 - ❌ Pillar 2 not represented
 - ❌ Game identity incomplete
 - Risk: High — investor won't see 50% of the vision
```

**行 102-102:**
```
**My Recommendation: Option B (Simplify to Core)**
```

**行 105-108:**
```
 1. The investor demo needs to show ALL pillars, even if rough. A polished half-game is worse than a playable full-game.
 2. Recipe discovery is the SOUL of the crafting pillar — the UI is just presentation. Core > polish for a vertical slice.
 3. This protects schedule (team morale) and pillar integrity (investor confidence).
 4. We can polish post-Alpha and show progression: "Here's Alpha vs. Beta" is a compelling narrative.
```

**行 110-110:**
```
References: Hades showed rough vertical slices in Early Access and iterated — investors loved the pillar demonstration over polish.
```

**行 112-112:**
```
Trade-offs I'm accepting: The demo won't look AAA-polished, but it will feel complete.
```

**行 114-114:**
```
**But this is your call.** You know the investor relationship better than I do. If they value polish over completeness, Option C might be right. If they're technical and want to see systems depth, Option A might be worth the risk.
```

**行 116-116:**
```
What's your decision?"
```

**行 118-118:**
```
User: "Option B. Let's simplify the scope."
```

**行 120-121:**
```
You (support decision):
"Excellent. I'll document this decision and cascade it:
```

**行 123-126:**
```
1. Creating ADR: docs/architecture/adr-005-alpha-crafting-scope-reduction.md
2. Updating design/gdd/crafting-system.md with Alpha scope markers
3. Notifying game-designer and lead-programmer to align on new 1.5-week plan
4. Adding to production/milestones/alpha.md as success criteria: 'Crafting pillar demonstrated via core discovery mechanic'
```

**行 128-131:**
```
Validation criteria: We'll know this was right if:
 - Investor demo shows both Pillar 1 (combat) and Pillar 2 (discovery) in playable form
 - Team hits Alpha deadline without crunch
 - Post-Alpha sprint can polish crafting without rework
```

**行 133-133:**
```
May I proceed with documentation?"
```

**行 137-137:**
```
You: [Creates ADR, updates docs, notifies relevant agents]
```

**未翻译列表项:**
- 行 56: - design/gdd/crafting-system.md (what's designed)
- 行 57: - production/sprints/sprint-current.md (what's planned)
- 行 58: - design/pillars.md (what's non-negotiable)
- 行 63: 1. Is crafting a core pillar feature or a nice-to-have?
- 行 76: - Pillar 2 ("Emergent Discovery") representation at the investor demo
- 行 77: - Schedule integrity and team trust
- 行 78: - Technical debt if we rush complex systems
- 行 81: - ✅ Pillar 2 fully represented
- 行 82: - ✅ No design compromises
- 行 83: - ❌ Misses investor demo date
- 行 84: - ❌ May damage relationship with investor
- 行 85: - Risk: High — could lose funding opportunity
- 行 88: - Scope: Recipe discovery only, no UI polish, 10 recipes instead of 30
- 行 89: - ✅ Pillar 2 still represented (core mechanic intact)
- 行 90: - ✅ Makes investor demo
- 行 91: - ✅ Can polish post-Alpha
- 行 92: - ❌ First impression is "rough"
- 行 93: - Risk: Medium — demo may not wow, but pillar is visible
- 行 96: - ✅ Makes deadline with polish
- 行 97: - ✅ Team focuses on core combat (Pillar 1)
- 行 98: - ❌ Pillar 2 not represented
- 行 99: - ❌ Game identity incomplete
- 行 100: - Risk: High — investor won't see 50% of the vision
- 行 105: 1. The investor demo needs to show ALL pillars, even if rough. A polished half-game is worse than a playable full-game.
- 行 123: 1. Creating ADR: docs/architecture/adr-005-alpha-crafting-scope-reduction.md
- 行 129: - Investor demo shows both Pillar 1 (combat) and Pillar 2 (discovery) in playable form
- 行 130: - Team hits Alpha deadline without crunch
- 行 131: - Post-Alpha sprint can polish crafting without rework

--------------------------------------------------------------------------------

### .codebuddy\docs\templates\faction-design.md
- 未翻译段落数: 32
- 未翻译列表项数: 17

**未翻译段落:**

**行 4-5:**
```
*Owner: world-builder*
*Status: [Draft / Approved / Implemented]*
```

**行 13-14:**
```
| **Full Name** | [Official faction name] |
| **Common Name** | [What people call them] |
```

**行 16-19:**
```
| **Alignment** | [Not D&D alignment — their moral complexity in 1 sentence] |
| **Symbol** | [Description of their emblem/flag/sigil] |
| **Colors** | [Primary and secondary colors associated with this faction] |
| **Motto** | [Their defining phrase or creed] |
```

**行 25-26:**
```
[2-3 paragraphs describing who this faction is, what they want, and why they
matter to the game world. Write as if briefing someone who knows nothing.]
```

**行 33-33:**
```
[How did this faction form? What event or need brought them together?]
```

**行 36-38:**
```
1. **[Event Name]** ([Date/Era]): [What happened and how it shaped the faction]
2. **[Event Name]** ([Date/Era]): [Impact]
3. **[Event Name]** ([Date/Era]): [Impact]
```

**行 41-41:**
```
[Where is this faction now? Are they ascendant, declining, stable, fractured?]
```

**行 48-50:**
```
- [Belief 1 — what they hold as fundamental truth]
- [Belief 2]
- [Belief 3]
```

**行 53-54:**
```
- [Value 1 — what they reward and respect]
- [Value 2]
```

**行 57-58:**
```
- [Thing 1 — what they punish or reject]
- [Thing 2]
```

**行 65-66:**
```
[How is the faction organized? Military ranks? Council of elders? Meritocracy?
Describe the power structure.]
```

**行 69-73:**
```
| Name | Role | Personality | Motivation |
| ---- | ---- | ---- | ---- |
| [Leader] | [Title] | [2-3 adjectives] | [What drives them] |
| [Second] | [Title] | [Personality] | [Motivation] |
| [Notable] | [Title] | [Personality] | [Motivation] |
```

**行 76-78:**
```
- **How to join**: [Birth? Initiation? Purchase? Invitation?]
- **How to leave**: [Can they? What happens?]
- **Population**: [Rough size and composition]
```

**行 82-82:**
```
## Territory and Resources
```

**行 85-85:**
```
[Where does this faction control territory? What are their key locations?]
```

**行 88-90:**
```
- **Primary resource**: [What they have abundance of]
- **Scarcity**: [What they lack and need]
- **Trade goods**: [What they export/sell]
```

**行 92-92:**
```
### Military Strength
```

**行 93-94:**
```
[How powerful are they? Standing army? Special forces? Magical capabilities?
```

**行 98-98:**
```
## Relationships
```

**行 100-101:**
```
| Faction | Relationship | Reason | Trend |
| ---- | ---- | ---- | ---- |
```

**行 103-104:**
```
| [Faction B] | [Relationship] | [Why] | [Trend] |
| [Player] | [Starting disposition] | [Why] | [Player-influenced] |
```

**行 108-108:**
```
## Reputation System (if applicable)
```

**行 110-117:**
```
| Tier | Points | Benefits | Requirements |
| ---- | ---- | ---- | ---- |
| Hostile | [-1000 to -500] | [Attacked on sight] | [Betrayal, war crimes] |
| Unfriendly | [-500 to -100] | [No services, higher prices] | [Opposing actions] |
| Neutral | [-100 to 100] | [Basic services] | [Default] |
| Friendly | [100 to 500] | [Discounts, quests] | [Complete tasks] |
| Honored | [500 to 1000] | [Unique items, areas, abilities] | [Major questline] |
| Exalted | [1000+] | [Best rewards, title, housing] | [Full faction commitment] |
```

**行 124-125:**
```
[How does the player encounter and interact with this faction? Quests?
Trading? Combat? Diplomacy?]
```

**行 128-129:**
```
[Does this faction introduce any unique gameplay mechanics? Crafting recipes?
Combat styles? Magic systems?]
```

**行 132-132:**
```
[Brief overview of the major questlines associated with this faction.]
```

**行 139-139:**
```
[What do their buildings look like? Materials, shapes, scale.]
```

**行 142-142:**
```
[What do members wear? Identifying visual elements.]
```

**行 145-145:**
```
[What tools, weapons, and abilities do they use?]
```

**行 148-148:**
```
[What sounds are associated with this faction? Musical themes, ambient sounds.]
```

**行 155-157:**
```
- **Contradictions to watch**: [Any potential conflicts with other lore]
- **Open questions**: [Things not yet decided about this faction]
- **Off-limits**: [Things that must NOT be true about this faction]
```

**行 163-166:**
```
- Related factions: [List factions that interact with this one]
- Related areas: [Levels/regions where this faction appears]
- Related questlines: [Story arcs involving this faction]
- Affects: [economy, combat encounters, narrative branches]
```

**未翻译列表项:**
- 行 36: 1. **[Event Name]** ([Date/Era]): [What happened and how it shaped the faction]
- 行 48: - [Belief 1 — what they hold as fundamental truth]
- 行 53: - [Value 1 — what they reward and respect]
- 行 57: - [Thing 1 — what they punish or reject]
- 行 76: - **How to join**: [Birth? Initiation? Purchase? Invitation?]
- 行 77: - **How to leave**: [Can they? What happens?]
- 行 78: - **Population**: [Rough size and composition]
- 行 88: - **Primary resource**: [What they have abundance of]
- 行 89: - **Scarcity**: [What they lack and need]
- 行 90: - **Trade goods**: [What they export/sell]
- 行 155: - **Contradictions to watch**: [Any potential conflicts with other lore]
- 行 156: - **Open questions**: [Things not yet decided about this faction]
- 行 157: - **Off-limits**: [Things that must NOT be true about this faction]
- 行 163: - Related factions: [List factions that interact with this one]
- 行 164: - Related areas: [Levels/regions where this faction appears]
- 行 165: - Related questlines: [Story arcs involving this faction]
- 行 166: - Affects: [economy, combat encounters, narrative branches]

--------------------------------------------------------------------------------

### .codebuddy\docs\templates\systems-index.md
- 未翻译段落数: 35
- 未翻译列表项数: 12

**未翻译段落:**

**行 12-14:**
```
[One paragraph explaining the game's mechanical scope. What kind of systems does
this game need? Reference the core loop and game pillars. This should help any
team member understand the "big picture" of what needs to be designed and built.]
```

**行 18-18:**
```
## Systems Enumeration
```

**行 21-21:**
```
|---|-------------|----------|----------|--------|------------|------------|
```

**行 23-23:**
```
| 2 | [e.g., Camera System] | Core | MVP | Not Started | — | Player Controller |
```

**行 25-27:**
```
[Add a row for every identified system. Use the categories and priority tiers
defined below. Mark systems that were inferred (not explicitly in the concept doc)
with "(inferred)" in the system name.]
```

**行 33-43:**
```
| Category | Description | Typical Systems |
|----------|-------------|-----------------|
| **Core** | Foundation systems everything depends on | Player controller, input, physics, camera, scene management, state machine |
| **Gameplay** | The systems that make the game fun | Combat, AI, stealth, movement abilities, interaction |
| **Progression** | How the player grows over time | XP/leveling, skill trees, unlocks, achievements, reputation |
| **Economy** | Resource creation and consumption | Currency, loot, crafting, shops, item database, drop tables |
| **Persistence** | Save state and continuity | Save/load, settings, cloud sync, profile management |
| **UI** | Player-facing information displays | HUD, menus, inventory screen, dialogue UI, map, notifications |
| **Audio** | Sound and music systems | Music manager, SFX bus, ambient audio, adaptive music, voice |
| **Narrative** | Story and dialogue delivery | Dialogue system, quest tracking, cutscenes, journal, lore entries |
| **Meta** | Systems outside the core game loop | Analytics, tutorials/onboarding, accessibility options, photo mode |
```

**行 45-46:**
```
[Not every game needs every category. Remove categories that don't apply.
Add custom categories if needed.]
```

**行 50-50:**
```
## Priority Tiers
```

**行 52-54:**
```
| Tier | Definition | Target Milestone | Design Urgency |
|------|------------|------------------|----------------|
| **MVP** | Required for the core loop to function. Without these, you can't test "is this fun?" | First playable prototype | Design FIRST |
```

**行 56-56:**
```
| **Alpha** | All features present in rough form. Complete mechanical scope, placeholder content OK. | Alpha milestone | Design THIRD |
```

**行 61-61:**
```
## Dependency Map
```

**行 63-64:**
```
[Systems sorted by dependency order — design and build from top to bottom.
Systems at the top are foundations; systems at the bottom are wrappers.]
```

**行 66-66:**
```
### Foundation Layer (no dependencies)
```

**行 68-68:**
```
1. [System] — [one-line rationale for why this is foundational]
```

**行 70-70:**
```
### Core Layer (depends on foundation)
```

**行 72-72:**
```
1. [System] — depends on: [list]
```

**行 74-74:**
```
### Feature Layer (depends on core)
```

**行 76-76:**
```
1. [System] — depends on: [list]
```

**行 78-78:**
```
### Presentation Layer (depends on features)
```

**行 80-80:**
```
1. [System] — depends on: [list]
```

**行 82-82:**
```
### Polish Layer (depends on everything)
```

**行 84-84:**
```
1. [System] — depends on: [list]
```

**行 88-88:**
```
## Recommended Design Order
```

**行 90-92:**
```
[Combining dependency sort and priority tiers. Design these systems in this
order. Each system's GDD should be completed and reviewed before starting the
next, though independent systems at the same layer can be designed in parallel.]
```

**行 94-97:**
```
| Order | System | Priority | Layer | Agent(s) | Est. Effort |
|-------|--------|----------|-------|----------|-------------|
| 1 | [First system to design] | MVP | Foundation | game-designer | [S/M/L] |
| 2 | [Second system] | MVP | Foundation | game-designer | [S/M/L] |
```

**行 99-100:**
```
[Effort estimates: S = 1 session, M = 2-3 sessions, L = 4+ sessions.
A "session" is one focused design conversation producing a complete GDD.]
```

**行 104-104:**
```
## Circular Dependencies
```

**行 106-108:**
```
[List any circular dependency chains found during analysis. These require
special architectural attention — either break the cycle with an interface,
or design the systems simultaneously.]
```

**行 110-112:**
```
- [None found] OR
- [System A <-> System B: Description of the circular relationship and
```

**行 116-116:**
```
## High-Risk Systems
```

**行 118-119:**
```
[Systems that are technically unproven, design-uncertain, or scope-dangerous.
These should be prototyped early regardless of priority tier.]
```

**行 121-122:**
```
| System | Risk Type | Risk Description | Mitigation |
|--------|-----------|-----------------|------------|
```

**行 127-127:**
```
## Progress Tracker
```

**行 131-136:**
```
| Total systems identified | [N] |
| Design docs started | [N] |
| Design docs reviewed | [N] |
| Design docs approved | [N] |
| MVP systems designed | [N/total MVP] |
| Vertical Slice systems designed | [N/total VS] |
```

**行 142-146:**
```
- [ ] Review and approve this systems enumeration
- [ ] Design MVP-tier systems first (use `/design-system [system-name]`)
- [ ] Run `/design-review` on each completed GDD
- [ ] Run `/gate-check pre-production` when MVP systems are designed
- [ ] Prototype the highest-risk system early (`/prototype [system]`)
```

**未翻译列表项:**
- 行 68: 1. [System] — [one-line rationale for why this is foundational]
- 行 72: 1. [System] — depends on: [list]
- 行 76: 1. [System] — depends on: [list]
- 行 80: 1. [System] — depends on: [list]
- 行 84: 1. [System] — depends on: [list]
- 行 110: - [None found] OR
- 行 111: - [System A <-> System B: Description of the circular relationship and
- 行 142: - [ ] Review and approve this systems enumeration
- 行 143: - [ ] Design MVP-tier systems first (use `/design-system [system-name]`)
- 行 144: - [ ] Run `/design-review` on each completed GDD
- 行 145: - [ ] Run `/gate-check pre-production` when MVP systems are designed
- 行 146: - [ ] Prototype the highest-risk system early (`/prototype [system]`)

--------------------------------------------------------------------------------

### .codebuddy\docs\templates\architecture-traceability.md
- 未翻译段落数: 31
- 未翻译列表项数: 9

**未翻译段落:**

**行 3-4:**
```
<!-- Living document — updated by /architecture-review after each review run.
     Do not edit manually unless correcting an error. -->
```

**行 6-6:**
```
## Document Status
```

**行 8-12:**
```
- **Last Updated**: [YYYY-MM-DD]
- **Engine**: [e.g. Godot 4.6]
- **GDDs Indexed**: [N]
- **ADRs Indexed**: [M]
- **Last Review**: [link to docs/architecture/architecture-review-[date].md]
```

**行 14-14:**
```
## Coverage Summary
```

**行 16-21:**
```
| Status | Count | Percentage |
|--------|-------|-----------|
| ✅ Covered | [X] | [%] |
| ⚠️ Partial | [Y] | [%] |
| ❌ Gap | [Z] | [%] |
| **Total** | **[N]** | |
```

**行 25-25:**
```
## Traceability Matrix
```

**行 27-30:**
```
<!-- One row per technical requirement extracted from a GDD.
     A "technical requirement" is any GDD statement that implies a specific
     architectural decision: data structures, performance constraints, engine
     capabilities needed, cross-system communication, state persistence. -->
```

**行 32-35:**
```
| Req ID | GDD | System | Requirement Summary | ADR(s) | Status | Notes |
|--------|-----|--------|---------------------|--------|--------|-------|
| TR-[gdd]-001 | [filename] | [system name] | [one-line summary] | [ADR-NNNN] | ✅ | |
| TR-[gdd]-002 | [filename] | [system name] | [one-line summary] | — | ❌ GAP | Needs `/architecture-decision [title]` |
```

**行 41-41:**
```
Requirements with no ADR coverage, prioritised by layer (Foundation first):
```

**行 43-43:**
```
### Foundation Layer Gaps (BLOCKING — must resolve before coding)
```

**行 44-44:**
```
- [ ] TR-[id]: [requirement] — GDD: [file] — Suggested ADR: "[title]"
```

**行 46-46:**
```
### Core Layer Gaps (must resolve before relevant system is built)
```

**行 47-47:**
```
- [ ] TR-[id]: [requirement] — GDD: [file] — Suggested ADR: "[title]"
```

**行 49-49:**
```
### Feature Layer Gaps (should resolve before feature sprint)
```

**行 50-50:**
```
- [ ] TR-[id]: [requirement] — GDD: [file] — Suggested ADR: "[title]"
```

**行 52-52:**
```
### Presentation Layer Gaps (can defer to implementation)
```

**行 53-53:**
```
- [ ] TR-[id]: [requirement] — GDD: [file] — Suggested ADR: "[title]"
```

**行 57-57:**
```
## Cross-ADR Conflicts
```

**行 59-59:**
```
<!-- Pairs of ADRs that make contradictory claims. Must be resolved. -->
```

**行 61-63:**
```
| Conflict ID | ADR A | ADR B | Type | Status |
|-------------|-------|-------|------|--------|
| CONFLICT-001 | ADR-NNNN | ADR-MMMM | Data ownership | 🔴 Unresolved |
```

**行 67-67:**
```
## ADR → GDD Coverage (Reverse Index)
```

**行 69-69:**
```
<!-- For each ADR, which GDD requirements does it address? -->
```

**行 71-73:**
```
| ADR | Title | GDD Requirements Addressed | Engine Risk |
|-----|-------|---------------------------|-------------|
| ADR-0001 | [title] | TR-combat-001, TR-combat-002 | HIGH |
```

**行 77-77:**
```
## Superseded Requirements
```

**行 79-80:**
```
<!-- Requirements that existed in a GDD when an ADR was written, but the GDD
     has since changed. The ADR may need updating. -->
```

**行 82-84:**
```
| Req ID | GDD | Change | Affected ADR | Status |
|--------|-----|--------|-------------|--------|
| TR-[id] | [file] | [what changed] | ADR-NNNN | 🔴 ADR needs update |
```

**行 88-88:**
```
## How to Use This Document
```

**行 90-91:**
```
**When writing a new ADR**: Add it to the "ADR → GDD Coverage" table and mark
the requirements it satisfies as ✅ in the matrix.
```

**行 93-95:**
```
**When approving a GDD change**: Scan the matrix for requirements from that GDD
and check whether the change invalidates any existing ADR. Add to "Superseded
```

**行 97-98:**
```
**When running `/architecture-review`**: The skill will update this document
automatically with the current state.
```

**行 100-101:**
```
**Gate check**: The Pre-Production gate requires this document to exist and to
have zero Foundation Layer Gaps.
```

**未翻译列表项:**
- 行 8: - **Last Updated**: [YYYY-MM-DD]
- 行 9: - **Engine**: [e.g. Godot 4.6]
- 行 10: - **GDDs Indexed**: [N]
- 行 11: - **ADRs Indexed**: [M]
- 行 12: - **Last Review**: [link to docs/architecture/architecture-review-[date].md]
- 行 44: - [ ] TR-[id]: [requirement] — GDD: [file] — Suggested ADR: "[title]"
- 行 47: - [ ] TR-[id]: [requirement] — GDD: [file] — Suggested ADR: "[title]"
- 行 50: - [ ] TR-[id]: [requirement] — GDD: [file] — Suggested ADR: "[title]"
- 行 53: - [ ] TR-[id]: [requirement] — GDD: [file] — Suggested ADR: "[title]"

--------------------------------------------------------------------------------

### .codebuddy\docs\templates\art-bible.md
- 未翻译段落数: 34
- 未翻译列表项数: 4

**未翻译段落:**

**行 9-9:**
```
## Visual Identity Summary
```

**行 10-10:**
```
[2-3 sentences describing the overall visual identity]
```

**行 12-12:**
```
## Reference Board
```

**行 13-13:**
```
[List reference games, films, art, and what specific visual quality each represents]
```

**行 15-17:**
```
| Reference | Medium | What We're Taking |
| --------- | ------ | ----------------- |
| [Name] | [Game/Film/Art] | [Specific quality] |
```

**行 19-19:**
```
## Color Palette
```

**行 21-21:**
```
### Primary Palette
```

**行 22-24:**
```
| Name | Hex | Usage |
| ---- | --- | ----- |
| [Color Name] | #XXXXXX | [Where and when to use] |
```

**行 26-26:**
```
### Emotional Color Mapping
```

**行 27-32:**
```
| Game State | Dominant Colors | Mood |
| ---------- | --------------- | ---- |
| Exploration | [Colors] | [Feeling] |
| Combat | [Colors] | [Feeling] |
| Safe zones | [Colors] | [Feeling] |
| Danger | [Colors] | [Feeling] |
```

**行 36-36:**
```
### Rendering Style
```

**行 37-37:**
```
[Realistic / Stylized / Pixel / Cel-shaded / etc.]
```

**行 40-40:**
```
[Character proportions, environment scale, UI scale relationships]
```

**行 42-42:**
```
### Level of Detail
```

**行 43-43:**
```
[How detailed are characters, environments, UI elements?]
```

**行 45-45:**
```
### Visual Hierarchy
```

**行 46-46:**
```
[How do we guide the player's eye? What's always most prominent?]
```

**行 48-48:**
```
## Character Art Standards
```

**行 49-49:**
```
[Silhouette requirements, color coding, animation style, proportions]
```

**行 51-51:**
```
## Environment Art Standards
```

**行 52-52:**
```
[Tilesets, modularity, lighting, atmospheric effects, scale]
```

**行 54-54:**
```
## UI Art Standards
```

**行 55-55:**
```
[Button styles, typography, icon style, menu layout principles, HUD density]
```

**行 57-57:**
```
## VFX Standards
```

**行 58-58:**
```
[Particle style, screen effects, impact feedback, color coding]
```

**行 60-60:**
```
## Asset Production Standards
```

**行 62-62:**
```
### Naming Convention
```

**行 63-63:**
```
`[category]_[name]_[variant]_[size].[ext]`
```

**行 65-65:**
```
### Texture Standards
```

**行 66-71:**
```
| Category | Max Resolution | Format | Color Space |
| -------- | -------------- | ------ | ----------- |
| Characters | [Size] | [Format] | [Space] |
| Environments | [Size] | [Format] | [Space] |
| UI | [Size] | [Format] | [Space] |
| VFX | [Size] | [Format] | [Space] |
```

**行 73-73:**
```
### Animation Standards
```

**行 74-74:**
```
[Frame rates, blend times, animation graph structure]
```

**行 76-76:**
```
## Accessibility
```

**行 77-80:**
```
- Colorblind-safe UI elements required
- Minimum text size: [X]px at 1080p
- High contrast mode specifications
- Icon + color (never color alone) for game state
```

**未翻译列表项:**
- 行 77: - Colorblind-safe UI elements required
- 行 78: - Minimum text size: [X]px at 1080p
- 行 79: - High contrast mode specifications
- 行 80: - Icon + color (never color alone) for game state

--------------------------------------------------------------------------------

### .codebuddy\docs\templates\release-notes.md
- 未翻译段落数: 25
- 未翻译列表项数: 13

**未翻译段落:**

**行 3-3:**
```
*Released: [Date]* / *发布于：[日期]*
```

**行 16-16:**
```
### [Major Feature 1 Name]
```

**行 17-18:**
```
[2-4 sentences describing the feature. Focus on what players can DO, not
how it works internally. Include a screenshot or GIF reference if applicable.]
```

**行 20-20:**
```
### [Major Feature 2 Name]
```

**行 30-30:**
```
| ---- | ---- | ---- | ---- | ---- |
```

**行 34-34:**
```
### Mechanic Changes
```

**行 35-36:**
```
- **[Change Name]**: [What changed and how it affects gameplay. Be specific
  about what players will experience differently.]
```

**行 40-40:**
```
## Quality of Life
```

**行 42-44:**
```
- [Improvement 1 — describe the player benefit, not the technical change]
- [Improvement 2]
- [Improvement 3]
```

**行 50-50:**
```
### Critical Fixes
```

**行 51-52:**
```
- Fixed [describe what players experienced, e.g., "a crash when loading
  saved games from version 1.0"]
```

**行 54-54:**
```
### Gameplay Fixes
```

**行 55-55:**
```
- Fixed [describe the incorrect behavior and the correct behavior now]
```

**行 58-58:**
```
- Fixed [description]
```

**行 61-61:**
```
- Fixed [description]
```

**行 63-63:**
```
### Platform-Specific Fixes
```

**行 64-64:**
```
- **[Platform]**: Fixed [description]
```

**行 68-68:**
```
## Performance Improvements
```

**行 70-72:**
```
- [Improvement players will notice, e.g., "Reduced load times by approximately
  30% on all platforms"]
- [Improvement]
```

**行 78-78:**
```
We are aware of the following issues and are working on fixes for a future update:
```

**行 80-81:**
```
- **[Issue]**: [Brief description and workaround if available]
- **[Issue]**: [Description]
```

**行 87-88:**
```
[Optional — tease upcoming content to build anticipation. Keep it vague enough
to not create binding commitments.]
```

**行 90-90:**
```
> [1-2 sentences about what the team is working on next]
```

**行 96-97:**
```
[Brief message thanking the community. Reference specific community feedback
that influenced changes in this release if applicable.]
```

**行 101-103:**
```
*For the full changelog with technical details, see the [developer changelog](link).*
*Report bugs: [link to bug report channel/form]*
*Join the community: [link to Discord/forum]*
```

**未翻译列表项:**
- 行 35: - **[Change Name]**: [What changed and how it affects gameplay. Be specific
- 行 42: - [Improvement 1 — describe the player benefit, not the technical change]
- 行 43: - [Improvement 2]
- 行 44: - [Improvement 3]
- 行 51: - Fixed [describe what players experienced, e.g., "a crash when loading
- 行 55: - Fixed [describe the incorrect behavior and the correct behavior now]
- 行 58: - Fixed [description]
- 行 61: - Fixed [description]
- 行 64: - **[Platform]**: Fixed [description]
- 行 70: - [Improvement players will notice, e.g., "Reduced load times by approximately
- 行 72: - [Improvement]
- 行 80: - **[Issue]**: [Brief description and workaround if available]
- 行 81: - **[Issue]**: [Description]

--------------------------------------------------------------------------------

### .codebuddy\docs\templates\changelog-template.md
- 未翻译段落数: 18
- 未翻译列表项数: 16

**未翻译段落:**

**行 3-3:**
```
**Release Date**: [Date]
```

**行 9-9:**
```
- **[Feature Name]**: [Player-friendly description of what they can now do. Focus on the experience, not the implementation. 1-2 sentences.]
```

**行 11-11:**
```
- **[Feature Name]**: [Description]
```

**行 17-17:**
```
- **[Area Improved]**: [How this makes the game better for the player. Be specific.]
```

**行 19-19:**
```
- **[Area Improved]**: [Description]
```

**行 23-23:**
```
## Balance Changes
```

**行 25-25:**
```
- **[What Changed]**: [Old value] -> [New value]. [Brief design reasoning in player terms. Example: "Healing potions now restore 50 HP (up from 30) -- late-game encounters needed more recovery options."]
```

**行 27-27:**
```
- **[What Changed]**: [Description]
```

**行 33-35:**
```
- Fixed an issue where [describe the player-visible symptom, not the code fix]
- Fixed [another player-visible symptom]
- Fixed [symptom]
```

**行 41-41:**
```
- [Issue description in player terms]. [Workaround if one exists.] We're working on a fix.
```

**行 45-45:**
```
## Technical Notes (Internal Only -- Remove Before Publishing)
```

**行 47-47:**
```
### Commits Covered
```

**行 48-49:**
```
- Range: `[first-hash]..[last-hash]`
- Total commits: [N]
```

**行 51-51:**
```
### Internal Changes
```

**行 52-52:**
```
- [Refactoring, infrastructure, or tooling changes not visible to players]
```

**行 54-54:**
```
### Deferred Items
```

**行 55-57:**
```
- [Features or fixes originally planned for this release but moved to next]
  - Reason: [why deferred]
  - New target: [version or sprint]
```

**行 61-62:**
```
Thank you for playing! Your feedback helps us improve the game.
Report issues at [support link].
```

**未翻译列表项:**
- 行 9: - **[Feature Name]**: [Player-friendly description of what they can now do. Focus on the experience, not the implementation. 1-2 sentences.]
- 行 11: - **[Feature Name]**: [Description]
- 行 17: - **[Area Improved]**: [How this makes the game better for the player. Be specific.]
- 行 19: - **[Area Improved]**: [Description]
- 行 25: - **[What Changed]**: [Old value] -> [New value]. [Brief design reasoning in player terms. Example: "Healing potions now restore 50 HP (up from 30) -- late-game encounters needed more recovery options."]
- 行 27: - **[What Changed]**: [Description]
- 行 33: - Fixed an issue where [describe the player-visible symptom, not the code fix]
- 行 34: - Fixed [another player-visible symptom]
- 行 35: - Fixed [symptom]
- 行 41: - [Issue description in player terms]. [Workaround if one exists.] We're working on a fix.
- 行 48: - Range: `[first-hash]..[last-hash]`
- 行 49: - Total commits: [N]
- 行 52: - [Refactoring, infrastructure, or tooling changes not visible to players]
- 行 55: - [Features or fixes originally planned for this release but moved to next]
- 行 56: - Reason: [why deferred]
- 行 57: - New target: [version or sprint]

--------------------------------------------------------------------------------

### .codebuddy\docs\agent-roster.md
- 未翻译段落数: 23
- 未翻译列表项数: 6

**未翻译段落:**

**行 3-6:**
```
The following agents are available. Each has a dedicated definition file in
`.codebuddy/agents/`. Use the agent best suited to the task at hand. When a task
spans multiple domains, the coordinating agent (usually `producer` or the
domain lead) should delegate to specialists.
```

**行 8-8:**
```
## Tier 1 -- Leadership Agents (GLM-5.1)
```

**行 9-13:**
```
| Agent | Domain | When to Use |
|-------|--------|-------------|
| `creative-director` | High-level vision | Major creative decisions, pillar conflicts, tone/direction |
| `technical-director` | Technical vision | Architecture decisions, tech stack choices, performance strategy |
| `producer` | Production management | Sprint planning, milestone tracking, risk management, coordination |
```

**行 15-15:**
```
## Tier 2 -- Department Lead Agents (DeepSeek-V3.2)
```

**行 16-25:**
```
| Agent | Domain | When to Use |
|-------|--------|-------------|
| `game-designer` | Game design | Mechanics, systems, progression, economy, balancing |
| `lead-programmer` | Code architecture | System design, code review, API design, refactoring |
| `art-director` | Visual direction | Style guides, art bible, asset standards, UI/UX direction |
| `audio-director` | Audio direction | Music direction, sound palette, audio implementation strategy |
| `narrative-director` | Story and writing | Story arcs, world-building, character design, dialogue strategy |
| `qa-lead` | Quality assurance | Test strategy, bug triage, release readiness, regression planning |
| `release-manager` | Release pipeline | Build management, versioning, changelogs, deployment, rollbacks |
| `localization-lead` | Internationalization | String externalization, translation pipeline, locale testing |
```

**行 27-27:**
```
## Tier 3 -- Specialist Agents (Kimi-K2.5 or MiniMax-M2.7)
```

**行 28-32:**
```
| Agent | Domain | Model | When to Use |
|-------|--------|-------|-------------|
| `systems-designer` | Systems design | DeepSeek-V3.2 | Specific mechanic implementation, formula design, loops |
| `level-designer` | Level design | Kimi-K2.5 | Level layouts, pacing, encounter design, flow |
| `economy-designer` | Economy/balance | DeepSeek-V3.2 | Resource economies, loot tables, progression curves |
```

**行 34-34:**
```
| `gameplay-programmer` | Gameplay code | DeepSeek-V3.2 | Feature implementation, gameplay systems code |
```

**行 36-54:**
```
| `engine-programmer` | Engine systems | DeepSeek-V3.2 | Core engine, rendering, physics, memory management |
| `ai-programmer` | AI systems | DeepSeek-V3.2 | Behavior trees, pathfinding, NPC logic, state machines |
| `network-programmer` | Networking | DeepSeek-V3.2 | Netcode, replication, lag compensation, matchmaking |
| `tools-programmer` | Dev tools | DeepSeek-V3.2 | Editor extensions, pipeline tools, debug utilities |
| `ui-programmer` | UI implementation | GLM-5v-Turbo | UI framework, screens, widgets, data binding |
| `technical-artist` | Tech art | GLM-5v-Turbo | Shaders, VFX, optimization, art pipeline tools |
| `sound-designer` | Sound design | MiniMax-M2.7 | SFX design docs, audio event lists, mixing notes |
| `writer` | Dialogue/lore | MiniMax-M2.7 | Dialogue writing, lore entries, item descriptions |
| `world-builder` | World/lore design | MiniMax-M2.7 | World rules, faction design, history, geography |
| `qa-tester` | Test execution | DeepSeek-V3.2 | Writing test cases, bug reports, test checklists |
| `performance-analyst` | Performance | GLM-5.1 | Profiling, optimization recs, memory analysis |
| `devops-engineer` | Build/deploy | GLM-5.1 | CI/CD, build scripts, version control workflow |
| `analytics-engineer` | Telemetry | DeepSeek-V3.2 | Event tracking, dashboards, A/B test design |
| `ux-designer` | UX flows | GLM-5.1 | User flows, wireframes, accessibility, input handling |
| `prototyper` | Rapid prototyping | DeepSeek-V3.2 | Throwaway prototypes, mechanic testing, feasibility validation |
| `security-engineer` | Security | DeepSeek-V3.2 | Anti-cheat, exploit prevention, save encryption, network security |
| `accessibility-specialist` | Accessibility | GLM-5v-Turbo | WCAG compliance, colorblind modes, remapping, text scaling |
| `live-ops-designer` | Live operations | DeepSeek-V3.2 | Seasons, events, battle passes, retention, live economy |
| `community-manager` | Community | GLM-5.0-Turbo | Patch notes, player feedback, crisis comms, community health |
```

**行 56-56:**
```
## Engine-Specific Agents (use the set matching your engine)
```

**行 58-58:**
```
### Engine Leads
```

**行 60-66:**
```
| Agent | Engine | Model | When to Use |
| ---- | ---- | ---- | ---- |
| `unreal-specialist` | Unreal Engine 5 | DeepSeek-V3.2 | Blueprint vs C++, GAS overview, UE subsystems, Unreal optimization |
| `unity-specialist` | Unity | DeepSeek-V3.2 | MonoBehaviour vs DOTS, Addressables, URP/HDRP, Unity optimization |
| `godot-specialist` | Godot 4 | DeepSeek-V3.2 | GDScript patterns, node/scene architecture, signals, Godot optimization |
| `wechat-specialist` | WeChat Mini Game | DeepSeek-V3.2 | WeChat platform architecture (MVC/ECS), wx.* APIs, game loop optimization, state/resource management, audio systems, sub-specialist coordination |
| `cocos-specialist` | Cocos Creator | DeepSeek-V3.2 | Component system, scene graph, rendering pipeline, Cocos optimization |
```

**行 69-69:**
```
### Unreal Engine Sub-Specialists
```

**行 71-76:**
```
| Agent | Subsystem | Model | When to Use |
| ---- | ---- | ---- | ---- |
| `ue-gas-specialist` | Gameplay Ability System | DeepSeek-V3.2 | Abilities, gameplay effects, attribute sets, tags, prediction |
| `ue-blueprint-specialist` | Blueprint Architecture | GLM-5v-Turbo | BP/C++ boundary, graph standards, naming, BP optimization |
| `ue-replication-specialist` | Networking/Replication | GLM-5.1 | Property replication, RPCs, prediction, relevancy, bandwidth |
| `ue-umg-specialist` | UMG/CommonUI | DeepSeek-V3.2 | Widget hierarchy, data binding, CommonUI input, UI performance |
```

**行 78-78:**
```
### Unity Sub-Specialists
```

**行 80-85:**
```
| Agent | Subsystem | Model | When to Use |
| ---- | ---- | ---- | ---- |
| `unity-dots-specialist` | DOTS/ECS | DeepSeek-V3.2 | Entity Component System, Jobs, Burst compiler, hybrid renderer |
| `unity-shader-specialist` | Shaders/VFX | GLM-5.1 | Shader Graph, VFX Graph, URP/HDRP customization, post-processing |
| `unity-addressables-specialist` | Asset Management | DeepSeek-V3.2 | Addressable groups, async loading, memory, content delivery |
| `unity-ui-specialist` | UI Toolkit/UGUI | GLM-5v-Turbo | UI Toolkit, UXML/USS, UGUI Canvas, data binding, cross-platform input |
```

**行 87-87:**
```
### Godot Sub-Specialists
```

**行 89-93:**
```
| Agent | Subsystem | Model | When to Use |
| ---- | ---- | ---- | ---- |
| `godot-gdscript-specialist` | GDScript | DeepSeek-V3.2 | Static typing, design patterns, signals, coroutines, GDScript performance |
| `godot-shader-specialist` | Shaders/Rendering | GLM-5v-Turbo | Godot shading language, visual shaders, particles, post-processing |
| `godot-gdextension-specialist` | GDExtension | DeepSeek-V3.2 | C++/Rust bindings, native performance, custom nodes, build systems |
```

**行 95-95:**
```
### Cocos Creator Sub-Specialists
```

**行 97-106:**
```
| Agent | Subsystem | Model | When to Use |
| ---- | ---- | ---- | ---- |
| `cocos_2d-expert` | 2D Rendering | DeepSeek-V3.2 | Sprite, UI components, 2D graphics, text rendering, mask effects |
| `cocos_3d-expert` | 3D Rendering | DeepSeek-V3.2 | Mesh rendering, skinned animation, model management, LOD |
| `cocos_animation-expert` | Animation System | DeepSeek-V3.2 | Animation clips, skeletal animation, state machines, blending |
| `cocos_core-expert` | Core Engine | DeepSeek-V3.2 | Component system, scene graph, lifecycle management, event system |
| `cocos_gfx-expert` | Graphics API | DeepSeek-V3.2 | Shaders, GPU resources, cross-platform backends, rendering pipeline |
| `cocos_physics-expert` | 3D Physics | DeepSeek-V3.2 | Rigid bodies, collision detection, raycasting, joints |
| `cocos_physics-2d-expert` | 2D Physics | DeepSeek-V3.2 | Box2D integration, 2D collision detection, physics events |
| `cocos_rendering-expert` | Rendering Pipeline | DeepSeek-V3.2 | Camera system, lighting, shadows, post-processing, optimization |
```

**行 110-110:**
```
### WeChat Mini Game (微信小游戏) Sub-Specialists
```

**行 112-117:**
```
| Agent | Domain | Model | Reports To | When to Use |
| ---- | ---- | ---- | ---- | ---- |
| `wechat-minigame-specialist` | Gameplay & Physics | DeepSeek-V3.2 | wechat-specialist | Platform APIs, 4MB package limit, physics engines (Box2D/Bullet/JoltPhysics via unified IPhysicsWorld interface), WASM integration, Spine/DragonBones animation runtimes |
| `wechat-shader-specialist` | WebGL Shaders | GLM-5v-Turbo | wechat-specialist | Custom shaders, WebGL 1.0/2.0, Unity/Unreal/Godot shader conversion to GLSL, post-processing effects, render pipeline standards |
| `wechat-ui-specialist` | UI/UX Design | GLM-5v-Turbo | wechat-specialist | Figma/Sketch prototyping, Photoshop/Illustrator asset production, FairyGUI layout with data binding, screen management, portrait-first design, WeChat design system compliance |
| `wechat-cloudbase-specialist` | Cloud Backend | DeepSeek-V3.2 | wechat-specialist | Serverless backend, database, cloud functions, storage, security rules, anti-cheat |
```

**行 120-125:**
```
- `wechat-specialist` is the Engine Lead for the WeChat platform, coordinating all sub-specialists
- WeChat Mini Game specialists use TypeScript (preferred) for all JavaScript code
- 4MB package size limit is strictly enforced
- Audio format: AAC preferred, MP3 fallback; avoid WAV and OGG
- Cloud Base provides serverless backend with MongoDB-like database
- Real-name verification (实名制) and anti-addiction (防沉迷) compliance required for China market
```

**未翻译列表项:**
- 行 120: - `wechat-specialist` is the Engine Lead for the WeChat platform, coordinating all sub-specialists
- 行 121: - WeChat Mini Game specialists use TypeScript (preferred) for all JavaScript code
- 行 122: - 4MB package size limit is strictly enforced
- 行 123: - Audio format: AAC preferred, MP3 fallback; avoid WAV and OGG
- 行 124: - Cloud Base provides serverless backend with MongoDB-like database
- 行 125: - Real-name verification (实名制) and anti-addiction (防沉迷) compliance required for China market

--------------------------------------------------------------------------------

### .codebuddy\docs\templates\sprint-plan.md
- 未翻译段落数: 19
- 未翻译列表项数: 9

**未翻译段落:**

**行 5-5:**
```
[One sentence: what does this sprint achieve toward the current milestone?] / [一句话：此冲刺为实现当前里程碑实现了什么？]
```

**行 7-7:**
```
## Milestone Context
```

**行 9-11:**
```
- **Current Milestone**: [Name]
- **Milestone Deadline**: [Date]
- **Sprints Remaining**: [N]
```

**行 15-22:**
```
| Resource | Available Days | Allocated | Buffer (20%) | Remaining |
|----------|---------------|-----------|-------------|-----------|
| Programming | | | | |
| **Total** | | | | |
```

**行 26-26:**
```
### Must Have (Critical Path)
```

**行 28-31:**
```
| ID | Task | Agent/Owner | Est. Days | Dependencies | Acceptance Criteria | Status |
|----|------|-------------|-----------|-------------|-------------------|--------|
| S[N]-001 | | | | None | | Not Started |
| S[N]-002 | | | | S[N]-001 | | Not Started |
```

**行 35-37:**
```
| ID | Task | Agent/Owner | Est. Days | Dependencies | Acceptance Criteria | Status |
|----|------|-------------|-----------|-------------|-------------------|--------|
| S[N]-010 | | | | | | Not Started |
```

**行 39-39:**
```
### Nice to Have (Cut First)
```

**行 41-43:**
```
| ID | Task | Agent/Owner | Est. Days | Dependencies | Acceptance Criteria | Status |
|----|------|-------------|-----------|-------------|-------------------|--------|
| S[N]-020 | | | | | | Not Started |
```

**行 45-45:**
```
## Carryover from Sprint [N-1]
```

**行 47-48:**
```
| Original ID | Task | Reason for Carryover | New Estimate | Priority Change |
|------------|------|---------------------|-------------|----------------|
```

**行 50-50:**
```
## Risks to This Sprint
```

**行 52-53:**
```
| Risk | Probability | Impact | Mitigation | Owner |
|------|------------|--------|-----------|-------|
```

**行 55-55:**
```
## External Dependencies
```

**行 57-58:**
```
| Dependency | Status | Impact if Delayed | Contingency |
|-----------|--------|------------------|-------------|
```

**行 60-60:**
```
## Definition of Done
```

**行 62-67:**
```
- [ ] All Must Have tasks completed and passing acceptance criteria
- [ ] No S1 or S2 bugs in delivered features
- [ ] Code reviewed and merged to develop
- [ ] Design documents updated for any deviations from spec
- [ ] Test cases written and executed for all new features
- [ ] Asset naming and format standards met
```

**行 69-69:**
```
## Daily Status Tracking
```

**行 71-75:**
```
| Day | Tasks Completed | Tasks In Progress | Blockers | Notes |
|-----|----------------|------------------|----------|-------|
```

**未翻译列表项:**
- 行 9: - **Current Milestone**: [Name]
- 行 10: - **Milestone Deadline**: [Date]
- 行 11: - **Sprints Remaining**: [N]
- 行 62: - [ ] All Must Have tasks completed and passing acceptance criteria
- 行 63: - [ ] No S1 or S2 bugs in delivered features
- 行 64: - [ ] Code reviewed and merged to develop
- 行 65: - [ ] Design documents updated for any deviations from spec
- 行 66: - [ ] Test cases written and executed for all new features
- 行 67: - [ ] Asset naming and format standards met

--------------------------------------------------------------------------------

### .codebuddy\docs\agent-coordination-map.md
- 未翻译段落数: 7
- 未翻译列表项数: 19

**未翻译段落:**

**行 138-147:**
```
| 两名设计师对机制意见不一致 | game-designer |
| 游戏设计与叙事冲突 | creative-director |
| 游戏设计与技术可行性冲突 | producer（协调），然后 creative-director + technical-director |
| 美术与音频基调冲突 | creative-director |
| 代码架构分歧 | technical-director |
| 跨系统代码冲突 | lead-programmer，然后 technical-director |
| 部门间进度冲突 | producer |
| 范围超出能力 | producer，然后 creative-director 做裁剪 |
| 质量门控分歧 | qa-lead，然后 technical-director |
| 性能预算违规 | performance-analyst 标记，technical-director 决定 |
```

**行 280-284:**
```
When a design document changes, the game-designer must notify:
- lead-programmer (implementation impact)
- qa-lead (test plan update needed)
- producer (schedule impact assessment)
- Relevant specialist agents depending on the change
```

**行 287-290:**
```
- lead-programmer（实现影响）
- qa-lead（需要更新测试计划）
- producer（进度影响评估）
- 根据变更相关的专家代理
```

**行 294-298:**
```
When an ADR is created or modified, the technical-director must notify:
- lead-programmer (code changes needed)
- All affected specialist programmers
- qa-lead (testing strategy may change)
- producer (schedule impact)
```

**行 301-304:**
```
- lead-programmer（需要代码变更）
- 所有受影响的专家程序员
- qa-lead（测试策略可能变更）
- producer（进度影响）
```

**行 308-311:**
```
When the art bible or asset standards change, the art-director must notify:
- technical-artist (pipeline changes)
- All content creators working with affected assets
- devops-engineer (if build pipeline is affected)
```

**行 314-316:**
```
- technical-artist（管线变更）
- 所有使用受影响资产的内容创作者
- devops-engineer（如果构建管线受影响）
```

**未翻译列表项:**
- 行 281: - lead-programmer (implementation impact)
- 行 282: - qa-lead (test plan update needed)
- 行 283: - producer (schedule impact assessment)
- 行 287: - lead-programmer（实现影响）
- 行 288: - qa-lead（需要更新测试计划）
- 行 289: - producer（进度影响评估）
- 行 290: - 根据变更相关的专家代理
- 行 295: - lead-programmer (code changes needed)
- 行 296: - All affected specialist programmers
- 行 297: - qa-lead (testing strategy may change)
- 行 301: - lead-programmer（需要代码变更）
- 行 302: - 所有受影响的专家程序员
- 行 303: - qa-lead（测试策略可能变更）
- 行 304: - producer（进度影响）
- 行 309: - technical-artist (pipeline changes)
- 行 310: - All content creators working with affected assets
- 行 314: - technical-artist（管线变更）
- 行 315: - 所有使用受影响资产的内容创作者
- 行 316: - devops-engineer（如果构建管线受影响）

--------------------------------------------------------------------------------

### .codebuddy\docs\templates\collaborative-protocols\design-agent-protocol.md
- 未翻译段落数: 17
- 未翻译列表项数: 8

**未翻译段落:**

**行 44-44:**
```
User: "Design a crafting system"
```

**行 47-51:**
```
"I'd love to help design your crafting system. First, some questions:
 1. Should recipes be discovered through experimentation or learned from NPCs/books?
 2. How punishing should failed craft attempts be? (materials lost vs. partial recovery)
 3. Is this a core pillar system or a supporting feature?
 4. Any reference games? (Minecraft discovery, Terraria complexity, Stardew simplicity?)"
```

**行 53-53:**
```
User: [answers questions]
```

**行 55-56:**
```
You (present options):
"Based on your answers, here are three approaches:
```

**行 58-63:**
```
**Option A: Full Discovery System**
- Mechanics: [detailed description]
- ✅ Pros: [list with reasoning]
- ❌ Cons: [list with reasoning]
- Aligns with pillars: [analysis]
- Reference games: Minecraft, Doodle God
```

**行 65-66:**
```
**Option B: Recipe Book System**
- [similar structure]
```

**行 68-69:**
```
**Option C: Hybrid Discovery + Hints**
- [similar structure]
```

**行 71-71:**
```
I recommend Option C because [reasoning based on their goals], but you should choose based on what excites you most. Which approach fits your vision?"
```

**行 73-73:**
```
User: "Option C, but with X modification"
```

**行 75-76:**
```
You (draft iteratively):
"Great choice. Here's a draft of the Overview and Player Fantasy sections:
```

**行 80-80:**
```
Does this match your intent? Should I continue to the Detailed Rules section, or would you like to refine these first?"
```

**行 82-82:**
```
User: "Looks good, continue"
```

**行 84-84:**
```
You: [drafts next section, shows it, iterates]
```

**行 86-86:**
```
[After all sections complete]
```

**行 88-91:**
```
You (request approval):
"The complete crafting system design is ready. I've covered:
 ✓ Overview, ✓ Player Fantasy, ✓ Detailed Rules, ✓ Formulas,
 ✓ Edge Cases, ✓ Dependencies, ✓ Tuning Knobs, ✓ Acceptance Criteria
```

**行 93-93:**
```
 May I write this to design/gdd/crafting-system.md?"
```

**行 97-98:**
```
You: [uses Write tool]
     "Created design/gdd/crafting-system.md. Would you like me to run /design-review to validate it?"
```

**未翻译列表项:**
- 行 48: 1. Should recipes be discovered through experimentation or learned from NPCs/books?
- 行 59: - Mechanics: [detailed description]
- 行 60: - ✅ Pros: [list with reasoning]
- 行 61: - ❌ Cons: [list with reasoning]
- 行 62: - Aligns with pillars: [analysis]
- 行 63: - Reference games: Minecraft, Doodle God
- 行 66: - [similar structure]
- 行 69: - [similar structure]

--------------------------------------------------------------------------------

### .codebuddy\docs\templates\difficulty-curve.md
- 未翻译段落数: 23
- 未翻译列表项数: 1

**未翻译段落:**

**行 17-17:**
```
The four common difficulty philosophies are: / 四种常见的难度哲学是：
```

**行 19-30:**
```
1. **Masochistic challenge as the core fantasy**: Difficulty is the product.
   Overcoming it is the emotional reward. Reducing difficulty removes the
   point. (Dark Souls, Celeste at max assist off) / **受虐挑战作为核心幻想**：难度是产品。克服难度是情感奖励。降低难度就失去了意义。（黑魂，Celeste关闭最大辅助）
2. **Accessible entry, optional depth**: The base experience is completable by
   most players; depth and challenge are opt-in for those who want them.
   (Hades, Hollow Knight with accessibility modes) / **可访问的入口，可选的深度**：基础体验对大多数玩家是可完成的；深度和挑战是为那些想要的人提供的选项。（Hades，带无障碍模式的Hollow Knight）
3. **Difficulty serves narrative pacing**: Challenge rises and falls to match
   story beats. The player must feel capable during story resolution and
   threatened during story crisis. (The Last of Us, God of War) / **难度服务于叙事节奏**：挑战根据故事节拍起伏。玩家在故事解决时应有能力感，在故事危机时应有威胁感。（最后生还者，战神）
4. **Relaxed engagement**: Challenge is present but never the focus. Failure
   is gentle and infrequent. The experience prioritizes comfort and expression
   over obstacle. (Stardew Valley, Animal Crossing) / **放松的参与**：挑战存在但从不成为焦点。失败是温和且不频繁的。体验优先考虑舒适度和表达而非障碍。（星露谷物语，动物森友会）
```

**行 32-34:**
```
State the philosophy explicitly, then add one sentence on what the player is
permitted to feel: are they allowed to feel frustrated? For how long before the
design must intervene? What is the acceptable cost of failure? / 明确陈述哲学，然后添加一句关于玩家允许感受的内容：他们是否允许感到沮丧？在设计必须干预前可持续多久？可接受的失败成本是多少？]
```

**行 40-48:**
```
> **Guidance**: Most games have multiple independent dimensions of challenge.
> Identifying them explicitly prevents the mistake of tuning only one axis
> (usually execution difficulty) while leaving others unexamined. A game can
> feel "easy" on execution but overwhelming on decision complexity — players
> experience this as confusing, not engaging. / **指导**：大多数游戏有多个独立的挑战维度。明确识别它们可以防止仅调整一个维度（通常是执行难度）而忽略其他维度的错误。游戏在执行上可能感觉"简单"，但在决策复杂性上可能压倒性——玩家会感到困惑而非投入。
> For each axis, answer: can the player control or reduce this axis through
> choices, builds, or settings? If not, it is a forced challenge dimension —
> be very intentional about how it is used. / 对于每个维度，回答：玩家是否可以通过选择、构建或设置来控制或减少此维度？如果不能，这是强制挑战维度——对其使用方式要非常谨慎。
```

**行 51-51:**
```
|------|-------------|----------------|-----------------|
```

**行 73-73:**
```
|-------|----------|------------------------|----------------------|----------------------|---------------------|
```

**行 85-92:**
```
> **Guidance**: The first hour deserves its own detailed breakdown because it
> does the most difficult design work: it must teach every foundational skill
> without feeling like a lesson, and it must create enough investment that the
> player commits to the journey ahead. Research on player retention shows that
> most players who leave a game do so in the first 30 minutes — not because
> the game is bad, but because onboarding failed to connect them. / **指导**：第一小时值得有自己的详细分析，因为它做最困难的设计工作：它必须教授每个基础技能而不感觉像课程，并且必须创造足够的投入使玩家承诺继续旅程。玩家留存研究表明，大多数离开游戏的玩家在前30分钟内这样做——不是因为游戏差，而是因为引导期未能连接他们。
> The scaffolding principle (Vygotsky's Zone of Proximal Development, adapted for game design): introduce each mechanic in isolation before combining it with others. A player cannot learn two skills simultaneously under pressure. / 脚手架原则（Vygotsky的最优发展区，改编为游戏设计）：在与其他机制结合之前单独介绍每个机制。玩家不能在压力下同时学习两个技能。
```

**行 97-97:**
```
|------|-----------------------|--------------------------|
```

**行 112-112:**
```
|----------|--------------|--------------------|-----------------------|
```

**行 125-127:**
```
A well-designed first failure teaches rather than punishes. The player should
be able to immediately identify what they did wrong and what they would do
differently. If the cause of failure is ambiguous, the player blames the game. / 设计良好的首次失败是教导而非惩罚。玩家应能立即识别自己做错了什么以及会如何不同地做。如果失败原因模糊，玩家会责备游戏。
```

**行 135-138:**
```
[Identify the specific moment — not a vague window, but a specific beat —
where the player should shift from "learning" to "doing." This is the moment
of first competence: the first time their prediction about the game comes true,
or the first time they execute a plan and it works. / 识别具体时刻——不是模糊窗口，而是具体的节拍——玩家应从"学习"转向"执行"。这是首次能力的时刻：第一次他们对游戏的预测成真，或第一次执行计划并成功。
```

**行 140-142:**
```
This moment must happen within the first hour. If it does not, the player
will not reach Phase 3 of the journey (First Mastery). Design this moment
deliberately — do not leave it to chance. / 此时刻必须在一小时内发生。如果不发生，玩家将无法达到旅程的第三阶段（首次精通）。刻意设计此时刻——不要留给机会。
```

**行 144-145:**
```
What is the moment? What systems create it? What does the player do to
trigger it? How does the game communicate that they have succeeded? / 是什么时刻？什么系统创造它？玩家做什么来触发它？游戏如何传达他们已经成功？]
```

**行 151-163:**
```
> **Guidance**: A healthy difficulty curve follows a sawtooth pattern
> (Csikszentmihalyi's flow model applied to macro-structure): tension builds
> through a sequence, then releases at a milestone, then re-engages at a
> slightly higher baseline. Flat difficulty creates boredom; uninterrupted
> escalation creates fatigue. / **指导**：健康的难度曲线遵循锯齿模式（Csikszentmihalyi的心流模型应用于宏观结构）：紧张通过序列建立，然后在里程碑释放，然后在稍高的基线重新参与。平坦难度创造无聊；不间断升级创造疲劳。
> Spikes are intentional peaks that test accumulated skills. Valleys are
> intentional troughs that give the player space to breathe, experiment, and
> feel powerful before the next escalation. Both are designed, not emergent. / 尖峰是测试累积技能的有意峰值。谷值是有意低谷，给玩家空间呼吸、实验，并在下一次升级前感受强大。两者都是设计的，不是突发的。
> "Recovery design" is critical: what happens immediately after a spike? The
> player should exit a hard moment feeling accomplished, not depleted. Give
> them a valley, a reward, or a narrative payoff. / "恢复设计"至关重要：尖峰后立即发生什么？玩家应退出困难时刻时感觉有成就感，而非耗尽感。给他们谷值、奖励或叙事回报。
```

**行 166-166:**
```
|------|-----------------|------|---------|-----------------|
```

**行 187-187:**
```
|-------|----------|--------|----------------|-------------|-------|
```

**行 215-215:**
```
|-------|--------------|---------------------|-----------|-----------------|
```

**行 239-239:**
```
|-----------|--------|---------------------|----------|
```

**行 248-248:**
```
|--------------|---------------------|-----------------|
```

**行 257-266:**
```
> **Guidance**: When two systems operate simultaneously, their combined
> difficulty is often greater than the sum of their parts — or sometimes
> less. These interactions are frequently unintended and only surface during
> playtesting. Documenting anticipated interactions here creates a checklist
> for QA and playtest sessions. / **指导**：当两个系统同时操作时，它们的组合难度通常大于部分之和——有时更小。这些交互通常是无意的，仅在游戏测试期间显现。在此记录预期的交互为QA和游戏测试会话创建检查清单。
> "Is this intended?" Yes means the interaction is a designed feature.
> No means it should be mitigated. Partial means the interaction is
> acceptable in small doses but problematic if it becomes the dominant
> experience. / "这是预期的吗？"是意味着交互是设计的功能。否意味着应该缓解。部分意味着交互在小剂量时可接受，但如果成为主导体验则有问题。
```

**行 269-269:**
```
|----------|----------|----------------|-----------|
```

**行 280-284:**
```
> **Guidance**: These checkpoints structure playtesting sessions to verify
> the difficulty curve is achieving its intent. Each item should be checked
> with at least 3 playtester sessions before being marked complete. Note the
> playtester profile that revealed issues — difficulty problems are almost
> always player-profile-specific. / **指导**：这些检查点结构化游戏测试会话以验证难度曲线是否达到其意图。每个项目应在标记完成前用至少3个游戏测试者会话检查。记录揭示问题的游戏测试者配置——难度问题几乎总是玩家配置特定的。
```

**行 319-319:**
```
|----------|-------|----------|-----------|
```

**未翻译列表项:**
- 行 19: 1. **Masochistic challenge as the core fantasy**: Difficulty is the product.

--------------------------------------------------------------------------------

### .codebuddy\docs\templates\accessibility-requirements.md
- 未翻译段落数: 23
- 未翻译列表项数: 0

**未翻译段落:**

**行 32-37:**
```
> **Why define tiers**: Accessibility is not binary. Defining four tiers gives / **为什么定义层级**：无障碍不是二元的。定义四个层级给予
> the team a shared vocabulary, forces an explicit commitment at the start of / 团队共同词汇，在开始生产时强制明确的承诺，
> production, and prevents scope creep in both directions ("we'll add it later" / 并防止范围在两个方向上蔓延（"我们稍后添加"
> and "we have to support everything"). The tiers below are this project's / 和"我们必须支持一切"）。下面的层级是此项目的
> definitions — the industry uses similar but not identical language. Commit to / 定义——行业使用类似但不完全相同的语言。承诺
> a tier with specific feature targets, not just the tier name. / 一个具有具体功能目标的层级，而不仅仅是层级名称。
```

**行 42-42:**
```
|------|----------------|----------------|
```

**行 50-50:**
```
**Target Tier**: [Standard] / **目标层级**：[标准]
```

**行 52-59:**
```
**Rationale**: [Write 3-5 sentences justifying the tier choice. Do not simply / **理由**：[写3-5句话证明层级选择的合理性。不要简单
state the tier — explain the reasoning. Consider: What is the game's genre and / 陈述层级——解释推理。考虑：游戏的类型是什么以及
how does it map to common accessibility barriers (e.g., fast-twitch games have / 它如何映射到常见的无障碍障碍（例如，快速反应游戏有
motor barriers; reading-heavy games have visual barriers)? Who is the target / 运动障碍；阅读量大的游戏有视觉障碍）？谁是目标
player and what does the research say about disability prevalence in that group? / 玩家，关于该群体残疾流行率的研究怎么说？
What are the platform requirements (Xbox requires XAG compliance for ID@Xbox)? / 平台要求是什么（Xbox要求ID@Xbox符合XAG）？
What is the team's capacity? What would dropping one tier cost the player base, / 团队的容量如何？降低一个层级会对玩家群体造成什么成本，
in concrete terms? / 具体来说？
```

**行 70-70:**
```
**Features explicitly in scope (beyond tier baseline)**: / **明确在范围内的功能（超出层级基线）**：
```

**行 72-72:**
```
  game is dialogue-heavy and subtitles are a primary channel"] / 游戏对话密集且字幕是主要通道"]
```

**行 75-75:**
```
**Features explicitly out of scope**: / **明确不在范围内的功能**：
```

**行 92-92:**
```
|---------|-------------|-------|--------|---------------------|
```

**行 114-116:**
```
> Fill in every gameplay or UI element where color is currently the sole / 填写每个颜色当前是唯一区分器的
> differentiator. Resolve each before shipping. A resolved entry has a non-color / 游戏玩法或界面元素。在发布前解决每个问题。一个已解决的条目有非颜色
> backup that works in all three colorblind modes above. / 备份，在上述三种色盲模式下都有效。
```

**行 119-119:**
```
|----------|-------------|---------------------|-----------------|--------|
```

**行 129-136:**
```
> **Why motor accessibility matters for games**: Games are more motor-demanding / **为什么运动无障碍对游戏重要**：游戏比大多数软件需要更多的运动能力。
> than most software. A web form requires precise clicks; a game may require / 一个网页表单需要精确点击；一个游戏可能需要
> rapid simultaneous button combinations held for specific durations. Motor / 快速同时的按钮组合按住特定持续时间。运动
> impairments span a wide range — from tremor (affecting precision) to / 障碍范围很广——从震颤（影响精度）到
> hemiplegia (one functional hand) to RSI (affecting hold duration). The AbleGamers / 偏瘫（一只功能手）到RSI（影响按住持续时间）。AbleGamers
> Able Assistance program estimates 35 million gamers in the US have a disability / Able Assistance项目估计美国有3500万玩家有残疾
> affecting their ability to play. Many of the features below cost very little / 影响他们的游戏能力。下面的许多功能如果在开始时规划成本非常低，
> to implement if planned from the start, and are extremely expensive to add post-launch. / 而在发布后添加极其昂贵。
```

**行 139-139:**
```
|---------|-------------|-------|--------|---------------------|
```

**行 166-166:**
```
|---------|-------------|-------|--------|---------------------|
```

**行 189-189:**
```
|---------|-------------|-------|--------|---------------------|
```

**行 203-203:**
```
|-------------|---------------------|--------------|-----------------|--------|
```

**行 223-223:**
```
|----------|---------------|-----------------|--------|-------|
```

**行 243-243:**
```
|--------|----------------|---------------|-------------------|------------------|-----------|-------|
```

**行 264-264:**
```
|---------|------------|------------|--------------|-------------|--------|
```

**行 286-286:**
```
|---------|--------------|-----------------|--------------|------------|
```

**行 296-299:**
```
> **Why track audit history**: Accessibility is not certified once and done. / **为什么跟踪审核历史**：无障碍不是一次认证就完成。
> Platform requirements change. New features may introduce new barriers. Legal / 平台要求变化。新功能可能引入新障碍。法律
> standards evolve. An audit history demonstrates due diligence and helps identify / 标准发展。审核历史展示尽职调查并帮助识别
> regressions between audits. / 审核间的回归。
```

**行 302-302:**
```
|------|---------|------|-------|-----------------|--------|
```

**行 312-312:**
```
|----------|-----|-----------|
```

**行 327-327:**
```
|----------|-------|----------|-----------|
```

--------------------------------------------------------------------------------

### .codebuddy\docs\templates\pitch-document.md
- 未翻译段落数: 21
- 未翻译列表项数: 1

**未翻译段落:**

**行 3-4:**
```
*Version: [Draft Number] / 版本：[草稿编号]*
*Date: [Date] / 日期：[日期]*
```

**行 10-12:**
```
> [One powerful sentence. If someone reads nothing else, this should make them
> 一个有力的句子。如果有人只看这一句，就应该被吸引。]
```

**行 18-20:**
```
[2-3 sentences expanding the hook into a clear picture. Genre, setting, core
mechanic, and what makes it special. / 
2-3句话将钩子扩展为清晰的画面。类型、设定、核心机制，以及特别之处。]
```

**行 34-35:**
```
**Primary**: [Who is the core audience? Be specific — not "gamers" but
"roguelike fans who enjoy build-crafting and short sessions"] / **主要**：[谁是核心受众？具体说明——不是"玩家"，而是"喜欢构建制作和短会话的roguelike爱好者"]
```

**行 37-37:**
```
**Secondary**: [Adjacent audience who would also enjoy this] / **次要**：[可能也喜欢的相邻受众]
```

**行 39-39:**
```
**Market Size**: [Estimated TAM based on comparable titles] / **市场规模**：[基于类似作品的预估总目标市场]
```

**行 46-46:**
```
| ---- | ---- | ---- | ---- |
```

**行 56-57:**
```
[What does the player get to BE or DO? The emotional promise. / 
```

**行 60-60:**
```
[Describe the primary activity / 描述主要活动]
```

**行 63-64:**
```
[What does a typical session look like start to finish? / 
```

**行 67-68:**
```
[Why do players come back tomorrow? / 
```

**行 74-79:**
```
1. **[Feature Name]**: [1-2 sentence description of what it is and why it
   matters to the player] / **[特性名称]**：[1-2句描述它是什么以及为什么对玩家重要]
2. **[Feature Name]**: [Description] / **[特性名称]**：[描述]
3. **[Feature Name]**: [Description] / **[特性名称]**：[描述]
4. **[Feature Name]**: [Description] / **[特性名称]**：[描述]
5. **[Feature Name]**: [Description] / **[特性名称]**：[描述]
```

**行 85-87:**
```
[Brief description of the art style, mood, and visual tone. Include reference
images or mood board link if available. / 
简要描述艺术风格、情绪和视觉基调。如果可用，包含参考图片或情绪板链接。]
```

**行 89-90:**
```
**Art Style**: [e.g., "Hand-painted 2D with dynamic lighting, inspired by
Hollow Knight's atmosphere but with warmer colors"] / **艺术风格**：[例如，"手绘2D带动态光照，灵感来自《空洞骑士》的氛围但使用更温暖的色彩"]
```

**行 96-97:**
```
[Brief description of the sonic palette and musical direction. / 
```

**行 99-100:**
```
**Music**: [e.g., "Adaptive orchestral with folk instruments, shifting based
on biome and combat intensity"] / **音乐**：[例如，"自适应管弦乐加民族乐器，根据地貌和战斗强度变化"]
```

**行 102-103:**
```
**SFX**: [e.g., "Crunchy, satisfying impact sounds. Tactile feedback on every
player action."] / **音效**：[例如，"清脆、令人满意的打击音效。每个玩家动作都有触觉反馈。"]
```

**行 122-122:**
```
| ---- | ---- | ---- |
```

**行 129-131:**
```
**Team Size**: [X people, roles] / **团队规模**：[X人，角色]
**Engine**: [Godot / Unity / Unreal] / **引擎**：[Godot / Unity / Unreal]
**Estimated Budget**: [Range if applicable] / **预估预算**：[范围（如果适用）]
```

**行 138-138:**
```
| ---- | ---- | ---- | ---- |
```

**行 147-149:**
```
[What do you need? Funding, publishing deal, team members, feedback? Be
specific about what you're looking for and what you're offering in return. / 
你需要什么？资金、发行协议、团队成员、反馈？具体说明你寻求什么以及提供什么回报。]
```

**未翻译列表项:**
- 行 74: 1. **[Feature Name]**: [1-2 sentence description of what it is and why it

--------------------------------------------------------------------------------

### .codebuddy\docs\templates\post-mortem.md
- 未翻译段落数: 18
- 未翻译列表项数: 1

**未翻译段落:**

**行 10-10:**
```
[2-3 sentence summary of what this milestone/project accomplished] / [关于这个里程碑/项目完成了什么的2-3句摘要]
```

**行 15-15:**
```
| ---- | ------ | ------ | ------ |
```

**行 21-22:**
```
| ---- | ----- | ------ |
| [Date] | [What happened] | [How it affected the project] |
```

**行 24-24:**
```
## What Went Well
```

**行 26-26:**
```
### [Category 1: e.g., Technical Execution]
```

**行 27-29:**
```
**What**: [Description]
**Why it worked**: [Root cause of success]
**How to repeat**: [What to keep doing]
```

**行 31-31:**
```
### [Category 2: e.g., Team Coordination]
```

**行 32-34:**
```
**What**: [Description]
**Why it worked**: [Root cause]
**How to repeat**: [Action]
```

**行 36-36:**
```
## What Went Poorly
```

**行 38-38:**
```
### [Category 1: e.g., Scope Management]
```

**行 39-42:**
```
**What**: [Description]
**Root cause**: [Why this happened]
**Impact**: [Time/quality/morale cost]
**Prevention**: [How to avoid next time]
```

**行 44-44:**
```
### [Category 2]
```

**行 49-55:**
```
| Metric | Target | Actual | Notes |
| ------ | ------ | ------ | ----- |
| Tasks completed | [N] | [N] | |
| Bugs found | — | [N] | |
| Bugs fixed | — | [N] | |
| Estimation accuracy | 100% | [N%] | |
| Scope changes | 0 | [N] | |
```

**行 57-57:**
```
## Lessons Learned
```

**行 59-60:**
```
1. **[Lesson]**: [Explanation and how it changes future work]
2. **[Lesson]**: [Explanation]
```

**行 64-66:**
```
| # | Action | Owner | Deadline | Status |
| - | ------ | ----- | -------- | ------ |
| 1 | [Action] | [Who] | [When] | [Open/Done] |
```

**行 68-68:**
```
## Acknowledgments
```

**行 69-69:**
```
[Call out exceptional contributions]
```

**未翻译列表项:**
- 行 59: 1. **[Lesson]**: [Explanation and how it changes future work]

--------------------------------------------------------------------------------

### .codebuddy\docs\templates\skill-test-spec.md
- 未翻译段落数: 14
- 未翻译列表项数: 5

**未翻译段落:**

**行 5-7:**
```
[One paragraph: what this skill does, when to use it, what it produces. Include
the primary output artifact, the verdict format it uses, and which pipeline stage
it belongs to. / 一段话：这个技能做什么，何时使用它，它产生什么。包括主要输出产物、它使用的裁决格式以及它所属的流水线阶段。]
```

**行 13-13:**
```
Verified automatically by `/skill-test static` — no fixture needed. / 通过 `/skill-test static` 自动验证——无需固定装置。
```

**行 32-32:**
```
**Input:** `/[skill-name] [args]` / **输入：** `/[skill-name] [args]`
```

**行 34-34:**
```
**Expected behavior:** / **预期行为：**
```

**行 36-37:**
```
2. [Phase 2 action — what the skill should evaluate / 第2阶段行动 — 技能应该评估什么]
3. [Phase N action — what the skill should output / 第N阶段行动 — 技能应该输出什么]
```

**行 39-39:**
```
**Assertions:** / **断言：**
```

**行 53-53:**
```
**Input:** `/[skill-name] [args]` / **输入：** `/[skill-name] [args]`
```

**行 55-55:**
```
**Expected behavior:** / **预期行为：**
```

**行 57-58:**
```
2. [Phase 2: skill surfaces the gap rather than assuming OK / 第2阶段：技能暴露缺口而不是假设没问题]
3. [Output: FAIL or BLOCKED verdict with specific blocker named / 输出：FAIL 或 BLOCKED 裁决，并指名具体的阻碍物]
```

**行 60-60:**
```
**Assertions:** / **断言：**
```

**行 72-72:**
```
**Input:** `/[skill-name]` (no argument) / **输入：** `/[skill-name]`（无参数）
```

**行 74-74:**
```
**Expected behavior:** / **预期行为：**
```

**行 77-77:**
```
**Assertions:** / **断言：**
```

**行 94-97:**
```
[Document what is intentionally NOT tested in this spec and why. Examples:
- "Case 3 (all-mode) is not covered because it runs too many checks to evaluate
  in a single spec — test each sub-mode individually."
- "The database integration path is not covered as it requires a live environment."
```

**未翻译列表项:**
- 行 95: - "Case 3 (all-mode) is not covered because it runs too many checks to evaluate
- 行 97: - "The database integration path is not covered as it requires a live environment."
- 行 99: - "用例3（all-mode）未覆盖，因为它在单个规格中运行太多检查无法评估 — 单独测试每个子模式。"
- 行 100: - "数据库集成路径未覆盖，因为它需要实时环境。"
- 行 101: - "涉及损坏的YAML文件的边缘情况推迟到未来规格中处理。"]

--------------------------------------------------------------------------------

### .codebuddy\docs\templates\collaborative-protocols\implementation-agent-protocol.md
- 未翻译段落数: 17
- 未翻译列表项数: 1

**未翻译段落:**

**行 54-54:**
```
User: "Implement the damage calculation system per design/gdd/combat-system.md"
```

**行 56-57:**
```
You (read and analyze):
```

**行 59-60:**
```
"I've read the combat system design. The damage formula is:
 final_damage = base_damage * weapon_multiplier * crit_multiplier * (1 - resistance)
```

**行 62-66:**
```
Before I implement, a few architectural questions:
 1. Should DamageCalculator be a static utility or an autoload singleton?
 2. Where should weapon data live? (Equipment class? CharacterStats? Separate WeaponData resource?)
 3. The design doc doesn't specify rounding behavior. Round down, round up, or keep decimal damage?
 4. Should we emit a signal when damage is calculated (for VFX/SFX hookup)?"
```

**行 68-68:**
```
User: "Static utility in src/gameplay/combat/. Weapon data in Equipment class. Round down to int. Yes, emit signal."
```

**行 70-71:**
```
You (propose architecture):
"Got it. Here's the proposed structure:
```

**行 91-91:**
```
Constants like crit_mult (2.0) will move to assets/data/combat_config.json per the data-driven rule.
```

**行 93-93:**
```
Does this match your expectations? Any changes before I write the code?"
```

**行 95-95:**
```
User: "Looks good. Implement it."
```

**行 99-99:**
```
[gameplay-code rule flags hardcoded crit multiplier]
```

**行 101-101:**
```
"Implemented src/gameplay/combat/damage_calculator.gd.
```

**行 103-104:**
```
The gameplay-code rule flagged one issue: crit multiplier was hardcoded (2.0).
I moved it to assets/data/combat_config.json as 'critical_damage_multiplier': 2.0.
```

**行 106-109:**
```
File is ready. Would you like me to:
 A) Write tests now (recommended)
 B) Let you review the code first
 C) Run /code-review for architecture validation"
```

**行 111-111:**
```
User: "A, write tests"
```

**行 113-115:**
```
You: [creates tests/combat/test_damage_calculator.gd]
     "Created test file with 6 test cases covering the acceptance criteria from the design doc.
```

**行 117-117:**
```
      Running /story-done to verify acceptance criteria and close out the story."
```

**行 119-119:**
```
[/story-done runs — verifies criteria, checks deviations, prompts code review, updates story status]
```

**未翻译列表项:**
- 行 63: 1. Should DamageCalculator be a static utility or an autoload singleton?

--------------------------------------------------------------------------------

### .codebuddy\docs\templates\test-plan.md
- 未翻译段落数: 17
- 未翻译列表项数: 0

**未翻译段落:**

**行 14-14:**
```
|-------|------|------------------------|------------------------------|
```

**行 21-22:**
```
**Totals**: [N] Logic, [N] Integration, [N] Visual/Feel, [N] UI, [N] Config/Data / 
**总计**：[N]逻辑，[N]集成，[N]视觉/手感，[N]界面，[N]配置/数据
```

**行 32-32:**
```
**What to test**: / **测试内容**：
```

**行 37-37:**
```
**Edge cases to cover**: / **要覆盖的边界情况**：
```

**行 43-43:**
```
**Estimated test count**: ~[N] unit tests / **预估测试数量**：~[N]个单元测试
```

**行 51-51:**
```
**What to test**: / **测试内容**：
```

**行 79-79:**
```
Critical paths to verify before QA hand-off (run via `/smoke-check`): / 在QA移交前验证的关键路径（通过`/smoke-check`运行）：
```

**行 82-86:**
```
2. New game / session can be started / 可以开始新游戏/会话
3. [Primary mechanic introduced or changed this sprint] / [本次冲刺引入或更改的主要机制]
4. [System with regression risk from this sprint's changes] / [因本次冲刺更改存在回归风险的系统]
5. Save / load cycle completes without data loss (if save system exists) / 保存/加载循环完成无数据丢失（如果存在保存系统）
6. Performance is within budget on target hardware / 在目标硬件上的性能在预算范围内
```

**行 93-93:**
```
|-------|--------------|--------------|-------------------|
```

**行 96-96:**
```
Sign-off requirement: Playtest notes → `production/session-logs/playtest-[sprint]-[story-slug].md` / 签字要求：游戏测试笔记 → `production/session-logs/playtest-[冲刺]-[故事标识].md`
```

**行 98-98:**
```
If no playtest sessions required: *No playtest sessions required for this sprint.* / 如果不需要游戏测试会话：*本次冲刺不需要游戏测试会话。*
```

**行 104-104:**
```
A story is DONE when ALL of the following are true: / 当以下所有条件都满足时，故事才算完成：
```

**行 114-114:**
```
**Stories requiring playtest sign-off before close**: [list, or "None"] / **需要在关闭前获得游戏测试签字的业务**：[列表，或"无"]
```

**行 120-120:**
```
*Fill in after testing is complete.* / *测试完成后填写。*
```

**行 123-123:**
```
|-------|-----------|--------|--------|-------|
```

**行 133-133:**
```
|----|-------|----------|-------------|--------|
```

**行 144-145:**
```
*Template: `.codebuddy/docs/templates/test-plan.md`* / *模板：`.codebuddy/docs/templates/test-plan.md`*
*Generated by: `/qa-plan` — do not edit this line* / *生成者：`/qa-plan` — 不要编辑此行*
```

--------------------------------------------------------------------------------

### .codebuddy\docs\templates\economy-model.md
- 未翻译段落数: 13
- 未翻译列表项数: 0

**未翻译段落:**

**行 3-5:**
```
*Created: [Date] / 创建日期：[日期]*
*Owner: economy-designer / 负责人：economy-designer*
*Status: [Draft / Balanced / Live] / 状态：[草稿 / 平衡 / 已上线]*
```

**行 11-12:**
```
[What resources, currencies, and exchange systems does this economy cover?
What player behaviors does it incentivize? / 此经济模型涵盖哪些资源、货币和交换系统？它激励哪些玩家行为？]
```

**行 19-19:**
```
| ---- | ---- | ---- | ---- | ---- | ---- |
```

**行 34-34:**
```
| ---- | ---- | ---- | ---- | ---- |
```

**行 45-45:**
```
| ---- | ---- | ---- | ---- | ---- |
```

**行 56-56:**
```
| ---- | ---- | ---- |
```

**行 69-69:**
```
| ---- | ---- | ---- | ---- |
```

**行 75-75:**
```
*Formula*: `XP(n) = [formula, e.g., 100 * n^1.5] / 公式：XP(n) = [公式，例如：100 * n^1.5]`
```

**行 78-78:**
```
*Formula*: `Price(tier) = [formula, e.g., base_price * 2^(tier-1)] / 公式：价格(等级) = [公式，例如：基础价格 * 2^(等级-1)]`
```

**行 86-86:**
```
| ---- | ---- | ---- | ---- | ---- |
```

**行 93-93:**
```
[Describe how the pity system works to prevent extreme bad luck streaks. / 描述保底系统如何工作以防止极端厄运连击。]
```

**行 100-100:**
```
| ---- | ---- | ---- | ---- |
```

**行 121-122:**
```
[Include results from economy simulations if available: player wealth
distribution over time, sink effectiveness, inflation rate, etc. / 如果可用，包含经济模拟结果：玩家财富随时间分布、消耗效率、通货膨胀率等。]
```

--------------------------------------------------------------------------------

### .codebuddy\docs\coordination-rules.md
- 未翻译段落数: 1
- 未翻译列表项数: 11

**未翻译段落:**

**行 93-96:**
```
**Do not use agent teams when**:
- One session's output is required as input for another (use sequential subagents)
- The task fits in a single session's context (use subagents instead)
- Cost is a concern — each team member burns tokens independently
```

**未翻译列表项:**
- 行 83: - Work spans multiple subsystems that will not touch the same files
- 行 84: - Each workstream would take >30 minutes and benefits from true parallelism
- 行 85: - A senior agent (technical-director, producer) needs to coordinate 3+ specialist
- 行 89: - 工作跨多个子系统且不会触碰相同文件
- 行 90: - 每个工作流需要>30分钟且受益于真正的并行
- 行 91: - 高级代理（technical-director、producer）需要协调3+个专家会话同时处理不同史诗
- 行 94: - One session's output is required as input for another (use sequential subagents)
- 行 95: - The task fits in a single session's context (use subagents instead)
- 行 99: - 一个会话的输出是另一个的输入（使用顺序子代理）
- 行 100: - 任务适合单个会话的上下文（改用子代理）
- 行 101: - 成本是考虑因素 — 每个团队成员独立消耗token

--------------------------------------------------------------------------------

### .codebuddy\docs\templates\test-evidence.md
- 未翻译段落数: 12
- 未翻译列表项数: 0

**未翻译段落:**

**行 13-14:**
```
[One paragraph describing the feature or behaviour that was validated. Include
the acceptance criteria numbers from the story that this evidence covers.] / [一段话描述已验证的功能或行为。包括此证据覆盖的故事的验收标准编号。]
```

**行 16-16:**
```
**Acceptance criteria covered**: [AC-1, AC-2, AC-3] / **覆盖的验收标准：** [AC-1, AC-2, AC-3]
```

**行 23-23:**
```
|---|----------------------|--------|-------|
```

**行 36-36:**
```
|---|----------|--------------|----------------------|
```

**行 38-38:**
```
| 2 | `[filename.png]` | | AC-2 |
```

**行 40-40:**
```
*If video: note the timestamp and what it demonstrates.* / *如果是视频：记录时间戳及其展示的内容。*
```

**行 55-58:**
```
[Anything noteworthy that didn't cause a FAIL but should be recorded. Examples:
minor visual jitter, frame dip under load, behaviour that technically passes
but felt slightly off. These become candidates for polish work.] / [任何值得注意但未导致FAIL的内容都应记录。示例：
轻微的视觉抖动、负载下的帧率下降、技术上通过但感觉略有问题的行为。这些成为优化工作的候选。]
```

**行 63-63:**
```
If nothing notable: *No significant observations.* / 如果没有值得注意的：*无显著观察结果。*
```

**行 69-71:**
```
All three sign-offs are required before the story can be marked COMPLETE via
`/story-done`. Visual/Feel stories require the designer or art-lead sign-off.
UI stories require the UX lead or designer sign-off. / 在故事可以通过 `/story-done` 标记为完成之前，需要所有三个签字批准。视觉/感觉故事需要设计师或艺术主管签字。UI故事需要UX主管或设计师签字。
```

**行 74-74:**
```
|------|------|------|-----------|
```

**行 79-81:**
```
**Any sign-off can be marked "Deferred — [reason]"** if the person is
unavailable. Deferred sign-offs must be resolved before the story advances
past the sprint review. / **任何签字都可以标记为"延期 — [原因]"，** 如果相关人员不可用。延期签字必须在故事通过sprint评审之前解决。
```

**行 85-87:**
```
*Template: `.codebuddy/docs/templates/test-evidence.md`* / *模板：`.codebuddy/docs/templates/test-evidence.md`*
*Used for: Visual/Feel and UI story type evidence records* / *用于：视觉/感觉和UI故事类型的证据记录*
*Location: `production/qa/evidence/[story-slug]-evidence.md`* / *位置：`production/qa/evidence/[story-slug]-evidence.md`*
```

--------------------------------------------------------------------------------

### .codebuddy\docs\glossary.md
- 未翻译段落数: 5
- 未翻译列表项数: 5

**未翻译段落:**

**行 11-11:**
```
|------|------|------|
```

**行 15-15:**
```
| Template | 模板 | — |
```

**行 21-22:**
```
| YAML Frontmatter | YAML 前置元数据 | — |
| Path Scope | 路径作用域 | — |
```

**行 63-91:**
```
| Difficulty Curve | 难度曲线 | — |
| Sawtooth Pattern | 锯齿模式 | 难度曲线的形状 |
| Scaffolded Challenge | 脚手架挑战 | 逐步引入机制 |
| Power Curve | 力量曲线 | 进度增长的数学模型 |
| Tuning Knob | 调节旋钮 | 可调参数 |
| Feel Knob | 手感旋钮 | 影响即时体验的参数 |
| Curve Knob | 曲线旋钮 | 影响进度形状的参数 |
| Gate Knob | 门控旋钮 | 影响节奏的参数 |
| Sink/Faucet Model | 汇入/汇出模型 | 虚拟经济模型 |
| Faucet | 汇入 | 资源进入经济 |
| Sink | 汇出 | 资源离开经济 |
| Pity System | 保底系统 | 概率奖励的保底机制 |
| Gini Coefficient | 基尼系数 | 财富分布度量 |
| Transitive Balance | 传递平衡 | A > B > C |
| Intransitive Balance | 非传递平衡 | 石头剪刀布 |
| Frustra Balance | 挫败平衡 | 表面不平衡有隐藏对策 |
| Asymmetric Balance | 不对称平衡 | 不同能力同等可行 |
| Degenerate Strategy | 退化策略 | 主导策略/漏洞利用 |
| Edge Case | 边界情况 | — |
| MVP (Minimum Viable Product) | 最小可行产品 | — |
| Vertical Slice | 垂直切片 | — |
| Scope Creep | 范围蔓延 | — |
| Design Test | 设计测试 | 验证设计原则的具体决策 |
| Ludonarrative Dissonance | 玩法叙事失调 | 机制与叙事矛盾 |
| Ludonarrative Consonance | 玩法叙事一致 | 机制与叙事和谐 |
| Scope Tiers | 范围层级 | — |
| Experience Target | 体验目标 | — |
| Positioning Map | 定位图 | — |
| Anti-Pillar | 反支柱 | — |
```

**行 98-110:**
```
|------|------|------|
| Dependency Injection | 依赖注入 | — |
| Singleton | 单例 | — |
| Interface | 接口 | — |
| Cyclomatic Complexity | 圈复杂度 | — |
| Code Review | 代码审查 | — |
| Refactoring | 重构 | — |
| Architecture Decision Record (ADR) | 架构决策记录 | — |
| CI/CD | 持续集成/持续部署 | — |
| Technical Debt | 技术债务 | — |
| Design Pattern | 设计模式 | — |
| Data-Driven | 数据驱动 | — |
| Hardcoded | 硬编码 | — |
```

**未翻译列表项:**
- 行 174: 1. **保留原文**：英文原文始终完整保留，中文作为补充
- 行 180: - "精益" → "精简"（lean mode）
- 行 181: - "独奏" → "单人"（solo mode）
- 行 182: - "汇入/汇出" → 保留，但加注英文 (faucet/sink)
- 行 183: - "视觉锚点" → "视觉标识锚点"（Visual Identity Anchor）

--------------------------------------------------------------------------------

### .codebuddy\docs\templates\milestone-definition.md
- 未翻译段落数: 10
- 未翻译列表项数: 0

**未翻译段落:**

**行 12-15:**
```
[2-3 sentences describing what this milestone achieves and why it matters.
What can we demonstrate or evaluate at the end of this milestone? / 
2-3句话描述这个里程碑实现什么以及为什么重要。
在这个里程碑结束时，我们可以展示或评估什么？]
```

**行 19-21:**
```
[Specific, measurable criteria. The milestone is complete ONLY when all of
具体、可衡量的标准。只有在所有这些都满足时，里程碑才算完成。]
```

**行 35-35:**
```
|---------|-----------|-------|--------------|--------|
```

**行 40-40:**
```
|---------|-----------|-------|--------------|-----------|--------|
```

**行 45-45:**
```
|---------|-----------|-------|----------|
```

**行 50-50:**
```
|------|-----------|-------------------|
```

**行 61-61:**
```
|------|------------|--------|-----------|-------|--------|
```

**行 68-68:**
```
|---------|-----------|-------------------|--------|
```

**行 73-73:**
```
|-----------|---------|--------|----------------|
```

**行 78-78:**
```
|------|-----------|-----------|
```

--------------------------------------------------------------------------------

### .codebuddy\docs\templates\sound-bible.md
- 未翻译段落数: 10
- 未翻译列表项数: 0

**未翻译段落:**

**行 6-7:**
```
[Describe the overall audio personality of the game in 2-3 sentences. What does the game "sound like"? What emotions should the audio evoke? / 
用2-3句话描述游戏的整体音频个性。游戏听起来怎么样？音频应该唤起什么情感？]
```

**行 16-16:**
```
| ---- | ---- | ---- |
```

**行 25-26:**
```
[Primary musical style, instrumentation palette, tempo ranges / 
```

**行 35-35:**
```
| ---- | ---- | ---- |
```

**行 54-54:**
```
| ---- | ---- | ---- |
```

**行 62-62:**
```
When multiple sounds compete, this priority determines what plays: / 当多个声音竞争时，此优先级决定播放什么：
```

**行 64-67:**
```
2. Player actions (attacks, abilities) / 玩家动作（攻击、能力）
3. Enemy actions (nearby enemies first) / 敌人动作（先处理附近的敌人）
4. UI feedback / 界面反馈
5. Environment / ambient / 环境/环境音
```

**行 81-81:**
```
| ---- | ---- | ---- |
```

**行 106-106:**
```
| ---- | ---- | ---- | ---- | ---- |
```

**行 113-113:**
```
`[category]_[subcategory]_[name]_[variation].ext`
```

--------------------------------------------------------------------------------

### .codebuddy\docs\setup-requirements.md
- 未翻译段落数: 4
- 未翻译列表项数: 5

**未翻译段落:**

**行 19-21:**
```
| ---- | ---- | ---- |
| **Git** | 版本控制、分支管理 | [git-scm.com](https://git-scm.com/) |
| **CodeBuddy IDE** | AI代理IDE插件 | 从VS Code市场或JetBrains插件仓库安装 |
```

**行 41-41:**
```
**Windows** (any of these):
```

**行 109-112:**
```
CodeBuddy works with any editor, but the template is optimized for:
- **VS Code** with the CodeBuddy extension
- **Cursor** (CodeBuddy compatible)
- Terminal-based CodeBuddy CLI
```

**行 115-117:**
```
- **VS Code** + CodeBuddy扩展
- **Cursor**（CodeBuddy兼容）
- 基于终端的CodeBuddy CLI
```

**未翻译列表项:**
- 行 110: - **VS Code** with the CodeBuddy extension
- 行 111: - **Cursor** (CodeBuddy compatible)
- 行 115: - **VS Code** + CodeBuddy扩展
- 行 116: - **Cursor**（CodeBuddy兼容）
- 行 117: - 基于终端的CodeBuddy CLI

--------------------------------------------------------------------------------

### .codebuddy\docs\templates\level-design-document.md
- 未翻译段落数: 9
- 未翻译列表项数: 0

**未翻译段落:**

**行 40-40:**
```
[The mandatory route through the level, step by step. / 穿越关卡的强制路线，逐步说明。]
```

**行 43-44:**
```
2. [Description of what happens along the path / 沿路径发生的事件描述]
3. Player exits at [E] / 玩家在[E]点退出
```

**行 49-49:**
```
|------|-------------------|--------|---------------|
```

**行 54-54:**
```
|----------|------|-------------|---------|
```

**行 61-61:**
```
|----|----------|------------------|-----------|-------------|
```

**行 68-68:**
```
|----|----------|------|-------------|---------------|
```

**行 83-83:**
```
[Describe the intended rhythm: where are the peaks, valleys, rest points? / 描述预期节奏：峰值、谷值、休息点在哪里？]
```

**行 88-88:**
```
|-------------|------------|----------|---------|
```

**行 104-104:**
```
|------|----------|-----------|------|-------------|
```

--------------------------------------------------------------------------------

### .codebuddy\docs\hooks-reference\hook-input-schemas.md
- 未翻译段落数: 8
- 未翻译列表项数: 0

**未翻译段落:**

**行 13-13:**
```
### PreToolUse: Bash
```

**行 26-26:**
```
### PreToolUse: Write
```

**行 38-38:**
```
### PreToolUse: Edit
```

**行 51-51:**
```
### PreToolUse: Read
```

**行 68-68:**
```
### PostToolUse: Write
```

**行 81-81:**
```
### PostToolUse: Edit
```

**行 129-130:**
```
| Exit Code | Meaning | Applicable Events |
|-----------|---------|-------------------|
```

**行 138-141:**
```
|--------|------|----------|
| 2 | 阻止（stderr 显示给 Claude） | 仅 PreToolUse |
| 其他 | 视为错误，工具继续执行 | 所有事件 |
```

--------------------------------------------------------------------------------

### .codebuddy\docs\templates\narrative-character-sheet.md
- 未翻译段落数: 8
- 未翻译列表项数: 0

**未翻译段落:**

**行 18-19:**
```
[Physical description sufficient for the art team to create concept art.
Reference the art bible for style constraints. / 足够让美术团队创作概念图的物理描述。参考美术风格指南了解风格约束。]
```

**行 44-44:**
```
|---------|---------|-----------|-------------|
```

**行 50-50:**
```
[What does this character want more than anything? This drives every scene. / 这个角色最想要什么？这驱动着每个场景。]
```

**行 55-55:**
```
|-------|-------|---------------|
```

**行 62-62:**
```
[What contradictory desires or beliefs create internal tension? / 什么矛盾的欲望或信念造成了内心紧张？]
```

**行 67-67:**
```
|-----------|-------------|---------|-------------------|
```

**行 95-95:**
```
[What game states affect this character's dialogue? / 哪些游戏状态影响此角色的对话？]
```

**行 98-98:**
```
|-----------|----------------|
```

--------------------------------------------------------------------------------

### .codebuddy\docs\templates\technical-design-document.md
- 未翻译段落数: 6
- 未翻译列表项数: 0

**未翻译段落:**

**行 27-28:**
```
[2-3 sentence summary of what this system does and why it exists / 
2-3句话总结这个系统做什么以及为什么存在]
```

**行 52-52:**
```
| --------- | -------------- | ---- |
```

**行 87-87:**
```
| ---------- | -------- |
```

**行 91-91:**
```
| -------------- | -------- |
```

**行 101-102:**
```
[What this design intentionally does NOT support and why / 
```

**行 105-106:**
```
[What might need to change if requirements evolve — but do NOT build for this now / 
如果需求演变可能需要改变什么——但现在不要为此构建]
```

--------------------------------------------------------------------------------

### .codebuddy\docs\coding-standards.md
- 未翻译段落数: 1
- 未翻译列表项数: 4

**未翻译段落:**

**行 106-108:**
```
  - **Godot**: `godot --headless --script tests/gdunit4_runner.gd`
  - **Unity**: `game-ci/unity-test-runner@v4` (GitHub Actions)
  - **Unreal**: headless runner with `-nullrhi` flag
```

**未翻译列表项:**
- 行 13: - **Verification-driven development**: Write tests first when adding gameplay systems.
- 行 106: - **Godot**: `godot --headless --script tests/gdunit4_runner.gd`
- 行 107: - **Unity**: `game-ci/unity-test-runner@v4` (GitHub Actions)
- 行 108: - **Unreal**: headless runner with `-nullrhi` flag

--------------------------------------------------------------------------------

### .codebuddy\docs\technical-preferences.md
- 未翻译段落数: 5
- 未翻译列表项数: 0

**未翻译段落:**

**行 3-4:**
```
<!-- Populated by /setup-engine. Updated as the user makes decisions throughout development. -->
<!-- All agents reference this file for project-specific standards and conventions. -->
```

**行 22-23:**
```
<!-- Written by /setup-engine. Read by /ux-design, /ux-review, /test-setup, /team-ui, and /dev-story -->
<!-- to scope interaction specs, test helpers, and implementation to the correct input methods. -->
```

**行 99-101:**
```
<!-- Written by /setup-engine when engine is configured. -->
<!-- Read by /code-review, /architecture-decision, /architecture-review, and team skills -->
<!-- to know which specialist to spawn for engine-specific validation. -->
```

**行 122-123:**
```
<!-- Skills use this table to select the right specialist per file type. -->
<!-- If a row says [TO BE CONFIGURED], fall back to Primary for that file type. -->
```

**行 129-130:**
```
|-----------------------|---------------------|
| Game code (primary language) | [TO BE CONFIGURED] |
```

--------------------------------------------------------------------------------

### .codebuddy\docs\templates\risk-register-entry.md
- 未翻译段落数: 3
- 未翻译列表项数: 1

**未翻译段落:**

**行 5-5:**
```
- **ID**: RISK-[NNNN]
```

**行 18-18:**
```
[Detailed description of the risk. What could go wrong? Under what conditions? / 风险的详细描述。可能出现什么问题？在什么条件下？]
```

**行 22-22:**
```
[What observable conditions would indicate this risk is materializing? / 哪些可观察到的条件表明此风险正在发生？]
```

**未翻译列表项:**
- 行 5: - **ID**: RISK-[NNNN]

--------------------------------------------------------------------------------

### .codebuddy\docs\skills-reference.md
- 未翻译段落数: 3
- 未翻译列表项数: 0

**未翻译段落:**

**行 72-73:**
```
| `/ux-design` | 引导式逐章节UX规格编写（屏幕/流程、HUD或模式库） |
| `/ux-review` | 验证UX规格的GDD一致性、无障碍和模式合规性 |
```

**行 213-217:**
```
| `/release-checklist` | 为当前构建生成并验证预发布清单 |
| `/launch-checklist` | 跨所有部门的完整上线就绪验证 |
| `/changelog` | 从git提交和冲刺数据自动生成变更日志 |
| `/patch-notes` | 从git历史和内部数据生成面向玩家的补丁说明 |
| `/hotfix` | 带审计追踪的紧急修复工作流，绕过正常冲刺流程 |
```

**行 257-265:**
```
| `/team-combat` | 游戏设计师 + 游戏逻辑程序员 + AI程序员 + 技术美术 + 音效设计师 + QA测试员 |
| `/team-narrative` | 叙事总监 + 作家 + 世界构建师 + 关卡设计师 |
| `/team-ui` | UX设计师 + UI程序员 + 美术总监 + 无障碍专家 |
| `/team-release` | 发布经理 + QA主管 + 运维工程师 + 制作人 |
| `/team-polish` | 性能分析师 + 技术美术 + 音效设计师 + QA测试员 |
| `/team-audio` | 音频总监 + 音效设计师 + 技术美术 + 游戏逻辑程序员 |
| `/team-level` | 关卡设计师 + 叙事总监 + 世界构建师 + 美术总监 + 系统设计师 + QA测试员 |
| `/team-live-ops` | 在线运营设计师 + 经济设计师 + 社区经理 + 数据分析工程师 |
| `/team-qa` | QA主管 + QA测试员 + 游戏逻辑程序员 + 制作人 |
```

--------------------------------------------------------------------------------

### .codebuddy\docs\CODEBUDDY-local-template.md
- 未翻译段落数: 0
- 未翻译列表项数: 1

**未翻译列表项:**
- 行 37: 1. Copy this template to your project root: `cp .codebuddy/docs/CODEBUDDY-local-template.md CODEBUDDY.local.md`

--------------------------------------------------------------------------------

### .codebuddy\docs\settings-local-template.md
- 未翻译段落数: 1
- 未翻译列表项数: 0

**未翻译段落:**

**行 35-36:**
```
Use **normal mode** — Claude asks before running most commands. This is safest
```

--------------------------------------------------------------------------------

### .codebuddy\docs\hooks-reference\post-merge-asset-validation.md
- 未翻译段落数: 1
- 未翻译列表项数: 0

**未翻译段落:**

**行 5-6:**
```
Runs after any merge to the `develop` or `main` branch that includes changes
```

--------------------------------------------------------------------------------

### .codebuddy\docs\hooks-reference\post-sprint-retrospective.md
- 未翻译段落数: 1
- 未翻译列表项数: 0

**未翻译段落:**

**行 12-15:**
```
Automatically generates a retrospective starting point by analyzing the sprint
data: what was planned vs completed, velocity changes, bug trends, and common
blockers. This is not a git hook but a workflow hook invoked through the
```

--------------------------------------------------------------------------------

### .codebuddy\docs\hooks-reference\pre-push-test-gate.md
- 未翻译段落数: 1
- 未翻译列表项数: 0

**未翻译段落:**

**行 5-6:**
```
Runs before any push to a remote branch. Mandatory for pushes to `develop`
```

--------------------------------------------------------------------------------

