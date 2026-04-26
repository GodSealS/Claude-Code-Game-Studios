# Agent Test Spec: wechat-specialist

## Agent Summary / 代理摘要
Domain: WeChat Mini Game platform architecture decisions, wx.* API best practices, package size management (4MB limit), game loop optimization, state/resource management, audio systems, and coordination of WeChat sub-specialists.
Does NOT own: Gameplay implementation (delegates to wechat-minigame-specialist), shader code (wechat-shader-specialist), UI design/implementation (wechat-ui-specialist), cloud functions (wechat-cloudbase-specialist).
Model tier: Kimi-K2.5 (Selected for complex architectural synthesis and platform-specific constraints analysis).
No gate IDs assigned.

---

<!-- 静态断言（结构） -->
## Static Assertions (Structural)

- [ ] `description:` field is present and domain-specific (references WeChat Mini Game platform, wx.* APIs, 4MB package limit)
- [ ] `allowed-tools:` list includes Read, Write, Edit, Bash, Glob, Grep
- [ ] Model tier is Kimi-K2.5 (Strategic choice for architectural oversight; NOT the code-authoring specialist default)
- [ ] Agent definition references `docs/engine-reference/wechat/VERSION.md` as the authoritative API source
- [ ] Agent acknowledges the WeChat sub-specialist routing table (minigame, shader, ui, cloudbase)

---

## Test Cases / 测试用例

<!-- 中文翻译 -->
### Case 1: In-domain request — MVC vs ECS architecture decision
**Input:** "Should I use MVC or ECS architecture for this puzzle game targeting WeChat Mini Games?"
**Expected behavior:**
- Produces a decision guide with rationale:
  - MVC: UI-heavy games (menu-driven, card games, puzzle games), simpler data flow, easier for designers to understand
  - ECS: Entity-heavy games (shooters, physics games, games with many objects), better performance for large numbers of entities
- Considers WeChat-specific constraints: memory usage, CPU performance on mobile devices
- Does NOT produce raw code for both patterns — refers to wechat-minigame-specialist for implementation
- Notes the 4MB package size impact of each approach (ECS may require more upfront code)

<!-- 用例 2：错误引擎重定向 -->
### Case 2: Wrong-engine redirect
**Input:** "Write a MonoBehaviour that runs on Start() and subscribes to a UnityEvent."
**Expected behavior:**
- Does NOT produce Unity MonoBehaviour code
- Clearly identifies that this is a Unity pattern, not a WeChat Mini Game pattern
- Provides the WeChat equivalent: a TypeScript class using `onLoad()` instead of `Start()`, and WeChat custom events or RxJS observables instead of UnityEvent
- Confirms the project is WeChat-based and redirects the conceptual mapping
- Notes that WeChat Mini Games use TypeScript/JavaScript, not C#

