redis = YAML.load(ERB.new(File.read("#{Rails.root}/config/redis.yml")).result)[Rails.env]

Newsdict::Application.config.cache_store = :redis_store, {
  host: "redis://#{redis['host']}/0/cache",
  port: 6379,
  namespace: ENV['NAMESPACE']
}, { expires_in: 90.minutes }

Newsdict::Application.config.session_store :redis_store,
  servers: ["redis://#{redis['host']}/0/session"],
  expire_after: 90.minutes,
  key: "_#{Rails.application.class.module_parent_name.downcase}_session",
  threadsafe: true,
  signed: true,
  secure: true