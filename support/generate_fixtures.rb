#!/usr/bin/env ruby

# Generates test fixtures with git. Replaces the spec/fixtures/ directory on
# each run. For each fixture, two files are created:
#   1.) Contains the output of `git status`
#   2.) Placeholder for the expected output of `git num`. Must be manually
#       edited with annotations. Don't forget to remove the "TODO: ANNOTATE"
#       note at the top of the file.

require 'tmpdir'

FIXTURES_PATH = File.join(File.dirname(__FILE__), 'spec', 'fixtures')
`rm -rf #{FIXTURES_PATH}`
`mkdir #{FIXTURES_PATH}`

def create_fixture(name)
  git_status_output = nil

  Dir.mktmpdir do |tmpdir|
    Dir.chdir(tmpdir) do
      `git init .`
      `git commit --allow-empty -m "Initial commit"`

      `git config color.status.added "yellow"`
      `git config color.status.changed "green"`
      `git config color.status.untracked "cyan"`

      yield
      git_status_output = `git -c color.status=always status --long`
    end
  end

  File.write(File.join(FIXTURES_PATH, name), git_status_output)
  File.write(File.join(FIXTURES_PATH, name << '_annotated'), "TODO: ANNOTATE\n" << git_status_output)
end

create_fixture('basic') do
  `touch file2 file3 file4 file5`
  `git add -A`
  `git commit -m "commit"`

  `echo "modified" > file2`
  `echo "modified" > file3`
  `echo "modified" > file4`
  `echo "modified" > file5`

  `touch file1 file6 file7 file8 file9`
  `git add file1 file2`
end

create_fixture('directories') do
  `mkdir dir1`
  `touch dir1/file`
  `git add -A`
  `git commit -m "commit"`

  `echo "modified" > dir1/file`

  `mkdir dir2`
  `touch dir2/file`
end

create_fixture('renames') do
  `touch file1`
  `git add -A`
  `git commit -m "commit"`

  `git mv file1 file2`
  `echo "modified" > file2`
end

create_fixture('special_characters') do
  # There needs to be content in the files for git to correctly detect renaming
  `echo "double quotes" > 'file with "double" quotes'`
  `echo "single quotes" > "file with 'single' quotes"`
  `echo "spaces" > "file with spaces"`
  `echo "backslashes" > 'file\\with\backslashes'`
  `git add -A`
  `git commit -m "commit"`

  `git mv 'file with "double" quotes' 'file still with "double" quotes'`
  `git mv "file with 'single' quotes" "file still with 'single' quotes"`
  `git mv "file with spaces" "file still with spaces"`
  `git mv 'file\\with\backslashes' 'file\\still\\with\backslashes'`

  `echo "modified" > 'file still with "double" quotes'`
  `echo "modified" > "file still with 'single' quotes"`
  `echo "modified" > "file still with spaces"`
  `echo "modified" > 'file\\still\\with\backslashes'`

  `touch 'file_with_!@#$%_special_chars'`
  `touch file_with_underscores`
end
