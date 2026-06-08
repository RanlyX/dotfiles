#!/bin/bash

# Create link from config
createLink() {
    local src=$1
    local dst=$2
    if [[ ! -L "$dst"  ]]; then
        if [[ -f "$src" ]]; then
	    echo "Creating symlink for $(basename $dst)..."
            ln -sf "$src" "$dst"
        fi
    fi
}

CONF_HOME="$HOME/.config"

echo
echo "=== Run auto link... ==="
# Shell
SHELL_CONF_HOME="$CONF_HOME/shell"
# Bash
BASH_CONF_HOME="$SHELL_CONF_HOME/bash"
createLink "$BASH_CONF_HOME/profile" "$HOME/.profile"
#createLink "$BASH_CONF_HOME/bashrc" "$HOME/.bashrc"
# Zsh
ZSH_CONF_HOME="$SHELL_CONF_HOME/zsh"
createLink "$ZSH_CONF_HOME/zshenv" "$HOME/.zshenv"

# Git
GIT_CONF_HOME="$CONF_HOME/git"
createLink "$GIT_CONF_HOME/gitconfig" "$HOME/.gitconfig"

# Tmux
TMUX_CONF_HOME="$CONF_HOME/tmux"
createLink "$TMUX_CONF_HOME/tmux.conf" "$HOME/.tmux.conf"

