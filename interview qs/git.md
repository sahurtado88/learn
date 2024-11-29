# GIT

1. Explain the difference between rebasing and merge in Git?

-  Git rebase is a command that allows developers to integrate changes from one branch to another.
- Git merge is a command that allows you to merge branches from Git.

Git rebase and merge both integrate changes from one branch into another. Where they differ is how they used. Git rebase moves a feature branch into a master. Git merge adds a new commit, preserving the history.

2. Have you faced the situation where you resolve conflicts in Git? How?

A merge conflict is an event that takes place when Git is unable to automatically resolve differences in code between two commits. Git can merge the changes automatically only if the commits are on different lines or branches. Here are the steps that will help you resolve conflicts in Git:

    1. The easiest way to resolve a conflicted file is to open it and make any necessary changes
    2. After editing the file, we can use the git add a command to stage the new merged content
    3. The final step is to create a new commit with the help of the git commit command
    4. Git will create a new merge commit to finalize the merge

3. How to revert a commit that has already been pushed and made public?

There are two processes through which you can revert a commit:
    1. Remove or fix the bad file in a new commit and push it to the remote repository. Then commit it to the remote repository using:
    git commit –m “commit message”
    2. Create a new commit to undo all the changes that were made in the bad commit. Use the following command:
    git revert <commit id>


5. How will you find a list of files that has been modified in a particular commit?

The command to get a list of files that has been changed in a particular commit is:
git diff-tree –r {commit hash}
• -r flag allows the command to list individual files
• commit hash lists all the files that were changed or added in the commit.

6. How will you fix a broken commit? What command you will use?

To fix a broken commit in Git, We use the “git commit — amend” command, which helps us combine the staged changes with the previous commits instead of creating a fresh new commit.

7. Explain git stash drop?

Git ‘stash drop’ command is used to remove the stashed item. This command will remove the last added stash item by default, and it can also remove a selected item as well.
Ex: If you want to delete item named stash@{manoj}; you can use the command:
git stash drop stash@{manoj}.

git stash is a useful tool for handling temporary changes in your working directory in Git. It allows you to quickly move between tasks without losing your work in progress.

8. Explain about “git cherry-pick”?

This command enables you to pick up commits from a branch within a repository and apply it to another branch. This command is useful to undo changes when any commit is accidentally made to the wrong branch. Then, you can switch to the correct branch and use this command to git cherry-pick the commit.



10. What is origin in Git?

Origin refers to the remote repository that a project was originally cloned from and is used instead of the original repository’s URL.

11. What is the difference between resetting and reverting?

git reset changes the state of the branch to a previous one by removing all of the states after the desired commit,

git revert does it through the creation of new reverting commits and keeping the original one intact.

12. What is ‘staging area’ or ‘index’ in Git?

That before completing the commits, it can be formatted and reviewed in an intermediate area known as ‘Staging Area’ or ‘Index’. Every change is first verified in the staging area and then that change is committed to the repository.

![alt text](image-19.png)

13. What work is restored when the deleted branch is recovered?

The files which were stashed and saved in the stash index list will be recovered back. Any untracked files will be lost. Also, it is a good idea to always stage and commit your work or stash them.

15. What is the purpose of branching and its types?

It allows the user to switch between the branches to keep the current work in sync without disturbing master branches and other developer’s work as per their requirements.

· Feature branching — A feature branch model keeps all of the changes for a particular feature inside of a branch. When the feature is fully tested and validated by automated tests, the branch is then merged into master.

· Task branching — In this branch, each task is implemented on its own branch with the task key included in the branch name. It is easy to see which code implements which task, just look for the task key in the branch name.

· Release branching — Once the develop branch has acquired enough features for a release, you can clone that branch to form a Release branch. Creating this branch starts the next release cycle, so no new features can be added after this point, only bug fixes, documentation generation, and other release-oriented tasks should go in this branch. Once it is ready to ship, the release gets merged into master and tagged with a version number.

## Basic Git Commands — Refresh your mind once again

git init: creating a new repository.

git clone: to copy or check out the working repository.

git pull: fetch the code already in the repository.

git push: sending the changes to the master branch.

git add: It adds file changes in an existing directory to index.

git commit –m [type in a message] — It is used to snapshot or record a file.

git diff [first branch] [second branch] — it is used to display the differences present between the two branches.

git rest [commit] — It is used to undo all the changes that have been incorporated as a part of a commit after a specified commit has taken place.

