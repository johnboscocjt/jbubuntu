#!/usr/bin/env bash
# Interactive menu to find files, apps, configs, ports, and processes.
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

banner() {
  echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
  echo -e "${GREEN}$1${NC}"
  echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
}

info()  { echo -e "${BLUE}→${NC} $*"; }
warn()  { echo -e "${YELLOW}!${NC} $*"; }

pause() { read -rp "Press Enter to continue…" _; }

find_files() {
  read -rp "Filename or pattern: " pat
  [[ -z "$pat" ]] && return
  banner "Files matching: $pat"
  info "Home (fast, max depth 6):"
  find "$HOME" -maxdepth 6 -iname "*${pat}*" 2>/dev/null | head -30
  info "System-wide (may need sudo, slower):"
  info "  sudo find / -iname '*${pat}*' 2>/dev/null | head -50"
  pause
}

find_apps() {
  read -rp "App name or package: " app
  [[ -z "$app" ]] && return
  "$SCRIPT_DIR/find-app.sh" "$app" || true
  pause
}

find_configs() {
  banner "Common config locations"
  info "Shell:        ~/.zshrc  ~/.config/starship.toml  ~/.config/fastfetch/"
  info "GNOME:        ~/.config/dconf/  gsettings list-recursively org.gnome"
  info "IDEs:         ~/.config/Code/  ~/.config/Cursor/  ~/.config/Windsurf/"
  info "Git/gh:       ~/.gitconfig  ~/.config/gh/"
  info "Databases:    /etc/postgresql/  /etc/mysql/  /etc/redis/  /etc/mongod.conf"
  info "Repo configs: $REPO_ROOT/config/"
  read -rp "Search config dir for pattern (blank = skip): " pat
  if [[ -n "$pat" ]]; then
    find "$HOME/.config" -maxdepth 4 -iname "*${pat}*" 2>/dev/null | head -30
  fi
  pause
}

find_ports() {
  read -rp "Port number (blank = list all listening): " port
  banner "Listening ports"
  if [[ -z "$port" ]]; then
    ss -tlnp 2>/dev/null || netstat -tlnp 2>/dev/null || true
  else
    ss -tlnp "sport = :$port" 2>/dev/null || lsof -i ":$port" 2>/dev/null || true
  fi
  pause
}

find_processes() {
  read -rp "Process name: " proc
  [[ -z "$proc" ]] && return
  banner "Processes matching: $proc"
  pgrep -af "$proc" 2>/dev/null || ps aux | grep -i "$proc" | grep -v grep || warn "No match"
  pause
}

find_text() {
  read -rp "Search string: " text
  read -rp "Directory [$HOME]: " dir
  dir="${dir:-$HOME}"
  [[ -z "$text" ]] && return
  banner "Text search: $text in $dir"
  if command -v rg &>/dev/null; then
    rg -l "$text" "$dir" 2>/dev/null | head -30
  else
    grep -rIl "$text" "$dir" 2>/dev/null | head -30
  fi
  pause
}

list_package_manifests() {
  banner "Repo package manifests"
  for f in "$REPO_ROOT/data/apt-packages.txt" "$REPO_ROOT/data/snap-apps.txt" \
           "$REPO_ROOT/data/flatpak-apps.txt" "$REPO_ROOT/installs/opt-manifest.txt"; do
    [[ -f "$f" ]] && info "$(basename "$f"): $(wc -l < "$f") entries"
  done
  pause
}

show_menu() {
  clear
  banner "jbubuntu — Find Anything"
  echo "  1) Find files by name"
  echo "  2) Find app install type"
  echo "  3) Locate config directories"
  echo "  4) Check listening ports"
  echo "  5) Find processes"
  echo "  6) Search file contents"
  echo "  7) Show repo package manifests"
  echo "  8) Open docs/how-to-find-stuff.md"
  echo "  q) Quit"
  echo
}

main() {
  while true; do
    show_menu
    read -rp "Choice: " choice
    case "$choice" in
      1) find_files ;;
      2) find_apps ;;
      3) find_configs ;;
      4) find_ports ;;
      5) find_processes ;;
      6) find_text ;;
      7) list_package_manifests ;;
      8)
        if command -v xdg-open &>/dev/null; then
          xdg-open "$REPO_ROOT/docs/how-to-find-stuff.md" 2>/dev/null || \
            info "See: $REPO_ROOT/docs/how-to-find-stuff.md"
        else
          info "See: $REPO_ROOT/docs/how-to-find-stuff.md"
        fi
        pause
        ;;
      q|Q) banner "Goodbye"; exit 0 ;;
      *) warn "Invalid choice" ; sleep 1 ;;
    esac
  done
}

main
