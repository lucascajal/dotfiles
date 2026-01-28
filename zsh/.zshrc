# .zshrc - Interactive shell configuration
# Environment variables and PATH are in .zshenv and .zprofile

# History configuration
HISTSIZE=5000                # Number of commands to keep in memory for the current session
HISTFILE=~/.zsh_history      # File where command history is saved
SAVEHIST=$HISTSIZE           # Number of commands to save in the history file
HISTDUP=erase                # Remove older duplicate entries from history
setopt appendhistory         # Append new history lines to the history file (don't overwrite)
setopt sharehistory          # Share command history data between all sessions
setopt hist_ignore_space     # Don't record commands that start with a space
setopt hist_ignore_all_dups  # Remove all previous lines matching the current command from history
setopt hist_save_no_dups     # Don't write duplicate commands to the history file
setopt hist_ignore_dups      # Don't record an entry that duplicates the previous entry
setopt hist_find_no_dups     # When searching history, skip duplicate entries

# Key bindings
bindkey -v                                          # Enable vi keybindings
bindkey '^[[A' history-beginning-search-backward    # Up arrow for history search based on current input
bindkey '^[[B' history-beginning-search-forward     # Down arrow for history search based on current input

# Aliases
alias e='echo "Press Enter to confirm exit, enter anything else to cancel..." && read -r key && [[ -z "$key" ]] && exit || echo "Exit cancelled"'
alias c='clear'
alias k='kubectl'
alias tree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"
alias ls='ls --color'
alias nvimf='nvim "$(fzf --tmux 90%)"' # open file in nvim via fzf (tmux mode to distinguish from terminal)
alias lgit='lazygit'
alias awslogin="rm ~/.aws/credentials && saml2aws --disable-keychain --skip-prompt login" # saml2aws

# Zinit plugin manager installation
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Zsh plugins
zinit wait lucid for \
    atinit"zicompinit; zicdreplay" \
        zsh-users/zsh-syntax-highlighting \
    atload"_zsh_autosuggest_start" \
        zsh-users/zsh-autosuggestions \
    blockf atpull'zinit creinstall -q .' \
        zsh-users/zsh-completions

zinit wait lucid for \
        Aloxaf/fzf-tab

# Load completions
# autoload -Uz compinit && compinit

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'              # Case insensitive completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"             # Use LS_COLORS for completion listing colors
# zstyle ':completion:*' menu no                                      # Don't use a menu for completions
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'  # fzf-tab cd preview

# FZF configuration
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

# Enable zoxide with cd override
eval "$(zoxide init --cmd cd zsh)"

# Starship prompt (after all plugins)
eval "$(starship init zsh)"
