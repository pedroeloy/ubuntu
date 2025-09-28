#!/usr/bin/env bash
##################################################################################################
# Configure Gdrive on ~/GoogleDrive on Ubuntu 24.04
# To execute run:
# sudo apt install curl -y ; curl -fsSL https://raw.githubusercontent.com/pedroeloy/ubuntu/refs/heads/main/scripts/configure_googledrive_on_home.sh | bash
##################################################################################################

sudo apt install rclone fuse3 -y
mkdir -p ~/GoogleDrive
mkdir -p ~/.config/systemd/user

cat  <<EOF > ~/.config/systemd/user/rclone-gdrive.service
[Unit]
Description=Mount Google Drive via rclone
After=network-online.target
Wants=network-online.target

[Service]
ExecStart=/usr/bin/rclone mount gdrive: %h/GoogleDrive \
    --vfs-cache-mode writes \
    --dir-cache-time 1h \
    --poll-interval 15s \
    --umask 002 \
    --uid $(id -u) --gid $(id -g) 

Restart=on-failure
Environment=PATH=/usr/bin:/bin:/usr/sbin:/sbin

[Install]
WantedBy=default.target
EOF

systemctl --user daemon-reload
systemctl --user enable rclone-gdrive


echo Manual Configuration...
# rclone config

# Instructions:
# n) New remote
# name: gdrive
# Storage: drive
# client id: [ENTER]
# client secret: [ENTER]
# Scope: 1 - Full access
# service_account_file: [ENTER]
# Advanced config: No
# (Login in Browser)
# Auto Config: Yes
# Shared Drive (Team Drive): No
# Keep this drive remote: Yes
# q) Quit Config


#Startup
systemctl --user restart rclone-gdrive


# Usefull extra commands:
# rclone ls gdrive:            # Test ls
# rclone mount gdrive: ~/GoogleDrive --vfs-cache-mode writes #Mount manually! 
# fusermount3 -u ~/GoogleDrive  # unmount
# rclone listremotes            # list remotes
# rclone sync ~/Documents gdrive:DocumentsBackup    # sync/backup

