#!/usr/bin/env bash
# Install GNOME Shell extensions from extensions.json (EGO + GitHub + APT).
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
EXT_JSON="$REPO_ROOT/config/gnome-extensions/extensions.json"
EXT_DIR="$HOME/.local/share/gnome-shell/extensions"

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

banner "GNOME extension installer"

if [[ ! -f "$EXT_JSON" ]]; then
  err "Missing $EXT_JSON"
  exit 1
fi

mkdir -p "$EXT_DIR"

info "Installing APT extension packages (if missing)"
sudo apt install -y gnome-shell-extensions 2>/dev/null || \
  warn "gnome-shell-extensions not available — install manually"

install_from_github() {
  local uuid="$1" url="$2"
  if [[ -d "$EXT_DIR/$uuid" ]]; then
    ok "Already installed: $uuid"
    return 0
  fi
  local tmp meta_dir
  tmp="$(mktemp -d)"
  info "Cloning $url"
  git clone --depth 1 "$url" "$tmp/repo"
  meta_dir="$(find "$tmp/repo" -name metadata.json 2>/dev/null | while read -r f; do
    grep -q "\"uuid\": \"$uuid\"" "$f" && dirname "$f" && break
  done | head -1)"
  if [[ -z "$meta_dir" ]]; then
    meta_dir="$(find "$tmp/repo" -maxdepth 2 -name metadata.json 2>/dev/null | head -1 | xargs dirname 2>/dev/null || true)"
  fi
  if [[ -n "$meta_dir" && -d "$meta_dir" ]]; then
    cp -r "$meta_dir" "$EXT_DIR/$uuid"
    ok "Installed from GitHub: $uuid"
  else
    warn "Could not locate extension root for $uuid"
  fi
  rm -rf "$tmp"
}

banner "Processing extensions.json"

while IFS= read -r line; do
  [[ -z "$line" ]] && continue
  case "$line" in
    CLONE:*)
      IFS='|' read -r _ uuid url <<< "${line#CLONE:}"
      install_from_github "$uuid" "$url"
      ;;
    MANUAL:*)
      IFS='|' read -r _ uuid name url <<< "${line#MANUAL:}"
      warn "Install manually: $name ($uuid)"
      info "  $url"
      ;;
    :::*)
      IFS='|' read -r _ uuid name source _ <<< "${line#:::}"
      if [[ "$source" == "apt" ]]; then
        ok "APT-managed: $uuid"
      elif [[ -d "$EXT_DIR/$uuid" ]]; then
        ok "Present: $uuid"
      fi
      ;;
  esac
done < <(python3 - "$EXT_JSON" <<'PY'
import json, sys, os
data = json.load(open(sys.argv[1]))
ext_dir = os.path.expanduser("~/.local/share/gnome-shell/extensions")
for e in data:
    uuid = e.get("uuid", "")
    name = e.get("name", "")
    source = e.get("source", "")
    url = e.get("url", "")
    print(f":::{uuid}|{name}|{source}|{url}")
    if source == "github" and url and not os.path.isdir(f"{ext_dir}/{uuid}"):
        print(f"CLONE:{uuid}|{url}")
    elif source not in ("apt",) and not os.path.isdir(f"{ext_dir}/{uuid}"):
        print(f"MANUAL:{uuid}|{name}|{url or 'https://extensions.gnome.org'}")
PY
)

if [[ -f "$REPO_ROOT/config/dconf/enabled-extensions.txt" ]]; then
  banner "Enabling extensions"
  ext_list="$(cat "$REPO_ROOT/config/dconf/enabled-extensions.txt")"
  dconf write /org/gnome/shell/enabled-extensions "$ext_list" 2>/dev/null || \
    warn "Could not write enabled-extensions — run after GNOME login"
  ok "Extension list written"
fi

banner "Extension install complete"
info "Restart GNOME Shell: Alt+F2 → r (X11) or log out/in (Wayland)"
info "Then run: $REPO_ROOT/scripts/apply-gnome-config.sh"
