load 'git-num'

describe GitNum do
  def parse_args(args)
    GitNum.parse_args(args.split(' ').map(&:strip))
  end

  describe 'convert' do
    it 'acts as a pass-through for unmatched args' do
      expect { parse_args('convert .') }.to output('.').to_stdout
      expect { parse_args('convert file1 file2 file3') }.to output('file1 file2 file3').to_stdout
    end
  end
end
