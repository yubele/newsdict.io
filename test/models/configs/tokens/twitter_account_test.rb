require 'test_helper'
class Configs::Tokens::TwitterAccountTest < ActiveSupport::TestCase
  test 'get_token' do
    FactoryBot.create("Configs::Tokens::Twitter")
    assert_equal Configs::Tokens::Twitter.get_token.class, Twitter::REST::Client
  end
end
