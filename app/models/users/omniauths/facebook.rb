class Users::Omniauths::Facebook < Users::Omniauth
  validates :provider_email, uniqueness: true
end