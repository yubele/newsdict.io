require 'test_helper'

class FetchUrlsJobTest < ActiveJob::TestCase
  test "the truth" do
    stub_get('/1.1/statuses/user_timeline.json').with(query: {screen_name: :yubele}).to_return(body: fixture('web_mock/twitter/statuses.json'), headers: {content_type: 'application/json; charset=utf-8'})
    # @todo Implementation
    # - WebMock for WebStat::Fetch.eyecatch_image_path
    # - WebMock for WebStat::FetchAsUrl
    FetchUrlsJob.new.perform(Sources::TwitterAccount.new({:name => :yubele}))
    assert_enqueued_jobs 0
  end
end
