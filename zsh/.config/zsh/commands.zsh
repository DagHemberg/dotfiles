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
    # Get the list of jobs, filtering out the (pwd now: ...) lines
    local jobs_list=$(jobs | grep -v "pwd now")

    if [[ -z $jobs_list ]]; then
      return
    fi

    # Count actual jobs
    local job_count=$(echo "$jobs_list" | wc -l)

    if [[ $job_count -eq 1 ]]; then
      BUFFER="fg"
    else
      # Format the list to show: "ID: Command"
      # We strip the [+] [-] and "suspended/running" status
      local selected_job=$(echo "$jobs_list" | awk '
        {
          id = $1; gsub(/[\[\]]/, "", id);
          $1=$2=$3=""; print id ":" $0
        }' | fzf --height 40% --reverse --delimiter ":" --with-nth 2..)

      if [[ -n $selected_job ]]; then
        local job_id=$(echo "$selected_job" | cut -d: -f1)
        BUFFER="fg %$job_id"
      else
        return
      fi
    fi
    zle accept-line
  else
    zle push-input -w
    zle clear-screen -w
  fi
}
zle -N fancy-ctrl-z

# fancy-ctrl-z () {
#   if [[ $#BUFFER -eq 0 ]]; then
#     BUFFER="fg"
#     if [[ $(jobs | wc -l) -gt 1 ]]; then
#       local job=$(jobs | fzf --height 40% --reverse)
#       if [[ -n $job ]]; then
#         local job_id=$(echo "$job" | awk '{print $1}' | tr -d '[]')
#         BUFFER="fg %$job_id"
#       else
#         return
#       fi
#     fi
#     zle accept-line
#   else
#     zle push-input -w
#     zle clear-screen -w
#   fi
# }
# zle -N fancy-ctrl-z

zmodload -i zsh/parameter
insert-last-command-output() {
  LBUFFER+="$(eval $history[$((HISTCMD-1))])"
}
zle -N insert-last-command-output

autoload -U zmv
