require 'test_helper'

class CrowlingSourcesJobTest < ActiveJob::TestCase
  test "Run jobs via twitter account" do
    twitter_account = Sources::TwitterAccount.new({:name => :yubele})

    # user_timeline mock
    stub_get('/1.1/statuses/user_timeline.json').with(query: {screen_name: :yubele}).to_return(body: fixture('web_mock/twitter/statuses.json'), headers: {content_type: 'application/json; charset=utf-8'})
    twitter_account.urls.each do |url|
      set_webmock(url)
      # Save Contents::Web's documents.
      CrowlingSourcesJob.perform_later(url)
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

    # Equeued `CrowlingSourcesJob`
    twitter_account.user_timeline.each do |tweet|
      tweet.to_h[:entities][:urls].each do |url|
        unless Contents::Web.where(unique_id: tweet.id).exists?
          CrowlingSourcesJob.perform_now(twitter_account, url[:expanded_url], unique_id: tweet.id)
        end
      end
    end
    count = Contents::Web.all.count

    # Equeued `CrowlingSourcesJob` uniqueress
    twitter_account.user_timeline.each do |tweet|
      tweet.to_h[:entities][:urls].each_with_index do |url, index|
        generated_url = "#{url[:expanded_url]}#{tweet.id}#{index}"
        set_webmock(generated_url)
        unless Contents::Web.where(unique_id: tweet.id).exists?
          CrowlingSourcesJob.perform_now(twitter_account, generated_url, unique_id: tweet.id)
        end
      end
    end
    assert_equal count, Contents::Web.all.count
  end
end
