#!/usr/bin/env bash
# Enable systemd services from the repo manifest (databases, tuning, web stack).
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
MANIFEST="$REPO_ROOT/config/system-services/enabled-services.txt"
DB_MANIFEST="$REPO_ROOT/config/system-services/databases/manifest.json"

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

ONLY_DBS=0
DRY_RUN=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --databases-only) ONLY_DBS=1; shift ;;
    --dry-run)        DRY_RUN=1; shift ;;
    -h|--help)
      echo "Usage: enable-services.sh [--databases-only] [--dry-run]"
      exit 0
      ;;
    *) shift ;;
  esac
done

enable_unit() {
  local unit="$1"
  [[ -z "$unit" || "$unit" =~ ^# ]] && return 0
  if systemctl list-unit-files "$unit" &>/dev/null; then
    if [[ $DRY_RUN -eq 1 ]]; then
      info "[dry-run] systemctl enable --now $unit"
    else
      info "Enabling $unit"
      sudo systemctl enable --now "$unit" 2>/dev/null && ok "$unit" || warn "Failed: $unit (package may not be installed)"
    fi
  else
    warn "Unit not found: $unit"
  fi
}

banner "Enabling system services"

# Priority: databases from manifest.json
if [[ -f "$DB_MANIFEST" ]]; then
  banner "Database services"
  python3 - "$DB_MANIFEST" <<'PY' | while read -r svc; do
import json, sys
m = json.load(open(sys.argv[1]))
for key in ("mariadb", "postgresql", "redis", "mongodb"):
    if key in m and "service" in m[key]:
        print(m[key]["service"])
for fpm in m.get("php_fpm", []):
    print(fpm)
if "apache" in m:
    print(m["apache"]["service"])
PY
    enable_unit "$svc"
  done
fi

if [[ $ONLY_DBS -eq 1 ]]; then
  banner "Database services done (--databases-only)"
  exit 0
fi

# User/dev services from manifest (skip cloud-init, getty, etc.)
PRIORITY_SERVICES=(
  auto-cpufreq.service
  ananicy-cpp.service
  haveged.service
  thermald.service
  apache2.service
  mariadb.service
  postgresql.service
  redis-server.service
  mongod.service
  php8.3-fpm.service
  php8.4-fpm.service
  openvpn.service
  create_ap.service
)

banner "Priority dev/tuning services"
for svc in "${PRIORITY_SERVICES[@]}"; do
  enable_unit "$svc"
done

# Optional: full manifest (commented by default — many are system defaults)
if [[ -f "$MANIFEST" ]] && [[ "${ENABLE_ALL_MANIFEST:-0}" == "1" ]]; then
  banner "Full manifest (ENABLE_ALL_MANIFEST=1)"
  while read -r line; do
    enable_unit "$line"
  done < <(grep -E '\.service$' "$MANIFEST" | grep -v '^$')
fi

banner "Service enablement complete"
info "Verify: systemctl status mariadb postgresql redis-server"
info "Docs: $REPO_ROOT/config/system-services/databases/RESTORE.md"
