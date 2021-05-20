ENV['RAILS_ENV'] ||= 'test'
if ENV['RAILS_ENV'] == 'test'
  require 'simplecov'
  require 'simplecov-lcov'
  SimpleCov::Formatter::LcovFormatter.config.report_with_single_file = true
  SimpleCov.formatter = SimpleCov::Formatter::LcovFormatter
  SimpleCov.start 'rails'  
end
require_relative '../config/environment'
require 'rails/test_help'
require 'twitter_helper'
Dir.glob(Rails.root.join('test/**/*_test.rb')).each { |file| require file}

WebMock.disable_net_connect!(:allow => /coveralls\.io/)
DatabaseCleaner[:redis].db = "redis://#{Rails.application.config_for(:redis)[:host]}/0"
# Overwride.
module WebDriverHelper
  # Get source
  # @param [String] url
  # @param [Integer] delay
  def get_source(url, delay=nil)
    agent = Mechanize.new { |_agent| _agent.user_agent = WebStat::Configure.get["user_agent"] }
    sleep delay unless delay.nil?
    agent.get(url).body
  rescue => e
    driver.quit if driver.class == Selenium::WebDriver
    raise e
  end
  module_function :get_source
end

class ActiveSupport::TestCase
  # Initialize DB
  def setup
    DatabaseCleaner.clean
  end
  # Set a webmock for web_mock/web_stat/blog.html
  # @param [String] url
  def set_webmock(url)
    uri = URI.parse(url)
    # robots.txt mock
    stub_request(:get,"#{uri.scheme}://#{uri.host}/robots.txt").to_return(body: fixture('web_mock/web_stat/robots.txt'), headers: {content_type: 'application/text; charset=utf-8'})
    # web mock
    stub_request(:get, url).to_return(body: fixture('web_mock/web_stat/blog.html'), headers: {content_type: 'application/html; charset=utf-8'})
    # eyecatch_image_path mock
    fetch_as_url = WebStat::FetchAsHtml.new(fixture('web_mock/web_stat/blog.html'))
    fetch_as_url.url = url
    stub_request(:get, fetch_as_url.eyecatch_image_path).to_return(body: fixture('assets/dummy.png'))
  end
end