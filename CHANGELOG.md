# 2.0.0 (not released)
* git-num annotations will now always be ordered sequentially from top to
  bottom, even if one filename appears multiple times. (Previously the numbers
  would be based on a psuedo-alphabetical sort of the paths with duplicates
  being assigned the same number.) The new behavior is more intuitive and makes
  it easier to select ranges of files.
* Rather than naively wrapping filenames in double quotes (and escaping quotes
  in the filename, if any), git-num now escapes filenames using the native Ruby
  [shellwords library](http://ruby-doc.org/stdlib-2.2.2/libdoc/shellwords/rdoc/Shellwords.html).

# 1.1.0
* When executing a git command, the git process will now replace the git-num
  process. This has two effects: 1.) the user will see the output of commands
  that write to STDOUT (e.g. `git num reset head` in some cases), and 2.)
  commands which read from STDIN will work as expected (e.g. `git num diff` and
  `git num add --patch`).

# 1.0.0
* Initial release
