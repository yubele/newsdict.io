class Admins::RegistrationsController < Devise::RegistrationsController
  # Redirect to edit on rails_admin
  def edit
    redirect_to rails_admin.edit_path(model_name: :user, id: resource.id)
  end
end