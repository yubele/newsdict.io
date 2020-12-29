RailsAdmin.config do |config|
  config.label_methods << :key
  config.model "Configs::Tokens::Twitter" do
    fields :key, :consumer_key, :consumer_secret, :access_token, :access_secret
    base do
      field :consumer_key, :password
      field :consumer_secret, :password
      field :access_token, :password
      field :access_secret, :password
    end
    list do
      field :consumer_key do
        pretty_value do
          unless bindings[:object].consumer_key.empty?
            '*' * 8
          end
        end
      end
      field :consumer_secret do
        pretty_value do
          unless bindings[:object].consumer_secret.empty?
            '*' * 8
          end
        end
      end
      field :access_token do
        pretty_value do
          unless bindings[:object].access_token.empty?
            '*' * 8
          end
        end
      end
      field :access_secret do
        pretty_value do
          unless bindings[:object].access_secret.empty?
            '*' * 8
          end
        end
      end
    end
  end
end