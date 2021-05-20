redis = Rails.application.config_for(:redis)

Sidekiq.configure_client do |config|
  config.redis = { url: "redis://#{redis['host']}", namespace: ENV['NAMESPACE'] }
end
Sidekiq.configure_server do |config|
  config.redis = { url: "redis://#{redis['host']}", namespace: ENV['NAMESPACE'] }
end
Sidekiq::Web.app_url = '/admin'