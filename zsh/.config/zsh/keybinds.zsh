# movement
bindkey '^[[3~' delete-char
bindkey '^[[3;5~' delete-word
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' emacs-forward-word

# autocomplete menu
bindkey -M menuselect '^M' .accept-line
bindkey -M menuselect '^A' .beginning-of-line
bindkey -M menuselect '^E' .end-of-line
# bindkey -M menuselect '^[[D' .backward-char '^[OD' .backward-char
# bindkey -M menuselect '^[[C' .forward-char '^[OC' .forward-char

bindkey '^Z' fancy-ctrl-z
bindkey '^Q^L' insert-last-command-output
