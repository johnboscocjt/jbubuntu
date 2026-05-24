#!/usr/bin/env bash
# Jubuntu — opinionated Ubuntu developer setup (Omakub-style)
# Reuses shared monorepo assets from parent directory
set -euo pipefail

JUROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Standalone repo (config at root) vs jbubuntu monorepo (nested jubuntu/)
if [[ -d "$JUROOT/config" && -d "$JUROOT/dotfiles" ]]; then
  REPO_ROOT="$JUROOT"
else
  REPO_ROOT="$(cd "$JUROOT/.." && pwd)"
fi
export DEBIAN_FRONTEND=noninteractive
export APT_LISTCHANGES_FRONTEND=none

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; BLUE='\033[0;34m'; CYAN='\033[0;36m'; NC='\033[0m'

DRY_RUN=false

log_section() { echo -e "\n${CYAN}════════════════════════════════════════════════════════════${NC}"; echo -e "${CYAN}  $1${NC}"; echo -e "${CYAN}════════════════════════════════════════════════════════════${NC}\n"; }
log_ok()    { echo -e "${GREEN}✓${NC} $*"; }
log_warn()  { echo -e "${YELLOW}⚠${NC} $*"; }
log_err()   { echo -e "${RED}✗${NC} $*" >&2; }
run()       { if $DRY_RUN; then echo "[dry-run] $*"; else "$@"; fi; }

usage() {
  cat <<EOF
Usage: $0 [OPTIONS]

Jubuntu — opinionated developer Ubuntu setup by johnboscocjt

Options:
  --dry-run    Print commands without executing
  -h, --help   Show this help
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --dry-run) DRY_RUN=true ;;
    -h|--help) usage; exit 0 ;;
    *) log_err "Unknown option: $1"; usage; exit 1 ;;
  esac
  shift
done

preflight() {
  log_section "Preflight"
  if [[ ! -f /etc/os-release ]]; then log_err "Not Linux"; exit 1; fi
  # shellcheck source=/dev/null
  source /etc/os-release
  log_ok "Detected: ${PRETTY_NAME:-Unknown}"
  if [[ "${ID:-}" != "ubuntu" ]]; then
    log_warn "Jubuntu is designed for Ubuntu LTS; proceeding anyway"
  fi
  if ! command -v sudo >/dev/null; then log_err "sudo required"; exit 1; fi
  command -v apt-get >/dev/null || { log_err "apt-get required"; exit 1; }
  if [[ -z "${XDG_CURRENT_DESKTOP:-}" ]] || [[ "$XDG_CURRENT_DESKTOP" != *GNOME* ]]; then
    log_warn "GNOME desktop recommended for full experience (themes, extensions, dconf)"
  fi
  run sudo apt-get update -qq
}

folder_layout() {
  log_section "Folder layout"
  run bash "$REPO_ROOT/installs/folder-layout.sh"
}

install_managers() {
  log_section "Package managers"
  run sudo apt-get install -y -qq snapd flatpak 2>/dev/null || true
}

third_party_apt() {
  log_section "Third-party APT (Chrome, Cursor, Code, Warp, Docker, MongoDB, Proton)"
  run bash "$REPO_ROOT/data/apt-third-party.sh" all || log_warn "Some third-party installs failed — see docs/manual-installs.md"
}

