Rails.application.routes.draw do
  # For health-check
  get 'active', to: proc { [200, Hash.new, Array.new] }
  get "/admin/edit_web_sections/:id/", to: "admin/edit_web_sections#show"
  get "/admin/edit_web_sections/:id/edit", to: "admin/edit_web_sections#edit"
  
  mount Sidekiq::Web => "/sidekiq", constraints: SuperAdminConstraint.new, as: 'sidekiq_web'
  mount RailsAdmin::Engine => "/admin", as: 'rails_admin'
  devise_for 'user', :controllers => {
    :registrations => 'admin/registrations'
  }
  get "/category/:category/", to: "pages#show"
  resources :contents, only: :show
  get "/paper/term/:from_date/:to_date/", to: "papers#term"
  get "/paper/term/:date/", to: "papers#one_day"
  get "/paper/:id/", to: "papers#show"
  resource :inquiries, only: [:show, :create]
  get "/img/:id", to: "images#index"
  # Apis
  namespace :api do
    namespace :v1 do
      resource :contents, only: [:show]
    end
  end
  root to: 'pages#show'
end