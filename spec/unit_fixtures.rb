class GitNumFixtures
  BASIC_PORCELAIN = [
    'XX file1',
    'XX file2',
    'XX file3'
  ].join("\n")

  BASIC_STATUS = [
    'On branch master',
    'Changes to be committed:',
    '  (use "git reset HEAD <file>..." to unstage)',
    '',
    "\tmodified:   file1",
    '',
    'Changes not staged for commit:',
    '  (use "git add <file>..." to update what will be committed)',
    '  (use "git checkout -- <file>..." to discard changes in working directory)',
    '',
    "\tmodified:   file2",
    '',
    'Untracked files:',
    '  (use "git add <file>..." to include in what will be committed)',
    '',
    "\tfile3"
  ].join("\n")

  BASIC_STATUS_ANNOTATED = [
    'On branch master',
    'Changes to be committed:',
    '  (use "git reset HEAD <file>..." to unstage)',
    '',
    "\tmodified:   [1] file1",
    '',
    'Changes not staged for commit:',
    '  (use "git add <file>..." to update what will be committed)',
    '  (use "git checkout -- <file>..." to discard changes in working directory)',
    '',
    "\tmodified:   [2] file2",
    '',
    'Untracked files:',
    '  (use "git add <file>..." to include in what will be committed)',
    '',
    "\t[3] file3"
  ].join("\n")
end
