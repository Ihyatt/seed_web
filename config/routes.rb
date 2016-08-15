require 'sidekiq/web'

Rails.application.routes.draw do
  
  resources :api_keys, except: [:edit, :update]
  resources :surveys do
    resources :questions, except: [:index]
  end

  authenticate :user do
    mount Sidekiq::Web => '/sidekiq'
  end

  resources :conversations
  devise_for :users,
    path:        '',
    path_names:  {:sign_in => 'login', :sign_out => 'logout', :edit => 'settings'},
    controllers: {registrations: 'registrations'}

  get 'about' => 'pages#about', as: :about

  namespace :api, :defaults => {:format => :json} do
    namespace :v1 do
      resources :users
    end
  end

  root to: 'pages#index'
end
