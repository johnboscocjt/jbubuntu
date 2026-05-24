#!/usr/bin/env bash
# Install auto-cpufreq to /opt and enable the systemd service.
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
INSTALL_DIR="/opt/auto-cpufreq"
SERVICE_SRC="$REPO_ROOT/config/system-services/performance/auto-cpufreq.service"
REPO_URL="${AUTO_CPUFREQ_REPO:-https://github.com/johnboscocjt/CPU-Autofrequency-Debian.git}"
FALLBACK_URL="https://github.com/AdnanHodzic/auto-cpufreq.git"

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

banner "auto-cpufreq installer"

if [[ $EUID -ne 0 ]] && ! sudo -n true 2>/dev/null; then
  info "This script requires sudo for /opt and systemd"
fi

# Clone or update
if [[ -d "$INSTALL_DIR/.git" ]]; then
  info "Updating existing install at $INSTALL_DIR"
  sudo git -C "$INSTALL_DIR" pull || warn "git pull failed"
else
  info "Cloning to $INSTALL_DIR"
  sudo rm -rf "$INSTALL_DIR"
  if ! sudo git clone --depth 1 "$REPO_URL" "$INSTALL_DIR" 2>/dev/null; then
    warn "Primary repo failed — trying upstream auto-cpufreq"
    sudo git clone --depth 1 "$FALLBACK_URL" "$INSTALL_DIR"
  fi
fi

# Python venv + install
banner "Setting up Python venv"
if [[ ! -d "$INSTALL_DIR/venv" ]]; then
  sudo python3 -m venv "$INSTALL_DIR/venv"
fi
sudo "$INSTALL_DIR/venv/bin/pip" install --upgrade pip wheel
if [[ -f "$INSTALL_DIR/requirements.txt" ]]; then
  sudo "$INSTALL_DIR/venv/bin/pip" install -r "$INSTALL_DIR/requirements.txt"
elif [[ -f "$INSTALL_DIR/setup.py" ]] || [[ -f "$INSTALL_DIR/pyproject.toml" ]]; then
  sudo "$INSTALL_DIR/venv/bin/pip" install "$INSTALL_DIR"
else
  sudo "$INSTALL_DIR/venv/bin/pip" install auto-cpufreq 2>/dev/null || \
    warn "Install auto-cpufreq package manually into venv"
fi

# Install systemd unit from repo
banner "Installing systemd service"
sudo cp "$SERVICE_SRC" /etc/systemd/system/auto-cpufreq.service
sudo systemctl daemon-reload
sudo systemctl enable --now auto-cpufreq.service

ok "auto-cpufreq enabled"
systemctl status auto-cpufreq.service --no-pager || true

banner "Done"
info "Tuning notes: $REPO_ROOT/config/system-services/performance/tuning-notes.md"
info "Disable Intel P-State conflicts: see tuning-notes.md"
