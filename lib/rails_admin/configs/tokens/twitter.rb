RailsAdmin.config do |config|
  config.label_methods << :key
  config.model "Configs::Tokens::Twitter" do
    fields :key, :is_default, :consumer_key, :consumer_secret, :access_token, :access_secret
    edit do
      field :consumer_key, :password
      field :consumer_secret, :password
      field :access_token, :password
      field :access_secret, :password
    end
    list do
      fields :consumer_key, :consumer_secret, :access_token, :access_secret do 
        pretty_value do
          '****'
        end
      end
    end
  end
end