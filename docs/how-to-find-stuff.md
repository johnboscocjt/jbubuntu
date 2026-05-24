# How to Find Stuff

Practical guide to locating files, applications, configs, ports, and processes on this system.

## Quick tools in this repo

| Script | Purpose |
|--------|---------|
| `scripts/find-anything.sh` | Interactive menu (files, apps, configs below) |
| `scripts/find-app.sh` | Detect install type for one app |
| `scripts/remove-app.sh` | Uninstall by detected type |

```bash
chmod +x scripts/*.sh
./scripts/find-anything.sh
```

## Find files by name

```bash
# Home directory (fast)
find ~ -maxdepth 6 -iname '*pattern*' 2>/dev/null

# System-wide (slow, may need sudo)
sudo find / -iname '*pattern*' 2>/dev/null | head -50

# Using locate (if mlocate installed)
sudo updatedb && locate pattern
```

## Find installed applications

See [installation-and-removal/find-installed.md](installation-and-removal/find-installed.md).

Quick reference:

```bash
# APT
dpkg -l | grep -i name
apt list --installed | grep -i name

# Snap
snap list | grep -i name

# Flatpak
flatpak list | grep -i name

# Binary on PATH
which appname
type -a appname

# Desktop launcher
find /usr/share/applications ~/.local/share/applications -iname '*name*.desktop'
```

Use `./scripts/find-app.sh cursor` for combined detection.

## Find configuration files

| App / area | Typical path |
|------------|--------------|
| Shell | `~/.zshrc`, `~/.config/starship.toml` |
| GNOME | `dconf dump /` or `~/.config/dconf/` |
| VS Code | `~/.config/Code/User/` |
| Cursor | `~/.config/Cursor/User/` |
| Git | `~/.gitconfig` |
| gh | `~/.config/gh/` |
| Flatpak apps | `~/.var/app/<app-id>/config/` |
| Snap apps | `~/snap/<name>/current/` |
| Repo backups | `~/jbubuntu/config/` |

Search config tree:

```bash
find ~/.config -maxdepth 3 -iname '*keyword*'
rg -l 'keyword' ~/.config
```

## Find text inside files

```bash
rg 'search-term' ~/projects
grep -rIl 'search-term' ~/.config
```

## Find listening ports

```bash
ss -tlnp                    # all TCP listeners
ss -tlnp 'sport = :5432'    # PostgreSQL
lsof -i :8080
sudo netstat -tlnp
```

Common dev ports:

| Port | Service |
|------|---------|
| 3306 | MariaDB |
| 5432 | PostgreSQL |
| 6379 | Redis |
| 27017 | MongoDB |
| 80/443 | Apache |
| 3000 | Node dev server |

## Find processes

```bash
pgrep -af postgres
ps aux | grep -i mariadb
systemctl status mariadb
htop   # then F4 filter
```

## Find package manifest entries

Repo manifests in `data/`:

```bash
grep -i bruno data/apt-packages.txt data/snap-apps.txt data/flatpak-apps.txt
grep -i bruno installs/opt-manifest.txt
```

## Find GNOME / dconf settings

```bash
gsettings list-recursively org.gnome.desktop.interface
dconf dump /org/gnome/shell/extensions/
dconf read /org/gnome/shell/enabled-extensions
```

## Find systemd services

```bash
systemctl list-units --type=service --state=running
systemctl list-unit-files | grep enabled
grep mariadb config/system-services/enabled-services.txt
```

## Find manual /opt installs

```bash
ls /opt/
cat installs/opt-manifest.txt
```

## Related docs

- [installation-and-removal/find-installed.md](installation-and-removal/find-installed.md)
- [installation-and-removal/by-format.md](installation-and-removal/by-format.md)
- [manual-installs.md](manual-installs.md)
