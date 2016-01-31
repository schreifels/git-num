#!/usr/bin/env bash

# This file is executed by the integration test suite and the fixture generator

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
