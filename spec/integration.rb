require 'lib/spec_helper'

SCRIPT = File.join(Dir.pwd, 'git-num')

describe 'GitNum integration with Git' do
  def git_num(cmd='')
    `#{SCRIPT} #{cmd}`
  end

  around(:each) do |examples|
    Dir.mktmpdir do |tmpdir|
      Dir.chdir(tmpdir) do
        `git init .`
        `git config color.status.added "yellow"`
        `git config color.status.changed "green"`
        `git config color.status.untracked "cyan"`
        examples.run
      end
    end
  end

  it 'stages files' do
    `touch file1 file2 file3 file4 file5`
    `mkdir dir1`
    `touch dir1/file6`
    `touch 'file7 with spaces'`
    `touch 'file8 with "double" quotes'`
    `touch "file9 with 'single' quotes"`
    `touch 'file10_with_!@#$%_special_chars'`

    expect(git_num).to include([
      'Untracked files:',
      '  (use "git add <file>..." to include in what will be committed)',
      '',
      "\t" + colorize(:untracked, '[1] dir1/'),
      "\t" + colorize(:untracked, '[2] file1'),
      "\t" + colorize(:untracked, '[3] file10_with_!@#$%_special_chars'),
      "\t" + colorize(:untracked, '[4] file2'),
      "\t" + colorize(:untracked, '[5] file3'),
      "\t" + colorize(:untracked, '[6] file4'),
      "\t" + colorize(:untracked, '[7] file5'),
      "\t" + colorize(:untracked, '[8] file7 with spaces'),
      "\t" + colorize(:untracked, '[9] "file8 with \\"double\\" quotes"'),
      "\t" + colorize(:untracked, '[10] file9 with \'single\' quotes')
    ].join("\n"))

    git_num('add 1-5 6 7 8-10')

    expect(git_num).to include([
      'Changes to be committed:',
      '  (use "git rm --cached <file>..." to unstage)',
      '',
      "\t" + colorize(:staged, 'new file:   [1] dir1/file6'),
      "\t" + colorize(:staged, 'new file:   [2] file1'),
      "\t" + colorize(:staged, 'new file:   [3] file10_with_!@#$%_special_chars'),
      "\t" + colorize(:staged, 'new file:   [4] file2'),
      "\t" + colorize(:staged, 'new file:   [5] file3'),
      "\t" + colorize(:staged, 'new file:   [6] file4'),
      "\t" + colorize(:staged, 'new file:   [7] file5'),
      "\t" + colorize(:staged, 'new file:   [8] file7 with spaces'),
      "\t" + colorize(:staged, 'new file:   [9] "file8 with \\"double\\" quotes"'),
      "\t" + colorize(:staged, 'new file:   [10] file9 with \'single\' quotes')
    ].join("\n"))

    `git commit -m "commit"`

    expect(git_num).to eq([
      'On branch master',
      'nothing to commit, working directory clean',
      ''
    ].join("\n"))
  end

  [
   {
      initial:        '"file7 with spaces"',
      initial_expect: 'file7 with spaces',
      renamed:        '"file7 with spaces renamed"',
      renamed_expect: 'file7 with spaces renamed'
    },
    {
      initial:        '"file8 with \\"double\\" quotes"',
      initial_expect: '"file8 with \\"double\\" quotes"',
      renamed:        '"file8 with \\"double\\" quotes renamed"',
      renamed_expect: '"file8 with \\"double\\" quotes renamed"'
    },
    {
      initial:        '"file9 with \'single\' quotes"',
      initial_expect: "file9 with 'single' quotes",
      renamed:        '"file9 with \'single\' quotes renamed"',
      renamed_expect: "file9 with 'single' quotes renamed"
    },
    {
      initial:        'file10_with_!@#$%_special_chars',
      initial_expect: 'file10_with_!@#$%_special_chars',
      renamed:        'file10_with_!@#$%_special_chars-renamed',
      renamed_expect: 'file10_with_!@#$%_special_chars-renamed'
    }
  ].each do |filenames|
    it "handles filename with special characters: #{filenames[:initial]}" do
      `touch #{filenames[:initial]}`

      expect(git_num).to include([
        'Untracked files:',
        '  (use "git add <file>..." to include in what will be committed)',
        '',
        "\t" + colorize(:untracked, '[1] ' + filenames[:initial_expect])
      ].join("\n"))

      git_num('add 1')
      `git commit -m "commit"`

      expect(git_num).to eq([
        'On branch master',
        'nothing to commit, working directory clean',
        ''
      ].join("\n"))

      `git mv #{filenames[:initial]} #{filenames[:renamed]}`
      `echo 'modified' > #{filenames[:renamed]}`

      expect(git_num).to include([
        'Changes to be committed:',
        '  (use "git reset HEAD <file>..." to unstage)',
        '',
        "\t" + colorize(:staged, 'renamed:    [1] ' + filenames[:initial_expect] + ' -> [2] ' + filenames[:renamed_expect]),
        '',
        'Changes not staged for commit:',
        '  (use "git add <file>..." to update what will be committed)',
        '  (use "git checkout -- <file>..." to discard changes in working directory)',
        '',
        "\t" + colorize(:unstaged, 'modified:   [2] ' + filenames[:renamed_expect])
      ].join("\n"))

      git_num('reset head 2')

      expect(git_num).to include([
        'Changes to be committed:',
        '  (use "git reset HEAD <file>..." to unstage)',
        '',
        "\t" + colorize(:staged, 'deleted:    [1] ' + filenames[:initial_expect]),
        '',
        'Untracked files:',
        '  (use "git add <file>..." to include in what will be committed)',
        '',
        "\t" + colorize(:untracked, '[2] ' + filenames[:renamed_expect]),
      ].join("\n"))
    end
  end
end
