RailsAdmin.config do |config|
  config.current_user_method(&:current_user)
  config.model "Sources::WebSite" do
    base do
      fields :alias, :description, :user_id do
        visible false
      end
      fields :name, :category_id
      field :xpath do read_only true end
      field :source_url
    end
  end
end