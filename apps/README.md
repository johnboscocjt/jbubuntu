# Application & Extension Catalog

Human-readable reference for every application, CLI tool, GNOME extension, and IDE extension on this Ubuntu workstation. Machine-readable install manifests live in [`data/`](../data/); restored configs live in [`config/`](../config/).

Each category README uses a consistent entry format:

| Field | Description |
|-------|-------------|
| **Name** | Friendly display name |
| **Package / ID** | APT package, Snap name, Flatpak ID, or extension UUID |
| **Source** | How it was installed |
| **What it is** | One-line description |
| **Used for** | Primary role on this system |
| **Typical tasks** | Day-to-day actions |

---

## Category index

| Category | Highlights | Guide |
|----------|------------|-------|
| **Development** | Cursor, VS Code, Windsurf, JetBrains, Docker, Git, Bruno, build tools | [development/README.md](development/README.md) |
| **Databases & backend** | PostgreSQL, MariaDB, Redis, MongoDB, PHP stack, pgAdmin | [databases-and-backend/README.md](databases-and-backend/README.md) |
| **Networking & security** | Proton VPN, Wireshark, pentest tools, OpenVPN, AnyDesk | [networking-and-security/README.md](networking-and-security/README.md) |
| **Media & creative** | VLC, OBS, Audacity, Spotify, HandBrake, downloaders | [media-and-creative/README.md](media-and-creative/README.md) |
| **Productivity & office** | Obsidian, Typora, ONLYOFFICE, WPS, draw.io | [productivity-and-office/README.md](productivity-and-office/README.md) |
| **Browsers & communication** | Chrome, Zen, Brave, Discord, Telegram | [browsers-and-communication/README.md](browsers-and-communication/README.md) |
| **System & utilities** | Nala, htop, Flatseal, Nemo, Nautilus, boot-repair | [system-and-utilities/README.md](system-and-utilities/README.md) |
| **System services & databases** | Enabled systemd units, auto-cpufreq, ananicy, thermald | [system-services-and-databases/README.md](system-services-and-databases/README.md) |
| **Terminals & shell** | Kitty, Ghostty, Warp, zsh, Starship, Ulauncher | [terminals-and-shell/README.md](terminals-and-shell/README.md) |
| **Modern CLI tools** | lsd, bat, fastfetch, jq, optional fd/rg/fzf | [modern-cli-tools/README.md](modern-cli-tools/README.md) |
| **Dev environment & credentials** | NVM, Deno, Go, PHP, gh, git, Atuin, SSH, Seahorse | [dev-environment-and-credentials/README.md](dev-environment-and-credentials/README.md) |
| **GNOME extensions** | 17 enabled shell extensions with use cases | [gnome-extensions/README.md](gnome-extensions/README.md) |
| **IDE extensions** | VS Code (81), Cursor (39), Windsurf (2) | [ide-extensions/README.md](ide-extensions/README.md) |

---

## Quick lookup by install source

| Source | Manifest | Example apps |
|--------|----------|--------------|
| **APT** | [`data/apt-packages.txt`](../data/apt-packages.txt) | `code`, `cursor`, `docker-desktop`, `postgresql`, `nala` |
| **Snap** | [`data/snap-apps.txt`](../data/snap-apps.txt) | `discord`, `telegram-desktop`, `phpstorm`, `ghostty` |
| **Flatpak** | [`data/flatpak-apps.txt`](../data/flatpak-apps.txt) | `app.zen_browser.zen`, `com.brave.Browser`, `org.videolan.VLC` |
| **Manual /opt** | [`installs/opt-manifest.txt`](../installs/opt-manifest.txt) | Bruno, Obsidian, Postman, draw.io, auto-cpufreq |
| **Third-party APT** | [`data/apt-third-party.sh`](../data/apt-third-party.sh) | Chrome, Cursor, Warp, Docker, MongoDB, Proton VPN, Sublime |

---

## Related documentation

- Root setup and restore: [`../README.md`](../README.md) (when present)
- Dev environment restore: [`config/dev-environment/`](../config/dev-environment/)
- IDE settings & keybindings: [`config/ide/`](../config/ide/)
- GNOME extension configs: [`config/dconf/shell-extensions-settings/`](../config/dconf/shell-extensions-settings/)
- Shell & terminal dotfiles: [`dotfiles/`](../dotfiles/)
