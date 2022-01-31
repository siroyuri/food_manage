Rails.application.routes.draw do
  devise_for :users
  root to: 'items#index'
  resources :categories, only: [:new, :create, :destroy]
  resources :items, only: [:index]
end
