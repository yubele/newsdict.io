initializer_path =  Rails.root.join('lib', 'rails_admin', 'initializer.rb')
# Require the rails_admins's config files.
Dir[Rails.root.join('lib', 'rails_admin', '**/*.rb')].each do |file|
  if File.file?(file) && File.basename(file) != File.basename(initializer_path)
    require file
  end
end
require initializer_path