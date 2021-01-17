Rails.application.reloade.to_prepare do
  Batch.single_server(:theme) do
    Configs::Theme.tidy
  end
  Configs::Theme.apply
  Rails.application.config.assets.paths.delete(Rails.root.join('app', 'assets', 'javascripts').to_s)
  Rails.application.config.assets.paths.delete(Rails.root.join('app', 'assets', 'stylesheets').to_s)
  Rails.application.config.assets.paths.delete(Rails.root.join('app', 'assets', 'images').to_s)
end