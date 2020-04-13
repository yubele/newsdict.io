Rails.application.routes.draw do
  # For health-check
  get 'active', to: proc { [200, Hash.new, Array.new] }
  mount Sidekiq::Web => "/sidekiq", constraints: SuperAdminConstraint.new, as: 'sidekiq_web'
  mount RailsAdmin::Engine => "/admin", as: 'rails_admin'
  devise_for 'user', :controllers => {
    :registrations => 'admin/registrations'
  }
  get "/category/:category/", to: "pages#show"
  get "/content/:id/", to: "pages#content"
  get "/img/:id", to: "images#index"
  # Apis
  namespace :api do
    namespace :v1 do
      resource :contents, only: [:show]
    end
  end
  root to: 'pages#show'
end