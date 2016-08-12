Rails.application.routes.draw do
  get 'about' => 'pages#about', as: :about
  root to: 'pages#index'
end
