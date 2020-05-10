RailsAdmin.config do |config|
  config.current_user_method(&:current_user)
  config.model "Sources::WebUrl" do
    field :name do
      visible true
    end
    field :alias do
      visible false
    end
    field :description do
      visible false
    end
    # login user id
    field :user_id do
      visible false
    end
    field :source_url do
      visible true
    end
    field :category_id do
      visible true
    end
  end
end