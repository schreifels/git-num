#!/usr/bin/env bash

# Generates a sample git project for a screenshot demonstrating git-num

# Setup ########################################################################

PS1="~/sample-git-project $ "
mkdir git-num-sample-repo
cd git-num-sample-repo
git init .

mkdir -p app/controllers
mkdir -p spec/controllers
mkdir -p app/models
mkdir -p spec/models
mkdir -p app/helpers

touch app/controllers/widgets_controller.rb
touch spec/controllers/widgets_controller_spec.rb
touch app/models/widget.rb
touch spec/models/widget_spec.rb
touch app/helpers/.keep
touch README

git add -A
git commit -m "Initial commit"

echo "modified" > app/controllers/widgets_controller.rb
echo "modified" > spec/controllers/widgets_controller_spec.rb
echo "modified" > app/models/widget.rb
echo "modified" > spec/models/widget_spec.rb
touch app/helpers/widget_helper.rb

git mv README README.md
git add app/controllers/widgets_controller.rb spec/controllers/widgets_controller_spec.rb

git num

# Teardown #####################################################################

cd .. && rm -rf git-num-sample-repo
