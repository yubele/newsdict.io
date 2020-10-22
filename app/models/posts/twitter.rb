class Posts::Twitter < ::Post
  field :twitter_token_id, type: BSON::ObjectId
  belongs_to :twitter_token, class_name: "Configs::Tokens::Twitter"
  # Tweet
  # @return [Boolean]
  def post
    #twitter_client.update()
  end

  private
  # Get Twitter::REST::Client instance
  # @private
  # @return [void]
  def twitter_client
    default_twitter = twitte_token
    Twitter::REST::Client.new do |config|
      config.consumer_key        = default_twitter.consumer_key
      config.consumer_secret     = default_twitter.consumer_secret
      config.access_token        = default_twitter.access_token
      config.access_token_secret = default_twitter.access_secret
    end
  end
end