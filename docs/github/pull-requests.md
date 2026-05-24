# Pull requests, reviews & merging

## Create a PR (command line)

```bash
git checkout -b feature/add-docs
# make changes, commit
git push -u origin feature/add-docs

gh pr create \
  --title "Add GitHub workflow docs" \
  --body "## Summary
- Push and sync guide
- Conflict resolution
- Branch protection

## Test plan
- [ ] Markdown renders on GitHub
- [ ] Links work"
```

Or open PR from GitHub web UI / GitHub Desktop after pushing a branch.

---

## PR lifecycle

```
Open PR → Review → (Changes requested?) → Approve → Merge → Delete branch
```

| State | Meaning |
|-------|---------|
| **Open** | Waiting for review |
| **Draft** | Work in progress, not ready for review |
| **Changes requested** | Reviewer wants fixes |
| **Approved** | Ready to merge |
| **Merged** | Code is in target branch |
| **Closed** | Rejected or abandoned |

---

## Reviews & voting

GitHub uses **approvals**, not literal votes:

| Review type | Effect |
|-------------|--------|
| **Approve** | ✅ Satisfied; counts toward required approvals |
| **Comment** | 💬 Feedback only; does not approve |
| **Request changes** | ❌ Blocks merge if protection requires approval |

### Request a review

```bash
gh pr edit 42 --add-reviewer username
```

Or on GitHub: PR page → Reviewers → add people.

### Self-review (solo projects)

With branch protection requiring 1 approval, you can approve your own PR if you have admin rights — or temporarily adjust rules for solo work.

---

## Merge strategies

| Strategy | Result | When to use |
|----------|--------|-------------|
| **Merge commit** | Preserves all commits + merge commit | Default; full history |
| **Squash and merge** | All PR commits → one commit on main | Clean history; feature PRs |
| **Rebase and merge** | Linear history, no merge commit | Strict linear main |

```bash
gh pr merge 42 --squash --delete-branch
gh pr merge 42 --merge
gh pr merge 42 --rebase
```

**Recommendation for jbubuntu:** squash and merge for doc/feature PRs; one commit per logical change on `main`.

---

## Update a PR after review

```bash
git checkout feature/add-docs
# make fixes
git add .
git commit -m "Address review: fix typo in conflicts.md"
git push origin feature/add-docs
# PR updates automatically
```

---

## Check PR status

```bash
gh pr list
gh pr view 42
gh pr checks 42    # CI status
gh pr diff 42
```

---

## Merge conflicts in a PR

If GitHub shows **"This branch has conflicts"**:

**Option A — GitHub web editor** (small conflicts)  
Click "Resolve conflicts" on the PR page.

**Option B — Local**
```bash
git fetch origin
git checkout feature/add-docs
git merge origin/main    # or rebase origin/main
# resolve conflicts
git add .
git commit -m "Resolve conflicts with main"
git push origin feature/add-docs
```

PR becomes mergeable again.

---

## Good PR habits

1. **Small PRs** — one feature or doc set per PR
2. **Clear title** — "Add GitHub push guide" not "updates"
3. **Test plan** — what you verified
4. **Link issues** — `Fixes #12` auto-closes issue on merge
5. **Delete branch after merge** — keeps repo tidy
