load 'git-num'
require 'lib/fixtures'

describe GitNum do
  def parse_args(args='')
    GitNum.parse_args(args.split(' ').map(&:strip))
  end

  describe 'status' do
    GitNumFixtures::FIXTURES.each do |name, fixture|
      it "properly annotates `git status` with indexes in #{name} case" do
        allow(GitNum).to receive(:git_status_porcelain)
            .and_return(GitNumFixtures::FIXTURES[name][:porcelain])
        allow(GitNum).to receive(:git_status)
            .and_return(GitNumFixtures::FIXTURES[name][:status])
        expect { parse_args }.to \
            output(GitNumFixtures::FIXTURES[name][:annotated_status]).to_stdout
      end
    end

    it 'runs some tests' do
      expect(GitNumFixtures::FIXTURES.length).to be > 2
    end
  end

  describe 'convert' do
    before(:each) do
      allow(GitNum).to receive(:git_status_porcelain)
          .and_return(GitNumFixtures::FIXTURES[:basic][:porcelain])
    end

    it 'converts args to filenames' do
      expect { parse_args('convert 1 file2 3') }.to \
          output('"file1" file2 "file3"').to_stdout
    end

    it 'acts as a pass-through for unmatched args' do
      expect { parse_args('convert .') }.to \
          output('.').to_stdout
      expect { parse_args('convert file1 file2 other-file') }.to \
          output('file1 file2 other-file').to_stdout
    end

    it 'supports a mix of indexes and filenames' do
      expect { parse_args('convert file1 1 3 other-file') }.to \
          output('file1 "file1" "file3" other-file').to_stdout
    end

    it 'supports no args' do
      expect { parse_args('convert') }.to output('').to_stdout
    end

    it 'supports ranges' do
      expect { parse_args('convert 1-1') }.to \
          output('"file1"').to_stdout
      expect { parse_args('convert 1-3') }.to \
          output('"file1" "file2" "file3"').to_stdout
      expect { parse_args('convert 1-3 6 7-10') }.to \
          output('"file1" "file2" "file3" "file6" "file7" "file8" "file9" "file10"').to_stdout
      expect { parse_args('convert 3-4 6 1-5') }.to \
          output('"file3" "file4" "file6" "file1" "file2" "file3" "file4" "file5"').to_stdout
      expect { parse_args('convert 10-15') }.to \
          output('"file10" 11 12 13 14 15').to_stdout
    end

    it 'supports special characters' do
      allow(GitNum).to receive(:git_status_porcelain)
          .and_return(GitNumFixtures::FIXTURES[:special_characters][:porcelain])
      expect { parse_args('convert 1') }.to output('"file with \\"double\\" quotes"').to_stdout
      expect { parse_args('convert 2') }.to output('"file still with \\"double\\" quotes"').to_stdout
      expect { parse_args('convert 3') }.to output('"file with \'single\' quotes"').to_stdout
      expect { parse_args('convert 4') }.to output('"file still with \'single\' quotes"').to_stdout
      expect { parse_args('convert 5') }.to output('"file with spaces"').to_stdout
      expect { parse_args('convert 6') }.to output('"file still with spaces"').to_stdout
      expect { parse_args('convert 7') }.to output('"file_with_!@#$%_special_chars"').to_stdout
      expect { parse_args('convert 8') }.to output('"file_with_underscores"').to_stdout
    end
  end

  describe 'arbitrary git command execution' do
    before(:each) do
      allow(GitNum).to receive(:git_status_porcelain)
          .and_return(GitNumFixtures::FIXTURES[:basic][:porcelain])
    end

    it 'supports any git command' do
      expect(GitNum).to receive(:`).ordered.with('git add "file1" file2 "file3"')
      parse_args('add 1 file2 3')

      expect(GitNum).to receive(:`).ordered.with('git reset head "file1" file2 "file3"')
      parse_args('reset head 1 file2 3')

      expect(GitNum).to receive(:`).ordered.with('git checkout -- "file1" file2 "file3"')
      parse_args('checkout -- 1 file2 3')

      expect(GitNum).to receive(:`).ordered.with('git custom-cmd "file1" file2 "file3"')
      parse_args('custom-cmd 1 file2 3')
    end
  end
end
