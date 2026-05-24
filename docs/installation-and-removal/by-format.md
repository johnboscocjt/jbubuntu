# Install by Package Format

How each package format is installed, updated, and located on this system.

## APT (primary)

**Manifest:** `data/apt-packages.txt`, vendor script `data/apt-third-party.sh`

```bash
# Single package
sudo apt update && sudo apt install package-name

# Bulk from manifest
grep -v '^#' data/apt-packages.txt | xargs sudo apt install -y

# Search
apt search keyword
apt list --installed | grep keyword
dpkg -l | grep keyword
```

**Config locations:** `/etc/`, `/usr/share/`, sometimes `~/.config/`

**Remove:**

```bash
sudo apt purge package-name
sudo apt autoremove
```

Third-party examples in `apt-third-party.sh`: Cursor, Google Chrome, Docker, MongoDB, PostgreSQL, NodeSource, etc.

## Snap

**Manifest:** `data/snap-apps.txt` (user snaps only — no runtimes)

```bash
sudo snap install discord
snap list
snap info package
```

**Paths:** `~/snap/<name>/current/`, `/snap/<name>/`

**Remove:**

```bash
sudo snap remove package-name
```

Common snaps: Discord, Telegram, Ghostty, PhpStorm, PyCharm, GitKraken.

## Flatpak

**Manifest:** `data/flatpak-apps.txt`

```bash
flatpak install flathub io.github.shiftey.Desktop
flatpak list
flatpak info app-id
```

**Paths:** `~/.var/app/<app-id>/`, `/var/lib/flatpak/`

**Remove:**

```bash
flatpak uninstall app-id
flatpak uninstall --delete-data app-id   # includes user data
```

Examples: Zen Browser, GitHub Desktop, Spotify, Brave, Authenticator.

## .deb (manual download)

```bash
sudo dpkg -i package.deb
sudo apt install -f    # fix dependencies
```

Track vendor .debs in `data/apt-third-party.sh` for repeatability.

## AppImage

**Location:** `~/Applications/` or `~/AppImages/`

```bash
chmod +x App.AppImage
./App.AppImage
```

**Desktop entry:** use `installs/templates/appimage.desktop.template`

No package manager tracking — use `find ~ -name '*.AppImage'`.

## /opt (manual extract)

**Manifest:** `installs/opt-manifest.txt`

```bash
ls /opt/
sudo tar -xf vendor.tar.gz -C /opt/AppName
```

Requires manual updates. Often symlinked to `/usr/local/bin`.

See [../manual-installs.md](../manual-installs.md).

## Git clone → build → install

Pattern for tools built from source:

```bash
git clone https://github.com/user/repo ~/src/github/repo
cd ~/src/github/repo
make && sudo make install
# or: npm install -g, cargo install, go install
```

Template: [installs/templates/git-clone-install.md](../../installs/templates/git-clone-install.md)

Examples: auto-cpufreq, custom GNOME extensions, jshortcuts.

## GNOME extensions

Mixed sources:

- **APT:** `gnome-shell-extension-ubuntu-dock`
- **extensions.gnome.org:** browser install
- **GitHub:** clone to `~/.local/share/gnome-shell/extensions/<uuid>/`

Script: `config/gnome-extensions/install-extensions.sh`

## Compare formats

| Format | Auto-update | Sandboxed | Easy remove |
|--------|-------------|-----------|-------------|
| APT | apt upgrade | No | apt purge |
| Snap | snap refresh | Yes | snap remove |
| Flatpak | flatpak update | Yes | flatpak uninstall |
| AppImage | Manual | No | delete file |
| /opt | Manual | No | rm -rf |

## Detection helper

```bash
./scripts/find-app.sh <name>
```

## Related

- [find-installed.md](find-installed.md)
- [uninstall-and-cleanup.md](uninstall-and-cleanup.md)
- [python-and-runtimes.md](python-and-runtimes.md)
