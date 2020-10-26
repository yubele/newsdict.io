class Posts::Twitter < ::Post
  field :twitter_token_id, type: BSON::ObjectId
  belongs_to :twitter_token, class_name: "Configs::Tokens::Twitter"
  # Tweet
  # @return [Boolean]
  def post
    twitter_client.update(bind_body)
  end

  private
  # Get Twitter::REST::Client instance
  # @private
  # @return [void]
  def twitter_client
    Twitter::REST::Client.new do |config|
      config.consumer_key        = twitter_token.consumer_key
      config.consumer_secret     = twitter_token.consumer_secret
      config.access_token        = twitter_token.access_token
      config.access_token_secret = twitter_token.access_secret
    end
  end
end