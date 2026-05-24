# SSH, GPG, and Keyring Restore

**Security rule:** Private keys, GPG secret keys, and keyring databases are **never** committed to jbubuntu.

## SSH keys

### Generate new key (recommended for new machine)

```bash
ssh-keygen -t ed25519 -C "johnboscocjt@gmail.com" -f ~/.ssh/id_ed25519
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
```

### Add to GitHub

Copy public key:

```bash
cat ~/.ssh/id_ed25519.pub
```

Add at: https://github.com/settings/keys

Or via gh:

```bash
gh ssh-key add ~/.ssh/id_ed25519.pub --title "jbubuntu-$(hostname)"
```

### Restore from secure backup

If migrating keys from encrypted backup (USB, password manager export):

```bash
chmod 700 ~/.ssh
chmod 600 ~/.ssh/id_ed25519
chmod 644 ~/.ssh/id_ed25519.pub
```

Optional `~/.ssh/config` template structure (no private keys in repo):

```
Host github.com
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_ed25519
  IdentitiesOnly yes
```

### Test

```bash
ssh -T git@github.com
```

## GPG keys

### List existing (after restore)

```bash
gpg --list-secret-keys --keyid-format=long
```

### Import from backup

```bash
gpg --import private-key.asc    # from secure offline backup only
gpg --import public-key.asc
```

### Configure git signing

```bash
git config --global user.signingkey YOUR_KEY_ID
git config --global commit.gpgsign true
export GPG_TTY=$(tty)
```

### GitHub signed commits

Export public key and add at https://github.com/settings/gpg/new

```bash
gpg --armor --export YOUR_KEY_ID
```

## GNOME Keyring (Seahorse)

- Created automatically on first login
- Stores WiFi passwords, app passwords, some cert imports
- **Not portable** — re-enter passwords on new machine

Launch: `seahorse` or **Passwords and Keys**

## Authenticator (2FA)

Flatpak: `com.belmoussaoui.Authenticator`

Re-scan QR codes from each service (GitHub, cloud providers) — backup codes should be stored separately in a password manager.

## GitHub CLI tokens

Stored in `~/.config/gh/hosts.yml` after `gh auth login` — see [../gh/RESTORE.md](../gh/RESTORE.md).

## GitHub Desktop OAuth

Flatpak sandbox — re-login in app. See [../../github-desktop/README-restore.md](../../github-desktop/README-restore.md).

## What to back up securely (outside git)

| Item | Suggested storage |
|------|-------------------|
| SSH private keys | Encrypted USB, password manager |
| GPG secret key | Offline backup + passphrase in password manager |
| 2FA backup codes | Password manager |
| GitHub recovery codes | Password manager |
| Database root passwords | Password manager |

## Related

- [../gh/RESTORE.md](../gh/RESTORE.md)
- [../../docs/dev-environment-and-credentials.md](../../docs/dev-environment-and-credentials.md)
