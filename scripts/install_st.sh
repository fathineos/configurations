#!/bin/sh
set -e

mkdir -p $HOME/bin

wget --quiet \
  https://raw.githubusercontent.com/fathineos/st/master/bin/st-dark \
  --output-document $HOME/bin/st-dark
  1>/dev/null
chmod +x $HOME/bin/st-dark

wget --quiet \
  https://raw.githubusercontent.com/fathineos/st/master/bin/st-light \
  --output-document $HOME/bin/st-light  \
  1>/dev/null
chmod +x $HOME/bin/st-light
