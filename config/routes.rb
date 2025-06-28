Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  localized do
    devise_for :users, controllers: { registrations: 'registrations' }

    root to: 'home#index'

    # Public profile
    get '/profile/:username', to: 'profiles#show', as: :profile

    # Public content
    resources :contents, only: [:show]

    resources :user do
      resource :dashboard, only: [:show]
      resources :contents, only: [:index, :new, :create]
    end

    namespace :admin do
      resources :tags, only: [:index, :create, :edit, :update, :destroy]
      resources :announcements, only: [:index, :new, :create, :edit, :update, :destroy]
    end
  end
end
