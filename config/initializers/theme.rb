# Flush the theme names.
Configs::Theme.delete_all
# Import the theme names.
Configs::Theme.directory_names.each do |key|
  if key == 'default'
    is_active = true
  else
    is_active = false
  end
  Configs::Theme.create!(
    key: key,
    is_active: is_active)
end
Configs::Theme.apply
