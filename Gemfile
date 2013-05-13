source 'https://rubygems.org'

gem 'rails', '3.2.12'

gem 'pg'
gem "bcrypt-ruby"
gem "paperclip"
gem "will_paginate"

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'bootstrap-sass'

group :test do
  gem 'rspec-rails', '2.11.0'
  gem 'factory_girl_rails', '3.5.0'
  gem 'capybara'
  gem 'launchy'
  gem 'guard-rspec'
  gem 'shoulda-matchers'
end

group :development do
  gem 'annotate', ">=2.5.0"
end

group :test, :development do
  gem 'database_cleaner'
  gem 'rspec-rails', '2.11.0'
  gem 'guard-rspec'
  gem 'rb-fsevent', :require => false if RUBY_PLATFORM =~ /darwin/i
  gem 'fuubar'
end
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

