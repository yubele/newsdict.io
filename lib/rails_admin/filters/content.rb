RailsAdmin.config do |config|
  config.label_methods << :exclude_domain
  config.current_user_method(&:current_user)
  config.model "Filters::Content" do
    # screen name
    field :id do
      visible false
    end
    field :exclude_domain do
      visible true
    end
  end
end