require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
# require "active_record/railtie"
# require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
require "rails/test_unit/railtie"
require 'sidekiq/web'
require 'sidekiq-scheduler/web'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Newsdict
  class Application < Rails::Application
    config.time_zone = 'Tokyo'
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0
    # These autoloaded constants would have been unloaded if `config.autoloader` had been set to `:zeitwerk`.
    config.autoloder = :zeitwerk
    # Recursively including all model subdirectories
    config.autoload_paths += Dir[Rails.root.join('app', 'models', '*', '**')]
    # Active Job
    config.active_job.queue_adapter = :sidekiq
    # Web site's prefix used by Source
    config.web_site_prefix = {
        twitter_account: 'https://twitter.com'}
    # config names
    config.keys = {
      head: 'Insert this code as high in the <head> tag',
      after_body: 'Insert this code immediately after the opening <body> tag',
      end_body: 'Insert this code immediately end the closing <body> tag'}
    # path of `mecab-dict-index` in worker
    config.path_of_smecab_dict_index = "/usr/lib/mecab/mecab-dict-index"
  end
end
