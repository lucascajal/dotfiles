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
alias fzfp="fzf --preview='cat {}'"
alias nvimf='nvim "$(fzf --preview='\''cat {}'\'')"'

# saml2aws
alias awslogin="rm ~/.aws/credentials && saml2aws --disable-keychain --skip-prompt login"

# zsh-autocomplete & zsh-autosuggestions
source $(brew --prefix)/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

eval "$(starship init zsh)"

source $(brew --prefix)/opt/zsh-fast-syntax-highlighting/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh