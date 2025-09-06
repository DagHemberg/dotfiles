# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# allow comments in commands
setopt interactivecomments

# emacs mode
bindkey -e

# Sets color variable such as $fg, $bg, $color and $reset_color
autoload -U colors && colors

# plugins
source $ZDOTDIR/.antidote/antidote.zsh
antidote load $ZDOTDIR/.zsh_plugins.txt

# other files
source $ZDOTDIR/aliases.zsh
source $ZDOTDIR/commands.zsh
source $ZDOTDIR/completions.zsh
source $ZDOTDIR/dirs.zsh
source $ZDOTDIR/keybinds.zsh

# fix ls colors
[[ -z "$LS_COLORS" ]] || zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# activate prompt
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
