#!/bin/sh
set -e

sudo apt-get install --assume-yes zsh 1>/dev/null

if [ ! -d $HOME/configurations ]; then
  git clone git@github.com:fathineos/configurations.git \
    $HOME/configurations || true 1>/dev/null
fi

mkdir -p $HOME/.zsh &&
ln -sf $HOME/configurations/dotfiles/.zshrc $HOME/.zshrc &&
ln -sf $HOME/configurations/dotfiles/.zsh/config $HOME/.zsh/config &&
ln -sf $HOME/configurations/dotfiles/.zsh/aliases $HOME/.zsh/aliases

if [ ! -d $HOME/.oh-my-zsh ]; then
  git clone https://github.com/robbyrussell/oh-my-zsh.git \
    ~/.oh-my-zsh 1>/dev/null
fi

echo "Run \033[31mchsh -s /bin/zsh\033[0m to change default shell"
