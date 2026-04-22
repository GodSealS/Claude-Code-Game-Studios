# Source Directory / 源代码目录

When writing or editing game code in this directory, follow these standards.

## Engine Version Warning / 引擎版本警告

The LLM's training data predates the pinned engine version.
**Always check `docs/engine-reference/` before using any engine API.**
Do not guess at post-cutoff API signatures — look them up first.

## Coding Standards / 编码标准

- All public APIs require doc comments
- Gameplay values must be **data-driven** (external config files), never hardcoded
- Prefer dependency injection over singletons for testability
- Every new system needs a corresponding ADR in `docs/architecture/`
- Commits must reference the relevant story ID or design document

## File Routing / 文件路由

Match the engine-specialist agent to the file type being written.
See `CODEBUDDY.md` → Technical Preferences → Engine Specialists → File Extension Routing.

When in doubt, use the primary engine specialist configured in `CODEBUDDY.md`.

## Tests / 测试

Tests live in `tests/` — not in `src/`.
Run `/test-setup` to scaffold the test framework if it doesn't exist yet.
Every gameplay system should have unit tests covering its formulas and edge cases.

## Verification-Driven Development / 验证驱动开发

Write tests first when adding gameplay systems.
For UI changes, verify with screenshots.
Compare expected output to actual output before marking work complete.


<!-- 中文翻译标记 / Chinese translation marker -->
