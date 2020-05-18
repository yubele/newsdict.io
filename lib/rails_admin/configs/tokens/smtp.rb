RailsAdmin.config do |config|
  config.label_methods << :key
  config.model "Configs::Tokens::Smtp" do
    fields :key, :host, :port, :domain, :username, :password, :authentication, :enable_starttls_auto, :sender, :is_default
  end
end