require 'test_helper'

class Sources::TwitterAccountTest < ActiveSupport::TestCase
  # Initialize DB
  def setup
    super
    config = FactoryBot.create("Configs::Tokens::TwitterAccount")
    twitter = FactoryBot.build("Posts::Twitter")
    twitter.twitter_token_id = config.id
    twitter.save
  end
  test "Get icon" do
    stub_request(:get, "https://api.twitter.com/1.1/users/show.json?screen_name=newsdict").to_return(body: fixture('web_mock/twitter/user.json'), headers: {content_type: 'application/json; charset=utf-8'})
    stub_request(:get, "https://pbs.twimg.com/profile_images/530654059917619200/36nO20Df_normal.jpeg").to_return(status: 200, body: "", headers: {})
    source = Sources::TwitterAccount.new
    source.name = "newsdict"
    assert_equal source.icon.class, BSON::Binary
  end

  test "Get the Contents::Tweet" do
    twitter_account = FactoryBot.create("Sources::TwitterAccount")
    stub(:twitter, '/1.1/statuses/user_timeline.json', 'web_mock/twitter/statuses.json', {screen_name: twitter_account.name})
    twitter_account.contents.each do |content|
      assert_equal content.class, Contents::Tweet
    end
  end

  test "Get relation_accounts" do
    twitter_account = FactoryBot.create("Sources::TwitterAccount")
    stub(:twitter, '/1.1/friends/list.json', 'web_mock/twitter/friends.json', {cursor: -1, screen_name: twitter_account.name})
    twitter_account.relation_accounts.each do |account|
      assert_equal account.class, Sources::Relations::TwitterAccount
    end

    assert_equal Sources::Relations::TwitterAccount.all.count, twitter_account.relation_accounts.count
  end
end