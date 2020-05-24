class ApplicationController < ActionController::Base
  before_action :set_action_mailer, :set_host
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  # Set domain for devise mail
  def set_host
    Rails.application.routes.default_url_options[:host] = request.host_with_port
  end

  # Required username at sign up / sign in
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:username])
  end
  
  def set_action_mailer
    default_mailer_setting = Configs::Tokens::Smtp.find_by(is_default: true)
    if default_mailer_setting
      ActionMailer::Base.delivery_method = :smtp
      ActionMailer::Base.smtp_settings = {
          address: default_mailer_setting.host,
          port: default_mailer_setting.port,
          domain: default_mailer_setting.domain,
          user_name: default_mailer_setting.username,
          password: default_mailer_setting.password,
          authentication: default_mailer_setting.authentication,
          enable_starttls_auto: default_mailer_setting.enable_starttls_auto
      }
    end
  end
end
