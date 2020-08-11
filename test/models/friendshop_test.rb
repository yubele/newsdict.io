require 'test_helper'

class FriendshipTest < ActiveSupport::TestCase
  include Warden::Test::Helpers
  def setup
    super
    @me = FactoryBot.create(:user)
    @user1 = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user)
    @user3 = FactoryBot.create(:user)
    @user4 = FactoryBot.create(:user)
    login_as(@me, scope: :user)
  end
  test "Request friendship" do
    assert Friendship.request(friend_user: @user1, user: @me)
    assert_nil Friendship.request(friend_user: @user1, user: @me)
  end
  test "Check default status" do
    friend = Friendship.request(friend_user: @user1, user: @me)
    assert_equal friend.status_id, 0
    assert_equal friend.status, Friendship::STATUS[0]
  end
  test "Check friend status" do
    Friendship.request(friend_user: @user1, user: @me)
    friendships = Friendship.from_user(@me)
    friendships.first.approve
    assert_equal friendships.first.status_id, 1
    assert_equal friendships.first.status, Friendship::STATUS[1]
  end
end