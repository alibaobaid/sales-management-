Rails.application.routes.draw do
  resources :manger_discounts
  resources :bank_transfers
  resources :sales_operations
  resources :mangers
  resources :assistants
  resources :marketers
  resources :deliveries
  resources :delegates
  resource  :home,                      only: [:index]
  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
