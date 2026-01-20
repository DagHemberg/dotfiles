# +args
alias mkdir="mkdir -pv"
alias rmdir="rmdir -v"
alias rm="rm -iv"
alias mv="mv -iv"
alias cp="cp -riv"
alias code="code --ozone-platform=wayland"
alias dw="pw -p Dsek"
alias git='LANG=en_US git'

# builtin replacements
alias cat="bat"
alias ls="eza"
alias grep="rg"
eval "$(zoxide init --cmd cd zsh)"

# programs
alias nv="nvim"
alias lg="lazygit"
alias winpod="podman-compose --file=$XDG_CONFIG_HOME/winapps/compose.yaml"

# yt-dlp -- downloading videos and music
alias dlv="yt-dlp -S 'ext' -o '$XDG_VIDEOS_DIR/yt-dlp/%(title)s.%(ext)s'"
alias dla="yt-dlp -S 'ext' -x -o '$XDG_MUSIC_DIR/yt-dlp/%(title)s.%(ext)s'"

# clipboard cli
alias cpc="clipcopy"
alias cpa="clippaste"

#kittens
alias ssh="kitten ssh"
alias img="kitten icat"

# xdg
alias mvn="mvn -gs $XDG_CONFIG_HOME/maven/settings.xml"
