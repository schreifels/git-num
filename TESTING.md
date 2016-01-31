# How to run tests

```bash
bundle install
bundle exec rspec spec/unit.rb
bundle exec rspec spec/integration.rb
```

# How fixtures work

Much of the confidence gained through the git-num unit and integration tests
come from fixtures. These are sample states that a Git repository could be in
when git-num is called.

Each of these states can be reached by executing the shell scripts in
`spec/fixtures/generators/` from a Git repository. Given these states, we expect
the text files in `spec/fixtures/git_status_output/` to represent the output of
`git status`. `spec/fixtures/git_num_output/` likewise contains the expected
output of `git num`.

The unit test suite checks (among other things) that when given the `git status`
output in `spec/fixtures/git_status_output/` that `git num` will output the text
in `spec/fixtures/git_num_output/`.

The integration test suite actually executes the scripts in
`spec/fixtures/generators/` and validates their output against
`spec/fixtures/git_num_output/`.

# How to create or update fixtures

1. Create a shell script in `spec/fixtures/generators/` (look at the existing
   scripts for inspiration)
2. Run `spec/fixtures/generate_fixtures.rb`
3. Run the unit and integration test suites. You should see a failure in both
   suites for the fixture you created
4. Edit the corresponding text file in `spec/fixtures/git_num_output/`, adding
   the annotations you expect git-num to output. Remove the `# TODO: ANNOTATE`
   note from the top of the file
5. Run the unit and integration test suites again to validate that your test is
   now passing
