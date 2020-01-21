module ApplicationHelper
  # Count user
  def count_user
    User.all.count
  end
end
