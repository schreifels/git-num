#!/usr/bin/env bash

# This file is executed when generate_fixture.sh is called

set -e

touch file1
if [ -n "$GIT_NUM" ]; then
  $GIT_NUM add 1
else
  git add -A
fi
git commit -m "commit"

git mv file1 file2
echo "modified" > file2
