require 'sidekiq/web'

Rails.application.routes.draw do
  
  authenticate :user, lambda { |user| user.is_admin } do
    mount Sidekiq::Web => '/sidekiq'
  end
  
  mount ActionCable.server => '/cable'

  resources :incidents

  resources :messages, only: [:create]

  resources :api_keys, except: [:edit, :update]
  resources :surveys do
    resources :questions, except: [:index]
  end

  resources :conversations
  get 'about' => 'pages#about', as: :about

  devise_for :users,
    path:        '',
    path_names:  {:sign_in => 'login', :sign_out => 'logout', :edit => 'settings'},
    controllers: {registrations: 'registrations'}

  namespace :api, :defaults => {:format => :json} do
    namespace :v1 do
      resources :users
    end
  end

  root to: 'pages#index'
end
