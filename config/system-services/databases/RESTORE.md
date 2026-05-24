# Database Services Restore

Enable MariaDB, PostgreSQL, Redis, MongoDB, PHP-FPM, and Apache from manifests.

## Manifest

`config/system-services/databases/manifest.json`:

```json
{
  "mariadb": { "service": "mariadb.service", "status": "active" },
  "postgresql": { "service": "postgresql.service", "version": "18.4" },
  "redis": { "service": "redis-server.service", "status": "active" },
  "mongodb": { "service": "mongod.service", "status": "failed" },
  "php_fpm": ["php8.3-fpm.service", "php8.4-fpm.service"],
  "apache": { "service": "apache2.service", "status": "active" }
}
```

## Install packages

From `data/apt-packages.txt` and `data/apt-third-party.sh`:

```bash
sudo apt update
sudo apt install mariadb-server postgresql postgresql-contrib \
  redis-server apache2 php8.3-fpm php8.4-fpm

# MongoDB — use vendor repo from apt-third-party.sh
# sudo apt install mongodb-org
```

## Enable services

```bash
chmod +x config/system-services/enable-services.sh
./config/system-services/enable-services.sh --databases-only
```

Manual:

```bash
sudo systemctl enable --now mariadb postgresql redis-server mongod apache2
sudo systemctl enable --now php8.3-fpm php8.4-fpm
```

## Verify

```bash
sudo systemctl status mariadb postgresql redis-server mongod apache2
sudo ss -tlnp | grep -E '3306|5432|6379|27017|:80'
```

| Service | Default port | Client test |
|---------|--------------|-------------|
| MariaDB | 3306 | `mysql -u root -p -e 'SELECT 1'` |
| PostgreSQL | 5432 | `sudo -u postgres psql -c 'SELECT 1'` |
| Redis | 6379 | `redis-cli ping` |
| MongoDB | 27017 | `mongosh --eval 'db.runCommand({ ping: 1 })'` |

## MongoDB troubleshooting

Source machine had `mongod.service` in **failed** state. On restore:

```bash
sudo journalctl -u mongod -n 50
sudo chown -R mongodb:mongodb /var/lib/mongodb
sudo systemctl restart mongod
```

Check `/etc/mongod.conf` for `dbPath` and bind IP.

## Apache modules

Enabled modules/sites list: `config/system-services/web-stack/apache2-enabled.txt`

```bash
sudo a2enmod rewrite ssl headers proxy_fcgi setenvif
sudo a2enconf php8.3-fpm php8.4-fpm 2>/dev/null || true
sudo systemctl reload apache2
```

## Configuration templates

If present in repo:

- `postgresql.conf.template`
- `mariadb.cnf.template`
- `redis.conf.template`

Merge with system configs under `/etc/postgresql/`, `/etc/mysql/`, `/etc/redis/`.

**Do not overwrite** production configs blindly — diff first.

## Data migration

Database data is **not** in jbubuntu. Migrate separately:

### PostgreSQL

```bash
# Old machine
pg_dump -U user dbname > backup.sql
# New machine
createdb dbname
psql -U user dbname < backup.sql
```

### MariaDB

```bash
mysqldump -u root -p --all-databases > all.sql
mysql -u root -p < all.sql
```

### Redis

```bash
redis-cli --rdb /path/to/dump.rdb
# copy dump.rdb to /var/lib/redis/ and restart
```

### MongoDB

```bash
mongodump --out=/backup/mongo
mongorestore /backup/mongo
```

## Security post-install

```bash
sudo mysql_secure_installation
sudo -u postgres psql -c "ALTER USER postgres PASSWORD 'newpassword';"
```

Store passwords in password manager — not in git.

## Related

- [../../docs/system-services-and-databases.md](../../docs/system-services-and-databases.md)
- [../enable-services.sh](../enable-services.sh)
