module Sources
  class TwitterAccount < ::Source
    include ::SourceTwitterConcern
    # Name is twitter's screen_name
    validates :name, uniqueness: true, format: { with: /\A[a-zA-Z0-9_]{1,15}\z/, message: 'twitter\'s screen_name only' }
    # Get Twitter Account URL
    def source_url
      Newsdict::Application.config.web_site_prefix[self.class.name.demodulize.underscore.to_sym]
    end
  end
end