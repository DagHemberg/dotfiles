# custom commands
naut() {
    set +m
    nautilus "$1" > /dev/null 2>&1 &
    disown
    set -m
}

open() {
    set +m
    xdg-open "$1" > /dev/null 2>&1 &
    disown
    set -m
}

clipcopy() {
    cat "${1:-/dev/stdin}" | wl-copy &>/dev/null &|;
}

clippaste() {
    wl-paste --no-newline;
}

fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line -w
  else
    zle push-input -w
    zle clear-screen -w
  fi
}
zle -N fancy-ctrl-z
