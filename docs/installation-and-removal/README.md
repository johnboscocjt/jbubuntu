# Installation and Removal Guide

Overview of how software is installed on this system and how to find, install, or remove it cleanly.

## Package sources on this machine

| Format | Manifest | Count (approx) |
|--------|----------|----------------|
| APT | `data/apt-packages.txt` | ~200 user packages |
| APT third-party | `data/apt-third-party.sh` | Vendor repos + .debs |
| Snap | `data/snap-apps.txt` | 18 user snaps |
| Flatpak | `data/flatpak-apps.txt` | 36 Flathub apps |
| /opt manual | `installs/opt-manifest.txt` | 15 directories |
| Runtimes | `config/dev-environment/runtimes/` | NVM, Deno, Go, PHP, Python |

## Recommended folder layout

```
~/src/github/          # Git clones (primary)
~/src/gitlab/
~/src/bitbucket/
~/Applications/        # AppImages
~/AppImages/
~/bin/                 # User scripts (jshortcuts, etc.)
~/go/bin/              # Go install target
/opt/                  # Manual vendor installs (sudo)
```

Create directories:

```bash
./installs/folder-layout.sh
```

## Helper scripts

| Script | Purpose |
|--------|---------|
| `scripts/find-app.sh` | Detect how an app was installed |
| `scripts/find-anything.sh` | Interactive finder menu |
| `scripts/remove-app.sh` | Uninstall with cleanup hints |

## Guide index

| Doc | Topic |
|-----|-------|
| [by-format.md](by-format.md) | APT, Snap, Flatpak, deb, AppImage, /opt |
| [python-and-runtimes.md](python-and-runtimes.md) | pip, pipx, nvm, npm, go install |
| [find-installed.md](find-installed.md) | Locate any installed app |
| [uninstall-and-cleanup.md](uninstall-and-cleanup.md) | Remove apps + orphan configs |

## Install workflow (new machine)

1. Run `data/apt-third-party.sh` for vendor repos (Cursor, Chrome, Docker, etc.)
2. Bulk APT: `xargs sudo apt install -y < data/apt-packages.txt`
3. Flatpak: `xargs -I{} flatpak install -y flathub {} < data/flatpak-apps.txt`
4. Snaps: install from `data/snap-apps.txt` as needed
5. Manual /opt apps per [manual-installs.md](../manual-installs.md)
6. Runtimes per [python-and-runtimes.md](python-and-runtimes.md)
7. Dotfiles + config from `config/` and `dotfiles/`

## Desktop entry cleanup

After removing AppImage or /opt apps, delete orphaned `.desktop` files:

```bash
find ~/.local/share/applications -name '*.desktop' -mtime +0
update-desktop-database ~/.local/share/applications
```

## Related docs

- [../manual-installs.md](../manual-installs.md)
- [../how-to-find-stuff.md](../how-to-find-stuff.md)
- [../installs/README.md](../installs/README.md)
