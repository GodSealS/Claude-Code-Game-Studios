---
name: graphify
description: "Control the graphify knowledge graph tool — build project knowledge graphs, query code structure, and analyze module relationships. Invoked via /graphify."
argument-hint: "[build|query|update|path|explain|cluster-only|export]"
user-invocable: true
allowed-tools: Bash, Read, Glob, Grep, Write, WebFetch
---

# /graphify

graphify turns any folder of code, docs, papers, images, or video into a queryable knowledge graph with community detection, confidence labels, and three outputs: interactive HTML, GraphRAG-ready JSON, and a plain-language GRAPH_REPORT.md.

---

## Environment Detection

Before any operation, resolve the graphify project root. Check in order:

1. `GRAPHIFY_HOME` environment variable (explicit override)
2. Fallback: search common paths — `%USERPROFILE%\.graphify`, `%LOCALAPPDATA%\graphify`

On Windows, read env vars with PowerShell:
```powershell
$env:GRAPHIFY_HOME
# or
[Environment]::GetEnvironmentVariable("GRAPHIFY_HOME", "User")
```

If none found, prompt the user:
> "graphify not found. Set GRAPHIFY_HOME to the graphify project directory (e.g. `F:\Tools\graphify_codebuddy`), or install it with `uv tool install graphifyy`."

Once resolved, all graphify commands use this root as the working directory. Store the resolved path in a session variable and reuse it — do not re-detect on every call.

Verify the install:
```powershell
cd $GRAPHIFY_HOME
uv run graphify --version
```

---

## Command Modes

| Mode | Trigger | Description |
|------|---------|-------------|
| **Build** | `/graphify build [path]` | Full pipeline on the specified path (default: `.`) |
| **Update** | `/graphify update [path]` | Incremental — only changed files |
| **Query** | `/graphify query "<question>"` | Search the graph for answers |
| **Path** | `/graphify path <A> <B>` | Shortest path between two concepts |
| **Explain** | `/graphify explain <node>` | Plain-language explanation of a node |
| **Cluster-only** | `/graphify cluster-only [path]` | Re-cluster without re-extracting |
| **Export** | `/graphify export <format>` | Export callflow-html / svg / graphml |

---

## Phase 1: Build Knowledge Graph

### `/graphify build [path]`

Build a knowledge graph for the given path (defaults to current workspace root).

```powershell
cd $GRAPHIFY_HOME
uv run graphify "<target-path>" --mode deep
```

**Pipeline stages:**
1. `detect` — discover all files, classify (CODE/DOCUMENT/IMAGE/VIDEO)
2. `extract` — AST extraction for code (local, free) + LLM extraction for docs/images
3. `build` — assemble NetworkX graph, deduplicate, merge
4. `cluster` — Leiden/Louvain community detection
5. `analyze` — god nodes, surprising connections, suggested questions
6. `export` — `graphify-out/graph.json`, `graph.html`, `GRAPH_REPORT.md`

**After building, output:**
```
Graph built:
  graphify-out/
  ├── graph.html        open in browser — click nodes, filter by community
  ├── GRAPH_REPORT.md   highlights: key concepts, surprising connections, suggested questions
  └── graph.json        query anytime → /graphify query "..."
```

### Build Options

| Option | Effect |
|--------|--------|
| `--mode deep` | Richer relationship extraction (default) |
| `--no-viz` | Skip HTML, report + JSON only |
| `--directed` | Preserve edge direction |
| `--wiki` | Generate crawlable Markdown wiki |
| `--svg` | Also export graph.svg |
| `--graphml` | Export for Gephi / yEd |

---

## Phase 2: Query Existing Graph

### Pre-check

Before querying, check if `graphify-out/graph.json` exists in the current workspace:
- Exists → query directly
- Missing → prompt user to run `/graphify build` first

### `/graphify query "<question>"`

```powershell
cd $GRAPHIFY_HOME
uv run graphify query "<question>" --graph "<workspace>/graphify-out/graph.json"
```

Query options:

| Option | Effect |
|--------|--------|
| `--dfs` | Depth-first traversal (trace a specific path) |
| `--budget 1500` | Cap answer at N tokens |

### `/graphify path "<A>" "<B>"`

```powershell
cd $GRAPHIFY_HOME
uv run graphify path "<A>" "<B>" --graph "<workspace>/graphify-out/graph.json"
```

### `/graphify explain "<node>"`

```powershell
cd $GRAPHIFY_HOME
uv run graphify explain "<node>" --graph "<workspace>/graphify-out/graph.json"
```

### Response Rules

- Prefer graphify results over general knowledge
- Cite `source_location` when referencing specific facts
- If the CLI is unavailable, fall back to reading `graphify-out/graph.json` directly with NetworkX traversal

---

## Phase 3: Incremental Update

### `/graphify update [path]`

Re-extract only changed files (uses manifest.json mtime + content hash).

```powershell
cd $GRAPHIFY_HOME
uv run graphify update "<target-path>"
```

Add `--no-cluster` to skip re-clustering.

---

## Phase 4: Re-cluster Only

### `/graphify cluster-only [path]`

Re-run community detection on an existing graph without re-extracting.

```powershell
cd $GRAPHIFY_HOME
uv run graphify cluster-only "<target-path>" --graph "<target-path>/graphify-out/graph.json"
```

Options: `--resolution 1.5` (finer communities), `--exclude-hubs 99` (suppress super-hubs from rankings).

---

## Phase 5: Export

### `/graphify export callflow-html`

Generate Mermaid architecture / call-flow HTML:

```powershell
cd $GRAPHIFY_HOME
uv run graphify export callflow-html "<workspace>/graphify-out"
```

### Other Export Formats

| Command | Output |
|---------|--------|
| `export callflow-html` | `<project>-callflow.html` |
| `export svg` | `graph.svg` |
| `export graphml` | `graph.graphml` |

---

## Common Workflows

| Task | Command |
|------|---------|
| First build for a project | `/graphify build .` |
| Search code structure | `/graphify query "how does auth connect to the database?"` |
| Trace dependency chain | `/graphify path "PlayerController" "NetworkManager"` |
| Understand a component | `/graphify explain "CombatSystem"` |
| Update after code changes | `/graphify update .` |
| Re-cluster after config change | `/graphify cluster-only .` |
| Export architecture diagram | `/graphify export callflow-html` |

---

## Troubleshooting

| Problem | Solution |
|---------|----------|
| `GRAPHIFY_HOME` not set | Set it to the graphify project directory, or install: `uv tool install graphifyy` |
| `uv: command not found` | Install uv: `winget install astral-sh.uv` |
| Graph has fewer nodes than expected | Use `--force` to rebuild |
| PowerShell path issues | Wrap target paths in double quotes |

---

## Privacy & Cost

- **AST extraction**: fully local, free, no API calls
- **Document / PDF / image extraction**: uses the current IDE session's model API (consumes session token quota)
- **No telemetry, no tracking, no analytics**
