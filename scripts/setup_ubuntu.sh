#!/usr/bin/env bash
# Script created for Ubuntu 24.04
# To execute run:
# sudo apt install curl ; curl -fsSL https://raw.githubusercontent.com/pedroeloy/ubuntu/refs/heads/main/scripts/setup_ubuntu.sh | bash

echo
echo Executing script...
echo

# Start by updating/upgrade the system and rebooting
#sudo apt update -y 
#sudo apt upgrade -y
#sudo reboot

#For Virtualbox guest additions install/upgrade
#sudo apt install bzip2 tar gcc make perl -y

#Set mouse acceleration similar to Windows (original: accel-profile='default') 
#gsettings set org.gnome.desktop.peripherals.mouse accel-profile adaptive
#gsettings set org.gnome.desktop.peripherals.mouse speed 0.3

#Set PT keyboard permanently but for user only
gsettings set org.gnome.desktop.input-sources sources "[('xkb','pt')]"

#Settings->Accessibility->Always show scrollbars
gsettings set org.gnome.desktop.interface overlay-scrolling false

#Set Settings->Appearance to Blue, defaults are: Yaru, Adwaita, Yaru
gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'     # Choose light theme   
gsettings set org.gnome.desktop.interface gtk-theme   'Yaru-blue'         # Settings->Appearance->Style->Color = Blue  //Default=Orange=Yaru
gsettings set org.gnome.desktop.wm.preferences theme  'Yaru-blue'         # Default=Adwaita        
gsettings set org.gnome.desktop.interface icon-theme  'Yaru-blue'         # Settings->Appearance->Style->Color = Blue  //Default=Orange=Yaru

#Install User Themes Extension that is included in gnome-shell-extensions and enable it
sudo apt install gnome-tweaks gnome-shell-extension-manager gnome-shell-extensions -y

#Move the Dock "Show Apps" button from the bottom to the top (original=false)
gsettings set org.gnome.shell.extensions.dash-to-dock show-apps-at-top true

# Gnome extention "Jut Perfection"
# Install "impatience" extension to increase animation speed, or view and try:  Just set GNOME_SHELL_SLOWDOWN_FACTOR=0.5 in /etc/environment.
# Install "App Icons Taskbar" extension has an alternativo to "dash to panel"

#gnome-extensions enable user-theme@gnome-shell-extensions.gcampax.github.com
#gsettings set org.gnome.shell.extensions.user-theme name 'Yaru-blue'


#Install MSEdge from repository
sudo apt install curl -y
curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" > /etc/apt/sources.list.d/microsoft-edge.list'
rm microsoft.gpg
sudo apt update -y
sudo apt install microsoft-edge-stable -y

#Install extras including microsoft fonts and extra codecs, must be run manually to accept EULAs.
#sudo apt install ubuntu-restricted-extras

#gsettings set org.gnome.shell.extensions.user-theme name 'Yaru-blue'
#TERMINAL_PROFILEID=$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d \')
