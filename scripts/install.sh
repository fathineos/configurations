#!/bin/sh
set -e

APT_FLAGS="--assume-yes"
FLAT_PAK_FLAGS="--assumeyes --noninteractive"

####################################################################
# System Sconfigurep-etup
####################################################################

sudo apt install $APT_FLAGS \
  curl \
  git 1>/dev/null

CHOICES=$(whiptail \
	--notags \
	--separate-output \
	--checklist \
	--nocancel \
 	"System Utils" 20 78 15 \
	ssh-keygen "Generate ssh key" OFF \
	git-config "Configure git" OFF \
  fonts-config "Install fonts" OFF \
	3>&1 1>&2 2>&3)

for CHOICE in $CHOICES; do
  case "$CHOICE" in
  "ssh-keygen")
    EMAIL=$(whiptail \
	    --inputbox "What is your ssh key email?" 8 39 \
	    --title "Setting up ssh key" \
	    3>&1 1>&2 2>&3)
    ssh-keygen -t ed25519 -C $EMAIL
    echo "Register public key in .ssh to Github"
    ;;
  "git-config")
    EMAIL=$(whiptail \
	    --inputbox "What is your git email?" 8 39 \
	    --title "Configure Git 1/3" \
	    3>&1 1>&2 2>&3)
    ssh-keygen -t ed25519 -C $EMAIL
    git config --global user.email $EMAIL

    FULLNAME=$(whiptail \
	    --inputbox "What is your git email?" 8 39 \
	    --title "Configure Git 2/3" \
	    3>&1 1>&2 2>&3)
    git config --global user.email $FULLNAME

    # Informational Prompt
    whiptail \
	    --msgbox \
	    --title "Configure Git 3/3" \
	    "Register public key in .ssh to Github" 25 80
    ;;
  "fonts-config")
    curl https://raw.githubusercontent.com/fathineos/configurations/master/scripts/install_fonts.sh | bash
    ;;
  *)
    echo "Unsupported item $CHOICE!" >&2
    exit 1
    ;;
  esac
done

####################################################################
# System Utils
####################################################################

CHOICES=$(whiptail \
	--notags \
	--separate-output \
	--checklist \
	--nocancel \
 	"System Utils" 20 78 15 \
        docker docker OFF \
	tmux tmux OFF \
	neovim neovim OFF \
	zsh zsh OFF \
	3>&1 1>&2 2>&3)

for CHOICE in $CHOICES; do
  case "$CHOICE" in
  "docker")
    curl -sSL https://get.docker.com/ | sudo sh
    sudo sh -eux <<EOF
apt install --assume-yes uidmap
EOF
    dockerd-rootless-setuptool.sh install
    ;;
  "neovim")
    curl https://raw.githubusercontent.com/fathineos/configurations/master/scripts/install_vim.sh | bash
    ;;
  "tmux")
    curl https://raw.githubusercontent.com/fathineos/configurations/master/scripts/install_tmux.sh | bash
    ;;
  "zsh")
    curl https://raw.githubusercontent.com/fathineos/configurations/master/scripts/install_zsh.sh | bash
    ;;
  *)
    echo "Unsupported item $CHOICE!" >&2
    exit 1
    ;;
  esac
done

####################################################################
# General Applications
####################################################################

CHOICES=$(whiptail \
	--notags \
	--separate-output \
	--checklist \
	--nocancel \
	--title "GUI Software" \
	"Choose software to install" 20 78 15 \
	keepassxc KeePassXC OFF \
	spotify Spotify OFF \
	stremio Stremio OFF \
	viber Viber OFF \
	slack Slack OFF \
	signal Signal OFF \
	skype Skype OFF \
	libreoffice "Libre Office" OFF \
	3>&1 1>&2 2>&3)

for CHOICE in $CHOICES; do
  case "$CHOICE" in
  "keepassxc")
    sudo flatpak install $FLAT_PAK_FLAGS "app/org.keepassxc.KeePassXC"
    ;;
  "spotify")
    sudo flatpak install $FLAT_PAK_FLAGS "app/com.spotify.Client/x86_64/stable"
    ;;
  "stremio")
    sudo flatpak install $FLAT_PAK_FLAGS "app/com.stremio.Stremio/x86_64/stable"
    ;;
  "viber")
    sudo flatpak install $FLAT_PAK_FLAGS "app/com.viber.Viber/x86_64/stable"
    ;;
  "slack")
    sudo flatpak install $FLAT_PAK_FLAGS "app/com.slack.Slack/x86_64/stable"
    ;;
  "signal")
    sudo flatpak install $FLAT_PAK_FLAGS "app/org.signal.Signal/x86_64/stable"
    ;;
  "skype")
    sudo flatpak install $FLAT_PAK_FLAGS "app/com.skype.Client/x86_64/stable"
    ;;
  "libreoffice")
    sudo flatpak install $FLAT_PAK_FLAGS "app/org.libreoffice.LibreOffice/x86_64/stable"
    ;;
  *)
    echo "Unsupported item $CHOICE!" >&2
    exit 1
    ;;
  esac
done
