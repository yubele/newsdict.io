ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'twitter_helper'
Dir.glob(Rails.root.join('test/**/*_test.rb')).each { |file| require file}

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