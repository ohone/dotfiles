# dotfiles

## Agent instructions

`agents/AGENTS.md` is the single global instructions file for every coding
agent. `install.sh` symlinks it to where each tool looks:

| Tool | Path |
|---|---|
| `claude` | `~/.claude/CLAUDE.md` |
| `pi` | `~/.pi/agent/AGENTS.md` |
| `codex` | `~/.codex/AGENTS.md` |
| `opencode` | `~/.config/opencode/AGENTS.md` |

```sh
git clone https://github.com/ohone/dotfiles.git ~/repos/dotfiles
~/repos/dotfiles/install.sh claude pi
```

Name the tools to link. The script fails if a tool's config directory is
missing or if a different file is already at the target.
