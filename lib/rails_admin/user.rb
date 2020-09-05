RailsAdmin.config do |config|
  config.label_methods << :username
  config.model User do
    list do
      field :provider do
        formatted_value{ bindings[:object].provider if bindings[:object].respond_to?(:provider) }
      end
      fields :username, :email, :sign_in_count, :is_manual_locked, :last_sign_in_at, :last_sign_in_ip
    end
    edit do
      fields :username, :is_manual_locked, :password, :password_confirmation
    end
    show do
      include_all_fields
      exclude_fields :encrypted_password
    end
  end
end