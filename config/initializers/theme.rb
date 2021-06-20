Rails.application.reloader.to_prepare do
  Configs::Theme.apply
  Rails.application.config.assets.paths.delete(Rails.root.join('app', 'assets', 'javascripts').to_s)
  Rails.application.config.assets.paths.delete(Rails.root.join('app', 'assets', 'stylesheets').to_s)
  Rails.application.config.assets.paths.delete(Rails.root.join('app', 'assets', 'images').to_s)
end
Rails.application.config.after_initialize do
  Batch.single_server(:theme) do
    Configs::Theme.tidy
  end
end
