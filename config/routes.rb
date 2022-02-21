Rails.application.routes.draw do
  devise_for :users
  root to: 'items#index'
  resources :categories, only: [:new, :create, :edit, :update, :destroy]
  resources :items, only: [:index, :create, :destroy] do
    member do
      get :add_form
      get :remove_form
    end
  end
  resources :item_informations, only: [:new, :create, :edit, :update, :destroy] do
    member do
      post :is_frozen
    end
    collection do
      get :new_category
    end
  end
end
