#!/usr/bin/env bash

# This file is executed when generate_fixture.sh is called

set -e

# There needs to be content in the files for git to correctly detect renaming
echo "double quotes" > 'file with "double" quotes'
echo "single quotes" > "file with 'single' quotes"
echo "spaces" > "file with spaces"
echo "backslashes" > 'file\\with\backslashes'
if [ -n "$GIT_NUM" ]; then
  $GIT_NUM add 1-4
else
  git add -A
fi
git commit -m "commit"

git mv 'file with "double" quotes' 'file still with "double" quotes'
git mv "file with 'single' quotes" "file still with 'single' quotes"
git mv "file with spaces" "file still with spaces"
git mv 'file\\with\backslashes' 'file\\still\\with\backslashes'

echo "modified" > 'file still with "double" quotes'
echo "modified" > "file still with 'single' quotes"
echo "modified" > "file still with spaces"
echo "modified" > 'file\\still\\with\backslashes'

touch 'file_with_!@#$%_special_chars'
touch file_with_underscores
