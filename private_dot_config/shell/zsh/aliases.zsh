# ========================================================
# zsh
# ========================================================
alias rlz="source $ZDOTDIR/.zshrc"
alias edz="vim $ZDOTDIR"

# Better ls
alias ls='exa'

# Detailed listing
alias ll='exa -lh --git'

# Detailed listing including hidden files
alias la='exa -lah --git'

# Tree view
alias tree='exa --tree'

# Reuse ls completions for exa (avoids defining a separate completion function)
compdef exa=ls

# Better cat
#alias cat='bat'

# =========================================================
# Core utilities
# =========================================================

alias grep='rg --color=auto'
alias diff='diff --color=auto'
alias df='df -h'

# =========================================================
# Navigation
# =========================================================

alias -- -='cd -'  # -- prevents - being parsed as a flag; cd - jumps to previous directory

# =========================================================
# Editor
# =========================================================

alias vim='vim'

# =========================================================
# Git
# =========================================================

alias glog='PAGER="less -F -X" git log'                              # -F quit if one screen, -X no clear on exit
alias gadog='PAGER="less -F -X" git log --all --decorate --oneline --graph'
alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

# =========================================================
# Video
# =========================================================

alias stream='mpv av://v4l2:/dev/video4 --fullscreen --demuxer-lavf-o=input_format=mjpeg,framerate=30 --profile=low-latency --untimed'
