# use in config/routes.rb
class SuperAdminConstraint
  def matches?(request)
    if current_user = User.find_by(id: request.env['warden'].user(:user).id)
      current_user.super_admin?
    end
  end
end