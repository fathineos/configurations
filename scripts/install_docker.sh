#!/bin/sh
set -e

curl -sSL https://get.docker.com/ | sudo sh && \
  sudo apt install --assume-yes -qq docker-compose-plugin && \
  sudo apt install --assume-yes -qq uidmap && \
  dockerd-rootless-setuptool.sh install;

if [ ! -f "/usr/local/bin/docker-compose" ]; then
  echo 'docker compose $@' | sudo tee -a /usr/local/bin/docker-compose && \
    sudo chmod +x /usr/local/bin/docker-compose;
fi
