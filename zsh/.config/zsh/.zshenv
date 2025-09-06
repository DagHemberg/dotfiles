# ZDOTDIR, XDG_{CONFIG,CACHE,DATA,STATE}_HOME defined in /etc/zshenv

export LD_LIBRARY_PATH=/usr/local/lib
export HISTFILE="$ZDOTDIR/.zsh_history"
export HISTSIZE=100000
export SAVEHIST=100000
setopt HIST_SAVE_NO_DUPS

export EDITOR="nvim"
export VISUAL="nvim"

source $ZDOTDIR/xdg.zsh # sets up better xdg dirs, so not everything defaults to $HOME
source "$CARGO_HOME/env"
source "$XDG_DATA_HOME/ghcup/env"

# PATH
path=(
  "$HOME/.local/bin"
  "$XDG_DATA_HOME/coursier/bin"
  "$XDG_DATA_HOME/julia/juliaup/bin"
  "$PNPM_HOME"
  $path
)

export PATH

eval "$(/usr/bin/mise activate zsh)"
