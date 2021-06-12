require 'test_helper'
class Configs::Tokens::TwitterAccountTest < ActiveSupport::TestCase
  test 'get_token' do
    FactoryBot.create("Configs::Tokens::TwitterAccount")
    assert_equal Configs::Tokens::TwitterAccount.client[:token].class, Twitter::REST::Client
  end
end
