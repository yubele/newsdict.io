class Users::Omniauths::Twitter < Users::Omniauth
  validates :provider_email, uniqueness: true
end