bulk_apt() {
  log_section "Core APT packages (Jubuntu curated)"
  local batch=() n=0
  while IFS= read -r pkg || [[ -n "$pkg" ]]; do
    [[ -z "$pkg" || "$pkg" =~ ^# ]] && continue
    batch+=("$pkg"); n=$((n+1))
    if (( n >= 40 )); then
      run sudo apt-get install -y -qq --no-install-recommends "${batch[@]}" || log_warn "Batch had failures"
      batch=(); n=0
    fi
  done < "$JUROOT/data/apt-core.txt"
  ((${#batch[@]})) && run sudo apt-get install -y -qq --no-install-recommends "${batch[@]}" || log_warn "Final batch had failures"
  log_ok "Core APT install complete"
}

install_flatpak() {
  log_section "Flatpak applications"
  run flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo 2>/dev/null || true
  while IFS= read -r app || [[ -n "$app" ]]; do
    [[ -z "$app" ]] && continue
    run flatpak install -y flathub "$app" 2>/dev/null || log_warn "Flatpak $app failed"
  done < "$REPO_ROOT/data/flatpak-apps.txt"
}

install_snap() {
  log_section "Snap applications"
  while IFS= read -r app || [[ -n "$app" ]]; do
    [[ -z "$app" ]] && continue
    run sudo snap install "$app" 2>/dev/null || log_warn "Snap $app failed"
  done < "$REPO_ROOT/data/snap-apps.txt"
}

gnome_extensions() {
  log_section "GNOME extensions"
  run bash "$REPO_ROOT/config/gnome-extensions/install-extensions.sh" || log_warn "Extension install had issues"
}

apply_gnome() {
  log_section "GNOME desktop, shortcuts, file managers"
  run bash "$REPO_ROOT/scripts/apply-gnome-config.sh" || log_warn "GNOME config needs active session — run apply-gnome-config.sh after login"
}

deploy_dotfiles() {
  log_section "Dotfiles (zsh, Starship, Kitty, lsd, fastfetch)"
  mkdir -p "$HOME/.config"/{lsd,fastfetch,kitty,ghostty,terminator,starship}
  run cp "$REPO_ROOT/dotfiles/starship.toml" "$HOME/.config/starship.toml" 2>/dev/null || true
  run cp "$REPO_ROOT/dotfiles/fastfetch/sample_2.jsonc" "$HOME/.config/fastfetch/" 2>/dev/null || true
  run cp "$REPO_ROOT/dotfiles/kitty/kitty.conf" "$HOME/.config/kitty/" 2>/dev/null || true
  run cp "$REPO_ROOT/dotfiles/ghostty/config" "$HOME/.config/ghostty/" 2>/dev/null || true
  run cp "$REPO_ROOT/dotfiles/terminator/config" "$HOME/.config/terminator/" 2>/dev/null || true
  run cp "$REPO_ROOT/dotfiles/cli-tools/lsd/config.yaml" "$HOME/.config/lsd/" 2>/dev/null || true
  run cp "$REPO_ROOT/dotfiles/zsh/.zshrc" "$HOME/.zshrc" 2>/dev/null || true
  run cp "$REPO_ROOT/dotfiles/zsh/custom_commands.zsh" "$HOME/.custom_commands.zsh" 2>/dev/null || true
  if ! grep -q 'shell-aliases.zsh' "$HOME/.zshrc" 2>/dev/null; then
    echo "[[ -f $REPO_ROOT/dotfiles/cli-tools/shell-aliases.zsh ]] && source $REPO_ROOT/dotfiles/cli-tools/shell-aliases.zsh" >> "$HOME/.zshrc"
  fi
  log_ok "Dotfiles deployed"
}

restore_ide() {
  log_section "IDE extensions and settings (VS Code + Cursor)"
  if command -v code >/dev/null; then
    while IFS= read -r ext; do [[ -n "$ext" ]] && run code --install-extension "$ext" 2>/dev/null || true; done < "$REPO_ROOT/config/ide/vscode/extensions.txt"
    mkdir -p "$HOME/.config/Code/User"
    run cp "$REPO_ROOT/config/ide/vscode/settings.json" "$HOME/.config/Code/User/settings.json" 2>/dev/null || true
    run cp "$REPO_ROOT/config/ide/vscode/keybindings.json" "$HOME/.config/Code/User/keybindings.json" 2>/dev/null || true
  fi
  if command -v cursor >/dev/null; then
    while IFS= read -r ext; do [[ -n "$ext" ]] && run cursor --install-extension "$ext" 2>/dev/null || true; done < "$REPO_ROOT/config/ide/cursor/extensions.txt"
    mkdir -p "$HOME/.config/Cursor/User"
    run cp "$REPO_ROOT/config/ide/cursor/settings.json" "$HOME/.config/Cursor/User/settings.json" 2>/dev/null || true
    run cp "$REPO_ROOT/config/ide/cursor/keybindings.json" "$HOME/.config/Cursor/User/keybindings.json" 2>/dev/null || true
  fi
  log_ok "IDE restore complete"
}

shell_extras() {
  log_section "Shell stack (Oh My Zsh, Starship, Atuin)"
  if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    run sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended || true
  fi
  command -v starship >/dev/null || run curl -fsSL https://starship.rs/install.sh | sh -s -- -y || true
  command -v atuin >/dev/null || run bash -c "$(curl -fsSL https://setup.atuin.sh)" || true
  log_ok "Shell stack installed"
}

dev_environment() {
  log_section "Dev environment (git, gh, NVM, Deno)"
  run cp "$REPO_ROOT/config/dev-environment/git/.gitconfig" "$HOME/.gitconfig" 2>/dev/null || true
  mkdir -p "$HOME/.config/gh"
  run cp "$REPO_ROOT/config/dev-environment/gh/config.yml" "$HOME/.config/gh/config.yml" 2>/dev/null || true
  [[ -f "$REPO_ROOT/config/dev-environment/atuin/config.toml.template" ]] && \
    mkdir -p "$HOME/.config/atuin" && \
    run cp "$REPO_ROOT/config/dev-environment/atuin/config.toml.template" "$HOME/.config/atuin/config.toml" 2>/dev/null || true
  if [[ ! -d "$HOME/.nvm" ]]; then
    run curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash || true
  fi
  # shellcheck source=/dev/null
  if [[ -s "$HOME/.nvm/nvm.sh" ]]; then
    source "$HOME/.nvm/nvm.sh"
    while IFS= read -r v; do [[ -n "$v" ]] && nvm install "$v" 2>/dev/null || true; done < "$REPO_ROOT/config/dev-environment/runtimes/nvm-versions.txt"
  fi
  command -v deno >/dev/null || run curl -fsSL https://deno.land/install.sh | sh || true
  log_ok "Dev environment configured"
}

enable_services() {
  log_section "System services (MariaDB, PostgreSQL, Redis, Apache, PHP-FPM, auto-cpufreq)"
  run bash "$REPO_ROOT/config/system-services/enable-services.sh" || log_warn "Some services failed — see config/system-services/databases/RESTORE.md"
  run bash "$REPO_ROOT/config/system-services/performance/auto-cpufreq-install.sh" 2>/dev/null || log_warn "auto-cpufreq skipped"
}

post_install() {
  log_section "Jubuntu installed — next steps"
  cat <<EOF

$(echo -e "${GREEN}Jubuntu setup complete.${NC}")

Manual steps (secrets / login required):
  1. gh auth login -h github.com
  2. Log into GNOME, then run:
       $REPO_ROOT/scripts/apply-gnome-config.sh
  3. Install WhiteSur theme (optional):
       git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git
       cd WhiteSur-gtk-theme && ./install.sh -t all
  4. Manual /opt apps: see $REPO_ROOT/docs/manual-installs.md
  5. SSH/GPG/2FA: see $REPO_ROOT/config/dev-environment/credentials/RESTORE.md
  6. First Laravel project: see $REPO_ROOT/docs/projects/laravel.md

Symlink: ~/jubuntu -> $JUROOT
CLI:     jubuntu doctor | jubuntu update

Reboot recommended.
EOF
}

main() {
  echo -e "${BLUE}Jubuntu — opinionated developer Ubuntu setup${NC}"
  if [[ -d "$JUROOT/config" ]]; then
    echo -e "${BLUE}by johnboscocjt · https://github.com/johnboscocjt/jubuntu${NC}"
  else
    echo -e "${BLUE}by johnboscocjt · https://github.com/johnboscocjt/jbubuntu${NC}"
  fi
  preflight
  folder_layout
  install_managers
  third_party_apt
  bulk_apt
  install_flatpak
  install_snap
  gnome_extensions
  apply_gnome
  deploy_dotfiles
  restore_ide
  shell_extras
  dev_environment
  enable_services
  post_install
}

main "$@"
