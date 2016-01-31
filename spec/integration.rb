DEBUG_MODE = false

SPEC_ROOT = File.dirname(__FILE__)
require File.join(SPEC_ROOT, 'lib', 'git_tools')

GIT_NUM = File.expand_path(File.join(SPEC_ROOT, '..', 'git-num'))
FIXTURE_GENERATOR_PATHS = Dir.glob(File.join(SPEC_ROOT, 'fixtures', 'generators', '*'))
GIT_NUM_OUTPUT_PATH = File.join(SPEC_ROOT, 'fixtures', 'git_num_output')

describe 'GitNum integration with Git' do
  def expected_git_num_output_for_generator(generator_path)
    File.read(File.join(GIT_NUM_OUTPUT_PATH, File.basename(generator_path, '.sh') << '.txt'))
  end

  around(:each) do |example|
    GitTools.create_git_repo { example.run }
  end

  FIXTURE_GENERATOR_PATHS.each do |generator_path|
    it "behaves as expected when executing #{File.basename(generator_path)}" do
      cmd = "GIT_NUM=#{GIT_NUM} bash #{generator_path}"
      if DEBUG_MODE
        puts "Executing #{generator_path}:\n\n"
        system(cmd)
        puts "\n\n\n\n\n\n"
      else
        `#{cmd}`
      end
      expect($?.exitstatus).to eq 0

      expect(`#{GIT_NUM}`).to eq expected_git_num_output_for_generator(generator_path)
      expect($?.exitstatus).to eq 0
    end
  end

  it 'runs some tests' do
    expect(FIXTURE_GENERATOR_PATHS.length).to be > 3
  end
end
