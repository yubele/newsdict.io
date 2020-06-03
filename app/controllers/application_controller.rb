class ApplicationController < ActionController::Base
  before_action :set_recaptcha, :set_action_mailer, :set_google_apis, :set_host
  before_action :configure_permitted_parameters, if: :devise_controller?

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
    recaptcha_site_key = Configs::Global.find_by(key: :recaptcha_site_key).value
    recaptcha_secret_key = Configs::Global.find_by(key: :recaptcha_secret_key).value
    Recaptcha.configure do |config|
      config.site_key  = recaptcha_site_key
      config.secret_key = recaptcha_secret_key
    end
  end
  # Setup google apis
  # @return [void]
  def set_google_apis
    EasyTranslate.api_key = Configs::Global.find_by(key: :google_translate_api).value
  end
end
