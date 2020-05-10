directory_names = Dir.glob("#{Rails.root}/app/themes/*/").map {|dir| dir.gsub("#{Rails.root}/app/themes/", "").gsub("/", "") }
themes = Theme.all.map {|theme| theme.name }
(directory_names | themes).each do |name|
  unless themes.include?(name)
    Theme.create!(
      name: name
    )
  end
  if themes.include?(name) && !directory_names.include?(name)
    Theme.where(name: name).delete
  end
end
unless Theme.find_by(is_active: true)
  Theme.find_by(name: 'default').update(is_active: true)
end
theme = Theme.find_by(is_active: true)
ActionController::Base.prepend_view_path  "app/themes/#{theme.name}"