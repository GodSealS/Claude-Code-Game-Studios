# Agent Test Spec: cocos_animation-expert / Cocos Creator动画系统专家代理测试规范

> **中文翻译**：此文件为Cocos Creator动画系统专家代理的测试规范。所有测试断言和用例保持英文原文以确保可执行性。


## Agent Summary / 代理摘要
Domain: Cocos Creator animation systems: keyframe animation, skeletal animation, state machines, blending, animation events, and performance optimization.
Does NOT own: 2D/3D rendering (cocos_2d-expert, cocos_3d-expert), physics (cocos_physics-expert), core engine (cocos_core-expert).
Model tier: DeepSeek-V3.2 (default).
No gate IDs assigned.

---

## Static Assertions (Structural) / 静态断言（结构）

- [ ] `description:` field is present and domain-specific (references animation systems, skeletal animation, state machines, blending)
- [ ] `allowed-tools:` list includes Read, Write, Edit, Bash, Glob, Grep
- [ ] Model tier is DeepSeek-V3.2 (default for specialists)
- [ ] Agent definition does not claim authority over rendering or physics
- [ ] File scope includes only animation-related files (under `cocos/animation/` directory)

---

## Test Cases / 测试用例

<!-- 用例 1：域内请求 — 适当输出 -->
### Case 1: In-domain request — appropriate output
**Input:** "Create a simple idle/walk/run animation state machine for a 2D character."
**Expected behavior:**
- Implements animation state machine using `cc.AnimationState` or custom FSM
- Defines transitions between idle, walk, run states based on velocity
- Uses sprite animation clips for each state
- Implements cross-fade blending between states
- Follows Cocos Creator's animation system patterns

<!-- 用例 2：错误域重定向 -->
### Case 2: Wrong-domain redirect
**Input:** "Set up 3D mesh rendering with material properties."
**Expected behavior:**
- Does NOT produce 3D rendering implementation code
- Clearly identifies that this is a 3D rendering task
- Refers to cocos_3d-expert for mesh rendering implementation
- May provide conceptual mapping if relevant (e.g., "animation can be applied to skinned mesh")

<!-- 中文翻译 -->
### Case 3: Skeletal animation setup
**Input:** "Configure skeletal animation for a 3D character with bone weights and skinning."
**Expected behavior:**
- Sets up `cc.SkeletonAnimation` component with bone hierarchy
- Configures animation clips for different actions
- Implements bone weight painting and skinning setup
- Handles animation blending between different skeletal clips
- Follows Cocos Creator's skeletal animation workflow

<!-- 中文翻译 -->
### Case 4: Animation blending techniques
**Input:** "Implement layer blending for upper body and lower body animations."
**Expected behavior:**
- Creates animation layer system for separate body parts
- Implements blend weights for each layer (e.g., 100% lower body walk, 50% upper body aim)
- Handles synchronization between layers
- Provides example of dynamic weight adjustment based on gameplay
- Follows project's animation architecture

<!-- 中文翻译 -->
### Case 5: Animation events and callbacks
**Input:** "Add events to animation timeline for footstep sounds and attack hit frames."
**Expected behavior:**
- Implements animation event callbacks using `cc.AnimationClip` event tracks
- Creates event handler system for different event types
- Provides example for sound playback and particle effects
- Handles timing precision and frame-rate independence
- Follows Cocos Creator's animation event patterns

<!-- 中文翻译 -->
### Case 6: Animation performance optimization
**Input:** "Our game has many animated characters causing performance issues. How to optimize?"
**Expected behavior:**
- Recommends using animation LOD (Level of Detail)
- Suggests GPU skinning for complex skeletal animations
- Advises animation culling for off-screen characters
- Mentions animation compression and sampling rate reduction
- Provides profiling guidance with Cocos Creator's animation debug tools

---

<!-- 协议合规性 -->
## Protocol Compliance

- [ ] Stays within declared domain (animation systems, skeletal animation, state machines, blending)
- [ ] Does NOT write rendering, physics, or core engine code
- [ ] Follows existing code patterns (component-based, event-driven, state-machine)
- [ ] Maintains backward compatibility; does not break existing APIs
- [ ] New features include test cases
- [ ] Uses `cocos_animation` Skill for domain knowledge reference
