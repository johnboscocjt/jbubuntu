#!/usr/bin/env bash
# Detect how an application was installed and locate related files.
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

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

usage() {
  cat <<'EOF'
Usage: find-app.sh <app-name-or-package>

Detect install type (APT, Snap, Flatpak, /opt, AppImage, pip, npm, go)
and print paths to binaries, desktop entries, and config directories.

Examples:
  find-app.sh cursor
  find-app.sh io.github.shiftey.Desktop
  find-app.sh bruno
EOF
}

[[ $# -ge 1 ]] || { usage; exit 1; }

QUERY="${1,,}"
QUERY_RAW="$1"

banner "Finding install info for: $QUERY_RAW"

found=0

# ── APT / dpkg ──────────────────────────────────────────────────────
if dpkg -l "$QUERY_RAW" &>/dev/null || dpkg -l "$QUERY" &>/dev/null; then
  pkg="$(dpkg -l "$QUERY_RAW" 2>/dev/null | awk '/^ii/{print $2; exit}')"
  [[ -z "$pkg" ]] && pkg="$(dpkg -l "$QUERY" 2>/dev/null | awk '/^ii/{print $2; exit}')"
  if [[ -n "$pkg" ]]; then
    ok "APT package: $pkg"
    info "Files: dpkg -L $pkg"
    dpkg -L "$pkg" 2>/dev/null | head -20
    echo "    … (use: dpkg -L $pkg | less)"
    found=1
  fi
fi

# Search apt by name pattern
if [[ $found -eq 0 ]]; then
  matches="$(dpkg -l 2>/dev/null | awk -v q="$QUERY" 'tolower($2) ~ q && $1=="ii" {print $2}' | head -5)"
  if [[ -n "$matches" ]]; then
    ok "Possible APT matches:"
    echo "$matches" | while read -r m; do info "$m"; done
    found=1
  fi
fi

# ── Snap ────────────────────────────────────────────────────────────
if snap list "$QUERY_RAW" &>/dev/null 2>&1 || snap list "$QUERY" &>/dev/null 2>&1; then
  snap_name="$(snap list 2>/dev/null | awk -v q="$QUERY" 'tolower($1) ~ q {print $1; exit}')"
  [[ -n "$snap_name" ]] && ok "Snap: $snap_name" && snap info "$snap_name" 2>/dev/null | head -15
  found=1
elif snap list 2>/dev/null | awk -v q="$QUERY" 'tolower($1) ~ q {found=1} END{exit !found}'; then
  snap_name="$(snap list 2>/dev/null | awk -v q="$QUERY" 'tolower($1) ~ q {print $1; exit}')"
  ok "Snap: $snap_name"
  found=1
fi

# ── Flatpak ─────────────────────────────────────────────────────────
if flatpak list --app 2>/dev/null | grep -qi "$QUERY"; then
  fp_id="$(flatpak list --app --columns=application 2>/dev/null | grep -i "$QUERY" | head -1)"
  ok "Flatpak: $fp_id"
  flatpak info "$fp_id" 2>/dev/null | head -20
  found=1
fi

# ── /opt manual installs ────────────────────────────────────────────
if [[ -d "/opt/$QUERY_RAW" ]] || [[ -d "/opt/${QUERY_RAW^}" ]]; then
  opt_dir="$(ls -d /opt/*"$QUERY"* 2>/dev/null | head -1)"
  ok "/opt install: $opt_dir"
  ls -la "$opt_dir" 2>/dev/null | head -10
  found=1
fi

if [[ -f "$REPO_ROOT/installs/opt-manifest.txt" ]]; then
  while read -r opt_name; do
  [[ -z "$opt_name" || "$opt_name" =~ ^# ]] && continue
    if [[ "${opt_name,,}" == *"$QUERY"* ]] && [[ -d "/opt/$opt_name" ]]; then
      ok "/opt (manifest): /opt/$opt_name"
      found=1
    fi
  done < "$REPO_ROOT/installs/opt-manifest.txt"
fi

# ── AppImage ────────────────────────────────────────────────────────
appimages="$(find "$HOME/Applications" "$HOME/AppImages" "$HOME/bin" -maxdepth 3 \
  -iname "*${QUERY}*.AppImage" 2>/dev/null || true)"
if [[ -n "$appimages" ]]; then
  ok "AppImage(s):"
  echo "$appimages"
  found=1
fi

# ── which / desktop entry ───────────────────────────────────────────
bin_path="$(command -v "$QUERY_RAW" 2>/dev/null || command -v "$QUERY" 2>/dev/null || true)"
if [[ -n "$bin_path" ]]; then
  ok "Binary: $bin_path"
  info "Real path: $(readlink -f "$bin_path" 2>/dev/null || echo "$bin_path")"
  found=1
fi

desktop_matches="$(find /usr/share/applications "$HOME/.local/share/applications" \
  -iname "*${QUERY}*.desktop" 2>/dev/null | head -5 || true)"
if [[ -n "$desktop_matches" ]]; then
  ok "Desktop entries:"
  echo "$desktop_matches"
  found=1
fi

# ── pip / pipx / npm / go ───────────────────────────────────────────
if command -v pipx &>/dev/null; then
  pipx_match="$(pipx list 2>/dev/null | grep -i "$QUERY" || true)"
  [[ -n "$pipx_match" ]] && ok "pipx: $pipx_match" && found=1
fi

if [[ -d "$HOME/.nvm/versions/node" ]]; then
  npm_global="$(find "$HOME/.nvm/versions/node" -path "*/bin/$QUERY_RAW" 2>/dev/null | head -1 || true)"
  [[ -n "$npm_global" ]] && ok "npm global (nvm): $npm_global" && found=1
fi

if [[ -d "$HOME/go/bin" ]]; then
  go_bin="$(find "$HOME/go/bin" -iname "*${QUERY}*" 2>/dev/null | head -3 || true)"
  [[ -n "$go_bin" ]] && ok "Go bin:" && echo "$go_bin" && found=1
fi

# ── Config directories ──────────────────────────────────────────────
config_globs=(
  "$HOME/.config/$QUERY_RAW"
  "$HOME/.config/${QUERY_RAW^}"
  "$HOME/.$QUERY_RAW"
)
for cfg in "${config_globs[@]}"; do
  [[ -e "$cfg" ]] && ok "Config: $cfg" && found=1
done

if [[ $found -eq 0 ]]; then
  warn "No install match found for '$QUERY_RAW'"
  info "Try: apt search $QUERY_RAW | grep -i $QUERY_RAW"
  info "Try: flatpak search $QUERY_RAW"
  info "Try: snap find $QUERY_RAW"
  exit 1
fi

banner "Done — see docs/installation-and-removal/find-installed.md for more"
