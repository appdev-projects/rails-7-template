# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.1'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.1.3', '>= 7.1.3.2'

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem 'sprockets-rails'

# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma'

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem 'importmap-rails'

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem 'turbo-rails'

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem 'stimulus-rails'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem 'jbuilder'

# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 4.0'

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Add search functionality
gem 'ransack'

# Add authorization
gem 'pundit'

# AJAX
gem 'jquery-rails'

# Admin
gem 'rails_admin', '~> 3.1'

# Use Sass to process CSS
gem 'sassc-rails'

# Breadcrumbs
gem 'kaminari'

gem 'cssbundling-rails'

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# AppDev Gems
# ===========
gem 'active_link_to'
gem 'appdev_support'
gem 'awesome_print'
gem 'carrierwave'
gem 'devise'
gem 'dotenv'
gem 'faker'
gem 'htmlbeautifier'
gem 'http'
gem 'simple_form'
gem 'sqlite3', '~> 1.4'
gem 'table_print'

group :development do
  gem 'annotate'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'dev_toolbar'
  gem 'draft_generators'
  gem 'grade_runner'
  gem 'pry-rails'
  gem 'rails_db'
  gem 'rails-erd'
  gem 'rufo'
  gem 'specs_to_readme'
  gem 'web-console'
end

group :development, :test do
  gem 'brakeman'
  gem 'bundler-audit'
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'rspec-rails', '~> 6.0.0'
  gem 'rubocop'
end

group :test do
  gem 'capybara'
  gem 'draft_matchers'
  gem 'rspec-html-matchers'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers', '~> 4.0'
  gem 'webdrivers'
  gem 'webmock'
end
