Sidekiq.configure_server do |config|
  config.redis = { url: "redis://#{ENV['REDIS_HOST']}:#{ENV['REDIS_PORT']}", namespace: ENV['SIDEKIQ_NAMESPACE'] }
end
