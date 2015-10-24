load 'git-num'

describe GitNum do
  let(:git_status_porcelain) do
    [
      'XX file1',
      'XX file2',
      'XX file3',
      'XX file4',
      'XX file5'
    ].join("\n")
  end

  before(:each) do
    allow(GitNum).to receive(:git_status_porcelain).and_return(git_status_porcelain)
  end

  def parse_args(args)
    GitNum.parse_args(args.split(' ').map(&:strip))
  end

  describe 'status' do
    let(:git_status) do
      [
        'On branch master',
        'Changes not staged for commit:',
        '  (use "git add <file>..." to update what will be committed)',
        '  (use "git checkout -- <file>..." to discard changes in working directory)',
        '',
        "\tmodified:   file1",
        "\tmodified:   file2",
        "\tmodified:   file3",
        "\tmodified:   file4",
        "\tmodified:   file5",
        '',
        'no changes added to commit (use "git add" and/or "git commit -a")'
      ].join("\n")
    end

    let(:expected_output) do
      [
        'On branch master',
        'Changes not staged for commit:',
        '  (use "git add <file>..." to update what will be committed)',
        '  (use "git checkout -- <file>..." to discard changes in working directory)',
        '',
        "\tmodified:   [1] file1",
        "\tmodified:   [2] file2",
        "\tmodified:   [3] file3",
        "\tmodified:   [4] file4",
        "\tmodified:   [5] file5",
        '',
        'no changes added to commit (use "git add" and/or "git commit -a")'
      ].join("\n")
    end

    before(:each) do
      allow(GitNum).to receive(:git_status).and_return(git_status)
    end

    it 'annotates `git status` with indexes' do
      expect { parse_args('') }.to output(expected_output).to_stdout
    end
  end

  describe 'convert' do
    it 'converts args to filenames' do
      expect { parse_args('convert 1 3 5') }.to \
          output('file1 file3 file5').to_stdout
    end

    it 'acts as a pass-through for unmatched args' do
      expect { parse_args('convert .') }.to \
          output('.').to_stdout
      expect { parse_args('convert file1 file2 other-file') }.to \
          output('file1 file2 other-file').to_stdout
    end

    it 'supports a mix of indexes and filenames' do
      expect { parse_args('convert file1 1 3 other-file') }.to \
          output('file1 file1 file3 other-file').to_stdout
    end

    it 'supports no args' do
      expect { parse_args('convert') }.to \
          output('').to_stdout
    end
  end
end
