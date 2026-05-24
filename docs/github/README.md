# GitHub workflow guide

Practical Git and GitHub reference for **johnboscocjt** — push, sync, conflicts, open-source collaboration, branch protection, PRs, and CI/CD.

**Tools on this system:** `git`, `gh` (GitHub CLI), GitHub Desktop (Flatpak), VS Code / Cursor Git integration.

## Contents

| Guide | Topics |
|-------|--------|
| [Push & sync scenarios](push-and-sync.md) | First push, add a folder, local repo exists vs clone fresh, avoid force push |
| [Conflicts](conflicts.md) | What causes them, how to fix, merge vs rebase |
| [Open-source & repo security](open-source-workflow.md) | Branch protection, who can push, PR reviews, CODEOWNERS |
| [PRs, reviews & merging](pull-requests.md) | Create PR, request review, approve, merge strategies |
| [CI/CD basics](ci-cd.md) | GitHub Actions, status checks, protect main |

## Golden rules

1. **Never force-push to `main`** unless you are alone on the repo and know exactly why.
2. **Pull before you push** when working with others (or across two machines).
3. **Use branches + PRs** for anything non-trivial — not direct commits to `main`.
4. **Enable branch protection** on public repos so random people cannot push to `main`.
5. **Use `git pull --rebase`** on feature branches to keep history clean (optional but nice).

## Quick command cheat sheet

```bash
# Status
git status
git remote -v
git log --oneline -5

# Sync local with remote
git fetch origin
git pull origin main          # merge (default)
git pull --rebase origin main # rebase (cleaner)

# Push
git push origin main
git push -u origin my-branch  # first push of new branch

# New folder / files (safe path)
git add my-new-folder/
git commit -m "Add my-new-folder with docs"
git pull --rebase origin main   # get remote changes first
git push origin main

# GitHub CLI
gh auth login
gh repo create johnboscocjt/my-repo --public --source=. --push
gh pr create --title "Add feature" --body "Description"
gh pr merge --squash
```

See individual guides for every scenario in detail.
