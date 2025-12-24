
#!/usr/bin/env bash
# Script created for Ubuntu 24.04
# To execute run:
# sudo apt install curl ; curl -fsSL https://raw.githubusercontent.com/pedroeloy/ubuntu/refs/heads/main/scripts/setup_ubuntu.sh | bash

echo
echo Executing script...
echo

##################################################################################################
# Start by updating/upgrade the system and rebooting
##################################################################################################
#sudo apt update -y 
#sudo apt upgrade -y
#sudo reboot


##################################################################################################
#For Virtualbox guest additions install/upgrade
##################################################################################################
#sudo apt install bzip2 tar gcc make perl -y



#Set mouse acceleration similar to Windows (original: accel-profile='default') 
#gsettings set org.gnome.desktop.peripherals.mouse accel-profile adaptive
#gsettings set org.gnome.desktop.peripherals.mouse speed 0.3


##################################################################################################
#Set PT keyboard permanently but for user only
##################################################################################################
gsettings set org.gnome.desktop.input-sources sources "[('xkb','pt')]"


##################################################################################################
#Settings->Accessibility->Always show scrollbars
##################################################################################################
gsettings set org.gnome.desktop.interface overlay-scrolling false


##################################################################################################
#Settings->Accessibility->Seeing->Cursor Size Medium (original=24)
##################################################################################################
#gsettings set org.gnome.desktop.interface cursor-size 32


##################################################################################################
#Set Settings->Appearance to Blue, defaults are: Yaru, Adwaita, Yaru
##################################################################################################
gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'     # Choose light theme   
gsettings set org.gnome.desktop.interface gtk-theme   'Yaru-blue'         # Settings->Appearance->Style->Color = Blue  //Default=Orange=Yaru
gsettings set org.gnome.desktop.wm.preferences theme  'Yaru-blue'         # Default=Adwaita        
gsettings set org.gnome.desktop.interface icon-theme  'Yaru-blue'         # Settings->Appearance->Style->Color = Blue  //Default=Orange=Yaru


##################################################################################################
#Install User Themes Extension that is included in gnome-shell-extensions and enable it
##################################################################################################
sudo apt install gnome-tweaks gnome-shell-extension-manager gnome-shell-extensions -y

# Open Extension Manager and install Dash-to-Panel
# Behaviour->Ungroup Applications, Configure->Maximum Width=60

#Move the Dock "Show Apps" button from the bottom to the top (original=false)
#gsettings set org.gnome.shell.extensions.dash-to-dock show-apps-at-top true

# Gnome extention "Jut Perfection"
# Install "impatience" extension to increase animation speed, or view and try:  Just set GNOME_SHELL_SLOWDOWN_FACTOR=0.5 in /etc/environment.
# Install "App Icons Taskbar" extension has an alternativo to "dash to panel"

#gnome-extensions enable user-theme@gnome-shell-extensions.gcampax.github.com
#gsettings set org.gnome.shell.extensions.user-theme name 'Yaru-blue'


##################################################################################################
# Install MSEdge from repository
##################################################################################################
sudo apt install curl -y
curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" > /etc/apt/sources.list.d/microsoft-edge.list'
rm microsoft.gpg
sudo apt update -y
sudo apt install microsoft-edge-stable -y
#sudo apt install microsoft-edge-beta -y    # Edge Beta


##################################################################################################
# Replace vi with vim as the default editor
##################################################################################################
#sudo apt install vim -y
#sudo update-alternatives --set editor /usr/bin/vim.basic


##################################################################################################
# Install Brave Browser from repository (better than snap)
# https://brave.com/linux/
##################################################################################################
#sudo apt install curl
#sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
#sudo curl -fsSLo /etc/apt/sources.list.d/brave-browser-release.sources https://brave-browser-apt-release.s3.brave.com/brave-browser.sources
#sudo apt update
#sudo apt install brave-browser


##################################################################################################
# Disable ntfs3 kernel driver, and use instead the FUSE ntfs-3g driver that is more reliable
# https://bugs.launchpad.net/ubuntu/+source/ntfs-3g/+bug/2062972
# reboot after the change!
##################################################################################################
#echo 'blacklist ntfs3' | sudo tee /etc/modprobe.d/disable-ntfs3.conf


##################################################################################################
# Make the GDM3 login screen appear at the current monitor configuration
# The internal monitor will still work when the external monitor is disconnected
# After an upgrade I may need to run this again
##################################################################################################
#sudo cp ~/.config/monitors.xml /var/lib/gdm3/.config/
#sudo chown gdm:gdm /var/lib/gdm3/.config/monitors.xml


##################################################################################################
# Help with QT5 apps windows buttons, and app size, like KeepassXC or QBittorrent
##################################################################################################
# export QT_QPA_PLATFORM="xcb;wayland"
# export QT_SCALE_FACTOR=1.2


##################################################################################################
# Grub Customizer for helping with dualboot menu: https://launchpad.net/~danielrichter2007/+archive/ubuntu/grub-customizer
# Set Custom Resolution to 640x480 to see better!
##################################################################################################
#sudo add-apt-repository ppa:danielrichter2007/grub-customizer
#sudo apt-get update
#sudo apt-get install grub-customizer


##################################################################################################
# Install snap Notepad++ (WINE)  (edge channel)
# Then run manually:  notepad-plus-plus.wine winecfg
# And set Graphics->Screen Resolution-> to 144 DPI in the GUI
##################################################################################################
# sudo snap install notepad-plus-plus --edge


##################################################################################################
# Remap LIFT mouse Back/Forward to middle mouse button
# Manually run afterwards:  input-remapper-gtk
# And Configure: Device LIFT, Add: Button EXTRA, Button SIDE -> Key or Macro (mouse)=BTN_MIDDLE
# Choose: Autoload
##################################################################################################
#sudo apt install input-remapper
#sudo systemctl enable --now input-remapper


##################################################################################################
# Install Geany Text Editor and get colour themes!
##################################################################################################
#sudo apt install geany -y


##################################################################################################
# Install XFCE Terminal
##################################################################################################
#sudo apt install xfce-terminal -y
#echo 'export VTE_DISABLE_STYLE_HIGHLIGHTING=1' >> ~/.bashrc    #Fix for XFCE selection bug drawing





##################################################################################################
# Install Gnome Software (including flatpak support)  and then reboot!
##################################################################################################
#sudo apt install gnome-software gnome-software-plugin-flatpak -y
#flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo


# Install extras including microsoft fonts and extra codecs, must be run manually to accept EULAs.
# Dont install because ttf-mscorefonts-installer seems disrupt font rendering on  chrome/edge!
#sudo apt install ubuntu-restricted-extras


#gsettings set org.gnome.shell.extensions.user-theme name 'Yaru-blue'
#TERMINAL_PROFILEID=$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d \')
