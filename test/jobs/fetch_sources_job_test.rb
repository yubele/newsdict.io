require 'test_helper'

class FetchSourcesJobTest < ActiveJob::TestCase
  test "the truth" do
    twitter_account = Sources::TwitterAccount.new({:name => :yubele})

    # user_timeline mock
    stub_get('/1.1/statuses/user_timeline.json').with(query: {screen_name: :yubele}).to_return(body: fixture('web_mock/twitter/statuses.json'), headers: {content_type: 'application/json; charset=utf-8'})
    twitter_account.urls.each do |url|
      uri = URI.parse(url)
      # robots.txt mock
      stub_request(:get,"#{uri.scheme}://#{uri.host}/robots.txt").to_return(body: fixture('web_mock/web_stat/robots.txt'), headers: {content_type: 'application/text; charset=utf-8'})
      # web mock
      stub_request(:get, url).to_return(body: fixture('web_mock/web_stat/blog.html'), headers: {content_type: 'application/html; charset=utf-8'})
      # eyecatch_image_path mock
      fetch_as_url = WebStat::FetchAsHtml.new(fixture('web_mock/web_stat/blog.html'))
      stub_request(:get, "#{uri.scheme}://#{uri.host}#{fetch_as_url.eyecatch_image_path}").to_return(body: "")
    end

    # Flush Contents::Web's documents.
    Contents::Web.destroy_all

    # Save Contents::Web's documents.
    FetchSourcesJob.new.perform(twitter_account)
    assert_enqueued_jobs 0
    assert_equal(twitter_account.urls.count, Contents::Web.count)

    FetchSourcesJob.perform_later(twitter_account)
    assert_enqueued_jobs 1
  end
end
