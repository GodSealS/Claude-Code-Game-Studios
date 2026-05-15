# Logic Prototype

A tiny interactive terminal app that lets the user drive a state model by hand.
Use when the question is about **business logic, state transitions, or data shape**
— the kind that looks reasonable on paper but only feels wrong once pushed through
real cases.

## When to Use This Branch

- "I'm not sure if this state machine handles the edge case where X then Y."
- "Does this data model actually let me represent the case where..."
- "I want to feel out what the API should look like before writing it."
- Anything where the user wants to **press buttons and watch state change**.

If the question is "what should this look like" — use [UI.md](UI.md) instead.

## Process

### 1. State the question

Write down what state model and what question you're prototyping, in a comment at
the top of the file. A prototype that answers the wrong question is pure waste.

### 2. Pick the language

Use whatever the host project uses. Match existing tooling conventions — don't add
a new package manager just for the prototype.

### 3. Isolate the logic in a portable module

Put the actual logic behind a small, pure interface that could be lifted into the
real codebase later. The TUI shell around it is throwaway; the logic module isn't.

Keep it pure: no I/O, no terminal code, no `console.log` for control flow.

### 4. Build the smallest TUI that exposes the state

Build a lightweight TUI: on every tick, clear screen and re-render the whole frame.
Each frame has:
1. **Current state** — pretty-printed, diff-friendly
2. **Keyboard shortcuts** — listed at the bottom

Behaviour:
- Initialise state as a single in-memory object
- Read one keystroke at a time, dispatch to handler that mutates state
- Re-render full frame after every action
- Loop until quit

### 5. Make it runnable in one command

Add a script to the project's existing task runner. User runs one command.

### 6. Capture the answer

When the prototype has done its job, the answer is the only thing worth keeping.
Write down what was learned before deleting the prototype.

## Anti-patterns

- Don't add tests
- Don't wire to the real database — use in-memory store
- Don't generalise — answer one question
- Don't blur the logic and TUI together — keep the logic layer portable
- Don't ship the TUI shell to production
