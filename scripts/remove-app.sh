#!/usr/bin/env bash
# Safe uninstall helper — detects install type and removes with cleanup hints.
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
ok()    { echo -e "${GREEN}✓${NC} $*"; }
err()   { echo -e "${RED}✗${NC} $*"; }

DRY_RUN=0
FORCE=0

usage() {
  cat <<'EOF'
Usage: remove-app.sh [options] <app-name>

Options:
  -n, --dry-run   Show what would be removed without deleting
  -f, --force     Skip confirmation prompts
  -h, --help      Show this help

Detects APT, Snap, Flatpak, pipx, npm global, /opt, and AppImage installs.
See docs/installation-and-removal/uninstall-and-cleanup.md for full guide.
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    -n|--dry-run) DRY_RUN=1; shift ;;
    -f|--force)   FORCE=1; shift ;;
    -h|--help)    usage; exit 0 ;;
    -*)           err "Unknown option: $1"; usage; exit 1 ;;
    *)            break ;;
  esac
done

[[ $# -ge 1 ]] || { usage; exit 1; }

QUERY="$1"
QUERY_LC="${QUERY,,}"

confirm() {
  [[ $FORCE -eq 1 ]] && return 0
  read -rp "$1 [y/N]: " ans
  [[ "${ans,,}" == "y" || "${ans,,}" == "yes" ]]
}

run_cmd() {
  if [[ $DRY_RUN -eq 1 ]]; then
    info "[dry-run] $*"
  else
    info "Running: $*"
    "$@"
  fi
}

banner "Remove app: $QUERY"

# Detect first
"$SCRIPT_DIR/find-app.sh" "$QUERY" || true
echo

removed=0

# APT
pkg="$(dpkg -l 2>/dev/null | awk -v q="$QUERY_LC" 'tolower($2) ~ q && $1=="ii" {print $2; exit}')"
if [[ -n "$pkg" ]]; then
  warn "APT package detected: $pkg"
  if confirm "Purge $pkg (apt purge)?"; then
    run_cmd sudo apt purge -y "$pkg"
    run_cmd sudo apt autoremove -y
    ok "APT removed"
    removed=1
  fi
fi

# Snap
snap_name="$(snap list 2>/dev/null | awk -v q="$QUERY_LC" 'tolower($1) ~ q {print $1; exit}')"
if [[ -n "$snap_name" ]]; then
  warn "Snap detected: $snap_name"
  if confirm "Remove snap $snap_name?"; then
    run_cmd snap remove "$snap_name"
    ok "Snap removed"
    removed=1
  fi
fi

# Flatpak
fp_id="$(flatpak list --app --columns=application 2>/dev/null | grep -i "$QUERY" | head -1 || true)"
if [[ -n "$fp_id" ]]; then
  warn "Flatpak detected: $fp_id"
  if confirm "Uninstall flatpak $fp_id?"; then
    run_cmd flatpak uninstall -y "$fp_id"
    ok "Flatpak removed"
    removed=1
  fi
fi

# pipx
if command -v pipx &>/dev/null && pipx list 2>/dev/null | grep -qi "$QUERY"; then
  pipx_name="$(pipx list 2>/dev/null | grep -i "$QUERY" | head -1 | awk '{print $1}')"
  if [[ -n "$pipx_name" ]] && confirm "Uninstall pipx package $pipx_name?"; then
    run_cmd pipx uninstall "$pipx_name"
    removed=1
  fi
fi

# /opt
opt_dir="$(ls -d /opt/*"$QUERY"* 2>/dev/null | head -1 || true)"
if [[ -n "$opt_dir" && -d "$opt_dir" ]]; then
  warn "/opt directory: $opt_dir"
  if confirm "Remove $opt_dir? (manual install — check for systemd units first)"; then
    run_cmd sudo rm -rf "$opt_dir"
    removed=1
  fi
fi

# AppImage + desktop entry
appimage="$(find "$HOME/Applications" "$HOME/AppImages" -maxdepth 2 -iname "*${QUERY}*.AppImage" 2>/dev/null | head -1 || true)"
if [[ -n "$appimage" ]]; then
  warn "AppImage: $appimage"
  if confirm "Delete AppImage?"; then
    run_cmd rm -f "$appimage"
    removed=1
  fi
fi

desktop="$(find "$HOME/.local/share/applications" -iname "*${QUERY}*.desktop" 2>/dev/null | head -1 || true)"
if [[ -n "$desktop" ]]; then
  info "Orphan desktop entry: $desktop"
  if confirm "Remove desktop entry?"; then
    run_cmd rm -f "$desktop"
    run_cmd update-desktop-database "$HOME/.local/share/applications" 2>/dev/null || true
  fi
fi

# Config cleanup hint
if [[ $removed -eq 1 ]]; then
  banner "Optional config cleanup"
  info "Leftover configs may exist in:"
  info "  ~/.config/$QUERY"
  info "  ~/.local/share/$QUERY"
  info "See docs/installation-and-removal/uninstall-and-cleanup.md"
else
  warn "Nothing was removed — run find-app.sh $QUERY for detection help"
  exit 1
fi
