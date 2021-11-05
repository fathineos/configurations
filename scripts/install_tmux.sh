#!/bin/sh
set -e

sudo apt install --assume-yes tmux 1>/dev/null

if [ ! -d $HOME/configurations ]; then
  git clone git@github.com:fathineos/configurations.git \
    $HOME/configurations || true 1>/dev/null
fi

mkdir -p $HOME/.tmux &&
ln -sf $HOME/configurations/dotfiles/.tmux.conf $HOME/.tmux.conf &&
ln -sf $HOME/configurations/dotfiles/.tmux/$colortheme $HOME/.tmux/colortheme

if [ ! -d $HOME/.tmux/plugins/tpm ]; then
  mkdir -p $HOME/.tmux/plugins
  git clone https://github.com/tmux-plugins/tpm \
    $HOME/.tmux/plugins/tpm 1>/dev/null
fi

whiptail \
  --msgbox \
  --title "tmux installation" \
  "Start tmux and run Ctlr+I to install plugins" 25 80
