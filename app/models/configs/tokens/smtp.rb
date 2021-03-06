class Configs::Tokens::Smtp < Configs::Token
  before_save do
    if is_default == true
      self.class.not(id: id).where(is_default: true).update(is_default: false)
    end
  end
  field :is_default, type: Boolean, default: false
  field :host, type: String
  field :port, type: Integer, default: 587
  field :domain, type: String
  field :username, type: String
  field :password, type: String
  field :authentication, type: String, default: 'login'
  field :enable_starttls_auto, type: Boolean, default: true
  field :sender, type: String
  validates :host, length: {minimum: 1, maximum: 255}, presence: true
  validates :port, length: {minimum: 1, maximum: 255}, presence: true
  validates :domain, length: {minimum: 1, maximum: 255}, presence: true
  validates :username, length: {minimum: 1, maximum: 255}
  validates :password, length: {minimum: 1, maximum: 255}
  validates :authentication, length: {minimum: 1, maximum: 255}, presence: true
  validates :enable_starttls_auto, length: {minimum: 1, maximum: 255}
  validates :sender, length: {minimum: 1, maximum: 255}, presence: true
end