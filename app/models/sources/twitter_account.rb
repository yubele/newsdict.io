class Sources::TwitterAccount < ::Source
  using ::ContentConcern
  field :user_id, type: Integer
  # Name is twitter's screen_name
  validates :name, uniqueness: true, format: { with: /\A[a-zA-Z0-9_]{1,15}\z/, message: 'twitter\'s screen_name only' }
  # Get the tweets.
  # @return `Contents::Tweet`s
  def contents
    twitter_client.user_timeline(name).map(&:to_content).flatten
  end
  # Get Twitter Account URL
  # @return [String] twitter url
  def source_url
    "#{Newsdict::Application.config.web_site_prefix[self.class.name.demodulize.underscore.to_sym]}/#{name}"
  end
  # Get media name
  # @return [String] media_nameq
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
  # @param [Content] content
  # @param [Hash] Content attributes
  # @return [Boolean]]
  def update?(content, attrs)
    content.unique_id != attrs[:unique_id].to_s
  end
  # Return icon image.
  # @return [BSON::Binary] image
  def icon
    unless icon_blob
      save_icon_blob_from_url(twitter_client.user(self.name).profile_image_url_https)
    end
    icon_blob
  end
  # Get home_timeline.entries.url.urls
  #  API Reference. https://developer.twitter.com/en/docs/tweets/timelines/api-reference/get-statuses-home_timeline
  def user_timeline
    twitter_client.user_timeline(self.name)
  end
  # Get friends.
  # @return follow users.
  def relation_accounts
    twitter_client.friends(self.name).map do |friend|
      parent_account = Sources::TwitterAccount.find_by(name: self.name)
      account = Sources::Relations::TwitterAccount.find_or_create_by(
        user_id: friend.id,
        name: friend.screen_name
        )
      if account.update_attributes({
        alias_name: friend.name,
        description: friend.description,
        category_id: parent_account.category_id,
        source_id: parent_account.id
        })
        account
      end
    end
  end

  private
  # Get Twitter::REST::Client instance
  # @private
  # @return [void]
  def twitter_client
    Configs::Tokens::Twitter.get_token
  end
end