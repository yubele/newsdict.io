class UrlsJob < CrowlingSourcesJob
  queue_as :default

  # Fetch the web each twitter accounts
  def perform
    Sources::Url.all.each do |source|
      source.urls.each do |url|
        CrowlingSourcesJob.perform_later(source, url)
      end
    end
  end
end