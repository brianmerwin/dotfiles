# AGENTS.md

## What this repo is
Chezmoi-managed dotfiles for Linux (Fedora/EL primary, Debian planned). Not a
code project — there is no build, test, or lint system. Edits here affect a
real user's shell, editor, and tools.

## Chezmoi naming conventions
- `dot_` → `.` prefix (e.g. `dot_zshrc` → `~/.zshrc`)
- `private_dot_` → `.` prefix + 600 permissions (e.g. `private_dot_ssh/`)
- `run_once_*` → runs once per host on `chezmoi apply` (installs)
- `run_onchange_*` → re-runs when the script content changes
- `.chezmoiignore` → patterns excluded from chezmoi managed directories
- `.chezmoi.toml.tmpl` → chezmoi config template (sets nvim as editor, auto-commit/push)

## Key directories
- `dot_config/nvim/` — LazyVim-based config (`init.lua` → `config.lazy`)
- `dot_config/opencode/` — OpenCode config + existing behavioral AGENTS.md
- `dot_tmux/` — TPM plugins (catppuccin, resurrect, continuum, vim-tmux-navigator)
- `dot_bootstrap/` — Ansible playbook for system bootstrap (common-config, fzf, helm, kubectl, neovim, starship, vault)
- `dot_local/` — local binaries and data

## Important constraints
- The existing `dot_config/opencode/AGENTS.md` contains git behavioral rules that
  are enforced via `opencode.json` permissions — preserve them if editing that file.
- `chezmoi.toml.tmpl` sets `autoCommit = true` and `autoPush = true` — chezmoi
  apply will auto-commit and push changes.
- Target audience: single-user Linux desktop (WSL-aware via DISPLAY env).
- `run_once_*` scripts assume `dnf` (Fedora/RHEL) — Debian support is a TODO.
