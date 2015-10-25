require 'lib/fixtures'

SCRIPT = File.join(Dir.pwd, 'git-num')

describe 'GitNum integration with Git' do
  def gn(cmd='')
    `#{SCRIPT} #{cmd}`
  end

  around(:each) do |examples|
    Dir.mktmpdir do |tmpdir|
      Dir.chdir(tmpdir) do
        `git init .`
        examples.run
      end
    end
  end

  it 'produces the expected output' do
    `touch file1 file2 file3 file4 file5 file6`
    `mkdir dir1`
    `touch dir1/file7`
    `touch 'file8 with "double" quotes'`
    `touch "file9 with 'single' quotes"`
    `touch 'file10_with_!@#$%_special_chars'`

    expect(gn).to include([
      'Untracked files:',
      '  (use "git add <file>..." to include in what will be committed)',
      '',
      "\t" + GitNumFixtures.colorize(:untracked, '[1] dir1/'),
      "\t" + GitNumFixtures.colorize(:untracked, '[2] file1'),
      "\t" + GitNumFixtures.colorize(:untracked, '[3] file10_with_!@#$%_special_chars'),
      "\t" + GitNumFixtures.colorize(:untracked, '[4] file2'),
      "\t" + GitNumFixtures.colorize(:untracked, '[5] file3'),
      "\t" + GitNumFixtures.colorize(:untracked, '[6] file4'),
      "\t" + GitNumFixtures.colorize(:untracked, '[7] file5'),
      "\t" + GitNumFixtures.colorize(:untracked, '[8] file6'),
      "\t" + GitNumFixtures.colorize(:untracked, '[9] "file8 with \\"double\\" quotes"'),
      "\t" + GitNumFixtures.colorize(:untracked, '[10] file9 with \'single\' quotes')
    ].join("\n"))

    gn('add 1-5 6 7 8-10')

    expect(gn).to include([
      'Changes to be committed:',
      '  (use "git rm --cached <file>..." to unstage)',
      '',
      "\t" + GitNumFixtures.colorize(:staged, 'new file:   [1] dir1/file7'),
      "\t" + GitNumFixtures.colorize(:staged, 'new file:   [2] file1'),
      "\t" + GitNumFixtures.colorize(:staged, 'new file:   [3] file10_with_!@#$%_special_chars'),
      "\t" + GitNumFixtures.colorize(:staged, 'new file:   [4] file2'),
      "\t" + GitNumFixtures.colorize(:staged, 'new file:   [5] file3'),
      "\t" + GitNumFixtures.colorize(:staged, 'new file:   [6] file4'),
      "\t" + GitNumFixtures.colorize(:staged, 'new file:   [7] file5'),
      "\t" + GitNumFixtures.colorize(:staged, 'new file:   [8] file6'),
      "\t" + GitNumFixtures.colorize(:staged, 'new file:   [9] "file8 with \\"double\\" quotes"'),
      "\t" + GitNumFixtures.colorize(:staged, 'new file:   [10] file9 with \'single\' quotes')
    ].join("\n"))
  end
end
