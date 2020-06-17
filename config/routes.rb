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

  scope :accounts do
    get ':id/owners', to: 'accounts#owners', as: :account_owners
    post ':id/owners', to: 'accounts#owner_create', as: :new_account_owner
  end
end
