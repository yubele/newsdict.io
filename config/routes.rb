Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admins/rails_admin', as: 'rails_admin'
  devise_for 'user'
end
