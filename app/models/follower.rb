class Follower < ApplicationRecord
  include Mongoid::Document
  field :followee_user_id, type: BSON::ObjectId
  field :user_id, type: BSON::ObjectId
  validates :user_id, :uniqueness => {:scope => :followee_user_id}
  index({followee_user_id: 1, user_id: 1}, {unique: true})
  include Mongoid::Timestamps
  class << self
    # Follow user
    # @param [User] followee_user
    # @param [User] user
    # @return [Follower|nil]
    def follow(followee_user:, user:)
      Follower.create!({
        followee_user_id: followee_user.id,
        user_id: user.id
      })
    rescue Mongoid::Errors::Validations
      # nothing
    end
    # Returns an array of `Follow` as seen from the `user`
    # @param [User] user
    # @return [Array] Array of `Follower`
    def from_user(user)
      Follower.where(user_id: user.id)
    end
    # Returns an array of `Follow` as seen from the `friend_user`
    # @param [User] follower_user
    # @return [Array] Array of `Follower`
    def from_followee_user(followee_user)
      Follower.where(followee_user_id: followee_user.id)
    end
  end
end