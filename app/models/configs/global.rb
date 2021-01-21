class Configs::Global < Config
  after_save do
    system("bin/rails restart")
  end
  field :value, type: String
  field :enabled, type: Boolean
  KEYS = [
    :recaptcha_v3_secret_key,
    :recaptcha_v3_site_key,
    :recaptcha_v2_secret_key,
    :recaptcha_v2_site_key,
    :google_translate_api,
    :facebook_app_id,
    :facebook_app_secret,
    :twitter_app_id,
    :twitter_app_secret,
    :google_app_id,
    :google_app_secret
  ]
  def to_s
    send(:value).to_s
  end
end