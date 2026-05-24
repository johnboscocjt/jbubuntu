# Find Installed Software

Commands and repo tools to locate how any application was installed.

## One-command detection

```bash
./scripts/find-app.sh <app-name>
```

Checks APT, Snap, Flatpak, `/opt`, AppImage, pipx, npm global, Go bin, desktop entries, and config dirs.

## By package manager

### APT / dpkg

```bash
dpkg -l | grep -i keyword
dpkg -L package-name          # list all files
apt-file search bin/name      # which package owns a binary
which name && dpkg -S $(which name)
```

### Snap

```bash
snap list
snap list | grep -i keyword
snap info snap-name
```

### Flatpak

```bash
flatpak list --app
flatpak list | grep -i keyword
flatpak info app.id.here
```

### Manual /opt

```bash
ls /opt/
cat installs/opt-manifest.txt
```

### AppImage

```bash
find ~/Applications ~/AppImages ~/bin -name '*.AppImage' 2>/dev/null
```

## By executable

```bash
which cursor code kitty bruno
type -a python3 node
command -v gh
```

## By desktop entry

```bash
find /usr/share/applications ~/.local/share/applications \
  -iname '*keyword*.desktop'

grep -l '^Name=.*Keyword' /usr/share/applications/*.desktop
```

Show launcher command:

```bash
grep '^Exec=' /usr/share/applications/code.desktop
```

## By running process

```bash
pgrep -af keyword
ps aux | grep -i keyword
```

## By port (services)

```bash
ss -tlnp | grep 5432
sudo lsof -i :3306
```

## Repo manifests (offline lookup)

```bash
grep -i keyword data/apt-packages.txt
grep -i keyword data/snap-apps.txt
grep -i keyword data/flatpak-apps.txt
grep -i keyword installs/opt-manifest.txt
```

## Language-specific

```bash
pipx list
npm list -g --depth=0
composer global show
go list -m all 2>/dev/null
flatpak list --runtime
```

## Interactive finder

```bash
./scripts/find-anything.sh
```

Menu options: files, apps, configs, ports, processes, text search, manifests.

## Related

- [../how-to-find-stuff.md](../how-to-find-stuff.md)
- [by-format.md](by-format.md)
- [uninstall-and-cleanup.md](uninstall-and-cleanup.md)
