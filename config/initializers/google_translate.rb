# Google Translate
Rails.application.reloader.to_prepare do
  api = Configs::Global.find_by(key: :google_translate_api)
  if api.value && api.enabled
    EasyTranslate.api_key = api.value
  end
end