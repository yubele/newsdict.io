RailsAdmin.config do |config|
  config.excluded_models = [:Source, :Content, :Config, :Filter, :Paper,
    # Deprecated class
    "Sources::WebUrl", "Sources::WebSection", "Sources::Url", "Theme", "Configs::Token", "CollectTag",
    "Users::Omniauth", "Users::Omniauths::Google", "Users::Omniauths::Facebook", "Users::Omniauths::Twitter",
    "Post", "Batch", "Friendship", "Follower"]
  config.model "Sources::TwitterAccount" do
    navigation_label I18n.t('admin.navigation.source')
    weight 1
  end
  config.model "Sources::WebSite" do
    navigation_label I18n.t('admin.navigation.source')
    weight 2
  end
  config.model "Inquiry" do
    navigation_label I18n.t('admin.navigation.inquiries_management')
    weight 3
  end
  config.model "Configs::Theme" do
    navigation_label I18n.t('admin.navigation.portal_setting')
    weight 4
  end
  config.model "Configs::View" do
    navigation_label I18n.t('admin.navigation.portal_setting')
    weight 5
  end
  config.model "Contents::Tweet" do
    navigation_label I18n.t('admin.navigation.content')
    weight 6
  end
  config.model "Contents::Web" do
    navigation_label I18n.t('admin.navigation.content')
    weight 7
  end
  config.model "Configs::Category" do
    navigation_label I18n.t('admin.navigation.crawling_setting')
    weight 8
  end
  config.model "Filters::IgnoreCrawlContent" do
    navigation_label I18n.t('admin.navigation.crawling_setting')
    weight 9
  end
  config.model "Filters::HiddenContent" do
    navigation_label I18n.t('admin.navigation.crawling_setting')
    weight 10
  end
  config.model "Configs::MecabDic" do
    navigation_label I18n.t('admin.navigation.crawling_setting')
    weight 11
  end
  config.model "Posts::Twitter" do
    navigation_label I18n.t('admin.navigation.posts')
    weight 12
  end
  config.model "Configs::Schedule" do
    navigation_label I18n.t('admin.navigation.notify_setting')
    weight 13
  end
  config.model "Configs::Hook" do
    navigation_label I18n.t('admin.navigation.notify_setting')
    weight 14
  end
  config.model "Configs::Tokens::Chatwork" do
    navigation_label I18n.t('admin.navigation.admin_setting')
    weight 15
  end
  config.model "Configs::Tokens::Slack" do
    navigation_label I18n.t('admin.navigation.admin_setting')
    weight 16
  end
  config.model "Configs::Tokens::Smtp" do
    navigation_label I18n.t('admin.navigation.admin_setting')
    weight 17
  end
  config.model "Configs::Tokens::TwitterAccount" do
    navigation_label I18n.t('admin.navigation.admin_setting')
    weight 18
  end
  config.model "Configs::Global" do
    navigation_label I18n.t('admin.navigation.admin_setting')
    weight 19
  end
  config.model "User" do
    navigation_label I18n.t('admin.navigation.admin_setting')
    weight 20
  end
end