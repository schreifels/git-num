def colorize(section, str)
  i = case section
      when :staged
        33 # yellow
      when :unstaged
        32 # green
      when :untracked
        36 # cyan
      else
        raise "Unknown section: #{section}"
      end

  "\e[#{i}m#{str}\e[m"
end

FIXTURES = {}
Dir.glob('spec/fixtures/*') do |filename|
  fixture_name = filename.sub('spec/fixtures/', '').sub('_annotated', '').to_sym
  fixture_type = filename.end_with?('_annotated') ? :annotated_status : :git_status

  FIXTURES[fixture_name] ||= {}
  FIXTURES[fixture_name][fixture_type] = File.read(filename)
end
