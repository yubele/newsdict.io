class ApplicationJob < ActiveJob::Base
  sidekiq_options retry: 0, backtrace: 20
end
