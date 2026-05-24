# Productivity & Office

Notes, knowledge management, office suites, diagrams, launchers, and password tools.

---

## Notes & knowledge management

| Name | Package | Source | What it is | Used for | Typical tasks |
|------|---------|--------|------------|----------|---------------|
| **Obsidian** | `/opt/Obsidian` | Manual `/opt/` | Markdown-based knowledge base with graph view | Personal wiki, project notes, linked thinking | Daily notes, backlinks, plugin workflows |
| **Typora** | `typora` | APT | WYSIWYG Markdown editor | Clean writing without preview split | Write docs, export to PDF/HTML |
| **Notes (Snap)** | `notes` | Snap | Simple note-taking app | Quick scratch notes | Jot reminders, short lists |

**Related config:** [`config/obsidian/obsidian.json`](../../config/obsidian/obsidian.json)

---

## Office suites & documents

| Name | Package / ID | Source | What it is | Used for | Typical tasks |
|------|--------------|--------|------------|----------|---------------|
| **ONLYOFFICE** | `org.onlyoffice.desktopeditors` | Flatpak | MS Office-compatible suite | Edit `.docx`, `.xlsx`, `.pptx` locally | Open Word/Excel files, collaborate offline |
| **WPS Office** | `wps-office` + `/opt/kingsoft` | APT + `/opt/` | Lightweight Office alternative | Compatibility with Chinese/MS formats | Spreadsheets, presentations, PDF export |
| **Evince** | `org.gnome.Evince` | Flatpak | PDF viewer | Read PDFs without full office suite | Open invoices, manuals |

---

## Diagrams & visual planning

| Name | Package | Source | What it is | Used for | Typical tasks |
|------|---------|--------|------------|----------|---------------|
| **draw.io (diagrams.net)** | `draw.io` + `/opt/drawio` | APT + `/opt/` | Diagram and flowchart editor | Architecture diagrams, ERDs, wireframes | Export PNG/SVG, save to Google Drive or local |
| **Mermaid (VS Code)** | VS Code extensions | Marketplace | Text-to-diagram in Markdown | Docs with embedded diagrams | Write ` ```mermaid ` blocks in README files |

---

## Calculators & utilities

| Name | Package | Source | What it is | Used for | Typical tasks |
|------|---------|--------|------------|----------|---------------|
| **Qalculate** | `qalculate` | Snap | Advanced calculator | Unit conversion, scientific calculations | Currency convert, solve expressions |
| **DevToolbox** | `me.iepure.devtoolbox` | Flatpak | Developer utility collection | Encoding, hashing, regex helpers | Base64 encode, UUID generate, JSON format |

---

## Launchers & docks

| Name | Package | Source | What it is | Used for | Typical tasks |
|------|---------|--------|------------|----------|---------------|
| **Ulauncher** | `ulauncher` | APT | Application launcher (Alt/ Super+A) | Fast app and file search | `Super+A` → type app name, run scripts |
| **Plank** | `plank` | APT | Lightweight dock | Secondary dock or testing | Pin favorites, auto-hide dock |

**Related config:** [`config/shortcuts/ulauncher-shortcuts.json`](../../config/shortcuts/ulauncher-shortcuts.json)

---

## Passwords & 2FA

| Name | Package / ID | Source | What it is | Used for | Typical tasks |
|------|--------------|--------|------------|----------|---------------|
| **Authenticator** | `com.belmoussaoui.Authenticator` | Flatpak | TOTP/HOTP 2FA code generator | GitHub, cloud service 2FA | Scan QR codes, copy 6-digit tokens |
| **Seahorse** | `seahorse` | APT | GNOME Passwords and Keys | Store SSH/GPG/app passwords in keyring | Manage login keyring, import certificates |

See [dev-environment-and-credentials/README.md](../dev-environment-and-credentials/README.md) for SSH, GPG, and gh credential setup.

---

## File conversion & cleanup

| Name | Package / ID | Source | What it is | Used for | Typical tasks |
|------|--------------|--------|------------|----------|---------------|
| **Converter** | `io.gitlab.adhami3310.Converter` | Flatpak | Unit and format converter | Quick conversions without web | Convert units, currencies |
| **BleachBit** | `org.bleachbit.BleachBit` | Flatpak | System cleaner | Free disk space, clear caches | Wipe temp files, browser cache |
| **Czkawka** | `com.github.qarmin.czkawka` | Flatpak | Duplicate file finder | Reclaim space from duplicate media | Scan home directory for dupes |
