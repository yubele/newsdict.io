module Sources
  class TwitterAccount < ::Source
    include ::SourceTwitterConcern
    after_initialize :set_twitter_client
    # Name is twitter's screen_name
    validates :name, uniqueness: true, format: { with: /\A[a-zA-Z0-9_]{1,15}\z/, message: 'twitter\'s screen_name only' }
    # Get Twitter Account URL
    def source_url
      "#{Newsdict::Application.config.web_site_prefix[self.class.name.demodulize.underscore.to_sym]}/#{name}"
    end
    def media_name
      "Twitter"
    end
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