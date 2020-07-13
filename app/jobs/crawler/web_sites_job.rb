module Crawler
  class WebSitesJob < ::CrawlersJob
    # Fetch the web each twitter accounts
    def perform
      Sources::WebSite.all.each do |source|
        source.urls.each do |url|
          ::CrawlersJob.perform_later(source, url,  unique_id: Digest::SHA256.hexdigest(url))
        end
      end
    end
  end
end