class Configs::Tokens::FacebookAccount < Configs::Token
  field :consumer_id, type: String
  field :consumer_secret, type: String
  validates :consumer_id, length: {minimum: 1, maximum: 255}, presence: true
  validates :consumer_secret, length: {minimum: 1, maximum: 255}, presence: true
  class << self
    # Get Twitter::REST::Client instance
    # @private
    # @return [void]
    def get_token
      account = self.all.sample
      Koala::Facebook::API.new(account.consumer_id, account.consumer_secret)
    end
  end
end