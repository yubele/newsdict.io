class Admin::RegistrationsController < Devise::RegistrationsController
  # Limited number of registered users
  def new
    if ENV['MAX_MEMBER_COUNT'].to_i < User.all.count
      redirect_to '/not_found'
    else
      super
    end
  end
  # Redirect to edit on rails_admin
  def edit
    redirect_to rails_admin.edit_path(model_name: :user, id: resource.id)
  end
end