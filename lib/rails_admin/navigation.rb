RailsAdmin.config do |config|
  config.excluded_models = [:Source, :Content, :Config, :Filter, :Paper]
  config.model "Sources::TwitterAccount" do
    navigation_label I18n.t('admin.navigation.setting')
    weight 1
  end
  config.model "Sources::Url" do
    navigation_label I18n.t('admin.navigation.setting')
    weight 2
  end
  config.model "Inquiry" do
    navigation_label I18n.t('admin.navigation.inquiries_management')
    weight 5
  end
  config.model "User" do
    navigation_label I18n.t('admin.navigation.global_setting')
    weight 10
  end
  config.model "Theme" do
    navigation_label I18n.t('admin.navigation.global_setting')
    weight 15
  end
  config.model "Configs::MecabDic" do
    navigation_label I18n.t('admin.navigation.global_setting')
    weight 20
  end
  config.model "Configs::View" do
    navigation_label I18n.t('admin.navigation.global_setting')
    weight 25
  end
  config.model "Configs::Category" do
    navigation_label I18n.t('admin.navigation.global_setting')
    weight 30
  end
  config.model "Contents::Web" do
    navigation_label I18n.t('admin.navigation.global_setting')
    weight 35
  end
  config.model "Filters::Content" do
    navigation_label I18n.t('admin.navigation.global_setting')
    weight 35
  end
end