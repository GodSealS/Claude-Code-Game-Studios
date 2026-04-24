---
name: soak-test
description: "Generate a soak test protocol for extended play sessions. Defines what to observe, measure, and log during long play sessions to surface slow leaks, fatigue effects, and edge cases that only appear after sustained play. Primarily used in Polish and Release phases. / 为长时间游玩会话生成浸泡测试协议。定义在长时间游玩期间需要观察、测量和记录的内容，以发现慢泄漏、疲劳效应和仅在持续游玩后出现的边界情况。主要用于打磨和发布阶段。"
argument-hint: "[duration: 30m | 1h | 2h | 4h] [focus: memory | stability | balance | all]"
user-invocable: true
allowed-tools: Read, Glob, Grep, Write
---

# Soak Test / 浸泡测试

A soak test (also called an endurance test) is an extended play session run
with specific observation goals. Unlike a smoke check (broad critical path,
~10 min) or a single-feature playtest (~30 min), a soak test runs for **30
minutes to several hours** to surface:

- **Memory leaks** — gradual heap growth that only appears after scene transitions
- **Performance drift** — frame time degradation that worsens over time
- **State accumulation bugs** — issues that only appear after N repetitions
  of a mechanic (inventory full, score overflow, AI state corruption)
- **Fun fatigue** — mechanics that feel good in a first session but grow
  repetitive over extended play
- **Content exhaustion** — the point where players run out of novel content

> **中文翻译**：浸泡测试（也称耐久测试）是带有特定观察目标的扩展游玩会话。与冒烟测试（广泛关键路径，约10分钟）或单功能试玩（约30分钟）不同，浸泡测试运行**30分钟到数小时**以发现：内存泄漏、性能漂移、状态累积缺陷、趣味疲劳、内容耗尽。

**This skill generates the observation protocol and analysis harness — the
human does the actual playing.** / **此技能生成观察协议和分析框架——由人类进行实际游玩。**

**Output:** `production/qa/soak-test-[date]-[duration].md`

**When to run:** / **何时运行：**
- Polish phase — before `/gate-check release` / 打磨阶段 — 在 `/gate-check release` 之前
- After fixing a memory or stability issue (regression soak) / 修复内存或稳定性问题后（回归浸泡）
- When extended play has not been formally tracked / 当扩展游玩尚未被正式跟踪时

---

## 1. Parse Arguments / 1. 解析参数

**Duration** (default: `1h`): / **持续时间**（默认：`1h`）：
- `30m` — short soak; suitable for testing a single mechanic or scene / 短浸泡；适合测试单个机制或场景
- `1h` — standard soak; covers most common leak categories / 标准浸泡；覆盖最常见泄漏类别
- `2h` — extended soak; recommended for first full Polish soak / 扩展浸泡；推荐用于首次完整打磨浸泡
- `4h` — deep soak; required for games with long session design (RPGs, sims) / 深度浸泡；适用于长会话设计的游戏（RPG、模拟类）

**Focus** (default: `all`): / **焦点**（默认：`all`）：
- `memory` — focus on heap size, object count, leak patterns / 聚焦堆大小、对象计数、泄漏模式
- `stability` — focus on crash/freeze/hang detection / 聚焦崩溃/冻结/挂起检测
- `balance` — focus on fun fatigue, content exhaustion, difficulty perception / 聚焦趣味疲劳、内容耗尽、难度感知
- `all` — all of the above / 以上全部

---

## 2. Load Context / 2. 加载上下文

Read:
- `.codebuddy/docs/technical-preferences.md` — engine (for engine-specific memory
  monitoring guidance), performance budgets (memory ceiling, target FPS)
- `design/gdd/game-concept.md` — intended session length (for comparison against
  soak duration), core loop description
- Most recent file in `production/playtests/` — prior playtest findings
  (to avoid re-documenting known issues)
- Most recent file in `production/qa/qa-plan-*.md` — current sprint test coverage
  (to understand what has been formally tested vs. what the soak covers)

