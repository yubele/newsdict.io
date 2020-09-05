module Sources
  class TwitterAccount < ::Source
    after_initialize :set_twitter_client
    # Name is twitter's screen_name
    validates :name, uniqueness: true, format: { with: /\A[a-zA-Z0-9_]{1,15}\z/, message: 'twitter\'s screen_name only' }
    # Get Twitter Account URL
    # @return [String] twitter url
    def source_url
      "#{Newsdict::Application.config.web_site_prefix[self.class.name.demodulize.underscore.to_sym]}/#{name}"
    end
    # Get media name
    # @return [String] media_name
    def media_name
      "Twitter"
    end
    # Get external urls
    def urls
      user_timeline.map { |tweet|
        tweet.to_h[:entities][:urls].map {|t| t[:expanded_url] }
      }.flatten
    end
    # Check if it is updated.
    # This is written here because it must be determined for each Source model.
    # @param [Contents::Web] content
    # @param [Hash] Contents::Web attributes
    # @return [Boolean]]
    def update?(content, attrs)
      content.unique_id != attrs[:unique_id].to_s
    end
    # Return icon image.
    # @return [BSON::Binary] image
    def icon
      unless icon_blob
        user = Newsdict::Application.config.twitter_client.user(self.name)
        self.save_icon_blob_from_url(user.profile_image_url_https)
      end
      self.icon_blob
    end
    # Get home_timeline.entries.url.urls
    #  API Reference. https://developer.twitter.com/en/docs/tweets/timelines/api-reference/get-statuses-home_timeline
    def user_timeline
      Newsdict::Application.config.twitter_client.user_timeline(self.name)
    end

    private
    # Get Twitter::REST::Client instance
    # @private
    # @return [void]
    def set_twitter_client
      default_twitter = Configs::Tokens::Twitter.find_by(is_default: true)
      if default_twitter
        Newsdict::Application.config.twitter_client = Twitter::REST::Client.new do |config|
          config.consumer_key        = default_twitter.consumer_key
          config.consumer_secret     = default_twitter.consumer_secret
          config.access_token        = default_twitter.access_token
          config.access_token_secret = default_twitter.access_secret
        end
      end
    end
  end
end