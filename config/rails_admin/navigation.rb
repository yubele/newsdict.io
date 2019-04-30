RailsAdmin.config do |config|
  config.excluded_models = [:Source, :Content]
  config.model "Sources::TwitterAccount" do
    navigation_label 'User Setting'
    weight 1
  end
  config.model "User" do
    navigation_label 'Global Setting'
    weight 10
  end
  config.model "Contents::Web" do
    navigation_label 'Global View'
    weight 20
  end
end