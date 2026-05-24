#!/usr/bin/env bash
# jbubuntu — Ubuntu system restore script
# Source: johnboscocjt/jbubuntu
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export DEBIAN_FRONTEND=noninteractive
export APT_LISTCHANGES_FRONTEND=none

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; BLUE='\033[0;34m'; CYAN='\033[0;36m'; NC='\033[0m'

SKIP_SNAP=false; SKIP_FLATPAK=false; SKIP_THIRD_PARTY=false; SKIP_IDE=false
SKIP_GNOME=false; SKIP_SERVICES=false; SKIP_DEV=false; DOTFILES_ONLY=false; DRY_RUN=false
WITH_SHELL=true; WITH_DEV=true

log_section() { echo -e "\n${CYAN}════════════════════════════════════════════════════════════${NC}"; echo -e "${CYAN}  $1${NC}"; echo -e "${CYAN}════════════════════════════════════════════════════════════${NC}\n"; }
log_ok()    { echo -e "${GREEN}✓${NC} $*"; }
log_warn()  { echo -e "${YELLOW}⚠${NC} $*"; }
log_err()   { echo -e "${RED}✗${NC} $*" >&2; }
run()       { if $DRY_RUN; then echo "[dry-run] $*"; else "$@"; fi; }

usage() {
  cat <<EOF
Usage: $0 [OPTIONS]

Options:
  --skip-snap           Skip Snap app installs
  --skip-flatpak        Skip Flatpak app installs
  --skip-third-party    Skip third-party APT repos (.deb vendors)
  --skip-ide            Skip IDE extension/settings restore
  --skip-gnome-config   Skip GNOME dconf/extensions/shortcuts
  --skip-services       Skip systemd service enablement
  --skip-dev-environment Skip runtimes (NVM, Deno, gh config, etc.)
  --dotfiles-only       Only deploy dotfiles and shell configs
  --dry-run             Print commands without executing
  -h, --help            Show this help
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --skip-snap) SKIP_SNAP=true ;;
    --skip-flatpak) SKIP_FLATPAK=true ;;
    --skip-third-party) SKIP_THIRD_PARTY=true ;;
    --skip-ide) SKIP_IDE=true ;;
    --skip-gnome-config) SKIP_GNOME=true ;;
    --skip-services) SKIP_SERVICES=true ;;
    --skip-dev-environment) WITH_DEV=false ;;
    --dotfiles-only) DOTFILES_ONLY=true ;;
    --dry-run) DRY_RUN=true ;;
    -h|--help) usage; exit 0 ;;
    *) log_err "Unknown option: $1"; usage; exit 1 ;;
  esac
  shift
done

preflight() {
  log_section "Phase 0: Preflight"
  if [[ ! -f /etc/os-release ]]; then log_err "Not a Linux system"; exit 1; fi
  # shellcheck source=/dev/null
  source /etc/os-release
  log_ok "Detected: ${PRETTY_NAME:-Unknown}"
  for cmd in apt-get; do
    command -v "$cmd" >/dev/null || { log_err "Missing $cmd"; exit 1; }
  done
  command -v snap >/dev/null || log_warn "snap not found — will install snapd"
  command -v flatpak >/dev/null || log_warn "flatpak not found — will install flatpak"
  run sudo apt-get update -qq
}

folder_layout() {
  log_section "Phase 0b: Install folder layout"
  run bash "$ROOT/installs/folder-layout.sh"
}

install_managers() {
  log_section "Phase 0c: Package managers"
  run sudo apt-get install -y -qq snapd flatpak 2>/dev/null || true
}

third_party_apt() {
  $SKIP_THIRD_PARTY && { log_warn "Skipping third-party APT"; return; }
  log_section "Phase 1: Third-party APT repositories"
  run bash "$ROOT/data/apt-third-party.sh" all || log_warn "Some third-party installs may have failed — see docs/manual-installs.md"
}

