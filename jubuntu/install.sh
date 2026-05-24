#!/usr/bin/env bash
# Jubuntu installer — clone repo, symlink ~/jubuntu, run setup
set -euo pipefail

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; BLUE='\033[0;34m'; NC='\033[0m'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [[ -f "$SCRIPT_DIR/manifest.conf" ]]; then
  # shellcheck source=/dev/null
  source "$SCRIPT_DIR/manifest.conf"
fi

# Defaults (override via env or manifest.conf)
REPO_URL="${JUBUNTU_REPO_URL:-${REPO_URL:-https://github.com/johnboscocjt/jbubuntu.git}}"
BRANCH="${JUBUNTU_BRANCH:-${BRANCH:-main}}"
CLONE_DIR="${JUBUNTU_CLONE_DIR:-${CLONE_DIR:-$HOME/.local/share/jubuntu/repo}}"
SYMLINK="${JUBUNTU_SYMLINK:-${SYMLINK:-$HOME/jubuntu}}"

echo -e "${BLUE}Jubuntu installer${NC}"
echo "Repository: $REPO_URL"
echo "Branch:     $BRANCH"
echo "Clone to:   $CLONE_DIR"
echo ""

if ! command -v git >/dev/null 2>&1; then
  echo "Installing git..."
  sudo apt-get update -qq && sudo apt-get install -y git
fi

mkdir -p "$(dirname "$CLONE_DIR")"

if [[ -d "$CLONE_DIR/.git" ]]; then
  echo -e "${YELLOW}Updating existing clone...${NC}"
  git -C "$CLONE_DIR" fetch origin "$BRANCH"
  git -C "$CLONE_DIR" checkout "$BRANCH"
  git -C "$CLONE_DIR" pull --ff-only origin "$BRANCH" 2>/dev/null || true
else
  echo -e "${GREEN}Cloning repository...${NC}"
  git clone --depth 1 --branch "$BRANCH" "$REPO_URL" "$CLONE_DIR"
fi

# Monorepo clone (jbubuntu/jubuntu/) vs standalone repo root
if [[ -f "$CLONE_DIR/jubuntu/setup.sh" ]]; then
  JUROOT="$CLONE_DIR/jubuntu"
else
  JUROOT="$CLONE_DIR"
fi

if [[ ! -f "$JUROOT/setup.sh" ]]; then
  echo -e "${RED}Error: $JUROOT/setup.sh not found${NC}" >&2
  exit 1
fi

# Home-level symlink
ln -sfn "$JUROOT" "$SYMLINK"
echo -e "${GREEN}Symlink:${NC} $SYMLINK -> $JUROOT"

# Install jubuntu CLI to ~/.local/bin
mkdir -p "$HOME/.local/bin"
ln -sfn "$JUROOT/bin/jubuntu" "$HOME/.local/bin/jubuntu"
chmod +x "$JUROOT/bin/jubuntu" "$JUROOT/setup.sh" 2>/dev/null || true

echo ""
echo -e "${GREEN}Running Jubuntu setup...${NC}"
echo ""

exec bash "$JUROOT/setup.sh" "$@"
