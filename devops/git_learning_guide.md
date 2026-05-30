# Git Complete Learning Guide

## Purpose

This guide serves as a comprehensive Git reference for:

- Learning Git?
- Daily Development?
- DevOps Workflows
- Interview Preparation
- Quick Revision

By the end of this guide, you will understand:

- What Git is
- Why Git is used
- Git Architecture
- Git Workflow
- Branching Strategy
- Merge vs Rebase
- Stash
- Cherry Pick
- Tags
- Git Best Practices
- Common Interview Questions

---

# What is Git?

Git is a Distributed Version Control System (DVCS) used to track changes in source code.

Git helps teams:

- Track code changes
- Collaborate efficiently
- Manage versions
- Recover previous code versions
- Maintain code history

Git was created by Linus Torvalds in 2005.

---

# Why Git?

Without Git:

Developer 1 → code changes

Developer 2 → code changes

Result:

- Lost changes
- File overwrites
- No history
- Difficult collaboration

With Git:

Developer 1
      |
      v
     Git
      ^
      |
Developer 2

Benefits:

- Version Control
- Collaboration
- Rollback Capability
- Branching
- Code Review Support

---

# Git Architecture

Git consists of three major areas:

    Working Directory
            |
            v
      Staging Area
            |
            v
       Local Repository
            |
            v
      Remote Repository

---

# Working Directory

The place where developers modify files.

Example:

    app.py
    README.md
    Dockerfile

Changes made here are not tracked until added to Git.

---

# Staging Area

Temporary area used to prepare changes for commit.

Command:

    git add file.txt

Purpose:

- Select specific changes
- Review before commit

---

# Local Repository

Stores commit history locally.

Command:

    git commit -m "Initial commit"

Purpose:

- Save snapshots of code
- Maintain version history

---

# Remote Repository

Central repository shared by team members.

Examples:

- GitHub
- GitLab
- Bitbucket
- Oracle SCM

Command:

    git push origin main

Purpose:

- Share code
- Collaborate with team

---

# Git Lifecycle

    Create File
          |
          v
    git status
          |
          v
    git add
          |
          v
    git commit
          |
          v
    git push
          |
          v
    Remote Repository

---

# Common Git Commands

## Check Version

    git --version

---

## Configure User

    git config --global user.name "John Doe"

    git config --global user.email "john@example.com"

Verify:

    git config --list

---

## Initialize Repository

    git init

Creates:

    .git/

directory.

---

## Clone Repository

    git clone https://github.com/user/project.git

Purpose:

- Download repository
- Create local copy

---

## Check Status

    git status

Shows:

- Modified files
- Staged files
- Untracked files

---

## Add Files

Single file:

    git add file.txt

All files:

    git add .

Purpose:

Move files from:

    Working Directory

to

    Staging Area

---

## Commit Changes

    git commit -m "Added login feature"

Purpose:

Create a snapshot of current changes.

---

## View Commit History

    git log

Compact view:

    git log --oneline

Example:

    a123456 Added login feature
    b654321 Initial commit

---

## Push Changes

    git push origin main

Purpose:

Upload commits to remote repository.

---

## Pull Changes

    git pull origin main

Purpose:

Download latest changes from remote repository.

---

## Fetch Changes

    git fetch

Purpose:

Download updates without merging.

Difference:

    git fetch

Downloads only.

    git pull

Downloads + merges.

---

# Branching

Branches allow independent development.

Default Branch:

    main

Create Branch:

    git branch feature-login

View Branches:

    git branch

Switch Branch:

    git checkout feature-login

Modern Syntax:

    git switch feature-login

Create and Switch:

    git checkout -b feature-login

or

    git switch -c feature-login

---

# Branch Workflow

          main
            |
            |
            v
     feature-login
            |
            v
      git merge
            |
            v
          main

Benefits:

- Isolation
- Parallel development
- Safer changes

---

# Merge

Purpose:

Combine changes from one branch into another.

Example:

    git checkout main

    git merge feature-login

Result:

    feature-login
          |
          v
         main

---

# Merge Conflict

Occurs when two developers modify the same lines.

Example:

Developer 1:

    app_version=1

Developer 2:

    app_version=2

