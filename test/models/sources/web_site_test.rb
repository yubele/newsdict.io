require 'test_helper'

class Sources::WebSiteTest < ActiveSupport::TestCase
  test "Get urls" do
    # Mock
    stub_request(:get, "https://newsdict.blog")
      .to_return(body: fixture('web_mock/web_stat/blog.html'), headers: {content_type: 'application/html; charset=utf-8'})
    sources_url = Sources::WebSite.new
    sources_url.source_url = "https://newsdict.blog"
    assert_equal sources_url.urls.count, 15
  end
  test "Get icon" do
    # Mock
    stub_request(:get, "https://newsdict.blog").
      to_return(body: fixture('web_mock/web_stat/blog.html'), headers: {content_type: 'application/html; charset=utf-8'})
    stub_request(:get, "https://newsdict.blog/favicon.ico").
      to_return(status: 200, body: "", headers: {})
    source = Sources::WebSite.new
    source.source_url = "https://newsdict.blog"
    assert_equal source.icon.class, BSON::Binary
  end
end