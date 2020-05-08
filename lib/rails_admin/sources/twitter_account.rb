RailsAdmin.config do |config|
  config.current_user_method(&:current_user)
  config.model "Sources::TwitterAccount" do
    # screen name
    field :name do
      visible true
    end
    field :alias do
      visible true
    end
    field :description do
      visible false
    end
    field :category_id do
      visible true
    end
    # login user id
    field :user_id do
      label "User Email"
      # SuperAdmin is visible
      visible do
        bindings[:controller].try(:current_user).try(:super_admin?)
      end
      # View email of user
      pretty_value do
        User.find(bindings[:object].user_id).email
      end
    end
    edit do
      # login user id
      field :user_id, :hidden do
        default_value do
          bindings[:view]._current_user.id
        end
      end
    end
  end
end