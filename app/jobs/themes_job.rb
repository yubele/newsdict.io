class ThemesJob < ApplicationJob
  queue_as :themes
  # Genetate sitemaps.
  def perform
    # Delete the theme not exists at directory.
    Configs::Theme.all.each do |theme|
      unless Dir.exists?(Rails.root.join('app', 'themes', theme.key))
        theme.destroy
      end
    end
    # Import the theme names.
    Configs::Theme.directory_names.each do |key|
      unless Configs::Theme.where(key: key).exists?
        Configs::Theme.create!(key: key)
      end
    end
    # Check active default theme, if Configs::Theme have not `is_active=true`;
    unless Configs::Theme.where(key: Configs::Theme::DEFAULT_THEME_NAME).exists?
      Configs::Theme.where(key: Configs::Theme::DEFAULT_THEME_NAME).update(is_active: true)
    end
  end
end