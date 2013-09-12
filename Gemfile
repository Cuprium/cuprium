source 'https://rubygems.org'
ruby '1.9.3'

gem 'rails', '3.2.14'

gem 'rake'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'pg'

gem 'devise'

gem 'debugger'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

group :development do
  gem 'pry-rails'
  gem 'pry-doc'
  gem 'pry-debugger'
  gem 'capistrano'
  # gem 'capistrano-ext'
  gem 'annotate'
  gem 'guard-cucumber'
end

group :development, :test do
  # gem 'rb-fsevent', :require => false if RUBY_PLATFORM =~ /darwin/i
  gem 'guard-rspec'
  gem 'growl'
end

group :test do
  gem 'cucumber-rails', require: false
  gem 'capybara'
  gem 'shoulda-matchers'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'webmock'
  gem 'database_cleaner'
end


# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'
