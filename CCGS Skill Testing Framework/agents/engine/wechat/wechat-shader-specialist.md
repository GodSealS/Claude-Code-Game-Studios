# Agent Test Spec: wechat-shader-specialist

## Agent Summary / 代理摘要
Domain: WebGL shader development for WeChat Mini Games, shader conversion from other engines (Unity/Unreal/Godot → GLSL), rendering optimization, WebGL 1.0 vs 2.0 decisions, and shader performance/quality tiers.
Does NOT own: Gameplay implementation (wechat-minigame-specialist), UI design/implementation (wechat-ui-specialist), architecture decisions (wechat-specialist).
Model tier: DeepSeek-V3.2 (default for technical specialists).
No gate IDs assigned.

---

<!-- 静态断言（结构） -->
## Static Assertions (Structural)

- [ ] `description:` field is present and domain-specific (references WebGL shaders, GLSL, rendering optimization, shader conversion)
- [ ] `allowed-tools:` list includes Read, Write, Edit, Bash, Glob, Grep
- [ ] Model tier is DeepSeek-V3.2 (default for specialists)
- [ ] Agent definition does not claim authority over gameplay or UI implementation
- [ ] Agent references WebGL constraints specific to WeChat Mini Game environment

---

## Test Cases / 测试用例

<!-- 中文翻译 -->
### Case 1: In-domain request — WebGL 1.0 vs 2.0 decision
**Input:** "Should we target WebGL 1.0 or 2.0 for our WeChat Mini Game?"
**Expected behavior:**
- Provides structured decision criteria:
  - WebGL 1.0: Maximum compatibility (older WeChat versions, low-end devices), simpler shader model
  - WebGL 2.0: Advanced features (instanced rendering, multiple render targets, better texture formats), better performance on supported devices
- Recommends feature detection pattern:
  ```typescript
  function getWebGLVersion(): '1.0' | '2.0' | 'none' {
    const canvas = wx.createCanvas();
    const gl = canvas.getContext('webgl2') || canvas.getContext('webgl');
    if (gl instanceof WebGL2RenderingContext) return '2.0';
    if (gl instanceof WebGLRenderingContext) return '1.0';
    return 'none';
  }
  ```
- Suggests progressive enhancement: build for WebGL 1.0, add WebGL 2.0 optimizations where available
- Considers WeChat version distribution data for compatibility decisions

<!-- 中文翻译 -->
### Case 2: Shader conversion from Unity Shader Graph
**Input:** "Convert this Unity Shader Graph node setup to GLSL for WeChat Mini Games."
**Input includes:** Unity Shader Graph screenshot or node description.
**Expected behavior:**
- Does NOT produce Unity ShaderLab code
- Analyzes the Unity shader functionality (e.g., PBR, unlit, sprite)
- Produces equivalent GLSL shader with WeChat-specific considerations:
  - Uses `precision mediump float;` for mobile compatibility
  - Avoids WebGL 1.0 unsupported features (textureGrad, derivative instructions)
  - Converts Unity-specific uniforms to WebGL equivalents
  - Adds fallbacks for missing features on WebGL 1.0
- Provides conversion table for common Unity → WebGL mappings:
  ```
  Unity _Time → WebGL iTime
  Unity _MainTex → WebGL texture sampler
  Unity _Color → WebGL uniform vec4
  ```
- Notes limitations: Some Unity Shader Graph features may not have direct WebGL equivalents

<!-- 中文翻译 -->
### Case 3: Performance optimization for mobile devices
**Input:** "Our fragment shader is causing performance issues on low-end Android devices. How do we optimize it?"
**Expected behavior:**
- Provides mobile-specific shader optimization techniques:
  1. Reduce texture samples: combine textures, use texture atlases
  2. Lower precision: `precision mediump float;` instead of `highp`
  3. Simplify math: avoid `pow()`, `sin()`, `cos()` in fragment shaders when possible
  4. Early depth testing: `gl_FragDepth` optimization
  5. Branch reduction: minimize `if` statements in shaders
  6. Use vertex shader for calculations when possible
- Includes code examples of optimized vs unoptimized shaders
- Recommends profiling with `EXT_disjoint_timer_query` if available
- Notes WeChat-specific constraints: limited GPU memory, thermal throttling on mobile

<!-- 中文翻译 -->
### Case 4: Shader quality tier system
**Input:** "How should we implement different shader quality levels for different device tiers?"
**Expected behavior:**
- Designs a shader quality tier system for WeChat Mini Games:
  ```typescript
  function getShaderQualityTier(): 'low' | 'medium' | 'high' {
    const { benchmarkLevel } = wx.getSystemInfoSync();
    const gl = canvas.getContext('webgl2') || canvas.getContext('webgl');
    const isWebGL2 = gl instanceof WebGL2RenderingContext;
    
    if (!isWebGL2 || benchmarkLevel < 5) return 'low';
    if (benchmarkLevel < 10) return 'medium';
    return 'high';
  }
  ```
- Defines tier characteristics:
  - Low: No dynamic lighting, simple textures, no post-processing
  - Medium: Basic lighting, normal maps, simple post-processing
  - High: PBR materials, multiple lights, advanced post-processing
