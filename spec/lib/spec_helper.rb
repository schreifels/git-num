def colorize(section, str)
  i = case section
      when :staged
        33 # yellow
      when :unstaged
        32 # green
      when :untracked
        36 # cyan
      else
        raise "Unknown section: #{section}"
      end

  "\e[#{i}m#{str}\e[m"
end

FIXTURES = {}

################################################################################

FIXTURES[:basic] = {
  porcelain: [
    'XX file1',
    'XX file2',
    'XX file3',
    'XX file4',
    'XX file5',
    'XX file6',
    'XX file7',
    'XX file8',
    'XX file9',
    'XX file10'
  ].join("\n"),

  status: [
    'On branch master',
    'Changes to be committed:',
    '  (use "git reset HEAD <file>..." to unstage)',
    '',
    "\t" + colorize(:staged, 'modified:   file1'),
    '',
    'Changes not staged for commit:',
    '  (use "git add <file>..." to update what will be committed)',
    '  (use "git checkout -- <file>..." to discard changes in working directory)',
    '',
    "\t" + colorize(:unstaged, 'modified:   file2'),
    "\t" + colorize(:unstaged, 'modified:   file3'),
    "\t" + colorize(:unstaged, 'modified:   file4'),
    '',
    'Untracked files:',
    '  (use "git add <file>..." to include in what will be committed)',
    '',
    "\t" + colorize(:untracked, 'file5'),
    "\t" + colorize(:untracked, 'file6'),
    "\t" + colorize(:untracked, 'file7'),
    "\t" + colorize(:untracked, 'file8'),
    "\t" + colorize(:untracked, 'file9'),
    "\t" + colorize(:untracked, 'file10')
  ].join("\n"),

  annotated_status: [
    'On branch master',
    'Changes to be committed:',
    '  (use "git reset HEAD <file>..." to unstage)',
    '',
    "\t" + colorize(:staged, 'modified:   [1] file1'),
    '',
    'Changes not staged for commit:',
    '  (use "git add <file>..." to update what will be committed)',
    '  (use "git checkout -- <file>..." to discard changes in working directory)',
    '',
    "\t" + colorize(:unstaged, 'modified:   [2] file2'),
    "\t" + colorize(:unstaged, 'modified:   [3] file3'),
    "\t" + colorize(:unstaged, 'modified:   [4] file4'),
    '',
    'Untracked files:',
    '  (use "git add <file>..." to include in what will be committed)',
    '',
    "\t" + colorize(:untracked, '[5] file5'),
    "\t" + colorize(:untracked, '[6] file6'),
    "\t" + colorize(:untracked, '[7] file7'),
    "\t" + colorize(:untracked, '[8] file8'),
    "\t" + colorize(:untracked, '[9] file9'),
    "\t" + colorize(:untracked, '[10] file10')
  ].join("\n")
}

################################################################################

FIXTURES[:directories] = {
  status: [
    'On branch master',
    'Changes not staged for commit:',
    '  (use "git add <file>..." to update what will be committed)',
    '  (use "git checkout -- <file>..." to discard changes in working directory)',
    '',
    "\t" + colorize(:unstaged, 'modified:   dir1/file'),
    '',
    'Untracked files:',
    '  (use "git add <file>..." to include in what will be committed)',
    '',
    "\t" + colorize(:untracked, 'dir2/')
  ].join("\n"),

  annotated_status: [
    'On branch master',
    'Changes not staged for commit:',
    '  (use "git add <file>..." to update what will be committed)',
    '  (use "git checkout -- <file>..." to discard changes in working directory)',
    '',
    "\t" + colorize(:unstaged, 'modified:   [1] dir1/file'),
    '',
    'Untracked files:',
    '  (use "git add <file>..." to include in what will be committed)',
    '',
    "\t" + colorize(:untracked, '[2] dir2/')
  ].join("\n")
}

################################################################################

FIXTURES[:renames] = {
  status: [
    'On branch master',
    'Changes to be committed:',
    '  (use "git reset HEAD <file>..." to unstage)',
    '',
    "\t" + colorize(:staged, 'renamed:    file1 -> file2'),
    '',
    'Changes not staged for commit:',
    '  (use "git add <file>..." to update what will be committed)',
    '  (use "git checkout -- <file>..." to discard changes in working directory)',
    '',
    "\t" + colorize(:unstaged, 'modified:   file2')
  ].join("\n"),

  annotated_status: [
    'On branch master',
    'Changes to be committed:',
    '  (use "git reset HEAD <file>..." to unstage)',
    '',
    "\t" + colorize(:staged, 'renamed:    [1] file1 -> [2] file2'),
    '',
    'Changes not staged for commit:',
    '  (use "git add <file>..." to update what will be committed)',
    '  (use "git checkout -- <file>..." to discard changes in working directory)',
    '',
    "\t" + colorize(:unstaged, 'modified:   [3] file2')
  ].join("\n")
}

################################################################################

FIXTURES[:special_characters] = {
  status: [
    'On branch master',
    'Changes to be committed:',
    '  (use "git reset HEAD <file>..." to unstage)',
    '',
    "\t" + colorize(:staged, 'renamed:    "file with \\"double\\" quotes" -> "file still with \\"double\\" quotes"'),
    "\t" + colorize(:staged, 'renamed:    file with \'single\' quotes -> file still with \'single\' quotes'),
    "\t" + colorize(:staged, 'renamed:    file with spaces -> file still with spaces'),
    '',
    'Changes not staged for commit:',
    '  (use "git add <file>..." to update what will be committed)',
    '  (use "git checkout -- <file>..." to discard changes in working directory)',
    '',
    "\t" + colorize(:unstaged, 'modified:   "file still with \\"double\\" quotes"'),
    "\t" + colorize(:unstaged, 'modified:   file still with \'single\' quotes'),
    "\t" + colorize(:unstaged, 'modified:   file still with spaces'),
    '',
    'Untracked files:',
    '  (use "git add <file>..." to include in what will be committed)',
    '',
    "\t" + colorize(:untracked, 'file_with_!@#$%_special_chars'),
    "\t" + colorize(:untracked, 'file_with_underscores')
  ].join("\n"),

  annotated_status: [
    'On branch master',
    'Changes to be committed:',
    '  (use "git reset HEAD <file>..." to unstage)',
    '',
    "\t" + colorize(:staged, 'renamed:    [1] "file with \\"double\\" quotes" -> [2] "file still with \\"double\\" quotes"'),
    "\t" + colorize(:staged, 'renamed:    [3] file with \'single\' quotes -> [4] file still with \'single\' quotes'),
    "\t" + colorize(:staged, 'renamed:    [5] file with spaces -> [6] file still with spaces'),
    '',
    'Changes not staged for commit:',
    '  (use "git add <file>..." to update what will be committed)',
    '  (use "git checkout -- <file>..." to discard changes in working directory)',
    '',
    "\t" + colorize(:unstaged, 'modified:   [7] "file still with \\"double\\" quotes"'),
    "\t" + colorize(:unstaged, 'modified:   [8] file still with \'single\' quotes'),
    "\t" + colorize(:unstaged, 'modified:   [9] file still with spaces'),
    '',
    'Untracked files:',
    '  (use "git add <file>..." to include in what will be committed)',
    '',
    "\t" + colorize(:untracked, '[10] file_with_!@#$%_special_chars'),
    "\t" + colorize(:untracked, '[11] file_with_underscores')
  ].join("\n")
}
