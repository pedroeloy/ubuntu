#!/usr/bin/env bash
# Script created for Ubuntu 24.04
# To execute run:
# curl https://raw.githubusercontent.com/pedroeloy/ubuntu/refs/heads/main/scripts/setup_ubuntu.sh | bash


# Start by updating the system and rebooting
#sudo apt update -y && sudo apt upgrade -y
#sudo reboot


#For Virtualbox guest additions install/upgrade
#sudo apt install bzip2 tar gcc make perl -y


#Set Settings->Appearance to Blue, defaults are: Yaru, Adwaita, Yaru
#gsettings set org.gnome.desktop.interface gtk-theme 'Yaru-blue'
#gsettings set org.gnome.desktop.wm.preferences theme 'Yaru-blue'
#gsettings set org.gnome.desktop.interface icon-theme 'Yaru-blue'

#Install User Themes Extension that is included in gnome-shell-extensions and enable it
#sudo apt install gnome-tweaks gnome-shell-extension-manager gnome-shell-extensions -y

#gnome-extensions enable user-theme@gnome-shell-extensions.gcampax.github.com
#gsettings set org.gnome.shell.extensions.user-theme name 'Yaru-blue'

#Settings->Accessibility->Always show scrollbars
gsettings set org.gnome.desktop.interface overlay-scrolling false


#Install MSEdge from repository
#sudo apt install curl -y
#curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
#sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
#sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" > /etc/apt/sources.list.d/microsoft-edge.list'
#rm microsoft.gpg
#sudo apt update -y
#sudo apt install microsoft-edge-stable -y


#gsettings set org.gnome.shell.extensions.user-theme name 'Yaru-blue'
#TERMINAL_PROFILEID=$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d \')
