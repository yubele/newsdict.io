Sidekiq.configure_client do |config|
  config.redis = { url: "redis://#{ENV['REDIS_HOST']}:#{ENV['REDIS_PORT']}", namespace: ENV['SIDEKIQ_NAMESPACE'] }
end
Sidekiq.configure_server do |config|
  config.redis = { url: "redis://#{ENV['REDIS_HOST']}:#{ENV['REDIS_PORT']}", namespace: ENV['SIDEKIQ_NAMESPACE'] }
end
Sidekiq::Web.app_url = ENV['ADMIN_URL']