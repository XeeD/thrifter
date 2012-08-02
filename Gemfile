source 'https://rubygems.org'

gem 'rails', '3.2.2'
gem 'mysql2'
gem 'jquery-rails'
gem 'haml-rails'
gem 'formtastic'
gem 'awesome_nested_set'
gem 'acts_as_list'
gem 'rack-mini-profiler'
gem 'carrierwave'
gem 'rmagick'

# Gems used only for compiling assets
group :assets, :cucumber do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # On Linux, use therubyracer as js runtime.
  # On Windows, execjs can locate the MS runtime, so we don't need this gem
  gem 'therubyracer', :platforms => :ruby_19
  gem 'uglifier', '>= 1.0.3'
  gem 'compass-rails'
end

# Test environment
group :test, :cucumber do
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
  gem 'shoulda'
  gem 'autotest-rails'
  gem 'capybara-screenshot'
end

group :cucumber do
  gem 'selenium-webdriver'
  gem 'capybara-selenium-remote'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'spork'
end

group :darwin do
  gem 'autotest-fsevent'
  gem 'autotest-growl'
end

group :linux do
  gem 'activerecord-postgresql-adapter'
  group :development, :test do
    gem 'autotest-inotify'
  end
end