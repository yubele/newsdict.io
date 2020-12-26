class Configs::Theme < Config
  DEFAULT_THEME_NAME = 'default'
  before_save do
    if is_active == true
      self.class.not(id: id).git where(is_active: true).update(is_active: false)
    end
  end
  after_save do
    if is_active == false && Configs::Theme.activated_theme.nil?
      self.class.where(key: Configs::Theme::DEFAULT_THEME_NAME).update(is_active: true)
    end
    Batch.restart_all_server
  end
  field :description, type: String
  field :is_active, type: Boolean, default: false
  class << self
    # Get already activated theme.
    # @return [Configs::theme] activated theme.
    def activated_theme
      find_by(is_active: true) || Configs::Theme.new({key: Configs::Theme::DEFAULT_THEME_NAME, is_active: true})
    end
    # Apply theme
    # @return [Configs::Theme] Applied theme.
    def apply
      ActionController::Base.prepend_view_path  "app/themes/#{activated_theme.key}"
      I18n.load_path += Dir[Rails.root.join('app', 'themes', activated_theme.key, 'locales', '*.{rb,yml}')]
      Rails.application.config.assets.paths = [
        Rails.root.join('app', 'themes', activated_theme.key, 'assets', 'config'),
        Rails.root.join('app', 'themes', activated_theme.key, 'assets', 'javascripts'),
        Rails.root.join('app', 'themes', activated_theme.key, 'assets', 'stylesheets'),
        Rails.root.join('app', 'themes', activated_theme.key, 'assets', 'images')]
      activated_theme
    end
    # Tidy Configs::Theme
    # @return [void]
    def tidy
      # Insert the theme directories to Configs::themes if ConfigsTheme has not it.
      exist_dirnames.each do |exist_dirname|
        unless where(key: exist_dirname).exists?
          create(key: exist_dirname)
        end
      end
      # Remove the Configs::themes records, if it does not exists at `app/themes/**`.
      all.each do |theme|
        unless File.exist?(Rails.root.join('app', 'themes', theme.key))
          theme.delete
        end
      end
      # Check active default theme, if Configs::Theme has not `is_active=true`;
      unless where(is_active: true).exists?
        where(key: Configs::Theme::DEFAULT_THEME_NAME).update(is_active: true)
      end
    end
    private
    # Get the names of app/themes/{name}.
    # @return [Array] names
    def exist_dirnames
      Dir.glob(Rails.root.join('app', 'themes', '*')).map { |path|
        path.gsub(Rails.root.join('app', 'themes').to_s, "").gsub("/", "")
      }
    end
  end
end