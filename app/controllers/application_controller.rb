class ApplicationController < ActionController::Base
  include Api::ContentsControllerConcern
  before_action :set_recaptcha, :set_action_mailer, :set_host, :hook_of_restart_all_server
  before_action :configure_permitted_parameters, if: :devise_controller?
  unless Rails.env.development?
    rescue_from StandardError, with: :exceptions_app
    rescue_from Mongoid::Errors::DocumentNotFound, ActionController::BadRequest, with: :not_found
  end

  def exceptions_app(exception)
    ExceptionNotifier.notify_exception(
      exception,
      env: request.env, data: { message: 'was doing something wrong' }
    )
    redirect_to not_found_path
  end
  def not_found
    redirect_to not_found_path
  end

  protected
  # Set domain for devise mail
  # @return [void]
  def set_host
    Rails.application.routes.default_url_options[:host] = request.host_with_port
  end
  # Required username at sign up / sign in
  # @return [void]
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:username])
  end
  # Setup action mailer
  # @return [void]
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
  # Setup recaptcha.
  # @return [void]
  def set_recaptcha
    Recaptcha.configure do |config|
      config.site_key  = Configs::Global.find_by(key: :recaptcha_v2_site_key).value
      config.secret_key = Configs::Global.find_by(key: :recaptcha_v2_secret_key).value
    end
  end
  # Hook of restart_all_server
  # @return [Boolean]
  def hook_of_restart_all_server
    if Batch.hook_of_restart_all_server
      redirect_to request.original_url
    end
  end
end
