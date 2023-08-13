#!/usr/bin/env bash

# Generates fixtures for the provided fixture name (see TESTING.md for details)
# e.g. ./fixtures/generate_fixture.sh basic

set -e

FIXTURE_NAME="$1"
CURRENT_DIR="$(realpath "$(dirname "$0")")"

GENERATE_SCRIPT_PATH="$CURRENT_DIR/generators/$1.sh"
GIT_STATUS_OUTPUT_PATH="$CURRENT_DIR/git_status/$FIXTURE_NAME.txt"
GIT_NUM_STATUS_OUTPUT_PATH="$CURRENT_DIR/git_num_status/$FIXTURE_NAME.txt"
GIT_NUM_CONVERT_OUTPUT_PATH="$CURRENT_DIR/git_num_convert/$FIXTURE_NAME.txt"

if [ ! -f "$GENERATE_SCRIPT_PATH" ]; then
  echo -e "A fixture generation script was not found at path:\n$GENERATE_SCRIPT_PATH"
  exit 1
fi

TMP_DIR="$(mktemp -d -t git-num-fixture)"
pushd "$TMP_DIR"

git init .
git commit --allow-empty -m "Initial commit"

git config color.status.added "yellow"
git config color.status.changed "green"
git config color.status.untracked "cyan"

$GENERATE_SCRIPT_PATH

GIT_STATUS_OUTPUT="$(git -c color.status=always -c status.short=false status)"

popd
rm -rf "$TMP_DIR"

echo
echo
echo "Creating $GIT_STATUS_OUTPUT_PATH..."
echo "$GIT_STATUS_OUTPUT" > "$GIT_STATUS_OUTPUT_PATH"

echo "Creating $GIT_NUM_STATUS_OUTPUT_PATH..."
echo -e "# TODO: Annotate with numbers\n\n" > "$GIT_NUM_STATUS_OUTPUT_PATH"
echo "$GIT_STATUS_OUTPUT" >> "$GIT_NUM_STATUS_OUTPUT_PATH"

echo "Creating $GIT_NUM_CONVERT_OUTPUT_PATH..."
echo "# TODO: Add filenames here" > "$GIT_NUM_CONVERT_OUTPUT_PATH"

echo
echo "Done!"
