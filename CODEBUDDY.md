# Claude Code Game Studios -- Game Studio Agent Architecture

Indie game development managed through 48 coordinated CodeBuddy subagents.
Each agent owns a specific domain, enforcing separation of concerns and quality.

## Technology Stack

- **Engine**: [CHOOSE: Godot 4 / Unity / Unreal Engine 5 / Cocos Creator]
- **Language**: [CHOOSE: GDScript / C# / C++ / Blueprint]
- **Version Control**: Git with trunk-based development
- **Build System**: [SPECIFY after choosing engine]
- **Asset Pipeline**: [SPECIFY after choosing engine]

> **Note**: Engine-specialist agents exist for Godot, Unity, Unreal, and Cocos Creator with
> dedicated sub-specialists. Use the set matching your engine.

## Project Structure

@.codebuddy/docs/directory-structure.md

## Engine Version Reference

The `@` import below points to the pinned engine version. Update it after
running `/setup-engine` to match your chosen engine:

- Godot: `@docs/engine-reference/godot/VERSION.md`
- Unity: `@docs/engine-reference/unity/VERSION.md`
- Unreal: `@docs/engine-reference/unreal/VERSION.md`
- Cocos Creator: `@docs/engine-reference/cocos/VERSION.md`

Current project engine:

## Technical Preferences

@.codebuddy/docs/technical-preferences.md

## Coordination Rules

@.codebuddy/docs/coordination-rules.md

## Collaboration Protocol

**User-driven collaboration, not autonomous execution.**
Every task follows: **Question -> Options -> Decision -> Draft -> Approval**

- Agents MUST ask "May I write this to [filepath]?" before using Write/Edit tools
- Agents MUST show drafts or summaries before requesting approval
- Multi-file changes require explicit approval for the full changeset
- No commits without user instruction

See `docs/COLLABORATIVE-DESIGN-PRINCIPLE.md` for full protocol and examples.

> **First session?** If the project has no engine configured and no game concept,
> run `/start` to begin the guided onboarding flow.

## Coding Standards

@.codebuddy/docs/coding-standards.md


## Context Management

@.codebuddy/docs/context-management.md
