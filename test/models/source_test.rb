require 'test_helper'
class UserTest < ActiveSupport::TestCase
  test 'Get urls' do
    stub_get('/1.1/statuses/user_timeline.json').with(query: {screen_name: :yubele}).to_return(body: fixture('web_mock/twitter/statuses.json'), headers: {content_type: 'application/json; charset=utf-8'})
    Sources::TwitterAccount.new({:name => :yubele}).urls.each do |url|
      assert url.match(/http/)
    end
  end
end