git reset –hard [commit] — This command is used to discard all the history and takes us to the last specified commit.

git log –follow [file] — his is similar to that of git log with the additional difference that it lists the version history for a particular file.

git show [commit] — This is used to display the metadata and all the content related changes of a particular commit.

git tag [commitID] — This is used to give particular tags to the code commits.

git branch [branch-name] — This is used to create a new branch.
git branch –d [branch name] — It is used to delete the current branch name specified.

git checkout [branch-name] — It is helpful in switching from one branch to another.

git status: To know the comparison between the working directories and index.

# Merge vs Rebase

Summarizing Key Differences:
Commit History: Merge preserves the history as it happened, with merge commits. Rebase creates a linear history by re-applying commits on top of the target branch.
Use Case: Merge is used when you want to keep the history of how features developed. Rebase is used when you want a cleaner, linear history.
Risk: Rebasing can rewrite commit history, which can be dangerous if not done correctly or on shared branches.
In practice, whether to use git merge or git rebase depends on the project's workflow preferences, the specific situation, and the team's agreement on maintaining the project's commit history.

-  Git rebase is a command that allows developers to integrate changes from one branch to another.
- Git merge is a command that allows you to merge branches from Git.

Git rebase and merge both integrate changes from one branch into another. Where they differ is how they used. Git rebase moves a feature branch into a master. Git merge adds a new commit, preserving the history.

# Git cherry pick
git cherry-pick is a powerful command that enables arbitrary Git commits to be picked by reference and appended to the current working HEAD. Cherry picking is the act of picking a commit from a branch and applying it to another. git cherry-pick can be useful for undoing changes. For example, say a commit is accidently made to the wrong branch. You can switch to the correct branch and cherry-pick the commit to where it should belong.

# Head
Git maintains a variable for referencing, called HEAD to the latest commit in the recent checkout branch. So if we make a new commit in the repo then the pointer or HEAD is going to move or change its position to point to a new commit.

#  git reset — mixed and git merge — abort?.

git reset — mixed is used to undo changes made in the working directory and staging area.

git merge — abort helps stop the merge process and return back to the state before the merging began.

# Fast forward merge

happen when the feature branch is already anchored off the lastes changes

# git stash

# git reset

soft: undo all the changes between HEAD and the commit, but save all the changes as staged

```
git reset --soft HEAD~1 #dehace el ultimo commit, peor los cambios siguen en stagging
```

mixed: defualt option,  undo all the changes between HEAD and the commit but save all the changes as unstaged

```
git reset --mixed HEAD~1 #dehace el ultimo commit, pero quita los cambios de stagging
```

hard: undo all the changes between HEAD and the commit and discard all the changes
```
git reset --hard HEAD~1 #deshace el ultimo commity borra todos los cambios
git reset --hard <commit hash>
```

# git ammend

# git bisect
 git bisect start
 git bisect bad
 git bisect good <commit>
 git bisect reset

# git revert
Git Revert
Purpose: git revert is used to undo changes from a specific commit by creating a new commit that reverses the changes. It doesn’t alter the commit history.
How it Works: When you use git revert <commit>, Git creates a new commit that applies the opposite changes of the specified commit. The previous commits remain in the history.
Use Case: Ideal when you want to undo a change while preserving history, such as in collaborative work where altering the commit history could disrupt others' work.

git revert <commit-hash>
This command will open an editor to confirm the new "revert" commit, showing the changes that will be applied in reverse.

# revert vs reset
Both git revert and git reset are Git commands used to undo changes, but they work differently and serve different purposes.

Key Differences
Feature	git revert	git reset
History	Preserves commit history by adding a new commit	Modifies commit history (with --hard or --mixed)
Safety	Safe to use in shared repositories	Can cause conflicts if used in shared branches
Use Case	Undo a specific change and preserve history	Permanently remove or rewrite commits
Options	N/A	--soft, --mixed, --hard
In summary:

Use git revert to undo changes without altering commit history.
Use git reset to adjust your branch’s history, especially if you're fixing commits in a private branch.

# 9. git pull VS git fetch

Git pull command pulls new changes or commits from a particular branch from your central repository and updates your target branch in your local repository. (Git pull = git fetch + git merge)

Git fetch is also used for the same purpose but it works in a slightly different way. When you perform a git fetch, it pulls all new commits from the desired branch and stores it in a new branch in your local repository. If you want to reflect these changes in your target branch, git fetch must be followed with a git merge.