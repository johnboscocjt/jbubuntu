# Media & Creative

Audio/video playback, recording, editing, streaming, and download tools.

**Install manifests:** [`data/apt-packages.txt`](../../data/apt-packages.txt), [`data/flatpak-apps.txt`](../../data/flatpak-apps.txt)

---

## Media players

| Name | Package / ID | Source | What it is | Used for | Typical tasks |
|------|--------------|--------|------------|----------|---------------|
| **VLC** | `org.videolan.VLC` | Flatpak | Universal media player | Play any video/audio format locally | Open MKV/MP4, stream URLs, adjust subtitles |
| **Spotify** | `com.spotify.Client` | Flatpak | Music streaming client | Background music while coding | Playlists, offline downloads (Premium) |
| **cmus** | `cmus` | APT | Terminal music player | Lightweight music in SSH/terminal sessions | Queue tracks, keyboard-driven playback |
| **Mousai** | `io.github.seadve.Mousai` | Flatpak | Shazam-like song identifier | Identify playing music | Recognize songs from microphone |
| **Clapgrep** | `de.leopoldluley.Clapgrep` | Flatpak | Audio search / recognition utility | Find songs or audio clips | Search audio libraries |

---

## Recording & streaming

| Name | Package / ID | Source | What it is | Used for | Typical tasks |
|------|--------------|--------|------------|----------|---------------|
| **OBS Studio** | `com.obsproject.Studio` | Flatpak | Screen capture and live streaming | Record tutorials, stream gameplay or demos | Set up scenes, capture display + mic |
| **Vysor** | `/opt/Vysor` | Manual `/opt/` | Android screen mirroring | Demo mobile apps on desktop | Mirror phone screen over USB/WiFi |
| **EasyEffects** | `com.github.wwmm.easyeffects` | Flatpak | PipeWire audio effects | EQ, noise suppression for mic/headphones | Tune mic for calls and recordings |
| **Pavucontrol** | `pavucontrol` | APT | PulseAudio/PipeWire volume control | Per-app audio routing | Route Discord to headphones, mute inputs |

---

## Audio & video editing

| Name | Package / ID | Source | What it is | Used for | Typical tasks |
|------|--------------|--------|------------|----------|---------------|
| **Audacity** | `org.audacityteam.Audacity` | Flatpak | Multi-track audio editor | Podcast editing, noise removal, trimming | Cut clips, normalize levels, export MP3 |
| **HandBrake** | `fr.handbrake.ghb` | Flatpak | Video transcoder | Compress video, convert formats | Rip DVDs, encode H.264/H.265 |
| **FFmpeg** | `ffmpeg` | APT | Command-line AV Swiss army knife | Scriptable encode/decode/merge | `ffmpeg -i input.mp4`, extract audio, concat |
| **Impression** | `io.gitlab.adhami3310.Impression` | Flatpak | PDF presentation tool | Present PDF slides fullscreen | Slide-show mode for exported decks |

---

## Downloaders & torrents

| Name | Package / ID | Source | What it is | Used for | Typical tasks |
|------|--------------|--------|------------|----------|---------------|
| **4K Video Downloader Plus** | `4kvideodownloaderplus` | APT | YouTube and video site downloader | Save videos/playlists locally | Download 1080p/4K from supported sites |
| **Free Download Manager** | `/opt/freedownloadmanager` | Manual `/opt/` | Multi-protocol download accelerator | Large file downloads with resume | Queue downloads, browser integration |
| **Video Downloader** | `com.github.unrud.VideoDownloader` | Flatpak | Simple web video downloader | Grab videos from supported pages | Paste URL, choose quality |
| **Tubefeeder** | `de.schmidhuberj.tubefeeder` | Flatpak | YouTube subscription client without Google account | Privacy-focused YouTube browsing | Watch subscriptions via RSS-style feed |
| **Transmission GUI** | `transgui` | APT | Graphical front-end for Transmission | BitTorrent downloads with GUI | Add `.torrent` files, monitor progress |
| **FreeTube** | `freetube` | Snap | Privacy-focused YouTube client | Watch YouTube without Google login | Subscriptions, no tracking |

---

## Image, PDF & document viewers

| Name | Package / ID | Source | What it is | Used for | Typical tasks |
|------|--------------|--------|------------|----------|---------------|
| **Okular** | `org.kde.okular` | Flatpak | Document viewer (PDF, EPUB, etc.) | Read PDFs and ebooks | Annotate PDFs, multi-format viewing |
| **Evince** | `org.gnome.Evince` | Flatpak | GNOME PDF viewer | Quick PDF reading | Open PDF attachments |
| **Converseen** | `net.fasterland.converseen` | Flatpak | Batch image converter | Resize/convert many images at once | Bulk PNG→JPEG, resize icons |
| **Frog** | `com.github.tenderowl.frog` | Flatpak | Image extraction from PDFs | Pull images out of PDF documents | Export embedded images |
| **Metadata Cleaner** | `metadata-cleaner` | Snap | Strip EXIF/metadata from files | Privacy before sharing photos | Remove GPS/camera data from images |

---

## Fonts & codecs

| Name | Package | Source | What it is | Used for | Typical tasks |
|------|---------|--------|------------|----------|---------------|
| **JetBrains Mono** | `fonts-jetbrains-mono` | APT | Developer monospace font | Code and terminal readability | Set as terminal/IDE font |
| **Ubuntu Restricted Extras** | `ubuntu-restricted-extras` | APT | Codecs and fonts (MP3, etc.) | Play proprietary media formats | Enable MP3/DVD playback out of the box |
| **Chromium FFmpeg Extra** | `chromium-codecs-ffmpeg-extra` | APT | Additional browser media codecs | H.264/AAC in Chromium-based apps | Stream video in browser without errors |

---

## Screen mirroring & phone tools

| Name | Package | Source | What it is | Used for | Typical tasks |
|------|---------|--------|------------|----------|---------------|
| **GSConnect** | GNOME extension | extensions.gnome.org | KDE Connect for GNOME | Phone notifications, file transfer, SMS | Send files phone↔PC, sync clipboard |

See [gnome-extensions/README.md](../gnome-extensions/README.md) for GSConnect details.
