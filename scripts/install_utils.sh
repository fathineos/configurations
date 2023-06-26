#!/bin/sh
set -e

# ls -> exa
# cat -> bat
# grep -> ag
# cd -> z
sudo apt install --assume-yes -qq silversearcher-ag exa bat;
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash;

