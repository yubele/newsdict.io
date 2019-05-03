Rails.application.routes.draw do
  mount Sidekiq::Web => ENV['SIDEKIQ_WEB_URL'], constraints: SuperAdminConstraint.new, as: 'sidekiq_web'
  mount RailsAdmin::Engine => ENV['ADMIN_URL'], as: 'rails_admin'
  devise_for 'user', :controllers => {
    :registrations => 'admins/registrations'
  }
  get '/', to: "fronts#index", as: 'root'
end