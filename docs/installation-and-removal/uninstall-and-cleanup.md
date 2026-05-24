# Uninstall and Cleanup

Remove applications completely and clean orphaned configuration.

## Automated helper

```bash
./scripts/remove-app.sh [--dry-run] [--force] <app-name>
```

Detects install type and runs the appropriate remover. Use `--dry-run` to preview.

## By format

### APT

```bash
sudo apt purge package-name
sudo apt autoremove --purge
```

Remove config files that purge missed:

```bash
dpkg -L package-name | grep etc
sudo rm -rf /etc/package-name
```

### Snap

```bash
snap remove package-name
# Remove all revisions:
snap list --all | awk '/disabled/{print $1, $3}' | while read name rev; do
  snap remove "$name" --revision="$rev"
done
```

User data: `~/snap/package-name/` — delete manually if desired.

### Flatpak

```bash
flatpak uninstall app-id
flatpak uninstall --delete-data app-id
```

User data: `~/.var/app/app-id/`

### AppImage

```bash
rm ~/Applications/App.AppImage
rm ~/.local/share/applications/app.desktop
update-desktop-database ~/.local/share/applications
```

### /opt manual

```bash
sudo systemctl disable --now service-name 2>/dev/null || true
sudo rm -rf /opt/AppName
sudo rm /usr/local/bin/appname
rm ~/.local/share/applications/appname.desktop
```

### pipx

```bash
pipx uninstall package-name
```

### npm global (NVM)

```bash
npm uninstall -g package-name
```

### Go

```bash
rm ~/go/bin/binary-name
```

## Orphan config cleanup

After uninstall, check common leftovers:

| Pattern | Example |
|---------|---------|
| `~/.config/<app>/` | `~/.config/Postman/` |
| `~/.local/share/<app>/` | caches, state |
| `~/.cache/<app>/` | safe to delete |
| `~/.var/app/<id>/` | Flatpak sandbox |
| `~/snap/<name>/` | Snap user data |

```bash
# List large config dirs
du -sh ~/.config/* | sort -hr | head -20
```

**Warning:** Do not delete `~/.config/dconf`, `~/.ssh`, or `~/.gnupg` unless intentional.

## Desktop database refresh

```bash
update-desktop-database ~/.local/share/applications
sudo update-desktop-database /usr/share/applications
```

## GNOME extension removal

```bash
gnome-extensions disable uuid@example.com
rm -rf ~/.local/share/gnome-shell/extensions/uuid@example.com/
# Alt+F2 → r (X11) or log out
```

## Database service removal

```bash
sudo systemctl stop mariadb
sudo apt purge mariadb-server
sudo rm -rf /var/lib/mysql   # destroys data — backup first!
```

See [../../config/system-services/databases/RESTORE.md](../../config/system-services/databases/RESTORE.md) for data backup before purge.

## Verify removal

```bash
./scripts/find-app.sh removed-app-name   # should find nothing
which removed-app-name                   # should be empty
```

## Related

- [find-installed.md](find-installed.md)
- [by-format.md](by-format.md)
- [../manual-installs.md](../manual-installs.md)
