RailsAdmin.config do |config|
  config.label_methods << :key
  config.model "Configs::Tokens::Smtp" do
    fields :key, :is_default, :host, :port, :domain, :username, :password, :authentication, :enable_starttls_auto, :sender
    list do
      field :password do
        pretty_value do
          '****'
        end
      end
    end
  end
end