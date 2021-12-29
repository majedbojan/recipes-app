# frozen_string_literal: true

Rails.application.routes.draw do
  require 'sidekiq/web'
  authenticate :user, ->(u) { u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  root to: 'pages#home'
  devise_for :users,  path:       '',
                      path_names: {
                        sign_in:      'auth/login',
                        sign_out:     'auth/logout',
                        sign_up:      'auth/sign_up',
                        password:     'auth/password',
                        confirmation: 'auth/confirmation',
                        edit:         'profile/password'
                      }

  resource  :profile, only: %i[show update]
  resources :recipe_requests, only:  %i[new create]
  resources :recipes, only: %i[index show] do
    member do
      get  :tag
    end

    collection do
      get :search
    end
  end

  namespace :admin do
    resources :dashboard, only:   %i[index]
    resources :users,     except: %i[new create]
    resources :recipes
    resources :recipe_requests, except: :create
    root to: redirect('admin/dashboard')
  end
  namespace :api do
    namespace :v1 do
      resources :recipes, only: %i[index show create] do
        resources :feedbacks, only: %i[index create]
      end
      resources :tags, only: :index
      resources :ingredients, only: :index
      resources :sessions, only: :create
    end
  end
end
