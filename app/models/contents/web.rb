class Contents::Web < ::Content
  # Crawl original URL
  # @return [String] url
  def source_url
    source.source_url  
  end
end