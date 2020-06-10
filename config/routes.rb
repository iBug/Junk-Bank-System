Rails.application.routes.draw do
  root to: 'home#index'

  resources :branches
  resources :departments
  resources :clients
end
