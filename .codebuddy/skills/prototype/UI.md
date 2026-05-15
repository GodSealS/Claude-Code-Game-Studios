# UI Prototype

Generate **several radically different UI variations** on a single route, switchable
from a floating bottom bar. The user flips between variants in the browser, picks
one (or steals bits from each), then throws the rest away.

## When to Use This Branch

- "What should this page look like?"
- "I want to see a few options for this dashboard before committing."
- "Try a different layout for the settings screen."
- Any time picking between vague mockups in your head is taking too long.

If the question is about logic/state — use [LOGIC.md](LOGIC.md) instead.

## Two Sub-Shapes

Strongly prefer Sub-shape A.

### Sub-shape A — Adjustment to an existing page (preferred)

Variants render **on the same route**, gated by a `?variant=` URL param.
Existing data fetching, params, auth all stay — only the rendering swaps.

### Sub-shape B — New page (last resort)

Only when the thing being prototyped genuinely has no existing page to live inside.
Create a throwaway route following the project's routing convention.

## Process

### 1. State the question and pick N

Default to **3 variants**. More than 5 stops being radically different.

### 2. Generate radically different variants

Variants must be **structurally different** — different layout, different information
hierarchy, different primary affordance. Not just different colours.

### 3. Wire them together

Create a single switcher component using `?variant=` search param:
```
variant = searchParams.get('variant') ?? 'A'
{variant === 'A' && <VariantA />}
{variant === 'B' && <VariantB />}
{variant === 'C' && <VariantC />}
<PrototypeSwitcher variants={['A','B','C']} current={variant} />
```

### 4. The floating switcher

Small fixed-position bar at bottom-centre:
- Left/right arrows cycle variants
- Keyboard: ← → arrow keys
- Visually distinct from the page (not part of the design)
- Hidden in production builds

### 5. Capture the answer and clean up

Once a variant wins, delete the losers and the switcher. Fold the winner in.

## Anti-patterns

- Variants differing only in colour or copy — that's a tweak, not a prototype
- Sharing too much code between variants — defeats the point
- Wiring variants to real mutations — read-only is fine
- Promoting prototype directly to production — rewrite properly when folding in
