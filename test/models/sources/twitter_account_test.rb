require 'test_helper'

class Sources::TwitterAccountTest < ActiveSupport::TestCase
  # Initialize DB
  def setup
    super
    FactoryBot.build("Posts::Twitter")
  end
  test "Get icon" do
    stub_request(:get, "https://api.twitter.com/1.1/users/show.json?screen_name=newsdict").to_return(body: fixture('web_mock/twitter/user.json'), headers: {content_type: 'application/json; charset=utf-8'})
    stub_request(:get, "https://pbs.twimg.com/profile_images/530654059917619200/36nO20Df_normal.jpeg").
      with(
        headers: {
              'Accept'=>'*/*',
              'Accept-Charset'=>'ISO-8859-1,utf-8;q=0.7,*;q=0.7',
              'Accept-Encoding'=>'gzip,deflate,identity',
              'Accept-Language'=>'en-us,en;q=0.5',
              'Connection'=>'keep-alive',
              'Host'=>'pbs.twimg.com',
              'Keep-Alive'=>'300',
              'User-Agent'=>'web_stat gem agent'
        }).
      to_return(status: 200, body: "", headers: {})
    source = Sources::TwitterAccount.new
    source.name = "newsdict"
    assert_equal source.icon.class, BSON::Binary
  end
end
