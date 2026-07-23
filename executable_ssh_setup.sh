#!/usr/bin/env bash

# Define the config file path
CONFIG_FILE="$HOME/.ssh/config"

# Create the config file if it doesn't exist
if [ ! -f "$CONFIG_FILE" ]; then
  touch "$CONFIG_FILE"
  echo "Created $CONFIG_FILE"
fi

# Append the configuration to the config file
cat <<EOL >>"$CONFIG_FILE"
# QTS Enterprise Github
Host github.com
  Hostname github.com
  User git
  IdentityFile ~/.ssh/Github-qts.pem
  IdentitiesOnly yes

Host github-brianmerwin
  Hostname github.com
  User git
  IdentityFile ~/.ssh/Github-brianmerwin.pem
  IdentitiesOnly yes
EOL

echo "Configuration added to $CONFIG_FILE"
