class ApplicationController < ActionController::Base
  before_action :set_host
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def set_host
    Rails.application.routes.default_url_options[:host] = request.host_with_port
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:username])
  end
end
