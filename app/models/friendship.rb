class Friendship < ApplicationRecord
  include Mongoid::Document
  field :friend_user_id, type: BSON::ObjectId
  field :status_id, type: Integer, default: 0
  field :user_id, type: BSON::ObjectId
  validates :user_id, :uniqueness => {:scope => :friend_user_id}
  index({friend_user_id: 1, user_id: 1}, {unique: true})
  include Mongoid::Timestamps
  STATUS = {
    0 => :request,
    1 => :approved}
  # symbol of status
  # @return [Symbol]
  def status
    Friendship::STATUS[status_id]
  end
  # Approve friend requeted
  def approve
    self.status_id = 1
    self.save
  end
  class << self
    # Request friendship to user
    # @param [User] friend_user
    # @param [User] user
    # @return [Friendship|nil]
    def request(friend_user:, user:)
      Friendship.create!({
        friend_user_id: friend_user.id,
        user_id: user.id
      })
    rescue Mongoid::Errors::Validations
      # nothing
    end
    # Returns an array of `Friendship` as seen from the `user`
    # @param [User] user
    # @return [Array] Array of `Frindshop`
    def from_user(user)
      Friendship.where(user_id: user.id)
    end
    # Returns an array of `Friendship` as seen from the `friend_user`
    # @param [User] friend_user
    # @return [Array] Array of `Frindshop`
    def from_friend_user(friend_user)
      Friendship.where(friend_user_id: friend_user.id)
    end
  end
end