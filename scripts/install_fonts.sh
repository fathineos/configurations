#!/bin/sh
set -e

sudo apt-get install --assume-yes fontconfig 1>/dev/null

if [ ! -d $HOME/configurations ]; then
  git clone git@github.com:fathineos/configurations.git \
    $HOME/configurations || true 1>/dev/null
fi
if [ ! -d $HOME/.fonts ]; then
  mkdir -p $HOME/.fonts
  /usr/bin/ls -d $HOME/configurations/fonts/* | xargs ln -st $HOME/.fonts/
  sudo fc-cache -f -v
fi
