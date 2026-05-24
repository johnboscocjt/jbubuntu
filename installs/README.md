# Manual Install Layout

Conventions for `/opt`, AppImages, and source checkouts on this system.

## Directory layout

| Path | Purpose |
|------|---------|
| `~/src/github/` | Primary git clone location |
| `~/src/gitlab/` | GitLab repos |
| `~/src/bitbucket/` | Bitbucket repos |
| `~/Applications/` | AppImages (user-writable) |
| `~/AppImages/` | Alternate AppImage location |
| `~/bin/` | Personal scripts (`jshortcuts`, wrappers) |
| `~/go/bin/` | Go `install` binaries |
| `/opt/` | Vendor bundles (requires sudo) |

Create all directories:

```bash
chmod +x installs/folder-layout.sh
./installs/folder-layout.sh
```

## /opt installs

Tracked in `installs/opt-manifest.txt`:

```
Bruno, Obsidian, Postman, Vysor, auto-cpufreq, containerd,
docker-desktop, drawio, freedownloadmanager, google, kingsoft,
klippboard, pt, sublime_text, warpdotdev
```

Pattern:

1. Download from vendor
2. Extract to `/opt/AppName`
3. Symlink binary → `/usr/local/bin/` or `~/bin/`
4. Optional desktop file from `installs/templates/appimage.desktop.template`

## AppImages

```bash
mv App.AppImage ~/Applications/
chmod +x ~/Applications/App.AppImage
cp installs/templates/appimage.desktop.template ~/.local/share/applications/myapp.desktop
# Edit Name, Exec, Icon
update-desktop-database ~/.local/share/applications
```

## Git clone workflow

See `installs/templates/git-clone-install.md` for clone → build → link pattern.

Example destinations:

```bash
git clone git@github.com:johnboscocjt/repo.git ~/src/github/repo
```

## Repo helper scripts

After `folder-layout.sh`, symlinks may exist in `~/bin/`:

- `find-app.sh`
- `find-anything.sh`
- `remove-app.sh`

## Detection and removal

```bash
./scripts/find-app.sh bruno
./scripts/remove-app.sh bruno
```

## Related docs

- [../docs/manual-installs.md](../docs/manual-installs.md)
- [../docs/installation-and-removal/by-format.md](../docs/installation-and-removal/by-format.md)
- [templates/git-clone-install.md](templates/git-clone-install.md)
