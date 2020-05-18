RailsAdmin.config do |config|
  config.label_methods << :key
  config.model "Configs::Tokens::Twitter" do
    fields :key, :consumer_key, :consumer_secret, :access_token, :access_secret, :is_default
  end
end