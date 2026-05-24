# jbubuntu monorepo

| Product | Purpose | Install |
|---------|---------|---------|
| **[Jubuntu](https://github.com/johnboscocjt/jubuntu)** | Opinionated dev Ubuntu (standalone repo) | `wget -qO- https://raw.githubusercontent.com/johnboscocjt/jubuntu/main/install \| bash` |
| **[Jubuntu](jubuntu/)** (in this monorepo) | Same installer, nested in jbubuntu | `wget -qO- https://raw.githubusercontent.com/johnboscocjt/jbubuntu/main/jubuntu/install \| bash` |
| **jbubuntu backup** | Personal machine restore | `./setup.sh` from repo root |

---

# jbubuntu — Ubuntu System Backup & Restore

Personal Ubuntu migration repository for **johnboscocjt**. Restores applications, GNOME desktop, shell environment, IDE configs, services, and documentation on a fresh Ubuntu LTS install.

**Public product:** [Jubuntu](jubuntu/README.md) — curated ~80-package dev profile with the same shared configs, installable via one-liner.

**Source system:** Ubuntu 26.04 LTS · GNOME · zsh · Nemo (default file manager)

## Quick start

```bash
git clone https://github.com/johnboscocjt/jbubuntu.git
cd jbubuntu
chmod +x setup.sh
./setup.sh                  # Full restore
./setup.sh --dry-run          # Preview commands
./setup.sh --dotfiles-only    # Shell + dotfiles only
```

After setup, log into GNOME and run:

```bash
./scripts/apply-gnome-config.sh   # If dconf failed during setup
gh auth login -h github.com         # GitHub CLI (token not in repo)
```

## What's included

| Area | Location |
|------|----------|
| **App inventory & use cases** | [`apps/README.md`](apps/README.md) |
| **APT / Snap / Flatpak manifests** | [`data/`](data/) |
| **GNOME themes & extensions** | [`config/dconf/`](config/dconf/), [`config/gnome-extensions/`](config/gnome-extensions/) |
| **IDE configs (VS Code, Cursor)** | [`config/ide/`](config/ide/) |
| **Shell & terminal dotfiles** | [`dotfiles/`](dotfiles/) |
| **Shortcuts & keybindings** | [`config/shortcuts/`](config/shortcuts/), [`docs/shortcuts-and-keybindings.md`](docs/shortcuts-and-keybindings.md) |
| **Dev runtimes (NVM, Deno, gh, git)** | [`config/dev-environment/`](config/dev-environment/) |
| **System services & databases** | [`config/system-services/`](config/system-services/) |
| **Install / uninstall guide** | [`docs/installation-and-removal/`](docs/installation-and-removal/) |
| **Find anything on your system** | [`docs/how-to-find-stuff.md`](docs/how-to-find-stuff.md) |
| **GitHub workflow (push, sync, PRs, CI/CD)** | [`docs/github/README.md`](docs/github/README.md) |
| **Project setup (Laravel, Node, Django, etc.)** | [`docs/projects/README.md`](docs/projects/README.md) |

## Application inventory (summary)

### Development · APT / Snap / Flatpak / Manual
| App | Source |
|-----|--------|
| VS Code, Cursor, Warp | APT (third-party repos) |
| Windsurf, OpenCode, Antigravity | APT / manual |
| PhpStorm, PyCharm, GitKraken | Snap |
| GitHub Desktop, Zen Browser | Flatpak |
| Docker Desktop, Bruno, Postman | `/opt/` or manual — see [`docs/manual-installs.md`](docs/manual-installs.md) |

### Databases & backend · APT
PostgreSQL 18, MariaDB, Redis, MongoDB, Apache2, PHP 8.3–8.5 + FPM, pgAdmin4, phpMyAdmin

### Browsers & communication
Google Chrome (APT), Firefox (APT), Zen & Brave (Flatpak), Discord & Telegram (Snap)

### Flatpak apps (37)
See [`data/flatpak-apps.txt`](data/flatpak-apps.txt) — Spotify, OBS, HandBrake, GitHub Desktop, LocalSend, etc.

### Snap apps (14)
See [`data/snap-apps.txt`](data/snap-apps.txt) — Discord, Telegram, Ghostty, PhpStorm, etc.

### GNOME extensions (17 enabled)
ubuntu-dock, blur-my-shell, burn-my-windows, tiling-assistant, Astra Monitor, Vitals, GSConnect, caffeine, space-bar, and more — see [`apps/gnome-extensions/README.md`](apps/gnome-extensions/README.md)

### Themes & appearance
| Setting | Value |
|---------|-------|
| GTK theme | WhiteSur-Dark |
| Icon theme | WhiteSur-dark |
| Cursor | breeze_cursors |
| WM theme | Mojave-Dark |
| Color scheme | Dark |

Install WhiteSur: `git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git && ./install.sh -t all`

## Dotfiles map

| File | Purpose |
|------|---------|
| `dotfiles/zsh/.zshrc` | zsh + OMZ + Starship + Atuin + fastfetch + NVM |
| `dotfiles/starship.toml` | Prompt theme |
| `dotfiles/cli-tools/lsd/config.yaml` | lsd file listing |
| `dotfiles/cli-tools/shell-aliases.zsh` | `ls`→lsd, `cat`→batcat |
| `dotfiles/kitty/kitty.conf` | Default terminal (Ctrl+Alt+T) |
| `config/dev-environment/git/.gitconfig` | Git identity + gh credential helper |

## Key shortcuts

| Keys | Action |
|------|--------|
| `Super + A` | Ulauncher |
| `Super + V` | Clipboard popup |
| `Ctrl + Alt + T` | Kitty terminal |
| `Super + J` | jshortcuts GUI |
| `Super + G` | GitHub Desktop |
| `Super + F` | Frog screenshot/OCR |
| `Super + Z` | Screenshot UI |

Full list: [`docs/shortcuts-and-keybindings.md`](docs/shortcuts-and-keybindings.md)

## Helper scripts

```bash
./scripts/find-app.sh obsidian       # How is it installed?
./scripts/find-anything.sh           # Interactive find menu
./scripts/remove-app.sh cursor       # Uninstall helper
./installs/folder-layout.sh          # Create ~/src/github, ~/Applications
```

## What is NOT backed up

- SSH private keys, GPG secret keys, `gh` auth tokens
- Browser profiles, database **data**, Docker images
- Obsidian vault **content** (clone from GitHub separately)
- GSConnect device pairing certificates
- Commercial license files (JetBrains, Typora, Packet Tracer)

See [`config/dev-environment/credentials/RESTORE.md`](config/dev-environment/credentials/RESTORE.md)

## setup.sh options

```
--skip-snap              Skip Snap installs
--skip-flatpak           Skip Flatpak installs
--skip-third-party       Skip vendor APT repos
--skip-ide               Skip IDE extensions/settings
--skip-gnome-config      Skip GNOME dconf/extensions
--skip-services          Skip systemd services
--skip-dev-environment   Skip NVM/Deno/gh config
--dotfiles-only          Dotfiles + shell only
--dry-run                Print commands only
```

## Documentation index

- [Shell & terminals](docs/shell-and-terminals.md)
- [GNOME desktop](docs/gnome-desktop.md)
- [IDE setup](docs/ide-setup.md)
- [Dev environment & credentials](docs/dev-environment-and-credentials.md)
- [System services & databases](docs/system-services-and-databases.md)
- [Installation & removal](docs/installation-and-removal/README.md)
- [How to find stuff](docs/how-to-find-stuff.md)
- [GitHub workflow](docs/github/README.md) — push, sync, conflicts, PRs, branch protection, CI/CD
- [Project setup](docs/projects/README.md) — Laravel, Node/React, Django, static sites
- [Manual /opt installs](docs/manual-installs.md)

## License

MIT — see [LICENSE](LICENSE)
