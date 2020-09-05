class Admin::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def auth
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    provider = request.env["omniauth.auth"].provider.to_s
    @user = Object.const_get("Users::Omniauths::#{provider.camelize}").from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, kind: provider) if is_navigational_format?
    else
      session["devise.omniauth"] = request.env["omniauth.auth"].except("extra")
      redirect_to new_user_registration_url
    end
  end
  alias_method :facebook, :auth
  alias_method :twitter, :auth
  alias_method :google, :auth
end