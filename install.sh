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

# Ensure config dir exists
mkdir -p ~/.config

# Symlink full configs
ln -sfn "$DOTFILES_DIR/tmux/tmux.conf" ~/.tmux.conf
ln -sfn "$DOTFILES_DIR/nvim" ~/.config/nvim

# Configure iTerm2
# Specify the preferences directory
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "$DOTFILES_DIR/iterm2"
# Tell iTerm2 to use the custom preferences in the directory
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true

echo "tmux + LazyVim installed"
