class Configs::Global < Config
  field :value, type: String
  KEYS = [
    :recaptcha_secret_key,
    :recaptcha_site_key,
    :google_translate_api
  ]
end