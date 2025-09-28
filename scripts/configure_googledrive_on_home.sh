
##################################################################################################
# Configure Gdrive on ~/GoogleDrive:
##################################################################################################

#sudo apt install rclone fuse3 -y
#mkdir -p ~/GoogleDrive
#mkdir -p ~/.config/systemd/user

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
    --uid 1000 --gid 1000 \
    --allow-other
Restart=on-failure
Environment=PATH=/usr/bin:/bin:/usr/sbin:/sbin

[Install]
WantedBy=default.target
EOF

systemctl --user daemon-reload
systemctl --user enable rclone-gdrive



# rclone config
# n) New remote
# name: gdrive
# Storage: drive
# client id: [ENTER]
# client secret: [ENTER]
# Scope: 1 - Full access
# service_account_file: [ENTER]
# Advanced config: No
# (Do login in Browser)
# Auto Config: Yes
# Shared Drive (Team Drive): No
# Keep this drive remote: Yes
# q) Quit Config
# rclone ls gdrive:
# rclone mount gdrive: ~/GoogleDrive --vfs-cache-mode writes

#Startup
#systemctl --user start rclone-gdrive

# Usefull commands:
#fusermount3 -u ~/GoogleDrive  # unmount
#rclone listremotes            # list remotes
#rclone sync ~/Documents gdrive:DocumentsBackup    # sync/backup

