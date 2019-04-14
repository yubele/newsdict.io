class FetchUrlsJob < ApplicationJob
  queue_as :default

  # Fetch the web pages by url
  # @param [Source] source
  def perform(source)
    # @todo Implementation
    source.urls.each do |url|
      #WebStat.stat_by_url(url)
    end
  end
end