<!-- 中文翻译 -->
### Case 3: Package size limit violation
**Input:** "Our main package is 5.2MB. What should we do?"
**Expected behavior:**
- Identifies that 5.2MB exceeds the 4MB WeChat Mini Game main package limit
- Provides structured solutions:
  1. Move assets to subpackages using `wx.loadSubpackage()`
  2. Compress images to WebP format
  3. Use texture atlases to reduce file count
  4. Remove unused assets (WeChat build doesn't tree-shake automatically)
  5. Consider loading large libraries (physics engines) as remote resources
- Does NOT suggest ignoring the limit — emphasizes it's a hard platform constraint
- Provides specific wx.* API examples for subpackage loading

<!-- 中文翻译 -->
### Case 4: WeChat API version compatibility
**Input:** "Use the new wx.createOffscreenCanvas() API for background rendering."
**Expected behavior:**
- Identifies `wx.createOffscreenCanvas()` as a specific WeChat API feature
- Flags the version risk: API may require a minimum WeChat version or base library version
- Directs the user to verify against `docs/engine-reference/wechat/VERSION.md` and official WeChat documentation
- Provides best-effort guidance while clearly marking it as unverified
- Suggests feature detection pattern:
  ```typescript
  if (typeof wx.createOffscreenCanvas === 'function') {
    // Use the API
  } else {
    // Fallback to regular canvas
  }
  ```

<!-- 中文翻译 -->
### Case 5: Sub-specialist delegation
**Input:** "Implement a physics-based character controller for our platformer game."
**Expected behavior:**
- Does NOT implement the physics controller directly
- Recognizes this requires physics engine integration (Box2D/Bullet/JoltPhysics)
- Delegates to `wechat-minigame-specialist` with clear context:
  - Game type: platformer (2D)
  - Recommended physics engine: Box2D (2D, ~500KB WASM)
  - Performance requirements: 60fps on mid-range devices
  - Package size constraints
- Explains the delegation: "Physics implementation is handled by wechat-minigame-specialist who owns the physics engine abstraction layer"
- Provides high-level architecture guidance before delegation

<!-- 中文翻译 -->
### Case 6: Context pass — WeChat version and device constraints
**Input:** Project context provided: Target WeChat version 8.0.25, mid-range Android devices. Request: "Design the game loop for smooth 60fps."
**Expected behavior:**
- Reads the WeChat version and device constraints
- Recommends game loop optimizations appropriate for mid-range Android:
  - Fixed timestep physics (1/60s)
  - Frame skipping when falling behind
  - Object pooling for frequently created/destroyed objects
  - Texture atlas batching to reduce draw calls
- References `wx.getSystemInfoSync()` for device capability detection
- Notes that WeChat 8.0.25 has specific performance characteristics and API availability
- Provides code example for accumulator-based game loop:
  ```typescript
  class GameLoop {
    private accumulator: number = 0;
    private readonly fixedDt: number = 1 / 60;
    
    update(dt: number): void {
      this.accumulator += dt;
      while (this.accumulator >= this.fixedDt) {
        this.physicsStep(this.fixedDt);
        this.accumulator -= this.fixedDt;
      }
      this.render(this.accumulator / this.fixedDt);
    }
  }
  ```

<!-- 中文翻译 -->
### Case 7: Social feature implementation
**Input:** "Add share functionality so players can share their high scores."
**Expected behavior:**
- Provides WeChat-specific share implementation using `wx.shareAppMessage()`
- Includes best practices:
  - Meaningful share content (score, screenshot, invite message)
  - Image generation from canvas (`canvas.toTempFilePathSync()`)
  - Query parameters for tracking (`shareId=123&score=1000`)
  - Timing: share after natural break points, not intrusive
- Does NOT implement generic social sharing — uses WeChat-native API
- Notes permission requirements and user experience considerations
- Example:
  ```typescript
  wx.shareAppMessage({
    title: 'I just scored 1000 points in Awesome Game!',
    imageUrl: canvas.toTempFilePathSync(),
    query: 'shareId=123&score=1000'
  });
  ```

---

## Protocol Compliance / 协议合规

- [ ] Stays within declared domain (WeChat platform architecture, wx.* APIs, package size management, sub-specialist coordination)
- [ ] Redirects wrong-engine requests to appropriate engine specialists or flags them as wrong-engine
- [ ] Redirects physics implementation to wechat-minigame-specialist
- [ ] Redirects shader implementation to wechat-shader-specialist
- [ ] Redirects UI implementation to wechat-ui-specialist
- [ ] Redirects cloud functions to wechat-cloudbase-specialist
- [ ] Flags WeChat version-gated APIs and requires version confirmation before suggesting them
- [ ] Enforces 4MB package size limit in all recommendations
- [ ] Returns structured pattern decision guides, not freeform opinions

---

<!-- 覆盖说明 -->
## Coverage Notes

- MVC vs ECS decision guide (Case 1) should be written to `docs/architecture/wechat/` as a reusable pattern doc
- Package size limit handling (Case 3) confirms the agent prioritizes platform constraints over feature completeness
- Sub-specialist delegation (Case 5) verifies the agent delegates implementation to appropriate experts
- Social feature implementation (Case 7) ensures WeChat-native APIs are used instead of generic solutions
- Version awareness (Case 4) confirms the agent does not confidently use APIs it cannot verify
- Device constraints (Case 6) verifies the agent applies performance optimization for target hardware

<!-- 中文翻译标记 / Chinese translation marker -->
