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

# Ensure config dir exists
mkdir -p ~/.config

# Symlink full configs
ln -sfn "$DOTFILES_DIR/tmux/tmux.conf" ~/.tmux.conf
ln -sfn "$DOTFILES_DIR/nvim" ~/.config/nvim
ln -sfn "$DOTFILES_DIR/alacritty" ~/.config/alacritty
ln -sfn "$DOTFILES_DIR/starship/starship.toml" ~/.config/starship.toml

# Add starship init to ~/.zshrc if not present
STARSHIP_LINE='eval "$(starship init zsh)"'
if ! grep -Fxq "$STARSHIP_LINE" ~/.zshrc; then
  echo "$STARSHIP_LINE" >> ~/.zshrc
  source ~/.zshrc
fi

echo "alacritty + starship + tmux + LazyVim installed"
