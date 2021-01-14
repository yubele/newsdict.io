require "nested_form/engine"
require "nested_form/builder_mixin"
Rails.configuration.to_prepare do
  initializer_path =  Rails.root.join('lib', 'rails_admin', 'initializer.rb')
  # Require the rails_admins's config files.
  Dir[Rails.root.join('lib', 'rails_admin', '**/*.rb')].each do |file|
    if File.file?(file) && File.basename(file) != File.basename(initializer_path)
      require file
    end
  end
  require initializer_path
  Rails.application.config.assets.precompile += %w{rails_admin/custom.css rails_admin/custom.js}
end