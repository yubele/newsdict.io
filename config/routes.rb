Rails.application.routes.draw do
  # For health-check
  get "healthz", to: proc { [200, Hash.new, Array.new] }
  # Not Found Page
  get "/not_found/", to: "errors#not_found", as: :not_found

  # Static page route
  get "/pages/:url_suffix/", to: "portals#page", as: :page

  # Image resouces
  get "/img/:id/", to: "images#index", as: :img
  get "/user_icon/:id/", to: "images#user_icon", as: :user_icon

  # Feed routes
  resource :rss, path: "/rss/", controller: "portals/rss", action: :show, only: [:show] do
    collection do
      get "/category/:category/", as: :category
      get "/tag/:keyword/", as: :tag
    end
  end

  # Content resources
  resources :contents, only: :show
  resources :sources, only: :show
  resource :inquiries, only: [:show, :create] do
    collection do
      post :request_removing
    end
  end
  resources :papers, only: :show do
    collection do
      get "/term/:from_date/:to_date/", to: "papers#term", as: :term
      get "/term/:date/", to: "papers#one_day", as: :oneday      
    end
  end
  resource :portals, path: "/category/:category/", controller: :portals, action: :show, only: [:show], as: :category
  resource :portals, path: "/tag/:tag/", controller: :portals, action: :show, only: [:show], as: :tag
  resource :portals, path: "/search/", controller: :portals, action: :show, only: [:show], as: :search
  root to: "portals#show"

  # Api routes
  namespace :api do
    namespace :v1 do
      resource :contents, only: [:show]
    end
  end

  # Admin routes
  devise_scope :user do
    scope module: :admin do
      scope module: :sources do
        resources :web_sites, path: "/admin/sources~web_site",only: [:edit, :update] do
          member do
            get :html
          end
        end
      end
    end
  end
  mount Sidekiq::Web => "/sidekiq", constraints: SuperAdminConstraint.new, as: "sidekiq_web"
  mount RailsAdmin::Engine => "/admin", as: "rails_admin"
  devise_for "user", :controllers => {
    registrations: 'admin/registrations',
    omniauth_callbacks: 'admin/omniauth_callbacks'
  }
  
  # Not found route
  get "*path", to: "application#exceptions_app"
end