# CI/CD basics with GitHub Actions

Continuous Integration (CI) runs automated checks on every push and PR. Continuous Deployment (CD) can deploy automatically when checks pass.

---

## What is CI/CD?

| Term | Meaning |
|------|---------|
| **CI** | Automatically **build and test** code on each push/PR |
| **CD** | Automatically **deploy** when CI passes (optional) |

For `jbubuntu`, CI might:
- Validate `setup.sh` syntax (`bash -n setup.sh`)
- Check markdown links
- Lint shell scripts
- Verify manifest files exist

---

## Minimal GitHub Actions workflow

Create `.github/workflows/ci.yml`:

```yaml
name: CI

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  validate:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Validate setup.sh syntax
        run: bash -n setup.sh

      - name: Validate helper scripts
        run: |
          for s in scripts/*.sh installs/*.sh; do
            bash -n "$s"
          done

      - name: Check required manifests exist
        run: |
          test -f data/apt-packages.txt
          test -f data/flatpak-apps.txt
          test -f data/snap-apps.txt
          test -f README.md
```

Every push and PR to `main` runs these checks. Red ❌ = fix before merge.

---

## Protect main with required checks

**Settings → Branches → Branch protection → Require status checks:**

- Select `validate` (or your job name)
- PRs cannot merge until CI passes

This blocks broken `setup.sh` from entering `main`.

---

## Common workflow triggers

```yaml
on:
  push:
    branches: [main, 'feature/**']
  pull_request:
    branches: [main]
  schedule:
    - cron: '0 6 * * 1'   # weekly Monday 6am UTC
  workflow_dispatch:       # manual run button
```

---

## Secrets in CI

Never hardcode tokens in workflow files. Use:

**Settings → Secrets and variables → Actions → New repository secret**

```yaml
- name: Deploy
  env:
    API_TOKEN: ${{ secrets.API_TOKEN }}
  run: ./deploy.sh
```

---

## Useful Actions marketplace examples

| Action | Purpose |
|--------|---------|
| `actions/checkout@v4` | Clone repo in runner |
| `actions/setup-node@v4` | Node.js for JS projects |
| `docker/build-push-action` | Build Docker images |
| `softprops/action-appleboy-ssh-action` | SSH deploy |

For jbubuntu (bash-focused), shell validation is enough to start.

---

## CD example (deploy docs site — optional)

```yaml
name: Deploy docs

on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/main'
    steps:
      - uses: actions/checkout@v4
      - name: Deploy to GitHub Pages
        uses: peaceiris/actions-gh-pages@v4
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./docs
```

Enable GitHub Pages in repo settings if you want hosted docs.

---

## View CI results

```bash
gh run list
gh run view RUN_ID
gh pr checks 42
```

Or: GitHub repo → **Actions** tab.

---

## CI/CD checklist for new public repos

- [ ] Add `.github/workflows/ci.yml`
- [ ] Require status checks on `main`
- [ ] Block force push on `main`
- [ ] Require PR before merge
- [ ] Add `LICENSE` (MIT for jbubuntu)
- [ ] Add `CONTRIBUTING.md` (optional)
- [ ] Enable Dependabot alerts
- [ ] Never commit secrets

---

## Related tools

| Tool | Role |
|------|------|
| **GitHub Actions** | Built-in CI/CD (free tier for public repos) |
| **Dependabot** | Auto PRs for dependency updates |
| **CodeQL** | Security scanning (free for public repos) |
| **Branch protection** | Gate merges on CI + reviews |

See [open-source-workflow.md](open-source-workflow.md) for branch protection setup.
