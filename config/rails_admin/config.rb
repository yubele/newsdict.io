RailsAdmin.config do |config|
  config.model Config do
    list do
      field :key do
        visible true
      end
      field :describe do
        visible true
      end
    end
    edit do
      field :value do
        visible true
      end
    end
  end
end