class Configs::Theme < Config
  DEFAULT_THEME_NAME = 'default'
  before_save do
    if is_active == true
      self.class.where(is_active: true).update(is_active: false)
    end
  end
  after_save do
    if is_active == false && Configs::Theme.activated_theme.nil?
      self.class.where(key: Configs::Theme::DEFAULT_THEME_NAME).update(is_active: true)
    end
    system("bin/rails restart")
  end
  field :description, type: String
  field :is_active, type: Boolean, default: false
  class << self
    # Get already activated theme.
    # @return [Configs::theme] activated theme.
    def activated_theme
      find_by(is_active: true)
    end
    # Apply theme
    # @return [Configs::Theme] Applied theme.
    def apply
      ActionController::Base.prepend_view_path  "app/themes/#{activated_theme.key}"
      I18n.load_path += Dir[Rails.root.join('app', 'themes', activated_theme.key, 'locales', '*.{rb,yml}')]
      Rails.application.config.assets.paths << Rails.root.join('app', 'themes', activated_theme.key, 'assets', 'javascripts')
      Rails.application.config.assets.paths << Rails.root.join('app', 'themes', activated_theme.key, 'assets', 'stylesheets')
      activated_theme
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