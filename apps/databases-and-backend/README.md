# Databases & Backend

SQL and NoSQL servers, caching, PHP web stack, admin GUIs, and backend frameworks running on this workstation.

**Related config:** [`config/system-services/databases/`](../../config/system-services/databases/) · **Services:** [`config/system-services/enabled-services.txt`](../../config/system-services/enabled-services.txt)

> Database **data** (rows, dumps) is not in this repo — only service configs and restore steps. Migrate data separately with `pg_dump`, `mysqldump`, etc.

---

## SQL database servers

| Name | Package / Service | Source | What it is | Used for | Typical tasks |
|------|-------------------|--------|------------|----------|---------------|
| **PostgreSQL 18** | `postgresql`, `postgresql.service` | APT | Advanced open-source relational database | Primary SQL store for apps needing PostgreSQL features | Create databases, run migrations, `psql` queries |
| **MariaDB** | `mariadb-server`, `mariadb.service` | APT | MySQL-compatible SQL server | Laravel default database, WordPress-style schemas | `mysql -u root`, import SQL dumps, manage users |
| **Apache2** | `apache2`, `apache2.service` | APT | HTTP web server | Serve local PHP sites and virtual hosts | Enable sites, restart after config changes, tail access logs |

**Status on source PC:** MariaDB, PostgreSQL, Redis, Apache2 active; see [`manifest.json`](../../config/system-services/databases/manifest.json).

---

## NoSQL & cache

| Name | Package / Service | Source | What it is | Used for | Typical tasks |
|------|-------------------|--------|------------|----------|---------------|
| **Redis** | `redis-server`, `redis-server.service` | APT | In-memory key-value store | Laravel cache, sessions, queues | `redis-cli ping`, flush cache, monitor keys |
| **MongoDB** | `mongodb-org`, `mongod.service` | APT ([MongoDB repo](../../data/apt-third-party.sh)) | Document-oriented NoSQL database | JSON/document storage, Compass exploration | Start `mongod`, insert collections, backup with `mongodump` |
| **MongoDB Compass** | `mongodb-compass` | APT | Official MongoDB GUI | Visual query builder and schema inspection | Connect to `localhost:27017`, browse collections |

---

## Admin GUIs & database tools

| Name | Package | Source | What it is | Used for | Typical tasks |
|------|---------|--------|------------|----------|---------------|
| **pgAdmin 4** | `pgadmin4`, `pgadmin4-web` | APT | PostgreSQL administration web/desktop app | Manage PostgreSQL servers, run SQL, backup/restore | Register servers, execute queries, view table stats |
| **phpMyAdmin** | `phpmyadmin` | APT | Web-based MySQL/MariaDB admin | Browser UI for MariaDB without CLI | Browse tables, run SQL, export databases |
| **Another Redis Desktop Manager** | `another-redis-desktop-manager` | Snap | Redis GUI client | Visual key browser and CLI alternative | Connect to local Redis, inspect hash/list keys |
| **DevDB** | VS Code extension | Marketplace | In-editor database browser | Quick table lookups from VS Code | Connect to local DBs, run ad-hoc SELECTs |

---

## PHP stack

| Name | Package / Service | Source | What it is | Used for | Typical tasks |
|------|-------------------|--------|------------|----------|---------------|
| **PHP CLI** | `php` | APT | PHP 8.5+ command-line interpreter | Artisan, Composer scripts, CLI tools | `php -v`, run scripts, `php artisan migrate` |
| **PHP-FPM 8.3** | `php8.3-fpm.service` | APT | FastCGI process manager (PHP 8.3) | Primary FPM pool for Apache/nginx | Restart after `php.ini` changes, tune pool sizes |
| **PHP-FPM 8.4** | `php8.4-fpm.service` | APT | Secondary PHP version pool | Projects requiring PHP 8.4 specifically | Switch vhost to 8.4 socket when needed |
| **Composer** | (global install) | User (`~/.config/composer/`) | PHP dependency manager | Laravel/vendor packages, global PHP tools | `composer install`, `composer global require` |

Typical PHP extensions on this system include: `intl`, `mysql`, `pgsql`, `redis`, `xdebug`, `mongodb`, `curl`, `mbstring`, `xml` — installed via APT `php-*` packages as needed.

---

## Python backend tooling

| Name | Package | Source | What it is | Used for | Typical tasks |
|------|---------|--------|------------|----------|---------------|
| **Django** | `python3-django` | APT | Python web framework | Python API and admin sites | `django-admin startproject`, run dev server |
| **pipenv** | `pipenv` | APT | Python virtualenv + Pipfile manager | Isolated Python project dependencies | `pipenv install`, `pipenv shell` |
| **pipx** | `pipx` | APT | Isolated Python CLI app installer | Global Python tools without polluting system Python | `pipx install pyqt5` |

---

## Service health checklist

After restore on a new PC:

```bash
systemctl is-active mariadb postgresql redis-server mongod apache2 php8.3-fpm
redis-cli ping
mysql -e 'SELECT 1'
psql -c 'SELECT 1'
```

If `mongod` fails to start, see system services docs — it was in a failed state on last export and may need data directory permissions or a fresh `mongod` init.
