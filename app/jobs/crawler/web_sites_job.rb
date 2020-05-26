module Crawler
  class WebSitesJob < ::CrawlersJob
    queue_as :crowling
  
    # Fetch the web each twitter accounts
    def perform
      Sources::WebSite.all.each do |source|
        source.urls.each do |url|
          ::CrawlersJob.perform_later(source, url)
        end
      end
    end
  end
end