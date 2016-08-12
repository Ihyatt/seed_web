Rails.application.routes.draw do
  devise_for :users
  get 'about' => 'pages#about', as: :about
  root to: 'pages#index'
end
