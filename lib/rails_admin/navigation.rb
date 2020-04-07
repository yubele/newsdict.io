RailsAdmin.config do |config|
  config.excluded_models = [:Source, :Content, :Config, :Filter]
  config.model "Sources::TwitterAccount" do
    navigation_label I18n.t('admin.navigation.setting')
    weight 1
  end
  config.model "User" do
    navigation_label I18n.t('admin.navigation.global_setting')
    weight 10
  end
  config.model "Configs::MecabDic" do
    navigation_label I18n.t('admin.navigation.global_setting')
    weight 15
  end
  config.model "Configs::View" do
    navigation_label I18n.t('admin.navigation.global_setting')
    weight 15
  end
  config.model "Contents::Web" do
    navigation_label I18n.t('admin.navigation.global_setting')
    weight 20
  end
end