- Provides shader compilation pattern for different tiers:
  ```typescript
  const shaderSource = {
    low: '#define SIMPLE_LIGHTING 1\n' + baseShader,
    medium: '#define NORMAL_MAPPING 1\n' + baseShader,
    high: '#define PBR 1\n#define SHADOWS 1\n' + baseShader
  };
  ```
- Emphasizes the importance of testing on actual WeChat devices

<!-- 中文翻译 -->
### Case 5: Post-processing effects for WeChat Mini Games
**Input:** "Implement a simple bloom effect for our game."
**Expected behavior:**
- Provides WebGL post-processing implementation suitable for WeChat:
  ```glsl
  // Fragment shader for bloom extraction (high-pass filter)
  uniform sampler2D u_texture;
  uniform float u_threshold;
  varying vec2 v_texCoord;
  
  void main() {
    vec4 color = texture2D(u_texture, v_texCoord);
    float brightness = dot(color.rgb, vec3(0.2126, 0.7152, 0.0722));
    if (brightness > u_threshold) {
      gl_FragColor = color;
    } else {
      gl_FragColor = vec4(0.0, 0.0, 0.0, 1.0);
    }
  }
  ```
    - Explains multi-pass rendering with framebuffers
  - Recommends optimized blur (separable Gaussian) for mobile performance
  - Suggests downsampling for performance (render at half resolution)
  - Includes performance caveats: post-processing expensive on mobile, consider disabling on low-end devices
- Provides WebGL 1.0 fallbacks for devices without floating point texture support

<!-- 中文翻译 -->
### Case 6: Wrong-domain request — gameplay implementation
**Input:** "Write the character movement physics code."
**Expected behavior:**
- Does NOT implement physics or gameplay code
- Clearly states: "Gameplay implementation is handled by wechat-minigame-specialist"
- Redirects to wechat-minigame-specialist
- May note if shaders are involved in character rendering (e.g., outline effects, dissolve effects)
- Does NOT overstep domain boundaries

<!-- 中文翻译 -->
### Case 7: Shader debugging and validation
**Input:** "Our shader compiles but produces black screen. How do we debug it?"
**Expected behavior:**
- Provides WeChat Mini Game shader debugging workflow:
  1. Check WebGL errors: `gl.getError()` after each call
  2. Validate shader compilation: `gl.getShaderParameter(shader, gl.COMPILE_STATUS)`
  3. Get shader info log: `gl.getShaderInfoLog(shader)`
  4. Use simple test shader to isolate issues
  5. Check texture loading: verify images are loaded before shader use
  6. Validate uniform locations: some may be optimized out
- Includes WeChat-specific debugging tools:
  - WeChat Developer Tools WebGL inspector
  - Remote debugging on Android devices
  - Frame capture for analysis
- Recommends gradual shader development: start with simple shader, add features incrementally

<!-- 中文翻译 -->
### Case 8: VFX particle shaders
**Input:** "Create a particle shader for fire effects that works in WeChat Mini Games."
**Expected behavior:**
- Provides particle shader optimized for WeChat:
  ```glsl
  // Particle vertex shader
  attribute vec3 a_position;
  attribute vec2 a_texCoord;
  attribute float a_lifetime;
  attribute float a_size;
  
  uniform mat4 u_projection;
  uniform mat4 u_view;
  uniform float u_time;
  
  varying vec2 v_texCoord;
  varying float v_alpha;
  
  void main() {
    // Simple particle animation
    float lifeProgress = mod(u_time + a_lifetime, 1.0);
    vec3 pos = a_position + vec3(0.0, lifeProgress * 2.0, 0.0);
    
    gl_Position = u_projection * u_view * vec4(pos, 1.0);
    gl_PointSize = a_size * (1.0 - lifeProgress);
    
    v_texCoord = a_texCoord;
    v_alpha = 1.0 - lifeProgress; // Fade out
  }
  ```
- Explains particle system integration with WebGL:
  - Use `gl.POINTS` for simple particles
  - Texture atlases for particle textures
  - Billboarding techniques for camera-facing particles
- Recommends performance optimizations:
  - Limit particle count (100-500 on mobile)
  - Use instanced rendering for WebGL 2.0
  - Disable depth testing for transparent particles
  - Batch particles by shader/material

---

## Protocol Compliance / 协议合规

- [ ] Stays within declared domain (WebGL shaders, rendering optimization, shader conversion)
- [ ] Redirects gameplay implementation to wechat-minigame-specialist
- [ ] Redirects UI implementation to wechat-ui-specialist
- [ ] Redirects architecture decisions to wechat-specialist
- [ ] Considers WeChat-specific constraints (WebGL version, mobile performance, package size)
- [ ] Provides shader code that works within WebGL 1.0/2.0 limitations
- [ ] Includes performance optimizations for mobile devices
- [ ] Validates shader compatibility with target WeChat versions

---

<!-- 覆盖说明 -->
## Coverage Notes

- WebGL version decision (Case 1) demonstrates understanding of WeChat device fragmentation
- Shader conversion (Case 2) validates cross-engine shader translation capability
- Performance optimization (Case 3) confirms mobile-first shader development approach
- Quality tier system (Case 4) shows adaptive rendering for diverse device capabilities
- Post-processing (Case 5) balances visual quality with mobile performance constraints
- Debugging workflow (Case 7) provides practical troubleshooting for WeChat environment
- VFX particles (Case 8) covers real-time effects within mobile GPU limitations

<!-- 中文翻译标记 / Chinese translation marker -->
