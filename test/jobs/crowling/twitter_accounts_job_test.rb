require 'test_helper'

class Crowling::TwitterAccountsJobTestJob < ActiveJob::TestCase
  test "Run jobs via twitter account" do
    twitter_account = Sources::TwitterAccount.new({:name => :yubele})

    # user_timeline mock
    stub_get('/1.1/statuses/user_timeline.json').with(query: {screen_name: :yubele}).to_return(body: fixture('web_mock/twitter/statuses.json'), headers: {content_type: 'application/json; charset=utf-8'})
    twitter_account.urls.each do |url|
      set_webmock(url)
      # Save Contents::Web's documents.
      Crowling::BaseJob.perform_later(url)
    end
    assert_enqueued_jobs twitter_account.urls.count
  end

  test "Don't record duplicate unique news" do
    twitter_account = Sources::TwitterAccount.new({:name => :yubele})
    # user_timeline mock
    stub_get('/1.1/statuses/user_timeline.json').with(query: {screen_name: :yubele}).to_return(body: fixture('web_mock/twitter/statuses.json'), headers: {content_type: 'application/json; charset=utf-8'})
    twitter_account.urls.each do |url|
      set_webmock(url)
    end

    # Equeued `Crowling::BaseJob`
    twitter_account.user_timeline.each do |tweet|
      tweet.to_h[:entities][:urls].each do |url|
        unless Contents::Web.where(unique_id: tweet.id).exists?
          Crowling::BaseJob.perform_now(twitter_account, url[:expanded_url], unique_id: tweet.id)
        end
      end
    end
    count = Contents::Web.all.count

    # Equeued `Crowling::BaseJob` uniqueress
    twitter_account.user_timeline.each do |tweet|
      tweet.to_h[:entities][:urls].each_with_index do |url, index|
        generated_url = "#{url[:expanded_url]}#{tweet.id}#{index}"
        set_webmock(generated_url)
        unless Contents::Web.where(unique_id: tweet.id).exists?
          Crowling::BaseJob.perform_now(twitter_account, generated_url, unique_id: tweet.id)
        end
      end
    end
    assert_equal count, Contents::Web.all.count
  end
  test "queued job" do
    user = FactoryBot.create(:user)
    twitter_account = FactoryBot.create("Sources::TwitterAccount")
    twitter_account.user_id = user.id
    twitter_account.save

    # user_timeline mock
    stub_get('/1.1/statuses/user_timeline.json').with(query: {screen_name: :newsdict}).to_return(body: fixture('web_mock/twitter/statuses.json'), headers: {content_type: 'application/json; charset=utf-8'})

    # Enqueued `Crowling::TwitterAccountsJob`
    Crowling::TwitterAccountsJob.perform_later
    assert_enqueued_jobs 1
  end
end