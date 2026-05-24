# GitHub CLI (`gh`) Restore

Re-authenticate GitHub CLI on a new machine. Config is sanitized — **no tokens** in this repo.

## What is backed up

| File | Contents |
|------|----------|
| `config/dev-environment/gh/config.yml` | Aliases, https protocol, editor settings |
| `config/dev-environment/git/.gitconfig` | gh credential helper reference |

## What is NOT backed up

- `~/.config/gh/hosts.yml` — contains OAuth token
- SSH keys for `gh ssh` operations

## Install gh

```bash
sudo apt install gh
# or: type -p curl >/dev/null || sudo apt install curl -y
# curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
# echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list
# sudo apt update && sudo apt install gh
```

## Restore config

```bash
mkdir -p ~/.config/gh
cp config/dev-environment/gh/config.yml ~/.config/gh/config.yml
cp config/dev-environment/git/.gitconfig ~/.gitconfig
```

## Authenticate

```bash
gh auth login
```

Recommended choices for this setup:

1. **GitHub.com**
2. **HTTPS**
3. **Login with a web browser**
4. Complete OAuth as **johnboscocjt**

Verify:

```bash
gh auth status
gh repo list --limit 3
```

## Git credential helper

After `gh auth login`, HTTPS git operations use gh automatically:

```gitconfig
[credential "https://github.com"]
    helper = !/usr/bin/gh auth git-credential
```

Test:

```bash
git clone https://github.com/johnboscocjt/some-private-repo.git /tmp/test-clone
```

## SSH alternative

If you prefer SSH remotes:

```bash
gh auth login --git-protocol ssh
gh ssh-key add ~/.ssh/id_ed25519.pub --title "new-machine"
git remote set-url origin git@github.com:user/repo.git
```

## Logout / token refresh

```bash
gh auth logout
gh auth login
```

## Related

- [../../docs/dev-environment-and-credentials.md](../../docs/dev-environment-and-credentials.md)
- [../credentials/RESTORE.md](../credentials/RESTORE.md)
