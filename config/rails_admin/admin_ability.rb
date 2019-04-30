class AdminAbility
  include CanCan::Ability
  def initialize(user)
    return unless user
    can :access, :rails_admin
    can :read, :dashboard
    if user.super_admin?
      can :manage, :all
      # super admin navigation
      RailsAdmin.config do |config|
        config.navigation_static_links = {
            'Sidekiq' => ENV['SIDEKIQ_WEB_URL']
        }
      end
    else
      # user role
      can :create, Sources::TwitterAccount, user_id: user.id if user
      can :manage, Sources::TwitterAccount, user_id: user.id
    end
  end
end