# Get already activated theme.
activated_theme = Configs::Theme.activated_theme
# Flush the theme names.
Configs::Theme.delete_all
# Import the theme names.
Configs::Theme.directory_names.each do |key|
  if (activated_theme.nil? && key == Configs::Theme::DEFAULT_THEME_NAME) ||
    (activated_theme && key == activated_theme.key)
    is_active = true
  else
    is_active = false
  end
  Configs::Theme.create!(
    key: key,
    is_active: is_active)
end
Configs::Theme.apply
