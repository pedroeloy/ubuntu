#!/usr/bin/env bash
# Fix Microsoft Edge PWAs icons on GNOME Wayland
# by changing StartupWMClass= in the .desktop files
# To execute run:
# sudo apt install curl ; curl -fsSL https://raw.githubusercontent.com/pedroeloy/ubuntu/refs/heads/main/scripts/fix_edge_pwas_icon.sh | bash

# Manual Instructions
# Correct Edge Webapp Icons when running webapps (Teams for example)
# Press <kbd>Alt</kbd>+<kbd>F2</kbd>, type lg, and hit Enter.
# Go to the Windows tab.
# Find your Edge webapp window → it will show an app entry like:
# app: microsoft-edge-webapp-Example-com.desktop
# That string (microsoft-edge-webapp-Example-com) is what GNOME expects for StartupWMClass
# and edit the corresponding .desktop file in ~/.local/share/applications


APP_DIR="$HOME/.local/share/applications"
cd "$APP_DIR" || exit 1

# Find all Edge PWA .desktop files
for desktop_file in msedge-*.desktop; do
  [ -f "$desktop_file" ] || continue

  startupwmclass="${desktop_file/msedge-/msedge-_}"   # add "_"
  startupwmclass="${startupwmclass/.desktop/}"        # remove ".desktop"
  
  sed -i "s|^StartupWMClass=.*|StartupWMClass=${startupwmclass}|"  "${desktop_file}"
done
