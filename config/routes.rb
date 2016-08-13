Rails.application.routes.draw do
  namespace :api, :defaults => {:format => :json} do
    namespace :v1 do
      resources :users
    end
  end
  
  devise_for :users, controllers: {registrations: 'registrations'}
  get 'about' => 'pages#about', as: :about
  root to: 'pages#index'
end
