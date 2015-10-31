# 1.1.0
* When executing a git command, the git process will now replace the git-num
  process. This has two effects: 1.) the user will see the output of commands
  that write to STDOUT (e.g. `git num reset head` in some cases), and 2.)
  commands which read from STDIN will work as expected (e.g. `git num diff` and
  `git num add --patch`).

# 1.0.0
* Initial release