bulk_apt() {
  log_section "Phase 2: Bulk APT packages"
  local batch=(); local n=0
  while IFS= read -r pkg || [[ -n "$pkg" ]]; do
    [[ -z "$pkg" || "$pkg" =~ ^# ]] && continue
    batch+=("$pkg"); n=$((n+1))
    if (( n >= 40 )); then
      run sudo apt-get install -y -qq --no-install-recommends "${batch[@]}" || log_warn "Batch install had failures"
      batch=(); n=0
    fi
  done < "$ROOT/data/apt-packages.txt"
  ((${#batch[@]})) && run sudo apt-get install -y -qq --no-install-recommends "${batch[@]}" || log_warn "Final batch had failures"
  log_ok "APT bulk install complete"
}

install_flatpak() {
  $SKIP_FLATPAK && { log_warn "Skipping Flatpak"; return; }
  log_section "Phase 3: Flatpak applications"
  run flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo 2>/dev/null || true
  while IFS= read -r app || [[ -n "$app" ]]; do
    [[ -z "$app" ]] && continue
    run flatpak install -y flathub "$app" 2>/dev/null || log_warn "Flatpak $app failed"
  done < "$ROOT/data/flatpak-apps.txt"
}

install_snap() {
  $SKIP_SNAP && { log_warn "Skipping Snap"; return; }
  log_section "Phase 4: Snap applications"
  while IFS= read -r app || [[ -n "$app" ]]; do
    [[ -z "$app" ]] && continue
    run sudo snap install "$app" 2>/dev/null || log_warn "Snap $app failed"
  done < "$ROOT/data/snap-apps.txt"
}

gnome_extensions() {
  $SKIP_GNOME && return
  log_section "Phase 5: GNOME extensions"
  run bash "$ROOT/config/gnome-extensions/install-extensions.sh" || log_warn "Extension install had issues"
}

apply_gnome() {
  $SKIP_GNOME && return
  log_section "Phase 6–7: GNOME config, shortcuts, file managers"
  run bash "$ROOT/scripts/apply-gnome-config.sh" || log_warn "GNOME config apply failed (need active GNOME session?)"
}

deploy_dotfiles() {
  log_section "Phase 9: Dotfiles"
  mkdir -p "$HOME/.config"/{lsd,fastfetch,kitty,ghostty,terminator,starship}
  run cp "$ROOT/dotfiles/starship.toml" "$HOME/.config/starship.toml" 2>/dev/null || true
  run cp "$ROOT/dotfiles/fastfetch/sample_2.jsonc" "$HOME/.config/fastfetch/" 2>/dev/null || true
  run cp "$ROOT/dotfiles/kitty/kitty.conf" "$HOME/.config/kitty/" 2>/dev/null || true
  run cp "$ROOT/dotfiles/ghostty/config" "$HOME/.config/ghostty/" 2>/dev/null || true
  run cp "$ROOT/dotfiles/terminator/config" "$HOME/.config/terminator/" 2>/dev/null || true
  run cp "$ROOT/dotfiles/cli-tools/lsd/config.yaml" "$HOME/.config/lsd/" 2>/dev/null || true
  run cp "$ROOT/dotfiles/zsh/.zshrc" "$HOME/.zshrc" 2>/dev/null || true
  run cp "$ROOT/dotfiles/zsh/custom_commands.zsh" "$HOME/.custom_commands.zsh" 2>/dev/null || true
  grep -q 'shell-aliases.zsh' "$HOME/.zshrc" 2>/dev/null || \
    echo "[[ -f $ROOT/dotfiles/cli-tools/shell-aliases.zsh ]] && source $ROOT/dotfiles/cli-tools/shell-aliases.zsh" >> "$HOME/.zshrc"
  log_ok "Dotfiles deployed"
}

restore_ide() {
  $SKIP_IDE && return
  log_section "Phase 8: IDE extensions and settings"
  if command -v code >/dev/null; then
    while IFS= read -r ext; do [[ -n "$ext" ]] && run code --install-extension "$ext" 2>/dev/null || true; done < "$ROOT/config/ide/vscode/extensions.txt"
    run cp "$ROOT/config/ide/vscode/settings.json" "$HOME/.config/Code/User/settings.json" 2>/dev/null || true
    run cp "$ROOT/config/ide/vscode/keybindings.json" "$HOME/.config/Code/User/keybindings.json" 2>/dev/null || true
  fi
  if command -v cursor >/dev/null; then
    while IFS= read -r ext; do [[ -n "$ext" ]] && run cursor --install-extension "$ext" 2>/dev/null || true; done < "$ROOT/config/ide/cursor/extensions.txt"
    run cp "$ROOT/config/ide/cursor/settings.json" "$HOME/.config/Cursor/User/settings.json" 2>/dev/null || true
    run cp "$ROOT/config/ide/cursor/keybindings.json" "$HOME/.config/Cursor/User/keybindings.json" 2>/dev/null || true
  fi
  log_ok "IDE restore complete"
}

shell_extras() {
  $WITH_SHELL || return
  log_section "Phase 10: Shell stack and CLI tools"
  run sudo apt-get install -y -qq lsd bat fastfetch neofetch htop nala jq wl-clipboard \
    zsh zsh-autosuggestions zsh-syntax-highlighting 2>/dev/null || true
  if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    run sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended || true
  fi
  command -v starship >/dev/null || run curl -fsSL https://starship.rs/install.sh | sh -s -- -y || true
  command -v atuin >/dev/null || run bash -c "$(curl -fsSL https://setup.atuin.sh)" || true
  log_ok "Shell extras installed"
}

dev_environment() {
  $WITH_DEV || return
  log_section "Phase 11: Dev environment"
  run cp "$ROOT/config/dev-environment/git/.gitconfig" "$HOME/.gitconfig" 2>/dev/null || true
  mkdir -p "$HOME/.config/gh"
  run cp "$ROOT/config/dev-environment/gh/config.yml" "$HOME/.config/gh/config.yml" 2>/dev/null || true
  [[ -f "$ROOT/config/dev-environment/atuin/config.toml.template" ]] && \
    run cp "$ROOT/config/dev-environment/atuin/config.toml.template" "$HOME/.config/atuin/config.toml" 2>/dev/null || true
  if [[ ! -d "$HOME/.nvm" ]]; then
    run curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash || true
  fi
  # shellcheck source=/dev/null
  [[ -s "$HOME/.nvm/nvm.sh" ]] && source "$HOME/.nvm/nvm.sh" && \
    while IFS= read -r v; do [[ -n "$v" ]] && nvm install "$v" 2>/dev/null || true; done < "$ROOT/config/dev-environment/runtimes/nvm-versions.txt"
  command -v deno >/dev/null || run curl -fsSL https://deno.land/install.sh | sh || true
  log_warn "Run: gh auth login -h github.com  (required for GitHub CLI)"
  log_warn "See config/dev-environment/credentials/RESTORE.md for SSH/GPG/2FA"
}

enable_services() {
  $SKIP_SERVICES && return
  log_section "Phase 12: System services"
  run bash "$ROOT/config/system-services/enable-services.sh" || log_warn "Some services failed to start"
  run bash "$ROOT/config/system-services/performance/auto-cpufreq-install.sh" 2>/dev/null || log_warn "auto-cpufreq install skipped or failed"
}

main() {
  echo -e "${BLUE}jbubuntu setup — Ubuntu migration restore${NC}"
  preflight
  if $DOTFILES_ONLY; then
    deploy_dotfiles
    shell_extras
    log_ok "Dotfiles-only mode complete"
    exit 0
  fi
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
  log_section "Done!"
  echo -e "${GREEN}Restore complete.${NC} See docs/manual-installs.md for /opt apps and docs/how-to-find-stuff.md for locating tools."
  echo "Reboot recommended. Log into GNOME and re-run: ./scripts/apply-gnome-config.sh if dconf failed."
}

main "$@"
