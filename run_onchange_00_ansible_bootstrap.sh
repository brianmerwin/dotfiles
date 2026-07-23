#!/usr/bin/env bash
set -euo pipefail

# Install uv if not present
if ! command -v uv &>/dev/null; then
  echo "Installing Astral UV..."
  if command -v curl &>/dev/null; then
    curl -LsSf https://astral.sh/uv/install.sh | sh
  else
    wget -qO- https://astral.sh/uv/install.sh | sh
  fi
fi

cd ~/.bootstrap

# Clean recreate venv
uv sync --no-install-project

# Prevent Python from writing .pyc files during root-privileged tasks
export PYTHONDONTWRITEBYTECODE=1

# Prompt for user preferences
read -rp "Install system packages via dnf/apt? (requires sudo) [y/N]: " INSTALL_SYSTEM
read -rp "Check for updates to installed binaries? [y/N]: " CHECK_UPDATES

# Normalize to true/false for Ansible (Jinja2 "n" | bool == True)
if [[ "$INSTALL_SYSTEM" =~ ^[Yy]$ ]]; then
  INSTALL_SYSTEM=true
else
  INSTALL_SYSTEM=false
fi

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

.venv/bin/ansible-playbook ./bootstrap.yml -i localhost, -c local \
  -e "install_system_packages=$INSTALL_SYSTEM" \
  -e "check_for_updates=$CHECK_UPDATES" \
  "${EXTRA_ARGS[@]}"
