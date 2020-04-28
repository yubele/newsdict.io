class SitemapsJob < ApplicationJob
  queue_as :default
  # Genetate sitemaps.a
  def perform
    Newsdict::Application.load_tasks
    Rake::Task['sitemap:refresh'].invoke
  end
end