RailsAdmin.config do |config|
  config.model User do
    list do
      filters [:username, :email]
      field :username do
        visible true
      end
      field :email do
        filterable true
      end
    end
    edit do
      field :username do
        visible true
      end
      field :is_manual_locked do
        visible true
      end
    end
  end
end