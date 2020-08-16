require 'test_helper'

class Sources::WebSiteTest < ActiveSupport::TestCase
  test "Get urls" do
    # Mock
    stub_request(:get, "https://newsdict.blog")
      .to_return(body: fixture('web_mock/web_stat/blog.html'), headers: {content_type: 'application/text; charset=utf-8'})
    sources_url = Sources::WebSite.new
    sources_url.source_url = "https://newsdict.blog"
    assert_equal sources_url.urls.count, 48
  end
end
