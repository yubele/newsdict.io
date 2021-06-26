# i18n-debug
I18n::Debug.logger = Logger.new(Rails.root.join('log', 'i18n-debug.log'))
# Running better_errors on docker.
BetterErrors::Middleware.allow_ip! "0.0.0.0/0"

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  # If you want to output 404 page, that set false.
  config.consider_all_requests_local = true

  # Enable/disable caching. By default caching is disabled.
  # Run rails dev:cache to toggle caching.
  if Rails.root.join('tmp', 'caching-dev.txt').exist?
    config.action_controller.perform_caching = true
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false
  end
  config.public_file_server.enabled = true

  config.cache_store = :redis_cache_store, { url: "redis://redis:6379/0/cache" }
  config.session_store :cache_store, key: ENV['NAMESPACE']

  # Don't care if the mailer can't send.
  #config.action_mailer.raise_delivery_errors = false

  config.action_mailer.perform_caching = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  config.assets.digest = false
  
  # Suppress logger output for asset requests.
  config.assets.quiet = false

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker

  # Logging to STDOUT
  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger    = ActiveSupport::TaggedLogging.new(logger)
  end

  # webpacker domain
  if ENV['WEBPACK_DEV_SERVER_PUBLIC'].present?
    config.action_controller.asset_host = Proc.new do |source|
      if source.starts_with?('/packs')
        "#{ENV['WEBPACK_DEV_SERVER_PUBLIC']}:3035"
      else
        "#{ENV['WEBPACK_DEV_SERVER_PUBLIC']}:3000"
      end
    end
  end

  # To allow requests to puma, add the following to your environment configuration
  config.hosts << "puma"

  # To allow requests to 'local domain'. It need to use oauth.
  config.hosts << ENV['LOCAL_DOMAIN']

  # mongoid log level
  config.mongoid.logger.level = Logger::INFO

  config.force_ssl = true
end