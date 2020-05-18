class ApplicationJob < ActiveJob::Base
  sidekiq_options retry: 0, backtrace: 20
  before_perform :set_twitter_client
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
