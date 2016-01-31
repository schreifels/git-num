require 'tmpdir'

class GitTools
  class << self
    def create_git_repo
      Dir.mktmpdir do |tmpdir|
        Dir.chdir(tmpdir) do
          `git init .`
          `git commit --allow-empty -m "Initial commit"`

          `git config color.status.added "yellow"`
          `git config color.status.changed "green"`
          `git config color.status.untracked "cyan"`

          yield
        end
      end
    end
  end
end
