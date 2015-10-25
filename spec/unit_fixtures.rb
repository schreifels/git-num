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
  },

  ##############################################################################

  renames: {
    porcelain: [
      'XX file1 -> file2'
    ].join("\n"),

    status: [
      'On branch master',
      'Changes to be committed:',
      '  (use "git reset HEAD <file>..." to unstage)',
      '',
      "\trenamed:    file1 -> file2",
      '',
      'Changes not staged for commit:',
      '  (use "git add <file>..." to update what will be committed)',
      '  (use "git checkout -- <file>..." to discard changes in working directory)',
      '',
      "\tmodified:   file2"
    ].join("\n"),

    annotated_status: [
      'On branch master',
      'Changes to be committed:',
      '  (use "git reset HEAD <file>..." to unstage)',
      '',
      "\trenamed:    [1] file1 -> [2] file2",
      '',
      'Changes not staged for commit:',
      '  (use "git add <file>..." to update what will be committed)',
      '  (use "git checkout -- <file>..." to discard changes in working directory)',
      '',
      "\tmodified:   [2] file2"
    ].join("\n")
  },

  ##############################################################################

  special_characters: {
    porcelain: [
      'XX "file with \"double\" quotes" -> "file still with \"double\" quotes"',
      'XX "file with \'single\' quotes" -> "file still with \'single\' quotes"',
      'XX "file with spaces" -> "file still with spaces"',
      'XX file_with_!@#$%_special_chars',
      'XX file_with_underscores'
    ].join("\n"),

    status: [
      'On branch master',
      'Changes to be committed:',
      '  (use "git reset HEAD <file>..." to unstage)',
      '',
      "\t" + 'renamed:    "file with \\"double\\" quotes" -> "file still with \\"double\\" quotes"',
      "\t" + 'renamed:    file with \'single\' quotes -> file still with \'single\' quotes',
      "\t" + 'renamed:    file with spaces -> file still with spaces',
      '',
      'Changes not staged for commit:',
      '  (use "git add <file>..." to update what will be committed)',
      '  (use "git checkout -- <file>..." to discard changes in working directory)',
      '',
      "\t" + 'modified:   "file still with \\"double\\" quotes"',
      "\t" + 'modified:   file still with \'single\' quotes',
      "\t" + 'modified:   file still with spaces',
      '',
      'Untracked files:',
      '  (use "git add <file>..." to include in what will be committed)',
      '',
      "\t" + 'file_with_!@#$%_special_chars',
      "\t" + 'file_with_underscores'
    ].join("\n"),

    annotated_status: [
      'On branch master',
      'Changes to be committed:',
      '  (use "git reset HEAD <file>..." to unstage)',
      '',
      "\t" + 'renamed:    [1] "file with \\"double\\" quotes" -> [2] "file still with \\"double\\" quotes"',
      "\t" + 'renamed:    [3] file with \'single\' quotes -> [4] file still with \'single\' quotes',
      "\t" + 'renamed:    [5] file with spaces -> [6] file still with spaces',
      '',
      'Changes not staged for commit:',
      '  (use "git add <file>..." to update what will be committed)',
      '  (use "git checkout -- <file>..." to discard changes in working directory)',
      '',
      "\t" + 'modified:   [2] "file still with \\"double\\" quotes"',
      "\t" + 'modified:   [4] file still with \'single\' quotes',
      "\t" + 'modified:   [6] file still with spaces',
      '',
      'Untracked files:',
      '  (use "git add <file>..." to include in what will be committed)',
      '',
      "\t" + '[7] file_with_!@#$%_special_chars',
      "\t" + '[8] file_with_underscores'
    ].join("\n")
  }
}
