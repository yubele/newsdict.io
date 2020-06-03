class SitemapsJob < ApplicationJob
  # Genetate sitemaps.
  def perform
    Newsdict::Application.load_tasks
    Rake::Task['sitemap:refresh'].invoke
  end
end