#!/bin/sh
set -e

sudo apt-get install --assume-yes \
  neovim \
  python3-pip \
  silversearcher-ag \
  1>/dev/null

if [ ! -d $HOME/configurations ]; then
  git clone git@github.com:fathineos/configurations.git \
    $HOME/configurations || true 1>/dev/null
fi

mkdir -p $HOME/.vim
ln -sf $HOME/configurations/dotfiles/.vimrc $HOME/.vimrc

if [ ! -d $HOME/.config/nvim ]; then
  mkdir -p $HOME/.config/nvim
  cat >> $HOME/.config/nvim/init.vim <<EOL
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vimrc
EOL
fi

# needed by deoplete package
pip3 install --user --upgrade \
  pynvim \
  msgpack>=1.0.0 \
  1>/dev/null
vim +PluginInstall +qall
