GIT_NUM_FIXTURES = {
  basic: {
    porcelain: [
      'XX file1',
      'XX file2',
      'XX file3'
    ].join("\n"),

    status: [
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
    ].join("\n"),

    annotated_status: [
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
  },

  ##############################################################################

  directories: {
    porcelain: [
      'XX dir1/file',
      'XX dir2/'
    ].join("\n"),

    status: [
      'On branch master',
      'Changes not staged for commit:',
      '  (use "git add <file>..." to update what will be committed)',
      '  (use "git checkout -- <file>..." to discard changes in working directory)',
      '',
      "\tmodified:   dir1/file",
      '',
      'Untracked files:',
      '  (use "git add <file>..." to include in what will be committed)',
      '',
      "\tdir2/"
    ].join("\n"),

    annotated_status: [
      'On branch master',
      'Changes not staged for commit:',
      '  (use "git add <file>..." to update what will be committed)',
      '  (use "git checkout -- <file>..." to discard changes in working directory)',
      '',
      "\tmodified:   [1] dir1/file",
      '',
      'Untracked files:',
      '  (use "git add <file>..." to include in what will be committed)',
      '',
      "\t[2] dir2/"
    ].join("\n")
  },

  ##############################################################################

  missing_index: {
    porcelain: [
      'XX file1'
    ].join("\n"),

    status: [
      'On branch master',
      'Changes not staged for commit:',
      '  (use "git add <file>..." to update what will be committed)',
      '  (use "git checkout -- <file>..." to discard changes in working directory)',
      '',
      "\tmodified:   file1",
      "\tmodified:   file2",
      '',
      'no changes added to commit (use "git add" and/or "git commit -a")'
    ].join("\n"),

    annotated_status: [
      'On branch master',
      'Changes not staged for commit:',
      '  (use "git add <file>..." to update what will be committed)',
      '  (use "git checkout -- <file>..." to discard changes in working directory)',
      '',
      "\tmodified:   [1] file1",
      "\tmodified:   [?] file2",
      '',
      'no changes added to commit (use "git add" and/or "git commit -a")'
    ].join("\n")
  }
}
