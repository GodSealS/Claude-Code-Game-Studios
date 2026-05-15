#!/usr/bin/env bash
# HITL (Human-In-The-Loop) debug template
# Usage: bash scripts/hitl-loop.template.sh [command-to-run]
# Prompts the user for observations after each run.

set -euo pipefail

COMMAND="$*"
if [ -z "$COMMAND" ]; then
  echo "Usage: $0 <command-to-run>"
  exit 1
fi

ITERATION=1
while true; do
  echo ""
  echo "=== Iteration $ITERATION ==="
  echo "Running: $COMMAND"
  echo "---"
  eval "$COMMAND" || true
  echo "---"
  echo "Command finished. Describe what you observed (or 'q' to quit):"
  read -r FEEDBACK
  if [ "$FEEDBACK" = "q" ] || [ "$FEEDBACK" = "quit" ]; then
    break
  fi
  echo "Observation recorded: $FEEDBACK"
  ITERATION=$((ITERATION + 1))
done

echo "HITL loop ended after $ITERATION iterations."
