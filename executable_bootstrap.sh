#!/usr/bin/env bash
set -euo pipefail

cd ~/.bootstrap

# Activate the virtual environment
# shellcheck disable=SC1091
source .venv/bin/activate

# Install required Ansible collections (no sudo; installs into ~/.bootstrap/collections)
ansible-galaxy collection install -r collections/requirements.yml

# Prevent Python from writing .pyc files during root-privileged tasks
export PYTHONDONTWRITEBYTECODE=1

# Prompt for user preferences
if [[ "$(uname -s)" == "Darwin" ]]; then
  # No sudo on macOS; system packages are installed via Homebrew (no sudo needed)
  INSTALL_SYSTEM=false
else
  read -rp "Install system packages via dnf/apt? (requires sudo) [y/N]: " INSTALL_SYSTEM
  # Normalize to true/false for Ansible (Jinja2 "n" | bool == True)
  if [[ "$INSTALL_SYSTEM" =~ ^[Yy]$ ]]; then
    INSTALL_SYSTEM=true
  else
    INSTALL_SYSTEM=false
  fi
fi

read -rp "Check for updates to installed binaries? [y/N]: " CHECK_UPDATES
if [[ "$CHECK_UPDATES" =~ ^[Yy]$ ]]; then
  CHECK_UPDATES=true
else
  CHECK_UPDATES=false
fi

# Only ask for sudo password if system packages will be installed
EXTRA_ARGS=()
if [[ "$INSTALL_SYSTEM" == "true" ]]; then
  EXTRA_ARGS+=(-K)
fi

# "${EXTRA_ARGS[@]+"${EXTRA_ARGS[@]}"}" guard: bash 3.2 (macOS /bin/bash)
# aborts on empty array expansion under `set -u`; newer bash tolerates it.
ansible-playbook bootstrap.yml -i localhost, -c local \
  -e "install_system_packages=$INSTALL_SYSTEM" \
  -e "check_for_updates=$CHECK_UPDATES" \
  "${EXTRA_ARGS[@]+"${EXTRA_ARGS[@]}"}"
