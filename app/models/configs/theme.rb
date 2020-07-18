class Configs::Theme < Config
  before_save do
    if is_active == true
      self.class.where(is_active: true).update(is_active: false)
    end
  end
  field :description, type: String
  field :is_active, type: Boolean, default: false
  class << self
    # Apply theme
    # @return [Configs::Theme] Applied theme.
    def apply
      apply_theme = find_by(is_active: true)
      ActionController::Base.prepend_view_path  "app/themes/#{theme.key}"
      I18n.load_path += Dir[Rails.root.join('app', 'themes', theme.key, 'locales', '*.{rb,yml}')]
      Rails.application.config.assets.paths << Rails.root.join('app', 'themes', theme.key, 'assets', 'javascripts')
      Rails.application.config.assets.paths << Rails.root.join('app', 'themes', theme.key, 'assets', 'stylesheets')
      apply_theme
    end
    
    # Get the names of app/themes/{name}.
    # @return [Array] names
    def directory_names
      Dir.glob("#{Rails.root}/app/themes/*/").map { |path|
        path.gsub("#{Rails.root}/app/themes/", "").gsub("/", "")
      }
    end
  end
end