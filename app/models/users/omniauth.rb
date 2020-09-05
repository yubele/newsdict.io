class Users::Omniauth < User
  # OmniAuth
  field :provider, type: String
  field :uid, type: String
  field :image, type: String
  # What to do if it overlaps with email authentication
  field :provider_email, type: String
  # Email is not required when using Omniauth.
  def email_required?
    false
  end
  def email
    provider_email
  end
  class << self
    # Omniauth
    def from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.provider_email = auth.info.email
        user.password = Devise.friendly_token[0,20]
        user.username = auth.info.name   # assuming the user model has a name
        user.image = auth.info.image # assuming the user model has an image
        # If you are using confirmable and the provider(s) you use validate emails,
        # uncomment the line below to skip the confirmation emails.
        user.skip_confirmation!
      end
    end
  end
end