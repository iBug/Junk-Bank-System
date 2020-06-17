Rails.application.routes.draw do
  root to: 'home#index'

  resources :branches
  resources :departments
  resources :staffs
  resources :clients
  resources :accounts
  resources :loans

  scope :clients do
    get ':id/contact', to: 'clients#contact', as: :contact
  end

  scope :accounts do
    get ':id/owners', to: 'accounts#owners', as: :account_owners
    post ':id/owners', to: 'ownerships#create', as: :new_account_owner
    delete ':id/owners/:client_id', to: 'ownerships#destroy', as: :destroy_account_owner
  end

  scope :loans do
    get ':id/issues', to: 'loans#issues', as: :loan_issues
    post ':id/issues', to: 'issues#create', as: :new_issue
    get ':id/clients', to: 'loans#clients', as: :loan_clients
  end

  scope :stats do
    get '', to: 'home#index', as: :stats
  end
end
