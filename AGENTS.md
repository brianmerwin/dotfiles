# AGENTS.md

First: read `~/.config/opencode/AGENTS.md` and follow its 4-line limit before any other action.

## What this repo is
Chezmoi-managed dotfiles for Linux (Fedora/EL primary, Debian planned). Not a
code project — there is no build, test, or lint system. Edits here affect a
real user's shell, editor, and tools.

## Chezmoi naming conventions
- `dot_` → `.` prefix (e.g. `dot_zshrc` → `~/.zshrc`)
- `private_dot_` → `.` prefix + 600 permissions (e.g. `private_dot_ssh/`)
- `run_once_*` → runs once per host on `chezmoi apply` (installs)
- `run_onchange_*` → re-runs when the script content changes
- `.chezmoiignore` (source root, `.tmpl` variant) → patterns chezmoi ignores in the
  SOURCE directory (i.e., files it will not track or deploy). Different from
  `dot_chezmoiignore` which gets deployed to `~/.chezmoiignore` on the target.
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

## Secrets & encryption
- Sensitive files are age-encrypted per-file using `chezmoi add --encrypt`. Encrypted
  files use the naming pattern `encrypted_<name>.age`. There is no directory-level
  encryption — each file must be encrypted individually.
- SSH keys, SSH config, and other secrets live in `private_dot_ssh/` as
  `encrypted_*.age` files. Never commit a plaintext `.pem`, `.key`, `id_*`, or
  `known_hosts` file. The `private_` prefix ensures 600 permissions.
- `encrypted_` + `.tmpl` can be combined (e.g. `encrypted_config.tmpl.age`):
  chezmoi decrypts first, then template-processes the decrypted content.
- The `.gitignore` is intentionally empty — secret protection relies on chezmoi-level
  patterns and encryption discipline, not git-level excludes.
- `dot_gitconfig` contains a work email in plaintext (`brian.merwin@qtsdatacenters.com`).
  Make a chezmoi template variable if you need to keep it out of the public repo.
- `executable_ssh_setup.sh` is a legacy setup helper; the SSH config it writes is
  now managed via `private_dot_ssh/encrypted_config.age`.
- To add a new encrypted file: `chezmoi add --encrypt ~/.ssh/something`, commit
  the generated `encrypted_*.age` file, then delete the plaintext original.
- `chezmoi edit` transparently decrypts, opens your editor, and re-encrypts on
  save — use this for editing encrypted files rather than manually decrypting.
