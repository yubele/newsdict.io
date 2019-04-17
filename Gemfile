source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Cannot use 2.6.x, because webpacker-4.0.1 is not support
# RubyInstaller(windows) is only supported up to `ruby-2.5.3`
ruby '2.6.2'
# Autoload dotenv in Rails. (https://github.com/bkeepers/dotenv)
gem 'dotenv-rails', '2.7.2', require: 'dotenv/rails-now'

# Active Job
# Simple, efficient background processing for Ruby (http://sidekiq.org)
gem 'sidekiq', '5.2.5'
# Namespaces Redis commands. (http://github.com/resque/redis-namespace)
gem 'redis-namespace', '1.6.0'
# Get the status of  the web pages. (https://newsdict.blog/web-stat/)
gem 'web_stat', '0.1.4'

##
# Social Api Gems
##
# A Ruby interface to the Twitter API. (http://sferik.github.com/twitter/)
gem 'twitter', '6.2.0'

##
# User Manage
##
# Flexible authentication solution for Rails with Warden (https://github.com/plataformatec/devise)
gem 'devise', '4.6.2'

##
# User
##
# User for Rails (https://github.com/sferik/rails_admin)
# Admin for Rails (https://github.com/sferik/rails_admin)
gem 'rails_admin', '1.4.2'
# used by rails_admin
# Kaminari Mongoid adapter (https://github.com/kaminari/kaminari-mongoid)
gem 'kaminari-mongoid', '1.0.1'

##
# mongodb
##
# Elegant Persistence in Ruby for MongoDB. (http://mongoid.org)
gem 'mongoid', '7.0.2'
# A MongoDB GridFS implementation for Mongoid (https://github.com/ahoward/mongoid-grid_fs)
# A MongoDB GridFS implementation for Mongoid (https://github.com/mongoid/mongoid-grid_fs)
gem 'mongoid-grid_fs', '2.4.0'
# Search implementation for Mongoid ORM (http://www.papodenerd.net/mongoid-search-full-text-search-for-your-mongoid-models/)
gem 'mongoid_search', '0.3.6'

##
# default gems
##
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
# Full-stack web application framework. (http://rubyonrails.org)
gem 'rails', '5.2.2'
# Use Puma as the app server
# Puma is a simple, fast, threaded, and highly concurrent HTTP 1.1 server for Ruby/Rack applications (http://puma.io)
gem 'puma', '3.12.0'
# Use SCSS for stylesheets
# Sass adapter for the Rails asset pipeline. (https://github.com/rails/sass-rails)
gem 'sass-rails', '5.0.7'
# Use Uglifier as compressor for JavaScript assets
# Ruby wrapper for UglifyJS JavaScript compressor (http://github.com/lautis/uglifier)
gem 'uglifier', '4.1.20'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
# Use webpack to manage app-like JavaScript modules in Rails (https://github.com/rails/webpacker)
gem 'webpacker', '4.0.1'
# Use CoffeeScript for .coffee assets and views
# CoffeeScript adapter for the Rails asset pipeline. (https://github.com/rails/coffee-rails)
gem 'coffee-rails', '4.2.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
# Turbolinks makes navigating your web application faster (https://github.com/turbolinks/turbolinks)
gem 'turbolinks', '5.2.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# Create JSON structures via a Builder-style DSL (https://github.com/rails/jbuilder)
gem 'jbuilder', '2.8.0'
# Reduces boot times through caching; required in config/boot.rb
# Boot large ruby/rails apps faster (https://github.com/Shopify/bootsnap)
gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  # Ruby fast debugger - base + CLI (https://github.com/deivid-rodriguez/byebug)
  gem 'byebug', '11.0.0'
  # Fixtures for Mongoid (https://github.com/Aethelflaed/mongoid-fixture_set) 
  # Fixtures for Mongoid (https://github.com/Aethelflaed/mongoid-fixture_set)
  gem 'mongoid-fixture_set', :git => 'https://github.com/yubele/mongoid-fixture_set'
  # Lock Gemfile gem declarations to specific Gemfile.lock versions (https://github.com/jeremyf/bundle-locker)
  gem 'bundle-locker', :git => 'https://github.com/newsdict/bundle-locker', :branch => 'feature/ignore_require_and_path'
  # Fast debugging with Pry. (https://github.com/deivid-rodriguez/pry-byebug)
  gem 'pry-byebug', '3.7.0'
end

group :development do
  # Add comments to your Gemfile with each dependency's description. (https://github.com/ivantsepp/annotate_gem)
  gem 'annotate_gem', :git => 'https://github.com/newsdict/annotate_gem.git', :branch => :bundler_bump
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  # A debugging tool for your Ruby on Rails applications. (https://github.com/rails/web-console)
  gem 'web-console', '3.7.0'
  # Listen to file modifications (https://github.com/guard/listen)
  gem 'listen', '3.1.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  # Rails application preloader (https://github.com/rails/spring)
  gem 'spring', '2.0.2'
  # Makes spring watch files using the listen gem. (https://github.com/jonleighton/spring-watcher-listen)
  gem 'spring-watcher-listen', '2.0.1'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  # Capybara aims to simplify the process of integration testing Rack applications, such as Rails, Sinatra or Merb (https://github.com/teamcapybara/capybara)
  gem 'capybara', '3.14.0'
  # The next generation developer focused tool for automated testing of webapps (https://github.com/SeleniumHQ/selenium)
  gem 'selenium-webdriver', '3.141.0'
  # Easy installation and use of chromedriver to run system tests with Chrome
  # Easy installation and use of chromedriver. (https://github.com/flavorjones/chromedriver-helper)
  gem 'chromedriver-helper', '2.1.0'
  ## Library for stubbing HTTP requests in Ruby. (http://github.com/bblimke/webmock)
  # Library for stubbing HTTP requests in Ruby. (http://github.com/bblimke/webmock)
  gem 'webmock', '3.5.1'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
# Timezone Data for TZInfo (http://tzinfo.github.io)
gem 'tzinfo-data', '1.2018.9'
