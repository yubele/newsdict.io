# Google Translate
Rails.configuration.to_prepare do
  if Configs::Global.find_by(key: :google_translate_api)
    EasyTranslate.api_key = Configs::Global.find_by(key: :google_translate_api).value
  end
end