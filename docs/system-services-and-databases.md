# System Services and Databases

Enabled systemd units, database stack, web server, and performance tuning.

## Service manifest

`config/system-services/enabled-services.txt` lists **78** enabled units from the source machine. Not all need manual enable on a fresh install — many are Ubuntu defaults.

Enable dev/database/tuning services:

```bash
chmod +x config/system-services/enable-services.sh
./config/system-services/enable-services.sh
```

Options:

- `--databases-only` — MariaDB, PostgreSQL, Redis, MongoDB, PHP-FPM, Apache only
- `--dry-run` — print commands without running
- `ENABLE_ALL_MANIFEST=1` — attempt every unit in the full manifest

## Database stack

From `config/system-services/databases/manifest.json`:

| Service | systemd unit | Status (source) |
|---------|--------------|-----------------|
| MariaDB | `mariadb.service` | active |
| PostgreSQL 18 | `postgresql.service` | active (v18.4) |
| Redis | `redis-server.service` | active |
| MongoDB | `mongod.service` | enabled (was failed — check logs) |
| PHP-FPM | `php8.3-fpm`, `php8.4-fpm` | enabled |
| Apache | `apache2.service` | active |

### Install packages (APT)

```bash
sudo apt install mariadb-server postgresql redis-server mongodb-org apache2 \
  php8.3-fpm php8.4-fpm
```

See `data/apt-packages.txt` for the full PHP extension list.

### Enable and verify

```bash
./config/system-services/enable-services.sh --databases-only

sudo systemctl status mariadb postgresql redis-server mongod apache2
sudo ss -tlnp | grep -E '3306|5432|6379|27017|80'
```

Full restore: [config/system-services/databases/RESTORE.md](../config/system-services/databases/RESTORE.md)

## Web stack

Apache enabled modules/sites: `config/system-services/web-stack/apache2-enabled.txt`

```bash
sudo a2enmod rewrite ssl headers
sudo systemctl reload apache2
```

## Performance tuning

| Tool | Unit | Location |
|------|------|----------|
| auto-cpufreq | `auto-cpufreq.service` | `/opt/auto-cpufreq` |
| ananicy-cpp | `ananicy-cpp.service` | Process priority profiles |
| thermald | `thermald.service` | Intel thermal daemon |
| haveged | `haveged.service` | Entropy |
| systemd-oomd | `systemd-oomd.service` | OOM killer |
| gamemode | user session | Gaming CPU governor |

Install auto-cpufreq:

```bash
sudo ./config/system-services/performance/auto-cpufreq-install.sh
```

Notes: [config/system-services/performance/tuning-notes.md](../config/system-services/performance/tuning-notes.md)

## Networking / VPN

Enabled on source system:

- `openvpn.service`
- `create_ap.service` (WiFi hotspot)
- `me.proton.vpn.split_tunneling.service` (Proton VPN)

Firewall template: `config/system-services/networking/ufw-rules.template` (if present)

## Maintenance timers

Documented in [config/system-services/maintenance/timers.md](../config/system-services/maintenance/timers.md):

- `anacron`, `fwupd-refresh`, `phpsessionclean`, Canonical Livepatch

## Data migration

Database **data** is not in this repo. Migrate with:

- PostgreSQL: `pg_dump` / `pg_restore`
- MariaDB: `mysqldump`
- Redis: copy RDB/AOF or `redis-cli --rdb`
- MongoDB: `mongodump` / `mongorestore`

## Related docs

- [dev-environment-and-credentials.md](dev-environment-and-credentials.md)
- [manual-installs.md](manual-installs.md)
