#!/usr/bin/env bash
# exit on error
set -o errexit

# Ruby on Rails
bundle exec puma -C config/puma.rb
