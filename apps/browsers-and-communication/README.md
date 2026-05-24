# Browsers & Communication

Web browsers, chat apps, email, and local file sharing.

**Default browser env:** `BROWSER="flatpak run app.zen_browser.zen"` (see dev-environment config)

---

## Web browsers

| Name | Package / ID | Source | What it is | Used for | Typical tasks |
|------|--------------|--------|------------|----------|---------------|
| **Zen Browser** | `app.zen_browser.zen` | Flatpak | Firefox-based privacy browser with vertical tabs | **Default browser** for daily browsing | Research, dev docs, vertical tab workflow |
| **Google Chrome** | `google-chrome-stable` | APT ([Chrome .deb](../../data/apt-third-party.sh)) | Chromium-based browser with Google sync | Sites requiring Chrome, DevTools, extensions-designated testing | Test web apps, use Chrome extensions |
| **Brave** | `com.brave.Browser` | Flatpak | Privacy-focused Chromium fork | Ad/tracker blocking, optional crypto wallet | Browse with shields up, import bookmarks |
| **Firefox** | `firefox` | APT (default Ubuntu) | Mozilla's open-source browser | Fallback browser, Firefox-only extensions | Developer edition workflows, privacy containers |
| **Chromium** | (via codecs) | APT extras | Open-source Chrome base | Secondary testing target | Verify site on Chromium engine |

---

## Chat & messaging

| Name | Package | Source | What it is | Used for | Typical tasks |
|------|---------|--------|------------|----------|---------------|
| **Discord** | `discord` | Snap | Voice/text chat for communities | Dev communities, gaming, screen share | Join servers, voice channels, share screen |
| **Telegram Desktop** | `telegram-desktop` | Snap | Cloud messaging client | Fast chats, channels, file sharing | Message contacts, download large files |
| **GSConnect** | GNOME extension | extensions.gnome.org | Phone integration via KDE Connect | SMS and notifications from Android | Reply to texts from desktop, sync clipboard |

---

## Email

| Name | Package | Source | What it is | Used for | Typical tasks |
|------|---------|--------|------------|----------|---------------|
| **Thunderbird** | `thunderbird` | APT / Snap | Mozilla email client | IMAP/POP mail, calendars | Manage multiple inboxes, filter rules |

---

## Local sharing & identity

| Name | Package / ID | Source | What it is | Used for | Typical tasks |
|------|--------------|--------|------------|----------|---------------|
| **LocalSend** | `org.localsend.localsend_app` | Flatpak | AirDrop-like LAN file transfer | Send files to phone/PC on same network | Drag files to nearby devices without cloud |
| **Identity** | `org.gnome.gitlab.YaLTeR.Identity` | Flatpak | Password/credential helper (GNOME ecosystem) | Complement Authenticator/Seahorse | Store app credentials |

---

## Browser-related dev tools

| Name | Package | Source | What it is | Used for | Typical tasks |
|------|---------|--------|------------|----------|---------------|
| **Live Server** | VS Code extension | Marketplace | Local dev server with live reload | Preview HTML/Blade in browser | Auto-refresh on save |
| **Five Server** | Cursor extension | Marketplace | Live reload dev server in Cursor | Same as Live Server for Cursor workflow | Serve static/Laravel public folder |

See [ide-extensions/](../ide-extensions/) for full extension lists.

---

## Communication shortcuts

| Action | Shortcut / launcher |
|--------|---------------------|
| Launch any app | Ulauncher `Super+A` |
| Open default browser | `$BROWSER` or Zen from app grid |
| Phone file transfer | GSConnect or LocalSend |

**Related config:** [`config/shortcuts/`](../../config/shortcuts/)
