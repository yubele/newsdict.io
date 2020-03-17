require 'test_helper'

class TwitterAccountsJobTestJob < ActiveJob::TestCase
  test "queued job" do
    user = FactoryBot.create(:user)
    twitter_account = FactoryBot.create("Sources::TwitterAccount")
    twitter_account.user_id = user.id
    twitter_account.save

    # user_timeline mock
    stub_get('/1.1/statuses/user_timeline.json').with(query: {screen_name: :newsdict}).to_return(body: fixture('web_mock/twitter/statuses.json'), headers: {content_type: 'application/json; charset=utf-8'})

    # Enqueued `TwitterAccountsJob`
    TwitterAccountsJob.perform_later
    assert_enqueued_jobs 1

    twitter_account = Sources::TwitterAccount.new({:name => :yubele})
    # user_timeline mock
    stub_get('/1.1/statuses/user_timeline.json').with(query: {screen_name: :yubele}).to_return(body: fixture('web_mock/twitter/statuses.json'), headers: {content_type: 'application/json; charset=utf-8'})
    twitter_account.urls.each do |url|
      set_webmock(url)
    end
    
    # Equeued `FetchSourcesJob` uniqueress
    TwitterAccountsJob.perform_now
    assert_enqueued_jobs twitter_account.urls.count, only: FetchSourcesJob
    TwitterAccountsJob.perform_now
    assert_enqueued_jobs twitter_account.urls.count, only: FetchSourcesJob
  end
end