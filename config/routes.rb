Rails.application.routes.draw do
  resources :product_discounts
  resources :manger_discounts
  get 'session/login'
  post 'session/attempt_login'
  get 'session/logout'
  resources :bank_transfers
  resources :sales_operations
  resources :mangers
  resources :assistants
  resources :marketers
  resources :deliveries
  resources :delegates
  resource  :home,                      only: [:index]
  root 'home#index'
  resources :users, except: [:show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
