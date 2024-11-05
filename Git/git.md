# VCS Version Control System

Version control is software that tracks and manages changes to files over time.

# configuring Git

```
git config --global user.name "Sergio"
git config user.name
git config --global user.email blah@blah.com
git config user.email
```

# git workflow

- Adding: we use the git add command to stage change to be commited

- Commit: we use git commit command to actually commit changes grom the staging area


# Head

HEAD is simply a pointer that refers to the current "location" in your repository. It points to a particular branch reference

So far, HEAD always points to the latest commit you made on the master branch, but soon we'll see that we can move around and HEAD will change!

# viewing Branches

git branch to view your existing branches

# Creating branches

Use git branch <branch name> to make a new branch based upon the current head

# Switching branches

git switch <branch-name>
git checkout <bracnh-name>

# creating and switching

git switch -c <branch-name>
git checkout -b <branch-name>

git branch -v 

# Merging Branches

