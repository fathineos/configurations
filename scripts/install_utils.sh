#!/bin/sh
set -e

# ls -> exa
# cat -> bat
# grep -> ag
# cd -> z
# early oom: early oom daemon
# and: auto nice daemon
sudo apt install --assume-yes -qq \
  silversearcher-ag \
  exa \
  bat \
  earlyoom \
  and;
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash;
