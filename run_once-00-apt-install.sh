#!/bin/bash

echo
echo "=== Run apt update... ==="
sudo apt update

echo
echo "=== Install packages... === "
sudo apt install -y \
    bat \
    curl \
    exa \
    fd-find \
    fzf \
    net-tools \
    openssh-client \
    openssh-server \
    ripgrep \
    tmux \
    vim \
    zsh
