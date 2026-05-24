# System & Utilities

Package management, monitoring, file managers, Flatpak control, system repair, and desktop utilities.

**File manager config:** [`config/file-managers/`](../../config/file-managers/)

---

## Package managers

| Name | Package | Source | What it is | Used for | Typical tasks |
|------|---------|--------|------------|----------|---------------|
| **Nala** | `nala` | APT | Modern frontend for `apt` | Cleaner install/remove output, history | `nala install pkg`, `nala history` |
| **Synaptic** | `synaptic` | APT | GUI package manager | Browse all APT packages visually | Search packages, fix broken deps |
| **Flatpak** | `flatpak` | APT | Universal Linux app sandbox | Install Flathub apps | `flatpak install flathub id` |
| **Snap Store / snapd** | `snapd` | APT | Canonical snap packaging | Install Discord, JetBrains snaps | `snap install`, `snap refresh` |
| **gdebi** | `gdebi` | APT | `.deb` installer GUI | Install standalone .deb files | Double-click vendor debs |
| **GNOME Software** | (desktop app) | Ubuntu default | App store front-end | Discover Flatpak/Snap/deb apps | Browse categories, updates |

---

## System monitoring

| Name | Package / ID | Source | What it is | Used for | Typical tasks |
|------|--------------|--------|------------|----------|---------------|
| **htop** | `htop` | APT | Interactive process viewer | CPU/RAM per process, kill stuck apps | Sort by CPU, send SIGTERM |
| **Mission Center** | `io.missioncenter.MissionCenter` | Flatpak | Modern system monitor GUI | GPU/CPU/RAM graphs | Watch thermals during builds |
| **Resources** | `net.nokyan.Resources` | Flatpak | Lightweight resource monitor | Per-app CPU/RAM/network | Identify resource hogs |
| **fastfetch** | `fastfetch` | APT | Neofetch-style system info | Terminal splash on shell open | Show OS, kernel, packages count |
| **neofetch** | `neofetch` | APT | ASCII art system info | Alternative to fastfetch | Screenshot-friendly system info |
| **Mousam** | `io.github.amit9838.mousam` | Flatpak | Weather app | Desktop weather glance | Check forecast |
| **Astra Monitor** | GNOME extension | GitHub | Top-bar hardware stats | Live CPU/GPU/RAM/network in panel | Monitor during compiles |

---

## File managers

| Name | Package | Source | What it is | Used for | Typical tasks |
|------|---------|--------|------------|----------|---------------|
| **Nemo** | `nemo`, `nemo-fileroller` | APT | Cinnamon-style file manager (**default**) | Daily file browsing, desktop icons, archive extract | Open folders, extract zip from context menu |
| **Nautilus** | `nautilus`, `nautilus-sendto` | APT | GNOME Files | GNOME search integration, send-to flows | Tree sidebar list view, GNOME app integration |

**Why Nemo is default:** Better desktop icons, dual-pane workflow, archive integration, pinned in dock.

**Captured settings:** [`config/file-managers/nemo.dconf`](../../config/file-managers/nemo.dconf)

| Setting | Value | Purpose |
|---------|-------|---------|
| Default folder handler | `nemo.desktop` | All directory opens use Nemo |
| Archive handlers | nemo-extract | Right-click extract |
| View | List, browser mode | Tabbed single window |
| Desktop icons | Enabled | Shortcuts on desktop |

---

## Flatpak management

| Name | Package / ID | Source | What it is | Used for | Typical tasks |
|------|--------------|--------|------------|----------|---------------|
| **Flatseal** | `com.github.tchx84.Flatseal` | Flatpak | Flatpak permission editor | Grant filesystem, device access to sandboxes | Allow VLC folder access, fix permission errors |
| **Gear Lever** | `it.mijorus.gearlever` | Flatpak | Manage Flatpak versions/branches | Switch app versions, cleanup | Roll back broken Flatpak updates |

---

## Disk, recovery & cleanup

| Name | Package / ID | Source | What it is | Used for | Typical tasks |
|------|---------|--------|------------|----------|---------------|
| **boot-repair** | `boot-repair` | APT | Bootloader repair tool | Fix GRUB after dual-boot issues | Reinstall GRUB, repair EFI |
| **TestDisk** | `testdisk` | APT | Partition and file recovery | Recover deleted partitions/files | Scan disk, undelete photos |
| **Baobab (Disk Usage)** | `baobab` | APT | Disk usage analyzer | Find large folders | Visual treemap of `/home` |
| **Czkawka** | `com.github.qarmin.czkawka` | Flatpak | Duplicate finder | Free disk space | Scan for duplicate images/videos |
| **BleachBit** | `org.bleachbit.BleachBit` | Flatpak | System cleaner | Clear caches safely | Wipe apt cache, browser data |

---

## Encryption & firmware

| Name | Package | Source | What it is | Used for | Typical tasks |
|------|---------|--------|------------|----------|---------------|
| **VeraCrypt** | `veracrypt` | APT | Encrypted volume manager | Sensitive file containers | Mount encrypted drives |
| **fwupd** | `fwupd`, `fwupd-signed` | APT | Firmware update daemon | BIOS, SSD, peripheral firmware | `fwupdmgr refresh`, install updates |

---

## GNOME & desktop tools

| Name | Package | Source | What it is | Used for | Typical tasks |
|------|---------|--------|------------|----------|---------------|
| **GNOME Extension Manager** | `gnome-shell-extension-manager` | APT | Install/manage shell extensions | Enable extensions from browser/EGO | Toggle extensions, update from GUI |
| **GNOME Shell Extensions** | `gnome-shell-extensions` | APT | Official extension pack | apps-menu, places-menu, user-theme | Base extensions from Ubuntu repos |
| **GDM Settings** | `gdm-settings` | APT | Login screen customization | Tweak GDM appearance | Change login theme/background |
| **chrome-gnome-shell** | `chrome-gnome-shell` | APT | Browser connector for EGO | Install extensions from extensions.gnome.org | One-click extension install |
| **gamemode** | `gamemode` | APT | CPU/GPU performance daemon | Boost performance for games/heavy apps | Auto-enable for Steam/proton titles |

---

## Miscellaneous utilities

| Name | Package / ID | Source | What it is | Used for | Typical tasks |
|------|--------------|--------|------------|----------|---------------|
| **Bazaar** | `io.github.kolunmi.Bazaar` | Flatpak | App store for GNOME | Discover new Flatpak apps | Browse curated apps |
| **Smile** | `it.mijorus.smile` | Flatpak | Emoji picker | Insert emoji anywhere | `Super+.` or app picker |
| **Collector** | `it.mijorus.collector` | Flatpak | Clipboard history manager | Multi-entry clipboard | Recall previous copies |
| **Actioneer** | `me.spaceinbox.actioneer` | Flatpak | Quick actions launcher | Shortcuts to common tasks | Run macros from panel |
| **Constrict** | `io.github.wartybix.Constrict` | Flatpak | Window aspect ratio tool | Force 16:9 for recordings | Resize windows for capture |
| **USB Creator** | `usb-creator-gtk` | APT | Bootable USB maker | Create Ubuntu live USB | Flash ISO to thumb drive |
| **Wine / Winetricks** | `wine`, `winetricks` | APT | Windows compatibility layer | Run occasional Windows apps | Install Windows software in prefix |
