RailsAdmin.config do |config|
  config.label_methods << :key
  config.model "Configs::Tokens::Twitter" do
    fields :key, :is_default, :consumer_key, :consumer_secret, :access_token, :access_secret
    edit do
      fields :consumer_key, :consumer_secret, :access_token, :access_secret do
        visible false
      end
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