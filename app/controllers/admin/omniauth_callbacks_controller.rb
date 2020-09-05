class Admin::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def auth
    auth = request.env["omniauth.auth"]
    provider = auth.provider.to_s
    if User.where(email: auth.info.email).exists?
      
    end
    @user = Object.const_get("Users::Omniauths::#{provider.camelize}").from_omniauth(auth)
    if @user
      set_flash_message(:notice, :success, kind: provider) if is_navigational_format?
      sign_in_and_redirect @user, event: :authentication
    else
      set_flash_message(:notice, :failure, kind: provider, reason: "Unkown")
      redirect_to user_session_path
    end
  end
  alias_method :facebook, :auth
  alias_method :twitter, :auth
  alias_method :google, :auth
end