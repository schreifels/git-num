SPEC_ROOT = File.dirname(__FILE__)
load File.join(SPEC_ROOT, '..', 'git-num') # `load` does not require a ".rb" file extension

FIXTURES = {}
['git_num_output', 'git_status_output'].each do |fixture_type|
  Dir.glob(File.join(SPEC_ROOT, 'fixtures', fixture_type, '*')) do |filename|
    fixture_name = File.basename(filename)

    FIXTURES[fixture_name] ||= {}
    FIXTURES[fixture_name][fixture_type] = File.read(filename)
  end
end
FIXTURES.each { |key, val| FIXTURES[key].freeze }
FIXTURES.freeze

describe GitNum do
  def parse_args(args='')
    GitNum.parse_args(args.split(' ').map(&:strip))
  end

  before(:each) do
    git_status_output = FIXTURES['basic.txt']['git_status_output']
    allow(GitNum).to receive(:git_status).and_return(git_status_output)
  end

  describe 'status' do
    FIXTURES.each do |name, fixture|
      it "properly annotates `git status` with indexes in #{name} case" do
        git_status_output = FIXTURES[name]['git_status_output']
        git_num_output    = FIXTURES[name]['git_num_output']

        allow(GitNum).to receive(:git_status).and_return(git_status_output)
        expect { parse_args }.to output(git_num_output).to_stdout
      end
    end

    it 'runs some tests' do
      expect(FIXTURES.length).to be > 3
    end
  end

  describe 'convert' do
    it 'converts args to filenames' do
      expect { parse_args('convert 1 3') }.to \
          output('file1 file3').to_stdout
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
      expect { parse_args('convert') }.to output('').to_stdout
    end

    it 'supports ranges' do
      expect { parse_args('convert 1-1') }.to \
          output('file1').to_stdout
      expect { parse_args('convert 1-3') }.to \
          output('file1 file2 file3').to_stdout
      expect { parse_args('convert 1-3 6 7-9') }.to \
          output('file1 file2 file3 file6 file7 file8 file9').to_stdout
      expect { parse_args('convert 3-4 6 1-5') }.to \
          output('file3 file4 file6 file1 file2 file3 file4 file5').to_stdout
      expect { parse_args('convert 9-12') }.to \
          output('file9 10 11 12').to_stdout

      expect { parse_args('convert abc123-456') }.to \
          output('abc123-456').to_stdout
      expect { parse_args('convert 123-456abc') }.to \
          output('123-456abc').to_stdout
    end

    it 'supports special characters' do
      git_status_output = FIXTURES['special_characters.txt']['git_status_output']
      allow(GitNum).to receive(:git_status).and_return(git_status_output)

      expect { parse_args('convert 1') }.to \
          output('"file with \\"double\\" quotes"').to_stdout
      expect { parse_args('convert 2') }.to \
          output('"file still with \\"double\\" quotes"').to_stdout
      expect { parse_args('convert 3') }.to \
          output(Shellwords.escape("file with 'single' quotes")).to_stdout
      expect { parse_args('convert 4') }.to \
          output(Shellwords.escape("file still with 'single' quotes")).to_stdout
      expect { parse_args('convert 5') }.to \
          output(Shellwords.escape('file with spaces')).to_stdout
      expect { parse_args('convert 6') }.to \
          output(Shellwords.escape('file still with spaces')).to_stdout
      expect { parse_args('convert 13') }.to \
          output(Shellwords.escape('file_with_!@#$%_special_chars')).to_stdout
      expect { parse_args('convert 14') }.to \
          output(Shellwords.escape('file_with_underscores')).to_stdout
    end
  end

  describe 'help' do
    ['-h', '--help', 'help'].each do |flag|
      it "outputs usage with flag: #{flag}" do
        expect { parse_args(flag) }.to output(/USAGE:/).to_stdout
      end
    end
  end

  describe 'version' do
    ['-v', '--version', 'version'].each do |flag|
      it "outputs version with flag: #{flag}" do
        expect { parse_args(flag) }.to output(/git-num version .+/).to_stdout
      end
    end
  end

  describe 'arbitrary git command execution' do
    it 'supports any git command' do
      expect(GitNum).to receive(:system).ordered.with('git add file1 file2 file3')
      parse_args('add 1 file2 3')

      expect(GitNum).to receive(:system).ordered.with('git reset head file1 file2 file3')
      parse_args('reset head 1 file2 3')

      expect(GitNum).to receive(:system).ordered.with('git checkout -- file1 file2 file3')
      parse_args('checkout -- 1 file2 3')

      expect(GitNum).to receive(:system).ordered.with('git custom-cmd file1 file2 file3')
      parse_args('custom-cmd 1 file2 3')
    end
  end
end
