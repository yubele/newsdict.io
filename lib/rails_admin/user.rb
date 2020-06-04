RailsAdmin.config do |config|
  config.label_methods << :username
  config.model User do
    list do
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