class Users::Omniauths::Google < Users::Omniauth
  validates :provider_email, uniqueness: true
end