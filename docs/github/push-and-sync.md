# Push & sync — all scenarios

How to push changes, add new folders, and keep local and remote in sync **without force push**.

---

## Scenario A: You already have a local repo (like `jbubuntu`)

This is your normal day-to-day workflow.

### Add a new folder and push (safe — no force push)

```bash
cd ~/jbubuntu   # or any existing repo

# 1. Create your folder and files
mkdir -p docs/my-new-topic
echo "# My topic" > docs/my-new-topic/README.md

# 2. Stage and commit
git add docs/my-new-topic/
git commit -m "Add docs/my-new-topic guide"

# 3. Pull remote changes FIRST (avoids rejected push)
git pull --rebase origin main

# 4. Push
git push origin main
```

**Why pull first?** If someone else (or you from another PC) pushed to GitHub since your last pull, Git refuses your push until you integrate their commits. Pulling first merges or rebases their work into yours — then push succeeds normally.

### Daily sync between two machines (home PC ↔ laptop)

**On machine A (after you commit locally):**
```bash
git push origin main
```

**On machine B (before you start work):**
```bash
git pull origin main
```

**On machine B (after you commit):**
```bash
git push origin main
```

**Rule:** Always **pull before push** when switching machines.

### Check if local is ahead or behind remote

```bash
git fetch origin
git status
# "Your branch is ahead of 'origin/main' by 2 commits"  → push
# "Your branch is behind 'origin/main' by 3 commits"   → pull
# "have diverged"                                       → pull --rebase, then push
```

### Visual sync diagram

```
Remote (GitHub)     Local
    A ─── B ─── C       A ─── B ─── C     ← in sync

    A ─── B ─── C ─── D                   ← remote ahead → git pull
    A ─── B ─── C       A ─── B ─── C ─── E   ← local ahead → git push
    A ─── B ─── D       A ─── B ─── C ─── E   ← diverged → pull --rebase, then push
```

---

## Scenario B: You do NOT have a local repo — start from GitHub

### B1: Clone an existing repo, add a folder, push

```bash
git clone https://github.com/johnboscocjt/jbubuntu.git
cd jbubuntu

mkdir -p docs/github/extra
echo "content" > docs/github/extra/note.md

git add docs/github/extra/
git commit -m "Add extra note"
git push origin main
```

No force push needed — you cloned the latest state first.

### B2: You have local files but no git yet — connect to existing GitHub repo

```bash
cd ~/my-local-project
git init
git add .
git commit -m "Initial local commit"

# Connect to existing remote (repo already on GitHub)
git remote add origin https://github.com/johnboscocjt/my-repo.git
git fetch origin

# IMPORTANT: integrate remote history before pushing
git pull origin main --allow-unrelated-histories
# resolve conflicts if any, then:
git push -u origin main
```

Use `--allow-unrelated-histories` only when local and remote were created independently.

### B3: Brand new project — create repo and first push

```bash
mkdir ~/my-new-project && cd ~/my-new-project
git init
echo "# My Project" > README.md
git add .
git commit -m "Initial commit"

# Option 1: GitHub CLI (easiest)
gh repo create johnboscocjt/my-new-project --public --source=. --remote=origin --push

# Option 2: Manual
# Create empty repo on github.com first, then:
git remote add origin https://github.com/johnboscocjt/my-new-project.git
git branch -M main
git push -u origin main
```

---

## Scenario C: Push rejected — what to do (NOT force push)

```bash
git push origin main
# ! [rejected] main -> main (fetch first)
```

**Fix:**
```bash
git pull --rebase origin main
# fix conflicts if prompted (see conflicts.md)
git push origin main
```

### When is force push actually OK?

| Situation | OK to force push? |
|-----------|-------------------|
| Feature branch only you use | Sometimes (`git push --force-with-lease`) |
| Shared `main` branch | **Never** (use revert or new commit instead) |
| You amended a commit not yet shared | Yes, on your branch only |
| Public open-source repo | **Avoid** — breaks contributors |

**Safer alternative to force push on main:** make a new commit that undoes the mistake:
```bash
git revert HEAD        # creates undo commit
git push origin main   # no force needed
```

Use `--force-with-lease` instead of `--force` if you must rewrite a branch — it fails if someone else pushed meanwhile.

---

## Scenario D: Add folder via GitHub Desktop (Flatpak)

1. Open GitHub Desktop → clone or open existing repo
2. Create folder/files in your file manager (Nemo)
3. GitHub Desktop shows changed files → write commit message → **Commit to main**
4. Click **Push origin**
5. If push fails → **Fetch origin** → **Pull origin** → resolve conflicts → Push again

Same rules: pull before push when remote has new commits.

---

## Scenario E: Push a new branch (recommended for features)

```bash
git checkout -b add-github-docs
mkdir -p docs/github
# ... edit files ...
git add docs/github/
git commit -m "Add GitHub workflow documentation"
git push -u origin add-github-docs

gh pr create --title "Add GitHub docs" --body "Workflow guide for push, sync, PRs"
```

This never touches `main` directly — safest for collaboration.

---

## Sync commands compared

| Command | What it does |
|---------|--------------|
| `git fetch` | Download remote commits; **does not** change your files |
| `git pull` | Fetch + merge into current branch |
| `git pull --rebase` | Fetch + replay your commits on top of remote (cleaner history) |
| `git push` | Upload your commits to remote |
| `git push -u origin branch` | Push and set upstream tracking |

### Recommended habit

```bash
git fetch origin && git status   # check before every push
git pull --rebase origin main    # sync
git push origin main             # upload
```
