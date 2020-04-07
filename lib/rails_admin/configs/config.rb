RailsAdmin.config do |config|
  config.model "Configs::View" do
    edit do
      field :key do
        visible true
      end
      field :description
      field :value
    end
    list do 
      field :key
      field :description
      field :value
    end
  end
end