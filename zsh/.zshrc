# JAVA_HOME
export JAVA_HOME=/opt/homebrew/Cellar/openjdk@11/11.0.19/libexec/openjdk.jdk/Contents/Home
export PATH=$JAVA_HOME/bin:$PATH
export PATH="/usr/local/opt/openjdk@17/bin:$PATH"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# rosetta terminal setup
if [ $(arch) = "i386" ]; then
    alias python3="/usr/local/bin/python3.11"
    alias brew86='/usr/local/bin/brew'
fi

alias k='kubectl'
alias tree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"

# saml2aws
alias awslogin="rm ~/.aws/credentials && saml2aws --disable-keychain --skip-prompt login"

# FZF configuration
## Search and open files with fzf and nvim (tmux view to distinguish from other fzf usages)
alias nvimf='nvim "$(fzf --tmux 90%)"'
## fzf shell integration
export FZF_CTRL_T_OPTS="
    --style full
    --height ~90%
    --preview 'if [ -d {} ]; then ls --color {} ; else bat -n --color=always {} ; fi'"
export FZF_CTRL_R_OPTS="--no-preview"
export FZF_ALT_C_OPTS="
    --style full
    --height ~90%
    --no-preview"
export FZF_DEFAULT_OPTS="
    --walker-skip .git,node_modules,target,.pyc,__pycache__,.pytest_cache,.DS_Store,.terraform,.mypy_cache,.venv
    --layout reverse
    --preview 'if [ -d {} ]; then ls --color {} ; else bat -n --color=always {} ; fi'"
source <(fzf --zsh)

# Zsh inline autosuggestions and syntax highlighting
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/opt/zsh-fast-syntax-highlighting/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

eval "$(starship init zsh)"