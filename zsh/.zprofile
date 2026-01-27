# .zprofile - Loaded once for LOGIN shells only (before .zshrc)
# Best place for PATH modifications to avoid duplicate entries

eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(/usr/local/bin/brew shellenv)"

# PATH modifications (order matters - first = highest priority)
export PATH="$JAVA_HOME/bin:$PATH"
export PATH="/usr/local/opt/openjdk@17/bin:$PATH"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# Rosetta terminal setup (architecture-specific)
if [ $(arch) = "i386" ]; then
    alias python3="/usr/local/bin/python3.11"
    alias brew86='/usr/local/bin/brew'
fi
