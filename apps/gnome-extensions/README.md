# GNOME Shell Extensions

All enabled and notable installed GNOME Shell extensions on this workstation, with what each changes on the desktop and when to use it.

**Manifest:** [`config/gnome-extensions/extensions.json`](../../config/gnome-extensions/extensions.json) · **Enabled list:** [`config/dconf/enabled-extensions.txt`](../../config/dconf/enabled-extensions.txt) · **Per-extension dconf:** [`config/dconf/shell-extensions-settings/`](../../config/dconf/shell-extensions-settings/)

---

## Enabled extensions (17)

| Name | UUID | Source | What it is | Used for | Typical tasks |
|------|------|--------|------------|----------|---------------|
| **Astra Monitor** | `monitor@astraext.github.io` | GitHub | Top-bar system monitor | Live CPU/GPU/RAM/disk/network stats | Watch usage during builds; spot thermal throttling |
| **User Themes** | `user-theme@gnome-shell-extensions.gcampax.github.com` | APT | Shell theme loader | Apply custom GNOME Shell themes (e.g. Mojave-Dark) | Enable third-party shell themes in Tweaks |
| **Blur My Shell** | `blur-my-shell@aunetx` | extensions.gnome.org | Panel/dash/overview blur | Frosted-glass aesthetic on UI chrome | Blur top panel, overview, lock screen |
| **Burn My Windows** | `burn-my-windows@schneegans.github.com` | GitHub | Animated window close effects | Visual flair when closing/minimizing windows | Active animation profile in [`config/burn-my-windows/`](../../config/burn-my-windows/) |
| **Places Menu** | `places-menu@gnome-shell-extensions.gcampax.github.com` | APT | Classic Places menu in panel | Quick access to Home, Documents, Downloads | Open common folders from top bar |
| **Applications Menu** | `apps-menu@gnome-shell-extensions.gcampax.github.com` | APT | Classic Applications menu | Traditional app launcher in panel | Browse apps by category |
| **Compiz Wobbly Windows** | `compiz-windows-effect@hermes83.github.com` | extensions.gnome.org | Wobbly window drag effect | Nostalgic Compiz-style window physics | Drag windows with elastic deformation |
| **Compiz Magic Lamp** | `compiz-alike-magic-lamp-effect@hermes83.github.com` | extensions.gnome.org | Magic-lamp minimize animation | Animated minimize to dock | Minimize with genie effect |
| **Compact Quick Settings** | `compact-quick-settings@gnome-shell-extensions.mariospr.org` | extensions.gnome.org | Denser quick settings panel | More toggles visible without scrolling | WiFi, Bluetooth, power in compact layout |
| **Space Bar** | `space-bar@luchrioh` | extensions.gnome.org | i3-style workspace indicator | Named workspaces in top panel | Switch workspaces, see active space |
| **GSConnect** | `gsconnect@andyholmes.github.io` | extensions.gnome.org | KDE Connect for GNOME | Phone integration (notifications, SMS, files) | Send files to Android, sync clipboard |
| **Vitals** | `Vitals@CoreCoding.com` | GitHub | Hardware sensor readout | Temperature, fan speed, voltage in panel | Monitor thermals; complement Astra Monitor |
| **Live Lock Screen** | `live-lockscreen@nick-redwill` | GitHub | Video/image lock screen backgrounds | Animated lock screen | Set video wallpaper on lock |
| **Ubuntu Dock** | `ubuntu-dock@ubuntu.com` | APT | macOS-style dock | App launching and window switching | Pin Nemo, Cursor, Kitty; autohide dock |
| **Caffeine** | `caffeine@patapon.info` | GitHub | Screen sleep inhibitor | Keep display awake during presentations/long builds | Toggle coffee icon before `npm run build` |
| **Frippery Move Clock** | `Move_Clock@rmy.pobox.com` | extensions.gnome.org | Reposition clock in panel | Clock next to system menu | Align clock with custom panel layout |
| **Tiling Assistant** | `tiling-assistant@leleat-on-github` | GitHub | Advanced window tiling | Windows-style snap assist + expanded tiling | Snap to quarters, keyboard tile, popup assist |

