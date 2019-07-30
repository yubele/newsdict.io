module TwitterConcern
  extend ActiveSupport::Concern

  # Get external urls
  def urls
    user_timeline.map { |tweet|
      tweet.to_h[:entities][:urls].map {|t| t[:expanded_url] }
    }.flatten
  end

  # Get home_timeline.entries.url.urls
  #  API Reference. https://developer.twitter.com/en/docs/tweets/timelines/api-reference/get-statuses-home_timeline
  def user_timeline
    Newsdict::Application.config.twitter_client.user_timeline(self.name)
  end

  class_methods do
  end
end