
require 'test_helper'
class ContentTest < ActiveSupport::TestCase
  
  test 'search_by_title' do
    faker_contents = Array.new
    100.times do
      faker_contents << FactoryBot.create(:content)
    end
    sample_faker_content = faker_contents.sample
    searched_content = Content.search_by_title(sample_faker_content.title).first
    
    assert_equal sample_faker_content, searched_content
  end
  
  test 'search_by_tag' do
    faker_contents = Array.new
    100.times do
      faker_contents << FactoryBot.create(:content)
    end
    sample_faker_content = faker_contents.sample
    searched_contents = Content.search_by_tag(sample_faker_content.tags.first)
    
    assert_equal 1, searched_contents.count
    assert_equal sample_faker_content.tags, searched_contents.first.tags
  end
  
  test 'search_by_category_name' do
    faker_contents = Array.new
    faker_categorys = Array.new
    faker_sources = Array.new
    100.times do
      content = FactoryBot.build(:content)
      source = FactoryBot.build("Sources::TwitterAccount")
      category = FactoryBot.create("Configs::Category")
      source.category_id = category.id
      source.save
      content.source_id = source.id
      content.save
      faker_contents << content
      faker_categorys << category
      faker_sources << source
    end
    keyword = faker_categorys.sample.key
    searched_contents = Content.search_by_category_name(keyword)
    
    assert_equal 1, searched_contents.count
    assert_equal searched_contents.first.source.category.key, keyword
  end
  
  test "search_by_mixed(title)" do
    faker_contents = Array.new
    faker_categorys = Array.new
    faker_sources = Array.new
    100.times do
      content = FactoryBot.build(:content)
      source = FactoryBot.build("Sources::TwitterAccount")
      category = FactoryBot.create("Configs::Category")
      source.category_id = category.id
      source.save
      content.source_id = source.id
      content.save
      faker_contents << content
      faker_categorys << category
      faker_sources << source
    end
    sample_faker_content = faker_contents.sample
    search = Proc.new do |keyword|
      searched_contents = Content.search_by_mixed(keyword)
      searched_contents.each do |content|
        assert content.title.match(/#{keyword}/) || content.tags.include?(keyword) || content.source.category.key.match(/#{keyword}/)
      end
    end

    keyword = sample_faker_content.title
    search.call(keyword)

    keyword = sample_faker_content.tags.sample
    search.call(keyword)

    keyword = sample_faker_content.source.category.key
    search.call(keyword)
  end
  
  # Initialize DB
  def setup
    super
    FactoryBot.create("Configs::Tokens::TwitterAccount")
  end
  
  test "save_form_job" do
    urls = Array.new
    twitter_account = FactoryBot.create("Sources::TwitterAccount", name: :yubele)
    # user_timeline mock
    stub_get('/1.1/statuses/user_timeline.json').with(query: {screen_name: :yubele}).to_return(body: fixture('web_mock/twitter/statuses.json'), headers: {content_type: 'application/json; charset=utf-8'})
    twitter_account.urls.each do |url|
      set_webmock(url)
      web_stat = WebStat.stat_by_url(url)
      web_stat[:title] << web_stat[:url] << web_stat[:title]
      attrs = Content.set_attributes_by_web_stat(twitter_account, web_stat)
      Content.save_form_job(attrs)
      urls << attrs[:expanded_url]
    end
    assert_equal Content.where(expanded_url: urls.first).first.count_of_shared, 1
  end

  test "Count of shared" do
    count_of_shared = 5
    urls = Array.new
    twitter_account = FactoryBot.create("Sources::TwitterAccount", name: :yubele)
    twitter_account.save
    # user_timeline mock
    stub_get('/1.1/statuses/user_timeline.json').with(query: {screen_name: :yubele}).to_return(body: fixture('web_mock/twitter/statuses.json'), headers: {content_type: 'application/json; charset=utf-8'})
    count_of_shared.times do |index|
      twitter_account.urls.each do |url|
        set_webmock(url)
        web_stat = WebStat.stat_by_url(url)
        web_stat[:title] << web_stat[:url] << web_stat[:title]
        attrs = Content.set_attributes_by_web_stat(twitter_account, web_stat)
        assert Content.save_form_job(attrs)
        urls << attrs[:expanded_url]
      end
    end
    assert_equal Content.where(expanded_url: urls.first).first.count_of_shared, count_of_shared
  end
end