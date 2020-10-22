require 'test_helper'
class Posts::TwitterTest < ActiveSupport::TestCase
  test 'post' do
    posts_twitter = FactoryBot.build("Posts::Twitter")
    tokens_twitter = FactoryBot.create("Configs::Tokens::Twitter")
    posts_twitter.twitter_token_id = tokens_twitter.id
    posts_twitter.save
    100.times.each do |index|
      FactoryBot.create("CollectTag")
    end
    posts_twitter.bind_body
  end
end