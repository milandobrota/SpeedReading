source 'https://rubygems.org'

gem 'rails', :git => "git://github.com/rails/rails.git", :branch => "3-1-stable"

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'pg', '0.12.2'
gem 'devise', '2.0.0'
gem 'haml-rails'
gem 'bootstrap-will_paginate'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer'

  gem 'uglifier'
  gem "twitter-bootstrap-rails"
end

group :development do
  gem 'hpricot'
  gem 'ruby_parser'
end

# needs to be in the development group to expose generators and rake tasks without having to type RAILS_ENV=test
group :test, :development do
  gem 'capybara', :require => false
  gem 'rspec-rails', :require => false
  gem 'debugger'
  gem 'database_cleaner'
end

gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'lazy_high_charts'
gem "paperclip", "~> 3.0"
gem 'aws-sdk'
gem 'aws-s3'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'