Note any performance budget targets from technical-preferences.md:
- Memory ceiling: [N MB, or "not set"]
- Target FPS: [N, or "not set"]
- Frame budget: [N ms, or "not set"]

---

## 3. Define Observation Checkpoints / 3. 定义观察检查点

Based on duration, generate timed checkpoints:

**30m soak**: T+0, T+10, T+20, T+30
**1h soak**: T+0, T+15, T+30, T+45, T+60
**2h soak**: T+0, T+20, T+40, T+60, T+80, T+100, T+120
**4h soak**: T+0, T+30, T+60, T+90, T+120, T+180, T+240

At each checkpoint, the observer records the observation items defined in
Phase 4.

---

## 4. Generate the Soak Test Protocol / 4. 生成浸泡测试协议

### Memory / Stability observation items (if focus = memory or all) / 内存/稳定性观察项（如果焦点 = memory 或 all）

Engine-specific monitoring guidance:

**Godot 4:**
- Open Debugger → Monitors tab; track `Memory → Static Memory` and
  `Object Count → Objects` across checkpoints
- Record: Static Memory (KB), Object Count, Orphan Nodes count
- Alert threshold: Memory growth > 20% from T+0 after the first 15 minutes
  (some growth on load is expected; sustained growth indicates a leak)
- Note: `Performance.get_monitor(Performance.MEMORY_STATIC)` returns bytes
  in Godot 4.6

**Unity:**
- Open Memory Profiler (Window → Analysis → Memory Profiler)
- Record: Total Reserved Memory (MB), GC Allocated (MB), Object Count at each checkpoint
- Alert threshold: GC Allocated growing monotonically across 3+ checkpoints

**Unreal Engine:**
- Use `stat memory` console command at each checkpoint
- Record: Physical Memory Used (MB), Physical Memory Available
- Alert threshold: Physical Memory Used growth > 50MB over the full soak

### Stability observation items (if focus = stability or all) / 稳定性观察项（如果焦点 = stability 或 all）

At each checkpoint, note:
- [ ] No crash, hang, or freeze occurred since last checkpoint
- [ ] Frame rate still within target budget ([target FPS] fps)
- [ ] Audio still playing correctly (no desync or silence)
- [ ] All HUD elements still rendering correctly
- [ ] Input responding as expected (no input loss or lag spike)

### Balance / fatigue observation items (if focus = balance or all) / 平衡/疲劳观察项（如果焦点 = balance 或 all）

Collect subjective observations at each checkpoint:
- [ ] Core mechanic still feels rewarding (Y/N)
- [ ] Perceived difficulty level: [too easy / appropriate / too hard]
- [ ] Any "I've seen this before" moments since last checkpoint? (novel content exhaustion)
- [ ] Any moment of frustration since last checkpoint? Note cause.
- [ ] Any moment of peak engagement since last checkpoint? Note cause.

---

## 5. Generate the Protocol Document / 5. 生成协议文档

