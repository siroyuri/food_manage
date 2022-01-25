Rails.application.routes.draw do
  devise_for :users
  root to: 'items#index'
  resources :categories, only: [:new, :create]
  resources :items, only: [:index]
end
