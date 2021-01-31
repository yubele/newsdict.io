class Contents::Tweet < ::Content
  # Get a tweet text.
  # @return [String] tweet text
  def text
    # @todo implement
  end
  # Crawl original URL
  # @return [String] url
  def source_url
    "https://twitter.com/#{source.name}/status/#{unique_id}"
  end
end