#!/usr/bin/env bash

set -euo pipefail

# Ensure script is run with root privileges
if [ "$EUID" -ne 0 ]; then
    echo "Error: Please run this script with sudo or as root." >&2
    exit 1
fi

echo
echo "On gnome keep:  gsettings get org.gnome.desktop.peripherals.mouse accel-profile 'default'"
echo


# Prompt for DPI (default to 120 if left blank)
read -p "Enter DPI (default 120=125%, 96=100%, 144=150% ): " MY_DPI
MY_DPI=${MY_DPI:-120}

# Prompt for Sensitivity (default to 10 if left blank)
read -p "Enter Windows Sensitivity (1-20, default 10): " MY_SENSITIVITY
MY_SENSITIVITY=${MY_SENSITIVITY:-10}


RAW_USER="${SUDO_USER:-$USER}"
# ORIGINAL: PATCH_URL="https://gitlab.freedesktop.org/tehabstract/libinput-epp/-/raw/main/0001-windows-epp.patch"

PATCH_URL="https://raw.githubusercontent.com/pedroeloy/ubuntu/refs/heads/main/scripts/ubuntu26.04/0001-windows-epp.patch"
WORK_DIR="/tmp/libinput-build"

echo "=== 1. Checking installed libinput version ==="
INSTALLED_VER=$(dpkg-query -W -f='${Version}\n' libinput-bin 2>/dev/null || dpkg-query -W -f='${Version}\n' libinput10 2>/dev/null || true)

if [ -z "$INSTALLED_VER" ]; then
    echo "Warning: libinput package not found via dpkg. Enabling source repos and continuing..."
else
    echo "Installed libinput version: ${INSTALLED_VER}"
fi

echo "=== 2. Enabling source repositories & installing build tools ==="
# Enable deb-src repositories in Ubuntu's deb822 sources format
sed -i 's/^Types: deb$/Types: deb deb-src/' /etc/apt/sources.list.d/ubuntu.sources 2>/dev/null || true

apt update
apt install -y build-essential devscripts dpkg-dev wget curl patch

echo "Installing build dependencies for libinput..."
apt build-dep -y libinput

echo "=== 3. Setting up workspace and downloading source code ==="
rm -rf "$WORK_DIR"
mkdir -p "$WORK_DIR"

# Ensure user owns the workspace directory to prevent permission errors during apt source
chown -R "$RAW_USER:$RAW_USER" "$WORK_DIR"

# Download Debian/Ubuntu package sources as non-root user
su -c "cd '$WORK_DIR' && apt source libinput" "$RAW_USER"

# Locate the extracted source directory
SRC_DIR=$(find "$WORK_DIR" -maxdepth 1 -mindepth 1 -type d ! -name ".*" | head -n 1)

if [ -z "$SRC_DIR" ] || [ ! -d "$SRC_DIR" ]; then
    echo "Error: Failed to locate downloaded source directory." >&2
    exit 1
fi

echo "Source directory prepared at: ${SRC_DIR}"

echo "=== 4. Fetching and applying EPP patch ==="
PATCH_FILE="$WORK_DIR/0001-windows-epp.patch"
echo "Downloading patch from ${PATCH_URL}..."
wget -q -O "$PATCH_FILE" "$PATCH_URL"
chown "$RAW_USER:$RAW_USER" "$PATCH_FILE"


echo "Setting DPI=$MY_DPI and SENSITIVITY=$MY_SENSITIVITY on patch file"
sed -i "s|#define DEFAULT_DISPLAY_DPI 96|#define DEFAULT_DISPLAY_DPI $MY_DPI|g" "$PATCH_FILE"
sed -i "s|#define DEFAULT_WINDOWS_SENS 10|#define DEFAULT_WINDOWS_SENS $MY_SENSITIVITY|g" "$PATCH_FILE"

echo "Applying patch..."
cd "$SRC_DIR"
patch -p1 < "$PATCH_FILE"

echo "=== 5. Compiling and packaging libinput ==="
su -c "cd '$SRC_DIR' && dpkg-buildpackage -b -uc -us" "$RAW_USER"

echo "=== 6. Deploying compiled packages ==="
cd "$WORK_DIR"

# Install all newly generated .deb packages
dpkg -i *.deb || apt-get install -f -y

echo "=== Success! ==="
echo "Patched libinput has been compiled and deployed."
echo "You may need to restart your graphical session or reboot for changes to take effect."
