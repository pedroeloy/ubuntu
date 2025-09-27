#!/usr/bin/env bash
# Fix Microsoft Edge PWAs icons on GNOME Wayland
# by changing StartupWMClass= in the .desktop files


APP_DIR="$HOME/.local/share/applications"
cd "$APP_DIR" || exit 1

# Find all Edge PWA .desktop files
for desktop_file in msedge-*.desktop; do
  [ -f "$desktop_file" ] || continue

  startupwmclass="${desktop_file/msedge-/msedge-_}"   # add "_"
  startupwmclass="${startupwmclass/.desktop/}"        # remove ".desktop"
  
  sed -i "s|^StartupWMClass=.*|StartupWMClass=${startupwmclass}|"  "${desktop_file}"
done
