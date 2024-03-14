#!/bin/sh
set -e

if ! which nvim >/dev/null; then
  sudo apt-get install --assume-yes -qq \
    curl \
    1>/dev/null && \
  curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage && \
  chmod u+x nvim.appimage && \
  sudo mv nvim.appimage /usr/local/bin/nvim
fi

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
