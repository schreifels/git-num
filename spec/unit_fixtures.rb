class GitNumFixtures
  class << self
    private

    def colorize(str)
      "\e[33m#{str}\e[m"
    end
  end

  FIXTURES = {
    basic: {
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
        "\t" + colorize('modified:   file1'),
        '',
        'Changes not staged for commit:',
        '  (use "git add <file>..." to update what will be committed)',
        '  (use "git checkout -- <file>..." to discard changes in working directory)',
        '',
        "\t" + colorize('modified:   file2'),
        "\t" + colorize('modified:   file3'),
        "\t" + colorize('modified:   file4'),
        '',
        'Untracked files:',
        '  (use "git add <file>..." to include in what will be committed)',
        '',
        "\t" + colorize('file5'),
        "\t" + colorize('file6'),
        "\t" + colorize('file7'),
        "\t" + colorize('file8'),
        "\t" + colorize('file9'),
        "\t" + colorize('file10')
      ].join("\n"),

      annotated_status: [
        'On branch master',
        'Changes to be committed:',
        '  (use "git reset HEAD <file>..." to unstage)',
        '',
        "\t" + colorize('modified:   [1] file1'),
        '',
        'Changes not staged for commit:',
        '  (use "git add <file>..." to update what will be committed)',
        '  (use "git checkout -- <file>..." to discard changes in working directory)',
        '',
        "\t" + colorize('modified:   [2] file2'),
        "\t" + colorize('modified:   [3] file3'),
        "\t" + colorize('modified:   [4] file4'),
        '',
        'Untracked files:',
        '  (use "git add <file>..." to include in what will be committed)',
        '',
        "\t" + colorize('[5] file5'),
        "\t" + colorize('[6] file6'),
        "\t" + colorize('[7] file7'),
        "\t" + colorize('[8] file8'),
        "\t" + colorize('[9] file9'),
        "\t" + colorize('[10] file10')
      ].join("\n")
    },

    ##########################################################################

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
        "\t" + colorize('modified:   dir1/file'),
        '',
        'Untracked files:',
        '  (use "git add <file>..." to include in what will be committed)',
        '',
        "\t" + colorize('dir2/')
      ].join("\n"),

      annotated_status: [
        'On branch master',
        'Changes not staged for commit:',
        '  (use "git add <file>..." to update what will be committed)',
        '  (use "git checkout -- <file>..." to discard changes in working directory)',
        '',
        "\t" + colorize('modified:   [1] dir1/file'),
        '',
        'Untracked files:',
        '  (use "git add <file>..." to include in what will be committed)',
        '',
        "\t" + colorize('[2] dir2/')
      ].join("\n")
    },

    ##########################################################################

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
        "\t" + colorize('modified:   file1'),
        "\t" + colorize('modified:   file2'),
        '',
        'no changes added to commit (use "git add" and/or "git commit -a")'
      ].join("\n"),

      annotated_status: [
        'On branch master',
        'Changes not staged for commit:',
        '  (use "git add <file>..." to update what will be committed)',
        '  (use "git checkout -- <file>..." to discard changes in working directory)',
        '',
        "\t" + colorize('modified:   [1] file1'),
        "\t" + colorize('modified:   [?] file2'),
        '',
        'no changes added to commit (use "git add" and/or "git commit -a")'
      ].join("\n")
    },

    ##########################################################################

    renames: {
      porcelain: [
        'XX file1 -> file2'
      ].join("\n"),

      status: [
        'On branch master',
        'Changes to be committed:',
        '  (use "git reset HEAD <file>..." to unstage)',
        '',
        "\t" + colorize('renamed:    file1 -> file2'),
        '',
        'Changes not staged for commit:',
        '  (use "git add <file>..." to update what will be committed)',
        '  (use "git checkout -- <file>..." to discard changes in working directory)',
        '',
        "\t" + colorize('modified:   file2')
      ].join("\n"),

      annotated_status: [
        'On branch master',
        'Changes to be committed:',
        '  (use "git reset HEAD <file>..." to unstage)',
        '',
        "\t" + colorize('renamed:    [1] file1 -> [2] file2'),
        '',
        'Changes not staged for commit:',
        '  (use "git add <file>..." to update what will be committed)',
        '  (use "git checkout -- <file>..." to discard changes in working directory)',
        '',
        "\t" + colorize('modified:   [2] file2')
      ].join("\n")
    },

    ##########################################################################

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
        "\t" + colorize('renamed:    "file with \\"double\\" quotes" -> "file still with \\"double\\" quotes"'),
        "\t" + colorize('renamed:    file with \'single\' quotes -> file still with \'single\' quotes'),
        "\t" + colorize('renamed:    file with spaces -> file still with spaces'),
        '',
        'Changes not staged for commit:',
        '  (use "git add <file>..." to update what will be committed)',
        '  (use "git checkout -- <file>..." to discard changes in working directory)',
        '',
        "\t" + colorize('modified:   "file still with \\"double\\" quotes"'),
        "\t" + colorize('modified:   file still with \'single\' quotes'),
        "\t" + colorize('modified:   file still with spaces'),
        '',
        'Untracked files:',
        '  (use "git add <file>..." to include in what will be committed)',
        '',
        "\t" + colorize('file_with_!@#$%_special_chars'),
        "\t" + colorize('file_with_underscores')
      ].join("\n"),

      annotated_status: [
        'On branch master',
        'Changes to be committed:',
        '  (use "git reset HEAD <file>..." to unstage)',
        '',
        "\t" + colorize('renamed:    [1] "file with \\"double\\" quotes" -> [2] "file still with \\"double\\" quotes"'),
        "\t" + colorize('renamed:    [3] file with \'single\' quotes -> [4] file still with \'single\' quotes'),
        "\t" + colorize('renamed:    [5] file with spaces -> [6] file still with spaces'),
        '',
        'Changes not staged for commit:',
        '  (use "git add <file>..." to update what will be committed)',
        '  (use "git checkout -- <file>..." to discard changes in working directory)',
        '',
        "\t" + colorize('modified:   [2] "file still with \\"double\\" quotes"'),
        "\t" + colorize('modified:   [4] file still with \'single\' quotes'),
        "\t" + colorize('modified:   [6] file still with spaces'),
        '',
        'Untracked files:',
        '  (use "git add <file>..." to include in what will be committed)',
        '',
        "\t" + colorize('[7] file_with_!@#$%_special_chars'),
        "\t" + colorize('[8] file_with_underscores')
      ].join("\n")
    }
  }
end
