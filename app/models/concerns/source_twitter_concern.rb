module SourceTwitterConcern
  extend ActiveSupport::Concern

  # Get external urls
  def urls
    user_timeline.map { |tweet|
      if Origins::Twitter.exists(unique_id: tweet.id)
        # Skip already tweet id
        next
      else
        Origins::Twitter.new(unique_id: tweet.id).save
        tweet.to_h[:entities][:urls].map {|t| t[:expanded_url] }
      end
    }.flatten.compact
  end

  # Get home_timeline.entries.url.urls
  #  API Reference. https://developer.twitter.com/en/docs/tweets/timelines/api-reference/get-statuses-home_timeline
  def user_timeline
    Newsdict::Application.config.twitter_client.user_timeline(self.name)
  end

  class_methods do
  end
end