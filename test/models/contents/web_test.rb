require 'test_helper'

class Contents::WebTest < ActiveSupport::TestCase
  test "save_form_job" do
    urls = Array.new
    twitter_account = Sources::TwitterAccount.new({:name => :yubele})
    # user_timeline mock
    stub_get('/1.1/statuses/user_timeline.json').with(query: {screen_name: :yubele}).to_return(body: fixture('web_mock/twitter/statuses.json'), headers: {content_type: 'application/json; charset=utf-8'})
    twitter_account.urls.each do |url|
      set_webmock(url)
      web_stat = WebStat.stat_by_url(url)
      web_stat[:title] << web_stat[:url] << web_stat[:title]
      attrs = Contents::Web.set_attributes_by_web_stat(twitter_account, web_stat)
      Contents::Web.save_form_job(web_stat, attrs)
      urls << attrs[:expanded_url]
    end
    assert_equal Contents::Web.where(expanded_url: urls.first).first.count_of_shared, 1
  end
  
  test "Count of shared" do
    count_of_shared = 5
    urls = Array.new
    twitter_account = Sources::TwitterAccount.new({:name => :yubele})
    count_of_shared.times do |index|
      twitter_account.urls.each do |url|
        set_webmock(url)
        web_stat = WebStat.stat_by_url(url)
        web_stat[:title] << web_stat[:url] << web_stat[:title]
        attrs = Contents::Web.set_attributes_by_web_stat(twitter_account, web_stat)
        Contents::Web.save_form_job(web_stat, attrs)
        urls << attrs[:expanded_url]
      end
    end
    assert_equal Contents::Web.where(expanded_url: urls.first).first.count_of_shared, count_of_shared
  end
end
