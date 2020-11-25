class Crawler::WebSitesJob < ::CrawlersJob
  # Fetch the web each twitter accounts
  def perform
    Sources::WebSite.all.each do |source|
      source.urls.each do |url|
        unless ::Filters::IgnoreCrawlContent.where(exclude_url: url).exists?
          ::CrawlersJob.perform_later(source, url,  unique_id: Digest::SHA256.hexdigest(url))
        end
      end
    end
  end
end