```markdown
# Soak Test Protocol

> **Date**: [date]
> **Duration**: [duration]
> **Focus**: [memory | stability | balance | all]
> **Engine**: [engine]
> **Generated by**: /soak-test

---

## Pre-Session Setup / 会话前设置

Before starting the soak:

- [ ] Game is running from a **fresh launch** (not resumed from a prior session)
- [ ] All background applications closed (minimise OS memory interference)
- [ ] Performance monitoring tool open and recording:
  - **Godot**: Debugger → Monitors tab → Memory section visible
  - **Unity**: Memory Profiler window open
  - **Unreal**: `stat memory` ready in console
- [ ] Soak target confirmed: [session design intent from game concept]
- [ ] Prior known issues to watch for: [from most recent playtest / qa-plan]

---

## Baseline (T+0) — Record Before Playing / 基线（T+0）— 游玩前记录

| Metric | Baseline Value |
|--------|---------------|
| Memory / Heap | [record before first frame of gameplay] |
| Object Count | [record] |
| FPS (first 30 seconds) | [record] |
| [Engine-specific metric] | [record] |

---

## Checkpoint Log / 检查点日志

### T+[N] minutes

**Memory / Stability** *(if applicable)*:

| Metric | Value | Δ from Baseline | Alert? |
|--------|-------|-----------------|--------|
| Memory / Heap | | | |
| Object Count | | | |
| FPS | | | |
| Crashes / Hangs | | | |

**Stability checks**:
- [ ] No crash or hang since last checkpoint
- [ ] Frame rate within budget ([N] fps target)
- [ ] Audio correct
- [ ] HUD rendering correctly
- [ ] Input responding correctly

**Balance / Fatigue** *(if applicable)*:
- Core mechanic still rewarding: Y / N
- Difficulty perception: too easy / appropriate / too hard
- Notable moments: [note any peak engagement or frustration]
- Content exhaustion signs: Y / N — [describe]

**Free observations**:
*(Note anything unexpected observed since the last checkpoint)*

---

[Repeat Checkpoint Log section for each timed checkpoint]

---

## Post-Session Analysis / 会话后分析

### Memory Trend / 内存趋势

| Checkpoint | Memory | Δ/hr extrapolated |
|------------|--------|-------------------|
| T+0 | | |
| [T+N] | | |

**Leak detected?** Y / N
**Estimated time to OOM at current rate**: [N hours / not applicable]

### Stability Summary / 稳定性摘要

Total crashes: [N]
Total hangs: [N]
Worst FPS observed: [N] fps at [checkpoint]
Performance degradation: stable / mild / severe

### Balance / Fatigue Summary / 平衡/疲劳摘要

Fun curve: [engaged throughout / fatigue onset at T+N / repetitive from start]
Content exhaustion point: [never / at T+N / early]
Difficulty arc: [appropriate / too easy throughout / difficulty spike at T+N]

### Issues Found / 发现的问题

| ID | Severity | Checkpoint | Description |
|----|----------|------------|-------------|
| SOAK-001 | S[1-4] | T+[N] | [description] |

---

## Verdict: PASS / PASS WITH CONCERNS / FAIL

**PASS**: No leaks detected, stability maintained, fun factor consistent
**PASS WITH CONCERNS**: Minor drift or fatigue noted; addressable in Polish
**FAIL**: Memory leak confirmed, stability breach, or severe fun fatigue

---

## Sign-Off

- **Tester**: [name] — [date]
- **QA Lead review**: [name] — [date]
```

---

## 6. Write Output / 6. 写入输出

Present the protocol summary in conversation, then ask:

"May I write this soak test protocol to
`production/qa/soak-test-[date]-[duration].md`?"

Write only after approval.

After writing:

"Protocol written. To run the soak:
1. Open the file and follow the Pre-Session Setup checklist
2. Record each checkpoint as you play
3. Complete the Post-Session Analysis section when done
4. File bugs from 'Issues Found' to `production/qa/bugs/`
5. Run `/bug-triage sprint` after the session to integrate any S1/S2 issues

If the verdict is FAIL, run `/smoke-check` again after fixing the issues."

---

## Collaborative Protocol / 协作协议

- **This skill generates a protocol — humans run it** — never attempt to
  run a soak test automatically. The observations require a human observer. / **此技能生成协议——由人类运行** — 绝不尝试自动运行浸泡测试。观察需要人类观察者。
- **Duration should match the game's session design** — a 5-minute game
  doesn't need a 4h soak; a city-builder might. Use judgment and ask if unclear. / **持续时间应匹配游戏的会话设计** — 5分钟的游戏不需要4小时浸泡；城市建造游戏可能需要。使用判断力，如果不清楚则询问。
- **First soak should be `all` focus** — narrow focus (memory-only) is for
  regression soaks after a specific fix, not the first pass / **首次浸泡应为 `all` 焦点** — 窄焦点（仅内存）用于特定修复后的回归浸泡，而非首次通过
- **Ask before writing** — always confirm before creating the protocol file / **写入前询问** — 创建协议文件前始终确认
