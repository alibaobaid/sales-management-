Rails.application.routes.draw do
  resources :deliveries
  resources :delegates
  root 'delegates#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
