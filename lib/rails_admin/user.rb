RailsAdmin.config do |config|
  config.label_methods << :username
  config.model User do
    list do
      filters [:username, :email]
      field :username
      field :email
      field :sign_in_count
      field :is_manual_locked
      field :last_sign_in_at
      field :last_sign_in_ip
    end
    edit do
      field :username do
        visible true
      end
      field :is_manual_locked do
        visible true
      end
    end
    show do
      field :username
      field :email
      field :encrypted_password
      field :reset_password_token
      field :reset_password_sent_at
      field :remember_created_at
      field :sign_in_count
      field :current_sign_in_at
      field :last_sign_in_at
      field :current_sign_in_ip
      field :last_sign_in_ip
      field :confirmation_token
      field :confirmed_at
      field :confirmation_sent_at
      field :unconfirmed_email
      field :failed_attempts
      field :unlock_token
      field :locked_at
    end
  end
end