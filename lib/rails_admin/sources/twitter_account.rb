RailsAdmin.config do |config|
  config.current_user_method(&:current_user)
  config.model "Sources::TwitterAccount" do
    base do
      # screen name
      field :name
      field :alias_name
      # refs. https://github.com/sferik/rails_admin/wiki/Enumeration#using-the-configuration-approach
      # legacy style because mongoid-enum do not maintend long time.
      field :category_id, :enum do
        enum do
          Configs::Category.all.map {|c| [c.key, c.id] }.to_h
        end
      end
      fields :description, :user_id do
        visible false
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
          User.find(bindings[:object].user_id).email if User.find(bindings[:object].user_id)
        end
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