Git cannot determine which version to keep.

Resolution:

1. Open file
2. Fix conflict
3. Add file

       git add file.txt

4. Commit

       git commit

---

# Rebase

Purpose:

Move branch commits on top of another branch.

Example:

    git checkout feature-login

    git rebase main

Before:

    A---B---C main
         
          D---E feature

After:

    A---B---C---D---E

Benefits:

- Cleaner history
- Linear commit structure

---

# Merge vs Rebase

| Merge | Rebase |
|---------|---------|
| Preserves history | Rewrites history |
| Creates merge commits | No merge commits |
| Easier for teams | Cleaner history |
| Safer | Requires caution |

Rule:

Use:

    merge

for shared branches.

Use:

    rebase

for local feature branches.

---

# Stash

Temporarily saves uncommitted changes.

Save:

    git stash

View:

    git stash list

Restore:

    git stash apply

Delete:

    git stash drop

Use Case:

Need to switch branches without committing work.

---

# Cherry Pick

Copies a specific commit.

Command:

    git cherry-pick <commit-id>

Use Case:

Move a bug fix without merging the entire branch.

---

# Tags

Used for releases.

Create Tag:

    git tag v1.0

Push Tag:

    git push origin v1.0

View Tags:

    git tag

Examples:

    v1.0
    v1.1
    v2.0

---

# Undo Changes

Discard file changes:

    git checkout -- file.txt

Remove staged changes:

    git reset HEAD file.txt

Undo last commit:

    git reset --soft HEAD1

Hard reset:

    git reset --hard HEAD1

Warning:

Hard reset permanently removes changes.

---

# Git Ignore

Ignore files from tracking.

File:

    .gitignore

Example:

    .log
    .tmp
    node_modules/
    .terraform/
    .idea/

Purpose:

Prevent unnecessary files from entering repository.

---

# Git Workflow Used in DevOps

Typical workflow:

    git clone

    git checkout -b feature

    git add .

    git commit

    git push

    Pull Request

    Code Review

    Merge

    Deployment

---

# Git Flow Strategy

Branches:

    main
    develop
    feature/
    release/
    hotfix/*

Example:

                main
                 |
          ----------------
          |              |
       release        hotfix
          |
        develop
          |
       feature

---

# Common Interview Questions

## What is Git?

Git is a distributed version control system used to track and manage source code changes.

---

## Difference Between Git and GitHub?

Git:

- Version Control Tool

GitHub:

- Remote Hosting Platform

---

## Difference Between Fetch and Pull?

Fetch:

    Download changes only

Pull:

    Download + merge changes

---

## Difference Between Merge and Rebase?

Merge:

- Preserves history

Rebase:

- Creates linear history

---

## What is Stash?

Temporary storage for uncommitted changes.

---

## What is Cherry Pick?

Copies a specific commit from one branch to another.

---

## What is HEAD?

Pointer to current commit.

Example:

    HEAD -> main

---

## What is a Merge Conflict?

Occurs when Git cannot automatically merge changes.

---

# Git Best Practices

1. Commit Frequently
2. Use Meaningful Commit Messages
3. Pull Before Push
4. Keep Branches Small
5. Use Pull Requests
6. Avoid Direct Changes to Main
7. Use .gitignore Properly
8. Review Code Before Merge
9. Tag Releases
10. Protect Production Branches

---

# Quick Revision Cheat Sheet

Initialize Repository:

    git init

Clone Repository:

    git clone <repo-url>

Check Status:

    git status

Add Files:

    git add .

Commit:

    git commit -m "message"

Push:

    git push origin main

Pull:

    git pull origin main

Create Branch:

    git checkout -b feature

Merge:

    git merge feature

Rebase:

    git rebase main

Stash:

    git stash

Cherry Pick:

    git cherry-pick <commit-id>

Tags:

    git tag v1.0

View History:

    git log --oneline

---

# Key Takeaway

Git is the foundation of modern DevOps and software development.

Mastering:

- Commits
- Branching
- Merging
- Rebasing
- Stashing
- Tags
- Pull Requests

provides the skills required for efficient collaboration, CI/CD pipelines, cloud-native development, and enterprise-scale software delivery.
