# Git Clone → Build → Install

Repeatable pattern for tools installed from source (not APT/Snap/Flatpak).

## Standard workflow

```bash
# 1. Clone to canonical location
git clone https://github.com/user/project.git ~/src/github/project
cd ~/src/github/project

# 2. Checkout pinned version (recommended)
git checkout v1.2.3

# 3. Build / install (pick one pattern below)

# Makefile
make
sudo make install          # → /usr/local/bin

# Python venv in /opt
sudo python3 -m venv /opt/project/venv
sudo /opt/project/venv/bin/pip install -r requirements.txt

# Node global (via nvm)
npm install -g .

# Go
go install ./cmd/tool@latest   # → ~/go/bin/

# Cargo
cargo install --path .

# 4. Desktop entry (optional)
cp ~/jbubuntu/installs/templates/appimage.desktop.template \
   ~/.local/share/applications/project.desktop
# Set Exec= to full binary path

# 5. systemd service (optional)
sudo cp project.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable --now project
```

## Examples on this system

| Tool | Location | Notes |
|------|----------|-------|
| auto-cpufreq | `/opt/auto-cpufreq` | See `config/system-services/performance/auto-cpufreq-install.sh` |
| jshortcuts | `~/bin/jshortcuts` | Separate repo; linked from Super+J |
| GNOME extensions | `~/.local/share/gnome-shell/extensions/<uuid>/` | `install-extensions.sh` |
| zsh-autocomplete | `~/zsh-autocomplete/` | Sourced from `.zshrc` |

## Update later

```bash
cd ~/src/github/project
git pull
make && sudo make install
# or re-run vendor install script
```

## Uninstall

```bash
sudo make uninstall          # if supported
sudo rm -rf /opt/project
rm ~/go/bin/tool
pipx uninstall tool
```

## Document new installs

Add directory name to `installs/opt-manifest.txt` and note in `docs/manual-installs.md`.

## Related

- [../README.md](../README.md)
- [../../docs/installation-and-removal/by-format.md](../../docs/installation-and-removal/by-format.md)
