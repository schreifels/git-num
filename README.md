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
