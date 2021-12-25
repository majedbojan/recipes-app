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
  resources :recipe_requests, only: %i[create]
  resources :recipes, only: %i[index show] do
    member do
      get  :tag
    end
  end

  namespace :admin do
    resources :dashboard, only:   %i[index]
    resources :users,     except: %i[new create]
    resources :recipes
    root to: redirect('admin/dashboard')
  end
end
