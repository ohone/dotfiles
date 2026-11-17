#!/usr/bin/env bash
# Symlink agents/AGENTS.md into each named tool's global instructions path.
#
# Usage: ./install.sh <tool>...     tools: claude pi codex opencode
#
# Fails if a tool's config directory is missing, or if a different file is
# already at the target. A target with identical content is replaced.
set -euo pipefail

SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/agents/AGENTS.md"

if [ $# -eq 0 ]; then
  echo "usage: $0 <tool>...   (claude pi codex opencode)" >&2
  exit 2
fi
[ -f "$SRC" ] || { echo "error: missing $SRC" >&2; exit 1; }

for tool in "$@"; do
  case "$tool" in
    claude)   target="$HOME/.claude/CLAUDE.md" ;;
    pi)       target="$HOME/.pi/agent/AGENTS.md" ;;
    codex)    target="$HOME/.codex/AGENTS.md" ;;
    opencode) target="$HOME/.config/opencode/AGENTS.md" ;;
    *) echo "error: unknown tool '$tool'" >&2; exit 2 ;;
  esac

  dir="$(dirname "$target")"
  [ -d "$dir" ] || { echo "error: $tool: $dir does not exist" >&2; exit 1; }

  if [ -L "$target" ]; then
    current="$(readlink "$target")"
    if [ "$current" = "$SRC" ]; then
      echo "$tool: already linked"
      continue
    fi
    echo "error: $tool: $target is a symlink to $current" >&2
    exit 1
  fi

  if [ -e "$target" ]; then
    cmp -s "$target" "$SRC" || {
      echo "error: $tool: $target exists and differs from $SRC" >&2
      exit 1
    }
    rm "$target"
  fi

  ln -s "$SRC" "$target"
  echo "$tool: $target -> $SRC"
done
