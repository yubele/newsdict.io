module Configs
  class Global < Config
    field :value, type: String
    KEYS = [
      :recaptcha_secret_key,
      :recaptcha_site_key,
      :google_translate_api
    ]
    def to_s
      send(:value).to_s
    end
  end
end