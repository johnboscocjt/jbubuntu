# Merge conflicts — causes and fixes

## What causes a conflict?

A conflict happens when **Git cannot automatically merge two changes to the same lines** in the same file.

Common causes:

| Cause | Example |
|-------|---------|
| **Two people edit the same file** | You edit `README.md` line 10; someone else edits line 10 on GitHub |
| **Two machines, no sync** | Edit on laptop, edit on desktop, push from both without pulling |
| **Pull after long gap** | Remote moved forward; your local branch diverged |
| **Merge vs rebase collision** | Rebasing replays commits and hits the same overlapping edit |

Git marks conflicts like this inside the file:

```
<<<<<<< HEAD
Your local version
=======
Remote / incoming version
>>>>>>> origin/main
```

---

## How to resolve (step by step)

### 1. Pull and see conflicts

```bash
git pull origin main
# CONFLICT (content): Merge conflict in README.md
# Automatic merge failed; fix conflicts and then commit the result.
```

### 2. Open conflicted files

```bash
git status
# both modified: README.md
```

Edit the file — **delete** the `<<<<<<<`, `=======`, `>>>>>>>` markers and keep the correct content (or combine both versions).

### 3. Mark resolved and commit

```bash
git add README.md
git commit -m "Resolve merge conflict in README.md"
git push origin main
```

### 4. Using VS Code / Cursor

- Open the file — editor shows **Accept Current / Accept Incoming / Accept Both**
- Save → stage → commit → push

### 5. Abort if you want to start over

```bash
git merge --abort        # if you were merging
git rebase --abort       # if you were rebasing
```

---

## Prevent conflicts

1. **Pull often** — `git pull --rebase origin main` before starting work
2. **Work on separate files** when collaborating
3. **Use feature branches** — less collision on `main`
4. **Communicate** — "I'm editing setup.sh today"
5. **Small, frequent commits** — easier to merge than one giant change

---

## Merge vs rebase (when pulling)

| Strategy | Command | Result |
|----------|---------|--------|
| **Merge** | `git pull origin main` | Creates a merge commit; preserves full history |
| **Rebase** | `git pull --rebase origin main` | Linear history; replays your commits on top |

Both can cause conflicts — resolution is the same (edit file, add, continue).

After rebase conflict:
```bash
# fix files
git add .
git rebase --continue
git push origin main
```

---

## Conflict on a specific scenario: adding a new folder

Adding a **new folder** rarely causes conflicts (no overlapping lines). Conflicts usually happen when:

- You and remote both **modified the same existing file** (e.g. `README.md`, `setup.sh`)
- You both **renamed or deleted** the same path

**Safe pattern when adding folders:**
```bash
git pull --rebase origin main   # sync first
mkdir new-folder && git add new-folder/
git commit -m "Add new-folder"
git push origin main            # almost never conflicts
```

If push is rejected, it's because **remote has new commits** — not because of your new folder. Pull, then push.
