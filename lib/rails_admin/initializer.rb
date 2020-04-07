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
      except  ['User', 'Configs::View', 'Contents::Web']
    end
    bulk_delete do
      except ['Config', 'Configs::View']
    end
    show
    edit
    delete do
      except ['Config', 'Configs::View']
    end
    show_in_app
  end
end