Rails.application.routes.draw do
  devise_for :users
  root to: 'items#index'
  resources :categories, only: [:new, :create, :destroy]
  resources :items, only: [:index, :create] do
    member do
      get :value_input
      get :add_form
      get :remove_form
      get :switching_forms
    end
  end
end
