Rails.application.routes.draw do
  root to: 'home#index'

  resources :branches
  resources :departments
  resources :staffs
  resources :clients
  resources :accounts

  scope :clients do
    get ':id/contact', to: 'clients#contact', as: :contact
  end
end
