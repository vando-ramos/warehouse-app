Rails.application.routes.draw do
  root 'home#index'

  resources :warehouses, only: %i[ show ]
end
