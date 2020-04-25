RailsAdmin.config do |config|
  config.label_methods << :key
  config.model "Configs::Category" do
    field :key
  end
end