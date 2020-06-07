# Deprecated theme
if Theme.exists? && Configs::Theme.empty?
  theme = Theme.find_by(is_active: true)
  Configs::Theme.create!(
    key: theme.name
  )
  Theme.delete_all
end
directory_keys = Dir.glob("#{Rails.root}/app/themes/*/").map {|dir| dir.gsub("#{Rails.root}/app/themes/", "").gsub("/", "") }
themes = Configs::Theme.all.map {|theme| theme.key }
(directory_keys | themes).each do |key|
  unless themes.include?(key)
    Configs::Theme.create!(
      key: key
    )
  end
  if themes.include?(key) && !directory_keys.include?(key)
    Configs::Theme.where(key: key).delete
    
  end
end
unless Configs::Theme.find_by(is_active: true)
  Configs::Theme.find_by(key: 'default').update(is_active: true)
end
theme = Configs::Theme.find_by(is_active: true)
ActionController::Base.prepend_view_path  "app/themes/#{theme.key}"
I18n.load_path = Dir[Rails.root.join('app', 'themes', theme.key, 'locales', '*.{rb,yml}')]
Rails.application.config.assets.paths << Rails.root.join('app', 'themes', theme.key, 'assets', 'javascripts')
Rails.application.config.assets.paths << Rails.root.join('app', 'themes', theme.key, 'assets', 'stylesheets')