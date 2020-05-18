RailsAdmin.config do |config|
  config.label_methods << :key
  config.model "Configs::Tokens::Twitter" do
    fields :key, :is_default, :consumer_key, :consumer_secret, :access_token, :access_secret
  end
end