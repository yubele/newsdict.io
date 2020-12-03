p "Start db:seed"
# Default User
unless User.where(email: ENV['ADMIN_USER_EMAIL']).exists?
  user = User.new
  user.email = ENV['ADMIN_USER_EMAIL']
  user.username = "admin"
  user.password = ENV['ADMIN_DEFALT_PASSWORD']
  user.password_confirmation = ENV['ADMIN_DEFALT_PASSWORD']
  user.confirmed_at = Time.now
  user.save!
end
# Global Config
Configs::Global::KEYS.each do |key|
  unless Configs::Global.find_by(key: key)
    Configs::Global.create(
      key: key,
      value: ""
    )
  end
end
# Hook Config
Configs::Hook::KEYS.each do |key|
  unless Configs::Hook.find_by(key: key)
    Configs::Hook.create(
      key: key
    )
  end
end
p "End of db:seed"