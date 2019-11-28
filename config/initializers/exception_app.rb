Rails.application.configure do
  config.exceptions_app = ErrorsController.action(:exceptions_app)
end