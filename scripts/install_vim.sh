#!/bin/bash

set -xeo pipefail

sudo apt-get install -y vim-nox python3-pip silversearcher-ag

if [ ! -d $HOME/configurations ]; then
    git clone git@github.com:fathineos/configurations.git \
        $HOME/configurations || true
fi

mkdir -p $HOME/.vim
ln -sf $HOME/configurations/dotfiles/.vimrc $HOME/.vimrc

if [ ! -d $HOME/.vim/bundle ]; then
    mkdir -p $HOME/.vim/bundle &&
    git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
fi

# needed by deoplete package
pip3 install --user --upgrade pynvim
vim +PluginInstall +qall
