require 'sidekiq/web'

Rails.application.routes.draw do
  
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  authenticate :user, lambda { |user| user.is_admin } do
    mount Sidekiq::Web => '/sidekiq'
  end
  
  mount ActionCable.server => '/cable'

  resources :reactions
  resources :genders
  resources :races

  resources :attachments, except: [:edit, :update]
  resources :incidents

  resources :messages, only: [:create]

  resources :api_keys, except: [:edit, :update]
  resources :surveys do
    resources :questions, except: [:index]
  end

  resources :conversations
  
  get 'about' => 'pages#about', as: :about
  get 'privacy-policy' => 'pages#privacy_policy', as: :privacy
  get 'terms-of-use' => 'pages#terms_of_use', as: :terms

  devise_for :users,
    path:        '',
    path_names:  {:sign_in => 'login', :sign_out => 'logout', :edit => 'settings'},
    controllers: {registrations: 'registrations'}

  namespace :api, :defaults => {:format => :json} do
    namespace :v1 do
      resources :officers, only: [:create, :update]

      resources :incident_types, only: [:index]
      resources :religions, only: [:index]
      resources :genders, only: [:index]
      resources :races, only: [:index]

      resources :attachments, only: [:create]
      resources :incidents
      resources :users do
        collection do
          post :generate
        end
      end
    end
  end

  root to: 'pages#index'
end
