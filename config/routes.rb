Rails.application.routes.draw do
  root 'salespeople#index'
  resources :salespeople
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
