redis = YAML.load(ERB.new(File.read("#{Rails.root}/config/redis.yml")).result)[Rails.env]
redis = Redis.new(url: "redis://#{redis['host']}", namespace: ENV['NAMESPACE'])
if redis.get('config/initializers/theme::lock').nil?
  redis.set('config/initializers/theme::lock', true)
  # Delete the theme not exists at directory.
  Configs::Theme.all.each do |theme|
    unless Dir.exists?(Rails.root.join('app', 'themes', theme.key))
      theme.destroy
    end
  end
  # Import the theme names.
  Configs::Theme.directory_names.each do |key|
    if Configs::Theme.exists(key: key).empty?
      Configs::Theme.create!(key: key)
    end
  end
  # Check active default theme, if Configs::Theme have not `is_active=true`;
  if Configs::Theme.exists(is_active: true).empty?
    Configs::Theme.where(key: Configs::Theme::DEFAULT_THEME_NAME).update(is_active: true)
  end
  redis.del('config/initializers/theme::lock')
end
Configs::Theme.apply