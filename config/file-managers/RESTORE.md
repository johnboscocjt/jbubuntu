# File Managers Restore

Restore **Nemo** as the default file manager with backed-up preferences.

## Default file manager: Nemo

Nemo replaces Nautilus for folder opening and desktop icons.

| Asset | Repo path |
|-------|-----------|
| Preferences dconf | `config/file-managers/nemo.dconf` |

## Restore steps

### 1. Install Nemo

```bash
sudo apt install nemo nemo-fileroller
```

### 2. Apply dconf preferences

```bash
dconf load /org/nemo/ < config/file-managers/nemo.dconf
```

Or via full GNOME apply:

```bash
./scripts/apply-gnome-config.sh
```

### 3. Set Nemo as default

```bash
xdg-mime default nemo.desktop inode/directory
xdg-settings set default-url-scheme-handler file nemo
```

If `mimeapps-file-manager.conf` exists in repo:

```bash
cp config/file-managers/mimeapps-file-manager.conf ~/.config/mimeapps.list
```

### 4. Enable desktop icons (if used)

```bash
nemo-desktop &
```

Add to startup applications or autostart if desired.

### 5. Dock favorite

Home folder opens with **Super+E** → Nemo. Ensure `nemo.desktop` is in dock favorites (`config/dconf/shell-favorites-raw.txt`).

## Nemo settings highlights

From `nemo.dconf`:

- Sidebar enabled on start
- Search files recursively
- Sort by name
- Hidden files off by default
- Window maximized by default

## Nautilus (GNOME Files)

Still installed for GNOME integration. Optional settings export: `config/file-managers/nautilus-gsettings.txt` (if present).

Do not remove Nautilus — some GNOME components depend on it.

## Archive handling

`nemo-fileroller` integrates archive open/extract with File Roller.

## Troubleshooting

| Issue | Fix |
|-------|-----|
| Folders open in Nautilus | Re-run `xdg-mime default nemo.desktop inode/directory` |
| No desktop icons | Start `nemo-desktop`, check GNOME "Desktop Icons" extension |
| Wrong window size | Reset via dconf or delete `~/.config/nemo/` window-state |

## Related

- [../../docs/gnome-desktop.md](../../docs/gnome-desktop.md)
- [../../docs/shortcuts-and-keybindings.md](../../docs/shortcuts-and-keybindings.md) (Super+E)
