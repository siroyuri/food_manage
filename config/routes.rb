Rails.application.routes.draw do
  devise_for :users
  root to: 'items#index'
  resources :categories, only: [:new, :create, :edit, :update, :destroy]
  resources :items, only: [:index, :create, :edit, :update, :destroy] do
    member do
      get :value_input
      get :add_form
      get :remove_form
    end
  end
  resources :item_informations, only: [:edit, :update, :destroy] do
    member do
      post :is_frozen
    end
  end
end
