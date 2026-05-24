# Dev Environment and Credentials

Runtimes, CLI auth tools, and secure credential restore. **No secrets are committed to this repo.**

## Runtime versions

Manifests in `config/dev-environment/runtimes/`:

| Runtime | Version | Install method |
|---------|---------|----------------|
| Node.js (NVM) | v24.15.0 | [nvm-sh/nvm](https://github.com/nvm-sh/nvm) |
| Deno | 2.6.8 | `curl -fsSL https://deno.land/install.sh \| sh` |
| Go | 1.26.0 | `sudo apt install golang-go` |
| PHP | 8.5.6 CLI (+ 8.3/8.4 FPM) | APT |
| Python | 3.14.4 | System + pip/pipx |
| pipx | pyqt5 | `pipx install pyqt5` |

### One-shot PATH setup

```bash
source config/dev-environment/env-paths.sh
```

Add that line to `~/.zshrc` after copying dotfiles.

### NVM restore

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
source ~/.nvm/nvm.sh
while read -r ver; do nvm install "$ver"; done < config/dev-environment/runtimes/nvm-versions.txt
nvm alias default "$(cat config/dev-environment/runtimes/node-default.txt)"
```

### Deno, Go, Python

```bash
# Deno
curl -fsSL https://deno.land/install.sh | sh

# Go (APT) — GOPATH=$HOME/go already in env-paths.sh
sudo apt install golang-go
mkdir -p ~/go/bin

# pipx packages
while read -r pkg; do pipx install "$pkg"; done < config/dev-environment/runtimes/pipx-packages.txt
```

## Git configuration

Copy sanitized config:

```bash
cp config/dev-environment/git/.gitconfig ~/.gitconfig
```

Highlights:

- User: **Jbtechnix - Mr. Humble Beginnings** / `johnboscocjt@gmail.com`
- Editor: `code --wait`
- Git LFS filters enabled
- GitHub HTTPS credentials via `gh auth git-credential`

## GitHub CLI (`gh`)

Config (no tokens): `config/dev-environment/gh/config.yml`

- Protocol: **https**
- Alias: `co` → `pr checkout`

### Auth restore

```bash
sudo apt install gh   # or from GitHub apt repo
gh auth login
# Choose: GitHub.com → HTTPS → Login with browser → johnboscocjt account
gh auth status
```

Full steps: [config/dev-environment/gh/RESTORE.md](../config/dev-environment/gh/RESTORE.md)

After login, `git push` over HTTPS works via the credential helper in `.gitconfig`.

## SSH and GPG

**Never committed:** private keys, `~/.ssh/id_*`, GPG secret keys, `~/.gnupg/private-keys-v2.d/`

Restore guide: [config/dev-environment/credentials/RESTORE.md](../config/dev-environment/credentials/RESTORE.md)

Summary:

1. Copy SSH public keys to GitHub → Settings → SSH keys (or generate new ed25519 key)
2. Import GPG public key; re-import secret key from secure backup (YubiKey, password manager export)
3. Configure `git commit.gpgsign` if used
4. Add keys to `ssh-agent` / GNOME Keyring (Seahorse)

## Atuin

Template: `config/dev-environment/atuin/config.toml.template` (sync tokens stripped)

```bash
cp config/dev-environment/atuin/config.toml.template ~/.config/atuin/config.toml
atuin login   # optional cloud sync
```

## Key storage apps

| App | Purpose | Restore |
|-----|---------|---------|
| Seahorse | GNOME Keyring | Automatic with login |
| Authenticator | 2FA TOTP | Flatpak — re-scan QR codes |
| VeraCrypt | Encrypted volumes | Remount with passwords |

## Docker Desktop

Installed under `/opt/docker-desktop`. Not backed up:

- `~/.docker/` credentials
- Images and containers

Re-install from Docker .deb, sign in to Docker Hub.

## What is NOT in this repo

- SSH/GPG private keys
- `~/.config/gh/hosts.yml` (auth token)
- Browser saved passwords
- GitHub Desktop OAuth token
- Database data files
- JetBrains licenses

## Related docs

- [shell-and-terminals.md](shell-and-terminals.md)
- [installation-and-removal/python-and-runtimes.md](installation-and-removal/python-and-runtimes.md)
- [system-services-and-databases.md](system-services-and-databases.md)
