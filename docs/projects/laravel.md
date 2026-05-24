# Laravel project setup

Complete guide to run a **Laravel** app on your Ubuntu stack (PHP 8.3–8.5, MariaDB/PostgreSQL, Redis, Apache, Composer, Cursor/VS Code with Laravel extensions).

---

## Prerequisites (system-wide)

Run once on a new machine:

```bash
cd ~/jbubuntu && ./setup.sh
# Or minimum for Laravel:
sudo apt install php8.3 php8.3-cli php8.3-fpm php8.3-mysql php8.3-pgsql php8.3-redis \
  php8.3-mbstring php8.3-xml php8.3-curl php8.3-zip php8.3-intl php8.3-bcmath \
  php8.3-sqlite3 php8.3-gd composer mariadb-server redis-server
sudo systemctl enable --now mariadb redis-server php8.3-fpm
```

Verify:

```bash
php -v          # 8.3+ 
composer -V
mysql --version
redis-cli ping  # PONG
```

Your IDE extensions (already in backup): Laravel, Intelephense, Blade Formatter, Laravel Pint, PHP Debug, Tailwind CSS IntelliSense.

---

## 1. Create or clone project

### New Laravel project

```bash
mkdir -p ~/src/github/johnboscocjt
cd ~/src/github/johnboscocjt

composer create-project laravel/laravel my-app
cd my-app
```

### Clone existing repo

```bash
cd ~/src/github/johnboscocjt
git clone https://github.com/johnboscocjt/my-app.git
cd my-app
composer install
cp .env.example .env
php artisan key:generate
```

---

## 2. Configure `.env`

### MariaDB (most common for Laravel)

```bash
sudo mysql -e "CREATE DATABASE my_app CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
sudo mysql -e "CREATE USER 'laravel'@'localhost' IDENTIFIED BY 'your_password';"
sudo mysql -e "GRANT ALL PRIVILEGES ON my_app.* TO 'laravel'@'localhost';"
sudo mysql -e "FLUSH PRIVILEGES;"
```

`.env`:

```env
APP_NAME=MyApp
APP_ENV=local
APP_DEBUG=true
APP_URL=http://127.0.0.1:8000

DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=my_app
DB_USERNAME=laravel
DB_PASSWORD=your_password

CACHE_STORE=redis
QUEUE_CONNECTION=redis
SESSION_DRIVER=redis

REDIS_HOST=127.0.0.1
REDIS_PASSWORD=null
REDIS_PORT=6379
```

### PostgreSQL alternative

```bash
sudo -u postgres createdb my_app
sudo -u postgres psql -c "CREATE USER laravel WITH PASSWORD 'your_password';"
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE my_app TO laravel;"
```

`.env`:

```env
DB_CONNECTION=pgsql
DB_HOST=127.0.0.1
DB_PORT=5432
DB_DATABASE=my_app
DB_USERNAME=laravel
DB_PASSWORD=your_password
```

### SQLite (simplest — no server)

```env
DB_CONNECTION=sqlite
# DB_DATABASE=/absolute/path/to/database/database.sqlite
```

```bash
touch database/database.sqlite
```

---

## 3. Run migrations and seed

```bash
php artisan migrate
php artisan db:seed          # if seeders exist
php artisan storage:link       # if using public disk
```

---

## 4. Run the development server

### Option A: Artisan (quickest)

```bash
php artisan serve
# → http://127.0.0.1:8000
```

With Vite frontend:

```bash
# Terminal 1
php artisan serve

# Terminal 2
npm install
npm run dev
```

### Option B: Apache virtual host (production-like)

```bash
sudo tee /etc/apache2/sites-available/my-app.conf << 'EOF'
<VirtualHost *:80>
    ServerName my-app.local
    DocumentRoot /home/jbtechnix/src/github/johnboscocjt/my-app/public

    <Directory /home/jbtechnix/src/github/johnboscocjt/my-app/public>
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/my-app-error.log
    CustomLog ${APACHE_LOG_DIR}/my-app-access.log combined
</VirtualHost>
EOF

echo "127.0.0.1 my-app.local" | sudo tee -a /etc/hosts
sudo a2ensite my-app.conf
sudo a2enmod rewrite
sudo systemctl reload apache2
```

Open `http://my-app.local`

---

## 5. Common Laravel tools on your system

| Tool | Command | Purpose |
|------|---------|---------|
| **Artisan** | `php artisan` | CLI for migrations, routes, cache |
| **Pint** | `./vendor/bin/pint` | Code style (extension enabled in Cursor) |
| **Tinker** | `php artisan tinker` | REPL |
| **Queue worker** | `php artisan queue:work` | Process Redis/database queues |
| **Scheduler** | `* * * * * php artisan schedule:run` | Cron entry |
| **Tests** | `php artisan test` | PHPUnit/Pest |

---

## 6. Open in Cursor / VS Code

```bash
cd ~/src/github/johnboscocjt/my-app
cursor .
```

Your restored settings already include:
- Intelephense for PHP
- Blade formatter on save (Cursor)
- Laravel Pint
- Tailwind CSS IntelliSense
- PHP Debug (Xdebug) — configure below if needed

### Optional: Xdebug

```bash
sudo apt install php8.3-xdebug
# Add to /etc/php/8.3/mods-available/xdebug.ini:
# xdebug.mode=debug
# xdebug.start_with_request=yes
sudo systemctl restart php8.3-fpm
```

---

## 7. Project `.gitignore` essentials

Laravel's default `.gitignore` already excludes:

```
/vendor
/node_modules
.env
/public/hot
/public/storage
/storage/*.key
.phpunit.result.cache
```

Commit `.env.example` with dummy values for teammates.

---

## 8. Full stack example (API + Redis queue)

```bash
# .env already has QUEUE_CONNECTION=redis

php artisan migrate
php artisan queue:work redis --tries=3   # Terminal 2

# Test queue
php artisan tinker
>>> dispatch(new \App\Jobs\ExampleJob());
```

---

## 9. Deploy checklist (when ready for production)

- [ ] `APP_ENV=production`, `APP_DEBUG=false`
- [ ] `php artisan config:cache`
- [ ] `php artisan route:cache`
- [ ] `php artisan view:cache`
- [ ] `npm run build` (Vite assets)
- [ ] Set up supervisor for `queue:work`
- [ ] HTTPS via Caddy/nginx/Apache + Let's Encrypt

---

## Quick reference

```bash
composer install
cp .env.example .env && php artisan key:generate
php artisan migrate
npm install && npm run dev    # if using Vite
php artisan serve
```

See also: [projects README](README.md) · [databases guide](../../apps/databases-and-backend/README.md) · [IDE extensions](../../apps/ide-extensions/vscode.md)
