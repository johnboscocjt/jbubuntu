# GNOME Desktop

Configuration for extensions, themes, window manager, and dconf restore on Ubuntu GNOME.

## Themes and appearance

From `config/dconf/interface.dconf` and `config/dconf/wm-preferences.dconf`:

| Setting | Value |
|---------|-------|
| GTK theme | **WhiteSur-Dark** |
| Icon theme | **WhiteSur-dark** |
| Cursor | **breeze_cursors** |
| Color scheme | **prefer-dark** |
| Font | Ubuntu Sans 11 / Ubuntu Sans Mono 13 |
| WM theme | **Mojave-Dark** |
| Button layout | `:minimize,maximize,close` (traffic lights on the right) |

### Installing WhiteSur

WhiteSur is installed via git clone (not bundled in this repo):

```bash
git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git
cd WhiteSur-gtk-theme
./install.sh -d -c Dark
./tweak.sh -g
```

Install **user-theme** extension (APT: `gnome-shell-extensions`) so shell themes like Mojave-Dark load correctly.

### Mojave-Dark window manager theme

Usually installed alongside WhiteSur or from [McMojave themes](https://github.com/vinceliuice/WhiteSur-gtk-theme). Select in GNOME Tweaks → Appearance → Legacy Applications / Shell.

## Enabled extensions (17)

Listed in `config/dconf/enabled-extensions.txt` and `config/gnome-extensions/extensions.json`:

| Extension | UUID | Purpose |
|-----------|------|---------|
| Astra Monitor | `monitor@astraext.github.io` | CPU/GPU/RAM/disk/network in top bar |
| User Themes | `user-theme@gnome-shell-extensions.gcampax.github.com` | Custom shell themes |
| Blur my Shell | `blur-my-shell@aunetx` | Frosted-glass panel/dash blur |
| Burn My Windows | `burn-my-windows@schneegans.github.com` | Animated window close effects |
| Places Menu | `places-menu@...` | Classic places menu |
| Apps Menu | `apps-menu@...` | Classic apps menu |
| Compiz Wobbly | `compiz-windows-effect@hermes83.github.com` | Wobbly windows |
| Compiz Magic Lamp | `compiz-alike-magic-lamp-effect@...` | Minimize animation |
| Compact Quick Settings | `compact-quick-settings@...` | Smaller quick settings |
| Space Bar | `space-bar@luchrioh` | i3-style workspace indicator |
| GSConnect | `gsconnect@andyholmes.github.io` | Phone integration (certs not in repo) |
| Vitals | `Vitals@CoreCoding.com` | Hardware sensors |
| Live Lock Screen | `live-lockscreen@nick-redwill` | Video lock backgrounds |
| Ubuntu Dock | `ubuntu-dock@ubuntu.com` | macOS-style dock |
| Caffeine | `caffeine@patapon.info` | Keep screen awake |
| Move Clock | `Move_Clock@rmy.pobox.com` | Clock position |
| Tiling Assistant | `tiling-assistant@leleat-on-github` | Advanced window tiling |

Per-extension dconf settings: `config/dconf/shell-extensions-settings/*.dconf`

Burn My Windows profile: `config/burn-my-windows/profiles/1724659341932340.conf`

## Install extensions

```bash
chmod +x config/gnome-extensions/install-extensions.sh
./config/gnome-extensions/install-extensions.sh
```

For extensions.gnome.org items, use the browser + [GNOME Shell Integration](https://extensions.gnome.org/) extension when CLI install fails.

## Restore dconf

Apply all GNOME settings in one step:

```bash
chmod +x scripts/apply-gnome-config.sh
./scripts/apply-gnome-config.sh
```

This loads:

- `config/dconf/interface.dconf` — GTK, fonts, cursors
- `config/dconf/wm-preferences.dconf` — Mojave-Dark WM
- `config/dconf/mutter.dconf` — tiling, experimental features
- `config/dconf/keybindings.dconf`, `media-keys.dconf`
- `config/shortcuts/gnome-custom-keybindings.dconf` — Super+A/V/J/G/F
- `config/shortcuts/gnome-shell-keybindings.dconf` — Super+Z screenshot
- All `shell-extensions-settings/*.dconf`
- Enabled extension UUID list
- `config/file-managers/nemo.dconf`

### Manual dconf load

```bash
dconf load /org/gnome/desktop/interface/ < config/dconf/interface.dconf
dconf load /org/gnome/desktop/wm/preferences/ < config/dconf/wm-preferences.dconf
```

### Export current settings (backup)

```bash
dconf dump /org/gnome/desktop/interface/ > interface.dconf
dconf dump /org/gnome/shell/extensions/ > extensions.dconf
```

## Mutter / tiling

From `config/dconf/mutter.dconf`:

- `center-new-windows=true`
- `edge-tiling=false` (Tiling Assistant handles snapping)
- `experimental-features=['scale-monitor-framebuffer']`

## Dock favorites

Raw favorites list: `config/dconf/shell-favorites-raw.txt`

## After restore

1. Log out and back in (required on Wayland for extensions)
2. On X11, Alt+F2 → `r` restarts GNOME Shell
3. Verify themes in GNOME Tweaks
4. Re-pair GSConnect devices (pairing certs excluded from repo)

## Related docs

- [shortcuts-and-keybindings.md](shortcuts-and-keybindings.md)
- [config/shortcuts/RESTORE.md](../config/shortcuts/RESTORE.md)
- [config/file-managers/RESTORE.md](../config/file-managers/RESTORE.md)
