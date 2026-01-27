# .zshenv - Loaded for ALL shells (interactive, non-interactive, scripts)
# Keep this minimal - only truly universal environment variables

. "$HOME/.cargo/env"

# JAVA_HOME (needed by build tools, scripts, etc.)
export JAVA_HOME=/opt/homebrew/Cellar/openjdk@11/11.0.19/libexec/openjdk.jdk/Contents/Home

# For zsh-autocomplete in Ubuntu (see https://github.com/marlonrichert/zsh-autocomplete?tab=readme-ov-file#installation--setup)
# skip_global_compinit=1