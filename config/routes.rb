Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  resources :warehouses, only: %i[show new create edit update destroy]
  resources :suppliers, only: %i[index show new create edit update]
  resources :product_models, only: %i[index new create show]
end
