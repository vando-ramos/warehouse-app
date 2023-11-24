Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  resources :warehouses, only: %i[show new create edit update destroy] do
    resources :stock_product_destinations, only: %i[create]
  end
  resources :suppliers, only: %i[index show new create edit update]
  resources :product_models, only: %i[index new create show]

  resources :orders, only: %i[new create show index edit update] do
    resources :order_items, only: %i[new create]
    get 'search', on: :collection
    post 'delivered', on: :member
    post 'canceled', on: :member
  end
end
