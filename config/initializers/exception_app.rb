Rails.configuration.to_prepare do
  Rails.application.configure do
    config.exceptions_app = ErrorsController.action(:exceptions_app)
  end
end