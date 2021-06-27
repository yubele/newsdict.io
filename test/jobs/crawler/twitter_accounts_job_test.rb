require 'test_helper'

class Crawler::TwitterAccountsJobTestJob < ActiveJob::TestCase
  # Initialize DB
  def setup
    super
    FactoryBot.create("Configs::Tokens::TwitterAccount")
  end
  
  test "Don't record duplicate unique news" do
    twitter_account = FactoryBot.create("Sources::TwitterAccount", name: :yubele)
    twitter_account.save
    # user_timeline mock
    stub_get('/1.1/statuses/user_timeline.json').with(query: {screen_name: :yubele}).to_return(body: fixture('web_mock/twitter/statuses.json'), headers: {content_type: 'application/json; charset=utf-8'})
    twitter_account.urls.each do |url|
      set_webmock(url)
    end

    # Equeued `Crawler::BaseJob`
    twitter_account.user_timeline.each do |tweet|
      tweet.to_h[:entities][:urls].each do |url|
        ::CrawlersJob.perform_now(twitter_account, url: url[:expanded_url], unique_id: tweet.id)
      end
    end
    
    count = Content.all.count
    # Equeued `Crawler::BaseJob` uniqueress
    twitter_account.user_timeline.each do |tweet|
      tweet.to_h[:entities][:urls].each_with_index do |url, index|
        generated_url = "#{url[:expanded_url]}#{tweet.id}#{index}"
        set_webmock(generated_url)
        ::CrawlersJob.perform_now(twitter_account, url: generated_url, unique_id: tweet.id)
      end
    end
    # Check to return `Contents::Tweet`
    Content.all.each do |content|
      assert_equal content.class, Contents::Tweet
    end
    assert_equal count, Content.all.count
  end
  
  test "queued job" do
    user = FactoryBot.create(:user)
    twitter_account = FactoryBot.create("Sources::TwitterAccount")
    twitter_account.user_id = user.id
    twitter_account.save

    # user_timeline mock
    stub_get('/1.1/statuses/user_timeline.json').with(query: {screen_name: :newsdict}).to_return(body: fixture('web_mock/twitter/statuses.json'), headers: {content_type: 'application/json; charset=utf-8'})

    # Enqueued `Crawler::TwitterAccountsJob`
    Crawler::TwitterAccountsJob.perform_later
    assert_enqueued_jobs 1
  end
end