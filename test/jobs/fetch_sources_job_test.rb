require 'test_helper'

class FetchSourcesJobTest < ActiveJob::TestCase
  test "Run jobs via twitter account" do
    twitter_account = Sources::TwitterAccount.new({:name => :yubele})

    # user_timeline mock
    stub_get('/1.1/statuses/user_timeline.json').with(query: {screen_name: :yubele}).to_return(body: fixture('web_mock/twitter/statuses.json'), headers: {content_type: 'application/json; charset=utf-8'})
    twitter_account.urls.each do |url|
      set_webmock(url)
      # Save Contents::Web's documents.
      FetchSourcesJob.perform_later(url)
    end
    assert_enqueued_jobs twitter_account.urls.count
  end
end
