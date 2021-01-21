RailsAdmin.config do |config|
  config.model "Contents::Tweet" do
    list do
      field :title
      field :created_at
      field :updated_at
      field :expanded_url
    end
    edit do
      include_all_fields
      field :created_at
      field :updated_at
    end
    show do
      include_all_fields
      field :created_at
      field :updated_at
    end
  end
end