#!/usr/bin/env bash

# This file is executed when generate_fixture.sh is called

set -e

touch file2 file3 file4 file5
if [ -n "$GIT_NUM" ]; then
  $GIT_NUM add 1-4
else
  git add -A
fi
git commit -m "commit"

echo "modified" > file2
echo "modified" > file3
echo "modified" > file4
echo "modified" > file5

touch file1 file6 file7 file8 file9
if [ -n "$GIT_NUM" ]; then
  $GIT_NUM add 1 5
else
  git add file1 file2
fi
