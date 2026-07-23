# Ansible Bootstrap Project

## Standards
Follow the [Red Hat Automation Good Practices](https://redhat-cop.github.io/automation-good-practices/) guide whenever practical, unless overridden by user direction.

Key rules to enforce:
- Task names in sub-task files must be prefixed (e.g. `install_packages | Install core packages`)
- Use `ansible_facts['os_family']` bracket notation, not `ansible_os_family`
- Roles should be idempotent; use `changed_when:` with `command`/`shell` tasks
- Variables prefixed with role name to avoid namespace collisions
- Prefer `defaults/main.yml` for user-facing inputs, `vars/main.yml` for constants

## Structure
- `bootstrap.yml` — top-level playbook, three plays (user prefs, Linux system packages, Linux user binaries, macOS)
- `roles/` — 19 roles; most are single-task `install_*` roles
- `roles/base_linux/` and `roles/base_macos/` — multi-task roles with `vars/`
- `roles/install_docker/` — only role with `handlers/`, `templates/`, `tests/`, `README.md`

## Deployed via chezmoi
This project lives inside a chezmoi dotfiles repo. It is run by `run_onchange_00_ansible_bootstrap.sh`, which:
1. Installs `uv` if missing
2. Syncs a Python venv in `~/.bootstrap` with `uv sync --no-install-project`
3. Runs `ansible-playbook bootstrap.yml` with local connection

Ansible is managed as a uv dependency in `pyproject.toml`, not installed system-wide.

## Gotchas
- `become: false` in bootstrap.yml — roles handle their own privilege escalation
- Commented-out roles in bootstrap.yml are not dead code; they are awaiting enablement
- Collections are git-ignored (`.bootstrap/collections/*`) — only `collections/requirements.yml` is tracked
- `PYTHONDONTWRITEBYTECODE=1` is set explicitly to avoid .pyc during root-privileged tasks
- When creating new `install_*` roles that download tarballs, always inspect the tarball contents first (`curl -fsSL <url> | tar tzf -`) — some archive the binary at the root (extracts directly to `dest`), others wrap it in a subdirectory (e.g. `app_version_os_arch/binary`). If subdirectory-wrapped, use `shell` + `tar xz --strip-components=1` instead of `ansible.builtin.unarchive` to avoid the binary landing in the wrong path
