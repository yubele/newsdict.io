RailsAdmin.config do |config|
  config.label_methods << :key
  config.model "Configs::Tokens::Twitter" do
    fields :key, :is_default, :consumer_key, :consumer_secret, :access_token, :access_secret
    base do
      field :consumer_key, :password
      field :consumer_secret, :password
      field :access_token, :password
      field :access_secret, :password
    end
  end
end