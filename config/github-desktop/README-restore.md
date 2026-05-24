# GitHub Desktop — Flatpak Restore

Reinstall and re-authenticate GitHub Desktop on a new Ubuntu/GNOME machine.

## Package info

| Item | Value |
|------|-------|
| Flatpak ID | `io.github.shiftey.Desktop` |
| Flathub | `flathub io.github.shiftey.Desktop` |
| GNOME shortcut | **Super+G** |
| Manifest | `data/flatpak-apps.txt` |

## Install

```bash
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install flathub io.github.shiftey.Desktop
```

Launch:

```bash
flatpak run io.github.shiftey.Desktop
```

## Authentication (required every new machine)

OAuth tokens live in the Flatpak sandbox — **not backed up** in jbubuntu.

1. Open GitHub Desktop
2. **File → Options → Accounts**
3. Click **Sign in** → **Sign in to GitHub.com**
4. Complete browser OAuth flow
5. Authorize GitHub Desktop

Verify by cloning a repository: **File → Clone repository**

## Flatpak data paths

| Purpose | Path |
|---------|------|
| Config | `~/.var/app/io.github.shiftey.Desktop/config/` |
| Data / cache | `~/.var/app/io.github.shiftey.Desktop/data/` |
| Cache | `~/.var/app/io.github.shiftey.Desktop/cache/` |

## Reset auth (troubleshooting)

```bash
flatpak kill io.github.shiftey.Desktop
flatpak uninstall --delete-data io.github.shiftey.Desktop
flatpak install flathub io.github.shiftey.Desktop
```

Sign in again from scratch.

## GNOME shortcut restore

Included in `config/shortcuts/gnome-custom-keybindings.dconf`:

```
binding='<Super>g'
command='flatpak run io.github.shiftey.Desktop'
```

Apply:

```bash
./scripts/apply-gnome-config.sh
```

## Git credential interaction

GitHub Desktop manages its own credentials inside the sandbox. For terminal `git` + `gh`, use [../dev-environment/gh/RESTORE.md](../dev-environment/gh/RESTORE.md) separately.

## Related

- [../../docs/obsidian-and-github-desktop.md](../../docs/obsidian-and-github-desktop.md)
- [../../docs/shortcuts-and-keybindings.md](../../docs/shortcuts-and-keybindings.md)
