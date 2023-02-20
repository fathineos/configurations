#!/bin/sh
set -e

if ! which nvim >/dev/null; then
  if which snap >/dev/null; then
    sudo snap install --beta nvim --classic
  else
    sudo apt-get install --assume-yes neovim 1>/dev/null
  fi
fi
sudo apt-get install --assume-yes \
    python3-pip \
    python3-venv \
    silversearcher-ag \
    1>/dev/null

pip install --user neovim

if [ ! -d $HOME/configurations ]; then
  git clone git@github.com:fathineos/configurations.git \
    $HOME/configurations || true 1>/dev/null
fi

if [ ! -d $HOME/.config/nvim ]; then
  mkdir -p $HOME/.config/nvim
fi
if [ ! -d $HOME/.config/nvim/lua ]; then
  rm -rf $HOME/.config/nvim && \
    ln -sf $HOME/configurations/dotfiles/.config/nvim $HOME/.config/
fi
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
nvim --headless -c 'autocmd COQdeps'
