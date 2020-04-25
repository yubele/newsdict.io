RailsAdmin.config do |config|
  config.model Theme do
    list do
      field :id do
        visible false
      end
      field :name do
        visible true
      end
      field :description do
        filterable true
      end
    end
    edit do
      field :name do
        visible true
      end
      field :description do
        filterable true
      end
    end
  end
end