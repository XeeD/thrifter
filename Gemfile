source 'https://rubygems.org'

gem 'rails', '3.2.2'
gem 'mysql2'
gem 'jquery-rails'
gem 'decent_exposure'
gem 'haml-rails'
gem 'formtastic'

# Gems used only for compiling assets
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # On Linux, use therubyracer as js runtime.
  # On Windows, execjs can locate the MS runtime, so we don't need this gem
  gem 'therubyracer', :platforms => :ruby_19
  gem 'uglifier', '>= 1.0.3'
  gem 'compass-rails'
end

# Test environment
group :test do
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
  gem 'rspec-rails'
  gem 'shoulda'
  gem 'autotest-rails'
  gem 'autotest-inotify', :platforms => :ruby_19
end
