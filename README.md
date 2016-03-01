# Usage

```
NAME:
  git-num - Quickly reference files in Git using numbers

USAGE:
  git num [git_cmd [index ...] | convert [index ...] | -h | -v]

EXAMPLES:
  git num                # show `git status` with git-num indexes
  git num add 1-3 5      # call `git add` with files at indexes 1, 2, 3, 5
  git num diff README 2  # call `git diff` with "README" and file at index 2
  git num reset HEAD 4   # call `git reset HEAD` with file at index 4
  git num checkout -- 4  # call `git checkout --` with file at index 4
  git num convert 1-3    # write filenames at indexes 1, 2, 3 to STDOUT
  git num -h             # show this help screen
  git num -v             # show version
```

# Screenshot

git-num works by annotating the output of `git status` with numbers. (It will
maintain whatever color scheme you use.)

<img src="https://raw.githubusercontent.com/schreifels/git-num/master/screenshot.png" width="550" alt="">

# Installation

git-num has been tested on OSX and Linux. It requires Git v1.7.9+ and Ruby
1.9.3+.

To install, download the
[git-num executable](https://github.com/schreifels/git-num/releases),
place it in a directory that is on your `PATH`, and `chmod +x git-num`. Git will
automatically use this executable when you call `git num`.

Or you may simply execute:

```bash
LATEST_RELEASE_URL=$(curl -s https://api.github.com/repos/schreifels/git-num/releases | grep browser_download_url | head -n 1 | cut -d '"' -f 4)
DESTINATION_PATH=/usr/local/bin/git-num

curl -L -o $DESTINATION_PATH $LATEST_RELEASE_URL
chmod +x $DESTINATION_PATH
git num -h # should output git-num help screen
```

Hopefully in the future, git-num will also be available via Homebrew.

If you're having issues, take a look at the
[troubleshooting guide](#troubleshooting) below.

# Customization

It's handy to create an alias for `git num`:

```bash
alias gn="git num"
```

You can take this a step further if you have aliases for other Git commands,
e.g.:

```bash
alias ga="git num add"
alias gr="git num reset"
alias gco="git num checkout"
alias gd="git num diff"
alias gds="git num diff --staged"
```

You can also use git-num in conjunction with non-Git commands, e.g.:

```bash
# `ber 2` => execute `bundle exec rspec [file at index 2]`
function ber() { git num convert "$@" | xargs bundle exec rspec; }

# `gnc 2` => copy file at index 2 to Mac clipboard
function gnc() { git num convert "$@" | pbcopy; }
```

# Goal

The goal of this project was to create a lightweight, well-tested Ruby command
line utility for referencing files in Git. Unlike other similar projects,
git-num supports renamed files, filenames with spaces, and other corner cases.

# Troubleshooting

## 'num' is not a git command.

```
~/sample-git-project $ git num
git: 'num' is not a git command. See 'git --help'.
```

This means the `git-num` executable is not on your `PATH`. Verify that the file
is located inside one of the directories listed in `echo $PATH`.

## Permission denied

```
~/sample-git-project $ git num
fatal: cannot exec 'git-num': Permission denied
```

You need to add execute permissions to the script:

```bash
chmod +x path/to/git-num
```

## 'num' appears to be a git command, but we were not able...

```
~/sample-git-project $ git num
fatal: 'num' appears to be a git command, but we were not able to execute it.
Maybe git-num is broken?
```

Type:

```bash
git-num
```

(Notice the hyphen.) This will execute the script directly rather than using
`git` to execute it. You should see the actual error printed out. You will
probably see something like:

```
bash: /usr/local/bin/git-num: /usr/bin/ruby: bad interpreter: No such file or directory
```

which means you do not have Ruby installed at `/usr/bin/ruby`. First, verify
that you have Ruby installed. If you do, change the first line of git-num to be
`#!/usr/bin/env ruby` (or the correct direct path).

This is not the default because Ruby version managers hijack
`#!/usr/bin/env ruby` and can be considerably slower than using the system Ruby
directly.
