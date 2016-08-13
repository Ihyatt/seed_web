Rails.application.routes.draw do
  namespace :api, :defaults => {:format => :json} do
    namespace :v1 do
      resources :users
    end
  end
  
  devise_for :users,
    path:        '',
    path_names:  {:sign_in => 'login', :sign_out => 'logout', :edit => 'settings'},
    controllers: {registrations: 'registrations'}

  get 'about' => 'pages#about', as: :about
  root to: 'pages#index'
end
