require 'test_helper'

class FollowTest < ActiveSupport::TestCase
  include Warden::Test::Helpers
  def setup
    super
    @me = FactoryBot.create(:user)
    @user1 = FactoryBot.create(:user)
    login_as(@me, scope: :user)
  end
  test "Request Follow" do
    follower = Follower.follow(followee_user: @user1, user: @me)
    assert_equal follower.followee_user_id, @user1.id
    assert_equal follower.user_id, @me.id
    assert_nil Follower.follow(followee_user: @user1, user: @me)
  end
end