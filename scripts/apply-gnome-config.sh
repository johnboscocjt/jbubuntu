#!/usr/bin/env bash
# Load all GNOME dconf configs from the jbubuntu repo.
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DCONF_DIR="$REPO_ROOT/config/dconf"
SHORTCUTS_DIR="$REPO_ROOT/config/shortcuts"

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
ok()    { echo -e "${GREEN}✓${NC} $*"; }
err()   { echo -e "${RED}✗${NC} $*"; }

load_dconf() {
  local file="$1"
  local label="${2:-$(basename "$file")}"
  if [[ ! -f "$file" ]]; then
    warn "Skip (missing): $file"
    return 0
  fi
  info "Loading $label"
  dconf load -f "$file"
  ok "$label"
}

banner "Applying GNOME dconf configuration"

if ! command -v dconf &>/dev/null; then
  err "dconf CLI not found — install dconf-cli"
  exit 1
fi

if [[ -z "${DBUS_SESSION_BUS_ADDRESS:-}" ]]; then
  warn "DBUS_SESSION_BUS_ADDRESS not set — sourcing from gnome-session"
  export $(grep -z DBUS_SESSION_BUS_ADDRESS /proc/$(pgrep -u "$USER" gnome-session 2>/dev/null | head -1)/environ 2>/dev/null | tr '\0' '\n' | grep DBUS || true)
fi

# Core appearance and WM
load_dconf "$DCONF_DIR/interface.dconf" "interface (GTK theme, fonts, cursors)"
load_dconf "$DCONF_DIR/wm-preferences.dconf" "wm-preferences (Mojave-Dark)"
load_dconf "$DCONF_DIR/mutter.dconf" "mutter (tiling, experimental features)"
load_dconf "$DCONF_DIR/keybindings.dconf" "keybindings (WM)"
load_dconf "$DCONF_DIR/media-keys.dconf" "media-keys (custom shortcuts)"

# Custom shortcuts (duplicate path — shortcuts dir is canonical for keybindings)
load_dconf "$SHORTCUTS_DIR/gnome-custom-keybindings.dconf" "custom keybindings (Super+A/V/J/G/F)"
load_dconf "$SHORTCUTS_DIR/gnome-shell-keybindings.dconf" "shell keybindings (Super+Z screenshot)"

# Per-extension settings
if [[ -d "$DCONF_DIR/shell-extensions-settings" ]]; then
  banner "Extension settings"
  for ext_dconf in "$DCONF_DIR/shell-extensions-settings"/*.dconf; do
    [[ -f "$ext_dconf" ]] || continue
    load_dconf "$ext_dconf" "$(basename "$ext_dconf" .dconf)"
  done
fi

# Enabled extensions list
if [[ -f "$DCONF_DIR/enabled-extensions.txt" ]]; then
  info "Setting enabled extensions"
  # Read Python-style list from file
  ext_list="$(cat "$DCONF_DIR/enabled-extensions.txt")"
  dconf write /org/gnome/shell/enabled-extensions "$ext_list"
  ok "enabled-extensions"
fi

# Nemo file manager
if [[ -f "$REPO_ROOT/config/file-managers/nemo.dconf" ]]; then
  banner "Nemo preferences"
  load_dconf "$REPO_ROOT/config/file-managers/nemo.dconf" "nemo"
fi

banner "GNOME config applied"
info "Log out and back in (or Alt+F2 → r) for extension changes to take full effect"
info "Install extensions first: $REPO_ROOT/config/gnome-extensions/install-extensions.sh"
info "Docs: $REPO_ROOT/docs/gnome-desktop.md"
