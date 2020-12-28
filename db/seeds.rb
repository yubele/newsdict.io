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
Configs::Global.tidy
# Hook Config
Configs::Hook.tidy
p "End of db:seed"