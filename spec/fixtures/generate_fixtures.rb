#!/usr/bin/env ruby

SPEC_ROOT = File.expand_path('..', File.dirname(__FILE__))
require File.join(SPEC_ROOT, 'lib', 'git_tools')

FIXTURE_GENERATOR_PATHS = Dir.glob(File.join(SPEC_ROOT, 'fixtures', 'generators', '*'))
GIT_STATUS_OUTPUT_PATH = File.join(SPEC_ROOT, 'fixtures', 'git_status_output')
GIT_NUM_OUTPUT_PATH = File.join(SPEC_ROOT, 'fixtures', 'git_num_output')

[GIT_STATUS_OUTPUT_PATH, GIT_NUM_OUTPUT_PATH].each do |path|
  `rm -rf #{path}`
  `mkdir #{path}`
end

FIXTURE_GENERATOR_PATHS.each do |generator_path|
  puts "Generating fixture for #{generator_path} ..."

  git_status_output = nil

  GitTools.create_git_repo do
    `bash #{generator_path}`
    raise "Exited with non-zero status" if $?.exitstatus != 0
    git_status_output = `git -c color.status=always status --long`
    raise "Exited with non-zero status" if $?.exitstatus != 0
  end

  fixture_filename = File.basename(generator_path, '.sh') << '.txt'
  File.write(File.join(GIT_STATUS_OUTPUT_PATH, fixture_filename), git_status_output)
  File.write(File.join(GIT_NUM_OUTPUT_PATH, fixture_filename), "# TODO: ANNOTATE\n" << git_status_output)
end
