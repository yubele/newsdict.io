class SitemapsJob < ApplicationJob
  queue_as :default
  # Genetate sitemaps
  def perform
    load File.expand_path('../../../bin/rake', __FILE__)
    Rake::Task['sitemap:refresh:no_ping'].invoke
  end
end