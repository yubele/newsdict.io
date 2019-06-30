Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq", constraints: SuperAdminConstraint.new, as: 'sidekiq_web'
  mount RailsAdmin::Engine => "/admin", as: 'rails_admin'
  devise_for 'user', :controllers => {
    :registrations => 'admins/registrations'
  }
  # For health-check
  get 'active', to: proc { [200, Hash.new, Array.new] }
  get '/', to: "fronts#index", as: 'root'
end