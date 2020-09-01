module Configs
  class Global < Config
    field :value, type: String
    KEYS = [
      :recaptcha_v2_secret_key,
      :recaptcha_v2_site_key,
      :recaptcha_v3_secret_key,
      :recaptcha_v3_site_key,
      :google_translate_api,
      :facebook_app_id,
      :facebook_app_secret,
    ]
    def to_s
      send(:value).to_s
    end
  end
end