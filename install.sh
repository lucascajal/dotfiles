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

# Install Krew (kubectl plugin manager)
(
  set -x; cd "$(mktemp -d)" &&
  OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
  ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
  KREW="krew-${OS}_${ARCH}" &&
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
  tar zxvf "${KREW}.tar.gz" &&
  ./"${KREW}" install krew
)
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
# Install krew plugins
kubectl krew install ctx
kubectl krew install ns
# kubectl krew install ktop # Requires prometheus & permissions
kubectl krew install resource-capacity
# kubectl krew install score

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
