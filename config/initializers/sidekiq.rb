redis = YAML.load_file("#{Rails.root}/config/redis.yml")[Rails.env]

Sidekiq.configure_client do |config|
  config.redis = { url: "redis://#{redis['host']}", namespace: ENV['SIDEKIQ_NAMESPACE'] }
end
Sidekiq.configure_server do |config|
  config.redis = { url: "redis://#{redis['host']}", namespace: ENV['SIDEKIQ_NAMESPACE'] }
end
Sidekiq::Web.app_url = ENV['ADMIN_URL']