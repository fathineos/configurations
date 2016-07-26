CONFIG_PATH='../'
SCRIPTS_PATH='../scripts'

################################# DEVELOPMENT #################################

zsh:
	~/configuration/scripts/install_zsh.sh

tmux:
	~/configuration/scripts/install_zsh.sh

passwords:
	wget -O /tmp/gpg-enc-privkey.asc.gpg https://www.dropbox.com/s/6hvq4iktwpqs73d/gpg-enc-privkey.asc.gpg
	gpg --output /tmp/gpg-enc-privkey.asc --decrypt /tmp/gpg-enc-privkey.asc.gpg
	gpg --import /tmp/gpg-enc-privkey.asc || true
	rm /tmp/gpg-enc-privkey.asc /tmp/gpg-enc-privkey.asc.gpg
	gpg --export --armor fotanks@gmail.com > ~/gpg-fotanks-pub.key

docker:
	if ! which docker > /dev/null; then \
		curl -sSL https://get.docker.com/ | sudo sh; \
		sudo gpasswd -a ${USER} docker; \
		sudo service docker restart; \
	fi

vim: _dotfiles_vim
	~/configuration/scripts/install_vim.sh

################################ ENTERTAINMENT ################################

stremio:
	wget -O /tmp/Stremio3.6.5.linux.tar.gz http://www.strem.io/Stremio3.6.5.linux.tar.gz
	mkdir ~/stremio
	tar xzf Stremio3.6.5.linux.tar.gz -C ~/stremio
	rm /tmp/Stremio3.6.5.linux.tar.gz
