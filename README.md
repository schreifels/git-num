# Usage

```
NAME:
  git-num - Quickly (un)stage files in Git using numbers

USAGE:
  git num [git_cmd [indexes...] | convert indexes... | -h]

EXAMPLES:
  git num                # show git status with indexes
  git num add 1-3 5      # call `git add` with files at indexes 1, 2, 3, 5
  git num reset head 4   # call `git reset head` with file at index 4
  git num checkout -- 4  # call `git checkout --` with file at index 4
  git num convert 1-3    # write filenames at indexes 1, 2, 3 to STDOUT
  git num -h             # show this help screen
```

# Screenshot

![](https://raw.githubusercontent.com/schreifels/git-num/master/screenshot.jpg)

# Installation

Simply download the
[git-num executable](https://raw.githubusercontent.com/schreifels/git-num/master/git-num),
place it in a directory that is in your `PATH`, and `chmod +x git-num`. Git will
automatically use this executable when you call `git num`.

# Goal

The goal of this project was to create a lightweight, well-tested Ruby command
line utility for referencing files in Git. Unlike other similar projects,
git-num supports renames, filenames with spaces, and other corner cases.
