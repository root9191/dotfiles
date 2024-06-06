# Setup fzf
# ---------
if [[ ! "$PATH" == */home/lichti/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/lichti/.fzf/bin"
fi

source <(fzf --zsh)
