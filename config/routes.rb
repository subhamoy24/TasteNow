Rails.application.routes.draw do
  resources :cart_items, only: [:create] do
    collection do
      post :remove
    end
  end
  resources :addons, only: [:create, :destroy]
  resources :variations, only: [:create, :destroy]
  resources :foods, only: [:create, :destroy]
  resources :carts, only: [:create, :destroy] do
    collection do
      get :details
    end
  end
  resources :users, only: [:create, :destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
