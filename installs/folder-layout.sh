#!/usr/bin/env bash
# Create recommended directory layout for development and manual installs.
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
ok()    { echo -e "${GREEN}✓${NC} $*"; }

banner "Creating folder layout"

DIRS=(
  "$HOME/src/github"
  "$HOME/src/gitlab"
  "$HOME/src/bitbucket"
  "$HOME/Applications"
  "$HOME/AppImages"
  "$HOME/bin"
  "$HOME/go/bin"
  "$HOME/.local/share/applications"
  "$HOME/Documents/mydocs"
)

for d in "${DIRS[@]}"; do
  if [[ ! -d "$d" ]]; then
    mkdir -p "$d"
    ok "Created $d"
  else
    info "Exists: $d"
  fi
done

# Symlink repo helper scripts if convenient
if [[ -d "$REPO_ROOT/scripts" ]]; then
  for script in find-app.sh find-anything.sh remove-app.sh; do
    if [[ -f "$REPO_ROOT/scripts/$script" && ! -e "$HOME/bin/$script" ]]; then
      ln -sf "$REPO_ROOT/scripts/$script" "$HOME/bin/$script"
      ok "Linked $HOME/bin/$script"
    fi
  done
fi

banner "Folder layout ready"
info "See installs/README.md for /opt conventions"
