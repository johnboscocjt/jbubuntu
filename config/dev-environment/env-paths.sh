#!/usr/bin/env bash
# Source this file to restore PATH exports for dev runtimes (NVM, Deno, Go, Composer, Atuin).
# Usage: source /path/to/jbubuntu/config/dev-environment/env-paths.sh
set -euo pipefail

# Local bins
export PATH="$HOME/.local/bin:$HOME/bin:$PATH"

# Atuin shell history
export PATH="$HOME/.atuin/bin:$PATH"
[[ -f "$HOME/.atuin/bin/env" ]] && . "$HOME/.atuin/bin/env"

# Deno
export DENO_INSTALL="${DENO_INSTALL:-$HOME/.deno}"
export PATH="$DENO_INSTALL/bin:$PATH"
[[ -f "$HOME/.deno/env" ]] && . "$HOME/.deno/env"

# Go
export GOPATH="${GOPATH:-$HOME/go}"
export PATH="$PATH:$GOPATH/bin"

# Composer (global PHP tools)
export PATH="$PATH:$HOME/.config/composer/vendor/bin"

# NVM (Node.js)
export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"
if [[ -s "$NVM_DIR/nvm.sh" ]]; then
  # shellcheck disable=SC1091
  . "$NVM_DIR/nvm.sh"
fi
if [[ -s "$NVM_DIR/bash_completion" ]]; then
  # shellcheck disable=SC1091
  . "$NVM_DIR/bash_completion"
fi

# Default browser (Zen via Flatpak)
export BROWSER="${BROWSER:-flatpak run app.zen_browser.zen}"

# Optional: load default Node version from repo manifest
_JBUBUNTU_REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." 2>/dev/null && pwd || true)"
if [[ -n "$_JBUBUNTU_REPO" && -f "$_JBUBUNTU_REPO/config/dev-environment/runtimes/node-default.txt" ]]; then
  _NODE_DEFAULT="$(tr -d '[:space:]' < "$_JBUBUNTU_REPO/config/dev-environment/runtimes/node-default.txt")"
  if command -v nvm &>/dev/null && [[ -n "$_NODE_DEFAULT" ]]; then
    nvm use "$_NODE_DEFAULT" &>/dev/null || true
  fi
fi

unset _JBUBUNTU_REPO _NODE_DEFAULT