---

## Extensions with exported settings

These have dedicated dconf backups in the repo:

| Extension | Config file |
|-----------|-------------|
| Astra Monitor | [`astra-monitor.dconf`](../../config/dconf/shell-extensions-settings/astra-monitor.dconf) |
| Blur My Shell | [`blur-my-shell.dconf`](../../config/dconf/shell-extensions-settings/blur-my-shell.dconf) |
| Burn My Windows | [`burn-my-windows.dconf`](../../config/dconf/shell-extensions-settings/burn-my-windows.dconf) + profile conf |
| Caffeine | [`caffeine.dconf`](../../config/dconf/shell-extensions-settings/caffeine.dconf) |
| GSConnect | [`gsconnect.dconf`](../../config/dconf/shell-extensions-settings/gsconnect.dconf) |
| Space Bar | [`space-bar.dconf`](../../config/dconf/shell-extensions-settings/space-bar.dconf) |
| Tiling Assistant | [`tiling-assistant.dconf`](../../config/dconf/shell-extensions-settings/tiling-assistant.dconf) |

---

## Installed but disabled

| Name | UUID | Source | What it is | Why disabled | When to enable |
|------|------|--------|------------|--------------|----------------|
| **Coverflow Alt-Tab** | `CoverflowAltTab@palatis.blogspot.com` | GitHub | 3D cover-flow Alt+Tab switcher | Conflicts with workflow / performance | Enable for visual Alt+Tab on demo machines |
| **Hide Top Bar** | `hidetopbar@mathieu.bidon.ca` | extensions.gnome.org | Auto-hide top panel | Prefer always-visible panel + Astra Monitor | Enable for immersive fullscreen browsing |

Other disabled UUIDs in [`config/dconf/disabled-extensions.txt`](../../config/dconf/disabled-extensions.txt) include stock Ubuntu extensions replaced by custom setup (duplicate docks, alternate tiling, etc.).

---

## Extension management tools

| Name | Package | Source | What it is | Used for | Typical tasks |
|------|---------|--------|------------|----------|---------------|
| **Extension Manager** | `gnome-shell-extension-manager` | APT | GUI for extensions | Install/update/toggle extensions | Browse extensions.gnome.org in-app |
| **chrome-gnome-shell** | `chrome-gnome-shell` | APT | Browser connector | Install from extensions.gnome.org website | Click "Install" on EGO pages |
| **gnome-shell-extensions** | `gnome-shell-extensions` | APT | Official extension pack | Base packages (apps-menu, user-theme, etc.) | APT dependency for stock extensions |

---

## Restore on new PC

```bash
# Install base packages
sudo apt install gnome-shell-extension-manager gnome-shell-extensions chrome-gnome-shell

# Enable extensions from manifest (after copying to ~/.local/share/gnome-shell/extensions/)
gnome-extensions enable blur-my-shell@aunetx
# ... repeat for each UUID in enabled-extensions.txt

# Import dconf settings
dconf load /org/gnome/shell/extensions/ < config/dconf/shell-extensions-settings/*.dconf
```

Run `setup.sh` GNOME extension phase when available, or use Extension Manager to install from URLs in [`extensions.json`](../../config/gnome-extensions/extensions.json).

---

## Desktop workflow summary

| Need | Extension(s) |
|------|--------------|
| macOS-like dock + workspaces | Ubuntu Dock, Space Bar |
| Window tiling beyond 2-column | Tiling Assistant |
| System stats in panel | Astra Monitor, Vitals |
| Phone sync | GSConnect |
| Visual polish | Blur My Shell, Burn My Windows, Compiz effects |
| Long builds / presentations | Caffeine |
| Classic GNOME menus | Apps Menu, Places Menu |
