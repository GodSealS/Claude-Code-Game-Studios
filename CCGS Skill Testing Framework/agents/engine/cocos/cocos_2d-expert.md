# Agent Test Spec: cocos_2d-expert

## Agent Summary
Domain: Cocos Creator 2D rendering systems: sprites, UI components, text rendering, 2D graphics, masks, clipping, and 2D performance optimization.
Does NOT own: 3D rendering (cocos_3d-expert), animation systems (cocos_animation-expert), core engine (cocos_core-expert).
Model tier: sonnet (default for specialists).
No gate IDs assigned.

---

## Static Assertions (Structural)

- [ ] `description:` field is present and domain-specific (references Cocos Creator 2D rendering, sprites, UI, text)
- [ ] `allowed-tools:` list includes Read, Write, Edit, Bash, Glob, Grep
- [ ] Model tier is sonnet (default for specialists)
- [ ] Agent definition does not claim authority over 3D rendering or animation systems
- [ ] File scope includes only 2D-related files (under `cocos/2d/` directory)

---

## Test Cases

### Case 1: In-domain request — appropriate output
**Input:** "Create a UI button with normal/hover/pressed states using sprite frames."
**Expected behavior:**
- Produces a TypeScript component extending `cc.Component`
- Uses `cc.Sprite` component with sprite frame switching for states
- Implements `onTouchStart`, `onTouchEnd`, `onTouchCancel` event handlers
- Follows Cocos Creator naming conventions (camelCase for methods, PascalCase for classes)
- Includes proper import statements for `cc` modules
- Uses `@property` decorator for serializable sprite frame references

### Case 2: Wrong-domain redirect
**Input:** "Set up a 3D skinned mesh animation for the player character."
**Expected behavior:**
- Does NOT produce 3D animation code
- Clearly identifies that this is a 3D animation task
- Refers to cocos_3d-expert for 3D model rendering
- Refers to cocos_animation-expert for animation systems
- May provide conceptual mapping if relevant (e.g., "2D sprite animation uses different patterns")

### Case 3: Performance optimization
**Input:** "Our 2D game has too many draw calls due to many separate sprites. How to batch them?"
**Expected behavior:**
- Recommends using sprite atlases and texture packing
- Suggests enabling `cc.Sprite` auto-batching where appropriate
- Advises grouping static sprites under same node hierarchy
- Mentions Cocos Creator's draw call profiler tool
- Provides TypeScript code example for manual batching if complex case

### Case 4: Text rendering with custom font
**Input:** "Implement a label using a custom TTF font with outline effect."
**Expected behavior:**
- Creates a `cc.Label` component with custom TTF font
- Implements outline effect using `cc.LabelOutline` component or custom shader
- Handles font loading and fallback scenarios
- Includes multi-resolution adaptation for text size
- Follows project's asset pipeline conventions

### Case 5: Mask and clipping system
**Input:** "Create a circular mask for a sprite to show only a circular portion."
**Expected behavior:**
- Uses `cc.Mask` component with circular shape
- Implements proper parent-child relationship for masking
- Handles dynamic resizing of mask and content
- Provides example of animated mask (e.g., expanding circle)
- Notes performance considerations for complex masks

### Case 6: 2D graphics drawing
**Input:** "Draw a dynamic progress bar with rounded corners using Graphics component."
**Expected behavior:**
- Creates a `cc.Graphics` component for vector drawing
- Implements `drawRoundedRect` method for progress bar background
- Dynamically fills the progress based on a percentage value
- Uses different colors for different progress states
- Optimizes redraw frequency to avoid performance issues

---

## Protocol Compliance

- [ ] Stays within declared domain (Cocos Creator 2D rendering, UI, sprites, text, graphics)
- [ ] Does NOT write 3D rendering, animation, or core engine code
- [ ] Follows existing code patterns (component-based, ui-system)
- [ ] Maintains backward compatibility; does not break existing APIs
- [ ] New features include test cases
- [ ] Uses `cocos_2d` Skill for domain knowledge reference