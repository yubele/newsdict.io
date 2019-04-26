RailsAdmin.config do |config|
  config.current_user_method(&:current_user)
  config.model User do
    list do
      filters [:email]
      field :email do
        filterable true
      end
    end
    edit do
      field :is_manual_locked do
        visible true
      end
      # login user id
      field :creator_id, :hidden do
        default_value do
          bindings[:view]._current_user.id
        end
      end
      # login user id
      field :updater_id, :hidden do
        default_value do
          bindings[:view]._current_user.id
        end
      end
    end
  end
end