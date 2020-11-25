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
      except  ['User', 'Contents::Web', 'Configs::Theme', 'Configs::Global', 'Configs::Hook']
    end
    bulk_delete do
      except ['Config', 'Configs::View', 'Configs::Theme', 'Configs::Global', 'Configs::Hook']
    end
    show do
      except ['Configs::Tokens::Twitter']
    end
    edit
    delete do
      except ['Config', 'Configs::Theme', 'Configs::Global', 'Configs::Hook']
    end
    show_in_app
  end
end