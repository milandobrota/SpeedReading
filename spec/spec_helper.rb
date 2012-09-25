# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/rspec'

Capybara.default_driver = :selenium
Capybara.run_server = false # run our own server
Capybara.app_host = 'http://localhost:3001'

DatabaseCleaner.strategy = :truncation

# Capybara.register_driver :selenium do |app|
#   Capybara::Selenium::Driver.new(app, :browser => :chrome)
# end

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false
end

include Capybara::DSL

def server_running?
  !`lsof -i :3001`.blank?
end

def ensure_server_is_running
  system 'rails s -e test -p 3001 -d' unless server_running?
end

def ensure_logged_in_as(role)
  email = "#{role}@test.com"
  password = 'foobar'
  user = User.find_by_email(email)
  user ||= User.create!(:email => email, :password => password, :role => User::ROLE_NAMES.index(role))
  visit '/'
  if page.current_url =~ /sign_in/
    fill_in 'Email', :with => email
    fill_in 'Password', :with => password
    find("#user_new").click_on 'Sign in'
  end
end
