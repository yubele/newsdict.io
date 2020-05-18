RailsAdmin.config do |config|
  config.model "Configs::Theme" do
    list do
      field :id do
        visible false
      end
      field :key do
        visible true
      end
      field :description do
        filterable true
      end
      field :is_active do
        filterable true
      end
    end
    edit do
      field :key do
        visible true
      end
      field :description do
        filterable true
      end
      field :is_active do
        filterable true
      end
    end
  end
end