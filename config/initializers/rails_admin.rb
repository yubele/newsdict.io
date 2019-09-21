# Require the rails_admins's config files.
Dir[Rails.root.join('config', 'rails_admin', '**/*')].each {|file| require file if File.file?(file)}
RailsAdmin.config do |config|
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.authorize_with :cancancan, AdminAbility
  config.current_user_method { current_user }
  # default actions
  config.actions do
    dashboard
    index
    new do
      except  ['User', 'Config']
    end
    bulk_delete do
      except ['Config']
    end
    show
    edit
    delete do
      except ['Config']
    end
    show_in_app
  end
end