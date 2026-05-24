# Manual Installs (/opt and AppImages)

Applications installed outside APT/Snap/Flatpak, documented in `installs/opt-manifest.txt`.

## /opt manifest

Current entries:

| Directory | Typical app |
|-----------|-------------|
| `Bruno` | API client (Bruno) |
| `Obsidian` | Notes (AppImage-style bundle) |
| `Postman` | API testing |
| `Vysor` | Android screen mirror |
| `auto-cpufreq` | CPU governor (see performance scripts) |
| `containerd` | Container runtime |
| `docker-desktop` | Docker Desktop |
| `drawio` | Diagrams |
| `freedownloadmanager` | Download manager |
| `google` | Google Chrome bundle |
| `kingsoft` | WPS Office |
| `klippboard` | Clipboard tool |
| `pt` | Cisco Packet Tracer |
| `sublime_text` | Sublime Text |
| `warpdotdev` | Warp terminal |

## Install pattern for /opt apps

1. Download vendor tarball, .deb extract, or AppImage from official site
2. Extract to `/opt/AppName` (requires sudo)
3. Symlink binary to `/usr/local/bin` or `~/bin`
4. Create desktop entry from `installs/templates/appimage.desktop.template`

```bash
sudo mkdir -p /opt/Bruno
sudo tar -xf bruno-linux-x64.tar.gz -C /opt/Bruno --strip-components=1
sudo ln -sf /opt/Bruno/bruno /usr/local/bin/bruno
```

## AppImages

Recommended location: `~/Applications/` or `~/AppImages/`

```bash
chmod +x ~/Applications/MyApp.AppImage
cp installs/templates/appimage.desktop.template ~/.local/share/applications/myapp.desktop
# Edit Name, Exec, Icon fields
update-desktop-database ~/.local/share/applications
```

## Apps requiring login or license

| App | Notes |
|-----|-------|
| **Postman** | Sign in to sync collections |
| **Packet Tracer** | Cisco NetAcad account |
| **Docker Desktop** | Docker Hub login |
| **Obsidian** | Optional Obsidian account / Sync |
| **Bruno** | Local collections; cloud optional |
| **Sublime Text** | License key |

## Packet Tracer

Cisco Packet Tracer (`/opt/pt`) requires NetAcad download and license acceptance. Not redistributable — download from Cisco after login.

## Docker Desktop

Install from Docker `.deb`, lives in `/opt/docker-desktop`. Re-authenticate after restore. Container images not backed up.

## Google Chrome

Often `/opt/google/chrome/google-chrome` with APT wrapper — check both `which google-chrome` and `/opt/google`.

## Folder layout helper

```bash
./installs/folder-layout.sh
```

Creates `~/src/github`, `~/Applications`, `~/bin`, etc.

## Find and remove

```bash
./scripts/find-app.sh postman
./scripts/remove-app.sh postman   # prompts per install type
```

For `/opt` only:

```bash
sudo rm -rf /opt/AppName
sudo rm /usr/local/bin/appname
rm ~/.local/share/applications/appname.desktop
```

## Related docs

- [installs/README.md](../installs/README.md)
- [installation-and-removal/by-format.md](installation-and-removal/by-format.md)
- [installation-and-removal/uninstall-and-cleanup.md](installation-and-removal/uninstall-and-cleanup.md)
