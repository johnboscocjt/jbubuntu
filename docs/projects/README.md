# Project setup guide

How to go from a **fresh Ubuntu machine** (after [`setup.sh`](../../setup.sh)) to a **working project** — system-wide tools vs per-project configuration.

**Recommended project location:** `~/src/github/<your-username>/<project-name>`

```bash
./installs/folder-layout.sh   # creates ~/src/github, ~/Applications, etc.
```

## System-wide vs project-specific

| Layer | What | Where | Installed by |
|-------|------|-------|--------------|
| **System-wide** | PHP, MariaDB, Redis, Node (NVM), Composer, Apache | `/usr`, services | `setup.sh` + APT |
| **Project-specific** | Source code, `.env`, `vendor/`, `node_modules/` | `~/src/github/...` | You, per repo |
| **IDE** | Extensions, format-on-save | VS Code / Cursor config | `setup.sh` restores from `config/ide/` |

You install the **stack once** on the system; each project gets its own folder, database, and `.env`.

---

## Quick start checklist (any project)

```bash
# 1. Clone into standard location
cd ~/src/github/johnboscocjt
git clone https://github.com/johnboscocjt/my-project.git
cd my-project

# 2. Copy environment file
cp .env.example .env          # if Laravel/Django/Node template exists

# 3. Install dependencies (see stack guide below)
# 4. Configure .env (DB name, APP_URL, keys)
# 5. Create database
# 6. Run migrations / build
# 7. Open in Cursor/VS Code
cursor .    # or code .
```

---

## Stack guides

| Stack | Guide | Database | Runtime |
|-------|-------|----------|---------|
| **Laravel (PHP)** | [laravel.md](laravel.md) | MariaDB / PostgreSQL / SQLite | PHP 8.3+, Composer |
| **Node / React / Next.js** | [node-javascript.md](node-javascript.md) | Optional PostgreSQL/MongoDB | NVM Node 24 |
| **Django (Python)** | [django.md](django.md) | PostgreSQL / SQLite | Python 3 + venv |
| **Static / docs site** | [static-and-docs.md](static-and-docs.md) | None | Optional Node for build |

---

## Databases (already on your system)

After `setup.sh`, these services should be available:

| Service | Default port | Create DB example |
|---------|--------------|-------------------|
| **MariaDB** | 3306 | `sudo mysql -e "CREATE DATABASE myapp;"` |
| **PostgreSQL** | 5432 | `sudo -u postgres createdb myapp` |
| **Redis** | 6379 | No create step — use DB `0` in `.env` |
| **MongoDB** | 27017 | See [databases RESTORE](../../config/system-services/databases/RESTORE.md) if service failed |

**GUI tools:** pgAdmin4, phpMyAdmin, MongoDB Compass, Another Redis Desktop Manager (Snap).

---

## Web server options for local projects

| Method | Best for | URL example |
|--------|----------|-------------|
| **`php artisan serve`** | Laravel quick dev | `http://127.0.0.1:8000` |
| **Apache virtual host** | PHP/Laravel production-like | `http://myapp.local` |
| **`npm run dev`** | Vite / Next / React | `http://localhost:5173` |
| **Docker Compose** | Full stack in containers | Project-defined ports |

Your system has **Apache2 + PHP-FPM** enabled. Laravel guide covers both `artisan serve` and Apache.

---

## IDE setup per project

Your Cursor/VS Code already has Laravel/PHP extensions from [`config/ide/`](../../config/ide/).

**Open project:**
```bash
cd ~/src/github/johnboscocjt/my-laravel-app
cursor .
```

**Useful per-project files (commit these):**
- `.editorconfig` — consistent indentation
- `.vscode/extensions.json` — recommend Laravel/PHP extensions to teammates
- `.vscode/settings.json` — project-specific format rules (optional)

**Do not commit:** `.env`, `vendor/`, `node_modules/`, `.idea/`

---

## Environment variables (`.env`)

Every stack uses a local secrets file:

| Stack | File | Generate keys |
|-------|------|---------------|
| Laravel | `.env` | `php artisan key:generate` |
| Django | `.env` or `settings` | `python -c "from django.core.management.utils import get_random_secret_key; print(get_random_secret_key())"` |
| Node | `.env.local` | Project-specific |

Never commit `.env` to GitHub — keep `.env.example` with placeholder values.

---

## Git workflow per project

See [`docs/github/`](../github/README.md) for push, sync, PRs.

```bash
git checkout -b feature/my-feature
# work, commit
git push -u origin feature/my-feature
gh pr create
```

---

## Troubleshooting

| Problem | Check |
|---------|-------|
| `php` wrong version | `php -v` — use `update-alternatives` or project-specific `php8.3` |
| DB connection refused | `systemctl status mariadb` / `postgresql` |
| Port in use | `ss -tlnp \| grep 8000` |
| Permission denied on `storage/` | Laravel: `chmod -R 775 storage bootstrap/cache` |
| Composer memory | `COMPOSER_MEMORY_LIMIT=-1 composer install` |

More: [`docs/how-to-find-stuff.md`](../how-to-find-stuff.md)
