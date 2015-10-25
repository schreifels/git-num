# Usage

```
NAME:
  git-num - Quickly (un)stage files in Git using numbers

USAGE:
  git num [git_cmd [index...] | convert index... | -h]

EXAMPLES:
  git num                # show `git status` with git-num indexes
  git num add 1-3 5      # call `git add` with files at indexes 1, 2, 3, 5
  git num add README 2   # call `git add` with "README" and file at index 2
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

# Customization

It's handy to create an alias for `git num`:

```bash
alias gn="git num"
```

You can take this a step further if you have aliases for other git commands,
e.g.:

```bash
alias ga="git num add"
__git_complete ga _git_add
alias grh="git num reset head"
__git_complete grh _git_reset
alias gco="git num checkout"
__git_complete gco _git_checkout
```

You can also use git-num in conjunction with non-git commands, e.g.:

```bash
function ber() { git num convert "$@" | xargs bundle exec rspec; }
```

will cause `ber 2` to execute `bundle exec rspec [file at index 2]`.

# Goal

The goal of this project was to create a lightweight, well-tested Ruby command
line utility for referencing files in Git. Unlike other similar projects,
git-num supports renamed files, filenames with spaces, and other corner cases.
