# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/rspec'
require 'database_cleaner'
require 'rack/test'
require "paperclip/matchers"
require 'webmock/rspec'

Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.include Warden::Test::Helpers
  config.include Devise::TestHelpers, :type => :controller
  config.include Paperclip::Shoulda::Matchers
  config.include FactoryGirl::Syntax::Methods
  config.order = "random"
  config.use_transactional_fixtures = false
  config.filter_run_excluding :skipping => true
  config.infer_base_class_for_anonymous_controllers = true
  Warden.test_mode!

  config.before(:each) do
    Warden.test_reset! 
  end

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    # DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.include Capybara::DSL
end

def login_post
  page.driver.post user_session_path, :username => @user.username, :password => @user.password
end 