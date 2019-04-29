ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'twitter_helper'

# initialize db
DatabaseCleaner.clean

class ActiveSupport::TestCase
  # Add more helper methods to be used by all tests here...
end