#!/usr/bin/env bash
set -euo pipefail

cd ~/.bootstrap

# Activate the virtual environment
# shellcheck disable=SC1091
source .venv/bin/activate

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

ansible-playbook bootstrap.yml -i localhost, -c local \
  -e "install_system_packages=$INSTALL_SYSTEM" \
  -e "check_for_updates=$CHECK_UPDATES" \
  "${EXTRA_ARGS[@]}"
