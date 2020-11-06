# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://newsdict.jp"
SitemapGenerator::Sitemap.sitemaps_path = 'shared/'
SitemapGenerator::Sitemap.create_index = true
Rails.application.routes.default_url_options[:trailing_slash] = true
SitemapGenerator::Sitemap.create do
  add '/', priority: 1.0, changefreq: 'always'
  Source.all.each do |source|
    add sources_path(source.id), priority: 0.8, changefreq: 'hourly'
  end
  Configs::Category.all.each do |config|
    add category_path(config.key), priority: 0.7, changefreq: 'hourly'
  end
  CollectTag.all.each do |tag|
    add tag_path(tag.name), priority: 0.7, changefreq: 'hourly'
  end
  Content.all.each do |content|
    add content_path(content.id), priority: 0.5, changefreq: 'monthly'
  end
end
