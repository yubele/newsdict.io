class Configs::Tokens::TwitterAccount < Configs::Token
  field :consumer_key, type: String
  field :consumer_secret, type: String
  field :access_token, type: String
  field :access_secret, type: String
  validates :consumer_key, length: {minimum: 1, maximum: 255}, presence: true
  validates :consumer_secret, length: {minimum: 1, maximum: 255}, presence: true
  validates :access_token, length: {minimum: 1, maximum: 255}, presence: true
  validates :access_secret, length: {minimum: 1, maximum: 255}, presence: true
  class << self
    # Get Twitter::REST::Client instance
    # @private
    # @return [void]
    def get_token
      account = self.all.sample
      Twitter::REST::Client.new do |config|
        config.consumer_key        = account.consumer_key
        config.consumer_secret     = account.consumer_secret
        config.access_token        = account.access_token
        config.access_token_secret = account.access_secret
      end
    end
  end
end