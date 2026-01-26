#!/usr/bin/env bash
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TS=$(date +%s)

backup() {
  if [ -e "$1" ] || [ -L "$1" ]; then
    mv "$1" "$1.bak.$TS"
  fi
}

# Install required packages
brew bundle

# Install TPM (Tmux Plugin Manager)
TPM_DIR="$HOME/.tmux/plugins/tpm"
if [ ! -d "$TPM_DIR" ]; then
  git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
fi

# Backup existing configs
backup ~/.tmux.conf
backup ~/.config/nvim
backup ~/.config/alacritty
backup ~/.config/starship.toml
backup ~/.zshrc
backup ~/.zprofile
backup ~/.zshenv

# Ensure config dir exists
mkdir -p ~/.config

# Symlink full configs
ln -sfn "$DOTFILES_DIR/tmux/tmux.conf" ~/.tmux.conf
ln -sfn "$DOTFILES_DIR/nvim" ~/.config/nvim
ln -sfn "$DOTFILES_DIR/alacritty" ~/.config/alacritty
ln -sfn "$DOTFILES_DIR/starship/starship.toml" ~/.config/starship.toml

# Setup zsh
ln -sfn "$DOTFILES_DIR/zsh/.zshrc" ~/.zshrc
ln -sfn "$DOTFILES_DIR/zsh/.zprofile" ~/.zprofile
ln -sfn "$DOTFILES_DIR/zsh/.zshenv" ~/.zshenv
source ~/.zshrc

echo "zsh + alacritty + starship + tmux + LazyVim installed"
