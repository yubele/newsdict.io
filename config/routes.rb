Rails.application.routes.draw do
  mount Sidekiq::Web => ENV['SIDEKIQ_WEB_URL'], constraints: SuperAdminConstraint.new
  mount RailsAdmin::Engine => ENV['ADMIN_URL'], as: 'rails_admin'
  devise_for 'user'
end