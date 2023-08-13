## How to run tests

```
make test
```

## Fixtures

Among other things, the `fixtures/` directory contains:

- `git_status/` - Example outputs from the `git status` command
- `git_num_status/` - Expected outputs from the `git num status` command for each of the fixtures in the `git_status/` directory
- `git_num_convert/` - Expected outputs from `git num convert` given the filenames in each of the fixtures in the `git_status/` directory (to test shellwords escaping)

These files can be generated automatically via:

```
./fixtures/generate_fixture.sh <fixture name>
```

where `<fixture name>` would be, for example, "basic" for the fixture generator defined in `fixtures/generators/basic.sh`.
