redis = YAML.load(ERB.new(File.read("#{Rails.root}/config/redis.yml")).result)[Rails.env]

Sidekiq.configure_client do |config|
  config.redis = { url: "redis://#{redis['host']}", namespace: ENV['NAMESPACE'] }
end
Sidekiq.configure_server do |config|
  config.redis = { url: "redis://#{redis['host']}", namespace: ENV['NAMESPACE'] }
end
Sidekiq::Web.app_url = '/admin'