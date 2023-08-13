#!/usr/bin/env bash

# This file is executed when generate_fixture.sh is called

set -e

mkdir dir1
touch dir1/file
if [ -n "$GIT_NUM" ]; then
  $GIT_NUM add 1
else
  git add -A
fi
git commit -m "commit"

echo "modified" > dir1/file

mkdir dir2
touch dir2/file
