Rails.application.routes.draw do
  mount Sidekiq::Web => "/super_admin/sidekiq", constraints: SuperAdminConstraint.new, as: 'sidekiq_web'
  mount RailsAdmin::Engine => "/admin", as: 'rails_admin'
  devise_for 'user', :controllers => {
    :registrations => 'admins/registrations'
  }
  get '/', to: "fronts#index", as: 'root'
end