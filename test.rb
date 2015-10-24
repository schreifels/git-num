load 'git-num'

describe GitNum do
  def parse_args(args)
    GitNum.parse_args(args.split(' ').map(&:strip))
  end

  describe 'convert' do
    before(:each) do
      allow(GitNum).to receive(:git_status_porcelain).and_return([
        'XX file1',
        'XX file2',
        'XX file3',
        'XX file4',
        'XX file5'
      ].join("\n"))
    end

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
  end
end
