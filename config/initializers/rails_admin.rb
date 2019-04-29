# Require the rails_admins's config files.
Dir[Rails.root.join('config', 'rails_admin', '**/*')].each {|file| require file if File.file?(file)}
RailsAdmin.config do |config|
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)
  config.authorize_with :cancancan, AdminAbility
  config.current_user_method { current_user }
  config.audit_with :mongoid_audit
  # default actions
  config.actions do
    dashboard
    index
    new do
      except  ['User']
    end
    history_index do
      only ['User']
    end
    bulk_delete
    show
    edit
    delete
    history_show do
      only ['User']
    end
    show_in_app
  end
end