RailsAdmin.config do |config|
  config.label_methods << :exclude_domain
  config.current_user_method(&:current_user)
  config.model "Filters::HiddenContent" do
    # screen name
    field :id do
      visible false
    end
    field :exclude_title
    field :exclude_url
  end
end