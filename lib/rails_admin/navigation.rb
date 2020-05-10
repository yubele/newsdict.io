RailsAdmin.config do |config|
  config.excluded_models = [:Source, :Content, :Config, :Filter, :Paper,
    # Deprecated class
    "Sources::Url"]
  config.model "Sources::TwitterAccount" do
    navigation_label I18n.t('admin.navigation.sources')
    weight 1
  end
  config.model "Sources::WebUrl" do
    navigation_label I18n.t('admin.navigation.sources')
    weight 2
  end
  config.model "Sources::WebSection" do
    navigation_label I18n.t('admin.navigation.sources')
    weight 3
  end
  config.model "Inquiry" do
    navigation_label I18n.t('admin.navigation.inquiries_management')
    weight 4
  end
  config.model "Theme" do
    navigation_label I18n.t('admin.navigation.portal_setting')
    weight 5
  end
  config.model "Configs::View" do
    navigation_label I18n.t('admin.navigation.portal_setting')
    weight 6
  end
  config.model "Contents::Web" do
    navigation_label I18n.t('admin.navigation.crawling_setting')
    weight 7
  end
  config.model "Configs::Category" do
    navigation_label I18n.t('admin.navigation.crawling_setting')
    weight 8
  end
  config.model "Filters::Content" do
    navigation_label I18n.t('admin.navigation.crawling_setting')
    weight 9
  end
  config.model "Configs::MecabDic" do
    navigation_label I18n.t('admin.navigation.crawling_setting')
    weight 10
  end
  config.model "User" do
    navigation_label I18n.t('admin.navigation.admin_setting')
    weight 11
  end
end