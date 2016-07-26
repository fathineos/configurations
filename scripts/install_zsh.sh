#!/bin/bash

set -xeo pipefail

sudo apt-get install -y zsh

if [ ! -d $HOME/configurations ]; then
    git clone git@github.com:fathineos/configurations.git \
        $HOME/configurations || true
fi

mkdir -p $HOME/.zsh &&
ln -sf $HOME/configurations/dotfiles/.zshrc $HOME/.zshrc &&
ln -sf $HOME/configurations/dotfiles/.zsh/config $HOME/.zsh/config &&
ln -sf $HOME/configurations/dotfiles/.zsh/aliases $HOME/.zsh/aliases

if [ ! -d $HOME/.oh-my-zsh ]; then
    git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
fi

echo 'Run chsh to change default shell'
