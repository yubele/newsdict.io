class AdminAbility
  include CanCan::Ability
  def initialize(user)
    return unless user
    can :access, :rails_admin
    can :read, :dashboard
    if user.super_admin?
      can :manage, :all
      # Deprecated class
      can :manage, Sources::Url, hidden: true
      # super admin navigation
      RailsAdmin.config do |config|
        config.navigation_static_links = {
            I18n.t('sidekiq') => "/sidekiq"
        }
        config.navigation_static_label = I18n.t('admin.navigation.other_system_admin')
      end
    else
      RailsAdmin.config do |config|
        config.navigation_static_links = {}
        config.navigation_static_label = nil
      end
      # user role
      can :create, Sources::TwitterAccount, user_id: user.id
      can :manage, Sources::TwitterAccount, user_id: user.id
      can :create, Sources::WebUrl, user_id: user.id
      can :manage, Sources::WebUrl, user_id: user.id
      can :update, User, id: user.id
    end
  end
end