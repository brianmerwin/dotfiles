# dotfiles
Linux dotfiles. Nothing to see here.

## Setup SSH
Locate and copy the `setup_ssh.sh` script from this repo. Place it into your user directory. Run `chmod +z .\setup_ssh.sh` and execute the script.

### Install Pre-requisites
```bash
sudo dnf -y group install "Development Tools" 
```

### SSH Keys
Manually create the ssh key file, place it in `~/.ssh/` and `chmod 600 [key file]`

### Initiate Chezmoi Setup

> **Note:** Uses the `github-brianmerwin` SSH host alias from `~/.ssh/config` to authenticate to GitHub.

```bash
mkdir -p ~/.config/chezmoi && printf "Paste your age secret key: " && stty -echo && read -r AGE_KEY && stty echo && printf "\n" && echo "$AGE_KEY" > ~/.config/chezmoi/key.txt && chmod 600 ~/.config/chezmoi/key.txt && sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply github-brianmerwin:brianmerwin/dotfiles.git && source "$HOME"/.zshrc
```

## To Do
- Configure chezmoi run once scripts for the Development Tools group, fzf, npm, git, uv, python
- Configure chezmoi to run on Debian distros as well as EL distros
