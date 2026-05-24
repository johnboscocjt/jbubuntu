# Jubuntu

**An opinionated developer setup for Ubuntu LTS by [johnboscocjt](https://github.com/johnboscocjt)**

Jubuntu is the public, Omakub-style install profile. One command gives you a dark GNOME desktop, zsh + Starship + Atuin, Kitty terminal, Laravel-ready PHP/database stack, and preconfigured VS Code + Cursor.

Install from **either repository**:

| Repo | One-liner |
|------|-----------|
| **[jubuntu](https://github.com/johnboscocjt/jubuntu)** (standalone) | `wget -qO- https://raw.githubusercontent.com/johnboscocjt/jubuntu/main/install \| bash` |
| **[jbubuntu](https://github.com/johnboscocjt/jbubuntu)** (monorepo) | `wget -qO- https://raw.githubusercontent.com/johnboscocjt/jbubuntu/main/jubuntu/install \| bash` |

---

## Install

### One-liner — jbubuntu monorepo

```bash
wget -qO- https://raw.githubusercontent.com/johnboscocjt/jbubuntu/main/jubuntu/install | bash
```

### One-liner — standalone jubuntu repo

```bash
wget -qO- https://raw.githubusercontent.com/johnboscocjt/jubuntu/main/install | bash
```

### Git clone (developers)

```bash
# From monorepo
git clone https://github.com/johnboscocjt/jbubuntu.git
cd jbubuntu/jubuntu
./setup.sh

# Or standalone repo
git clone https://github.com/johnboscocjt/jubuntu.git
cd jubuntu
./setup.sh
```

After install, `~/jubuntu` symlinks to the product folder for quick access.

---

## Requirements

| Requirement | Notes |
|-------------|-------|
| **Ubuntu 24.04+ or 26.04 LTS** | Tested on LTS releases |
| **GNOME desktop** | Extensions, dconf, and themes need GNOME |
| **Internet** | Downloads packages, Flatpaks, Snaps, and runtimes |
| **sudo** | System packages and services |

---

## What you get

| Area | Details |
|------|---------|
| **Desktop** | Dark GNOME, 17 extensions, Nemo default, WhiteSur-ready |
| **Terminal** | Kitty + Warp, zsh, Oh My Zsh, Starship, Atuin |
| **IDEs** | VS Code + Cursor extensions and settings |
| **Web stack** | Apache, PHP-FPM, MariaDB, PostgreSQL, Redis |
| **CLI** | lsd, bat, htop, nala, jq, fastfetch |
| **Apps** | Full Flatpak (37) + Snap (14) manifests from monorepo |
| **Services** | MariaDB, PostgreSQL, Redis, Apache, PHP-FPM, auto-cpufreq |

---

## After install

1. **GitHub CLI:** `gh auth login -h github.com`
2. **GNOME config** (if dconf failed during setup):
   ```bash
   ./scripts/apply-gnome-config.sh
   ```
   (Run from repo root — `~/jbubuntu` or standalone clone.)
3. **WhiteSur theme** (optional):
   ```bash
   git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git
   cd WhiteSur-gtk-theme && ./install.sh -t all
   ```
4. **Manual `/opt` apps:** [`docs/manual-installs.md`](../docs/manual-installs.md)
5. **SSH/GPG/2FA:** [`config/dev-environment/credentials/RESTORE.md`](../config/dev-environment/credentials/RESTORE.md)
6. **First Laravel project:** [`docs/projects/laravel.md`](../docs/projects/laravel.md)

---

## CLI

After install, `jubuntu` is available in `~/.local/bin`:

```bash
jubuntu doctor    # Check tools, services, symlink
jubuntu update    # Pull latest and re-run setup
jubuntu config    # Print repo paths
```

---

## Jubuntu vs jbubuntu backup

| | **Jubuntu** | **jbubuntu backup** |
|---|-------------|---------------------|
| **Purpose** | Public opinionated dev setup | Personal machine restore |
| **Repos** | [jubuntu](https://github.com/johnboscocjt/jubuntu) or `jbubuntu/jubuntu/` | [jbubuntu](https://github.com/johnboscocjt/jbubuntu) root |
| **Install** | `wget \| bash` one-liner | `./setup.sh` from repo root |
| **APT packages** | ~80 curated (`data/apt-core.txt`) | ~157 full backup list |
| **Audience** | Any developer on fresh Ubuntu | johnboscocjt's machines |

Both Jubuntu install paths share the same `config/`, `dotfiles/`, `data/`, and `scripts/`.

---

## Docs

- [Application inventory](../apps/README.md)
- [GitHub workflow](../docs/github/README.md)
- [Project setup (Laravel, Node, Django)](../docs/projects/README.md)
- [Find anything on your system](../docs/how-to-find-stuff.md)

---

## Trust model

The one-liner downloads and executes shell scripts from GitHub. Review [`install`](install), [`install.sh`](install.sh), and [`setup.sh`](setup.sh) before running. Prefer git clone if you want to inspect everything first.

---

## License

Same as the jbubuntu monorepo — personal backup configs; use at your own risk on your own machines.
