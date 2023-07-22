#!/bin/sh
set -e

if ! which nvim >/dev/null; then
  sudo add-apt-repository --yes ppa:neovim-ppa/unstable;
  sudo apt update -qq --assume-yes;
  sudo apt-get install --assume-yes neovim 1>/dev/null
fi
sudo apt-get install --assume-yes -qq \
    python3-pip \
    python3-venv \
    python3-neovim \
    silversearcher-ag \
    1>/dev/null

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
cd ~/.local/share/nvim/site/pack/packer/opt/coq_nvim &&
  python3 -m coq deps
