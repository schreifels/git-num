# 4.0.2

- Updated `git status` parsing to support bold colors
- Updated `git status` parsing to support colored tab characters (see issue #7)
- Created new (undocumented) `git num debug-regex` CLI option for debugging the regex parsing of a particular `git status` output

# 4.0.1

- Renamed packages to make the project installable via `go install`.

# 3.0.2, 3.0.3, 4.0.0

- These versions were failed attempts at making the project installable via `go install` and were retracted from the go pkg proxy.

# 3.0.1

- Added early return for improved performance of commands like `git num diff` when invoked with no args (useful for large repos when all of your git aliases wrap `git num`) (regression from the rewrite).

# 3.0.0

- Full rewrite in Go.

# 2.1.0

- Added early return so `git num convert` without args does not invoke `git status` unnecessarily (useful for large repos when using aliases like `alias gd="git num diff"`).

# 2.0.1

- Added support for Git 1.7.9+.
- Fixed a bug where `git num convert abc123-456` would be interpreted as "abc"
  followed by a range.
- Added troubleshooting instructions to the README.

# 2.0.0

- git-num annotations will now always be ordered sequentially from top to
  bottom, even if one filename appears multiple times. (Previously the numbers
  would be based on a psuedo-alphabetical sort of the paths with duplicates
  being assigned the same number.) The new behavior is more intuitive and makes
  it easier to select ranges of files.
- Rather than naively wrapping filenames in double quotes (and escaping quotes
  in the filename, if any), git-num now escapes filenames using the native Ruby
  [shellwords library](http://ruby-doc.org/stdlib-2.2.2/libdoc/shellwords/rdoc/Shellwords.html).
- Git commands are now executed in a subshell, which prevents Git from
  complaining about broken pipes when exiting from a large diff. Fixes issue #5.
- Added `-v` version option.
- Substantial improvements were made to the unit and integration test suites.

# 1.1.0

- When executing a Git command, the Git process will now replace the git-num
  process. This has two effects: 1.) the user will see the output of commands
  that write to STDOUT (e.g. `git num reset HEAD` in some cases), and 2.)
  commands which read from STDIN will work as expected (e.g. `git num diff` and
  `git num add --patch`).

# 1.0.0

- Initial release
