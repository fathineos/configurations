#!/bin/bash

set -xeo pipefail

sudo apt install -y tmux

colortheme='colortheme-primary'
if [ "$1" == "secondary" ]; then
    colortheme='colortheme-secondary'
fi

if [ ! -d $HOME/configurations ]; then
    git clone git@github.com:fathineos/configurations.git \
        $HOME/configurations || true
fi

mkdir -p $HOME/.tmux &&
ln -sf $HOME/configurations/dotfiles/.tmux.conf $HOME/.tmux.conf &&
ln -sf $HOME/configurations/dotfiles/.tmux/$colortheme $HOME/.tmux/colortheme

if [ "$1" == "secondary" ]; then
    sed -e '/unbind C-b/ s/^#*/#/' -i $HOME/.tmux.conf &&
    sed -e '/set -g prefix C-a/ s/^#*/#/' -i $HOME/.tmux.conf &&
    sed -e '/bind C-a send-prefix/ s/^#*/#/' -i $HOME/.tmux.conf
fi

if [ ! -d $HOME/.tmux/plugins/tpm ]; then
    mkdir -p $HOME/.tmux/plugins
    git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
fi

echo 'Start tmux and run Ctlr+I to install plugins'
