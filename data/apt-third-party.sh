#!/usr/bin/env bash
# Third-party APT repositories and .deb installers
# Source: live system export — run sections as needed on fresh Ubuntu LTS

set -euo pipefail

install_google_chrome() {
  echo "▶ Installing Google Chrome..."
  tmp=$(mktemp --suffix=.deb)
  curl -fsSL -o "$tmp" https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  sudo apt install -y "$tmp" || sudo apt -f install -y
  rm -f "$tmp"
}

install_cursor_repo() {
  echo "▶ Adding Cursor APT repo..."
  curl -fsSL https://downloads.cursor.com/keys/anysphere.asc | gpg --dearmor | sudo tee /usr/share/keyrings/cursor.gpg >/dev/null
  echo "deb [signed-by=/usr/share/keyrings/cursor.gpg arch=amd64] https://downloads.cursor.com/aptrepo stable main" | \
    sudo tee /etc/apt/sources.list.d/cursor.list >/dev/null
  sudo apt update && sudo apt install -y cursor
}

install_vscode_repo() {
  echo "▶ Adding VS Code APT repo..."
  curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /usr/share/keyrings/microsoft.gpg >/dev/null
  echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | \
    sudo tee /etc/apt/sources.list.d/vscode.list >/dev/null
  sudo apt update && sudo apt install -y code
}

install_warp_repo() {
  echo "▶ Adding Warp terminal APT repo..."
  curl -fsSL https://releases.warp.dev/linux/keys/warp.asc | gpg --dearmor | sudo tee /usr/share/keyrings/warp.gpg >/dev/null
  echo "deb [signed-by=/usr/share/keyrings/warp.gpg] https://releases.warp.dev/linux/deb stable main" | \
    sudo tee /etc/apt/sources.list.d/warpdotdev.list >/dev/null
  sudo apt update && sudo apt install -y warp-terminal
}

install_docker_desktop() {
  echo "▶ Installing Docker Desktop (.deb)..."
  tmp=$(mktemp --suffix=.deb)
  curl -fsSL -o "$tmp" "https://desktop.docker.com/linux/main/amd64/docker-desktop-amd64.deb"
  sudo apt install -y "$tmp" || sudo apt -f install -y
  rm -f "$tmp"
}

install_mongodb() {
  echo "▶ Adding MongoDB 8.0 repo..."
  curl -fsSL https://www.mongodb.org/static/pgp/server-8.0.asc | gpg --dearmor | sudo tee /usr/share/keyrings/mongodb-server-8.0.gpg >/dev/null
  echo "deb [signed-by=/usr/share/keyrings/mongodb-server-8.0.gpg] https://repo.mongodb.org/apt/ubuntu $(. /etc/os-release && echo "${VERSION_CODENAME:-noble}")/mongodb-org/8.0 multiverse" | \
    sudo tee /etc/apt/sources.list.d/mongodb-org-8.0.list >/dev/null
  sudo apt update && sudo apt install -y mongodb-org
}

install_protonvpn() {
  echo "▶ Installing Proton VPN repo package..."
  tmp=$(mktemp --suffix=.deb)
  curl -fsSL -o "$tmp" https://repo.protonvpn.com/debian/dists/stable/main/binary-all/protonvpn-stable-release_1.0.8_all.deb
  sudo apt install -y "$tmp" && sudo apt update
  sudo apt install -y proton-vpn-gnome-desktop
  rm -f "$tmp"
}

install_sublime() {
  echo "▶ Adding Sublime Text APT repo..."
  curl -fsSL https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /usr/share/keyrings/sublimehq.gpg >/dev/null
  echo "deb [signed-by=/usr/share/keyrings/sublimehq.gpg] https://download.sublimetext.com/ apt/stable/" | \
    sudo tee /etc/apt/sources.list.d/sublime-text.list >/dev/null
  sudo apt update && sudo apt install -y sublime-text
}

install_all_third_party() {
  install_google_chrome
  install_cursor_repo
  install_vscode_repo
  install_warp_repo
  install_docker_desktop
  install_mongodb
  install_protonvpn
  install_sublime
  echo "✓ Third-party APT installs complete. See docs/manual-installs.md for Obsidian, Bruno, Packet Tracer, etc."
}

case "${1:-all}" in
  chrome) install_google_chrome ;;
  cursor) install_cursor_repo ;;
  code) install_vscode_repo ;;
  warp) install_warp_repo ;;
  docker) install_docker_desktop ;;
  mongodb) install_mongodb ;;
  proton) install_protonvpn ;;
  sublime) install_sublime ;;
  all) install_all_third_party ;;
  *) echo "Usage: $0 [chrome|cursor|code|warp|docker|mongodb|proton|sublime|all]" ; exit 1 ;;
esac
