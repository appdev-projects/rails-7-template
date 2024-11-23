#!/usr/bin/env bash
# exit on error
set -o errexit

# Ruby on Rails
bundle exec rake db:migrate
bundle exec rake db:seed
bundle exec rails server
